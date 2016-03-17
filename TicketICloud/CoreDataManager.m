//
//  MarkMannger.m
//  TicketCloud
//
//  Created by ysyc_liu on 16/3/9.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

+ (CoreDataManager *)defaultManager {
    static dispatch_once_t onceT;
    static  CoreDataManager *_manager;
    dispatch_once(&onceT, ^{
        _manager  = [[CoreDataManager alloc]init];
    });
    return _manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveContext) name:NSManagedObjectContextObjectsDidChangeNotification object:nil];
    }
    return self;
}


/**
 *  添加
 *
 *  @param name 表名
 *  @param dic  <#dic description#>
 */
- (void)insertDataWithClassName:(NSString *)name attriDic:(NSDictionary *)dic{
    NSManagedObject *managedObj = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.managedObjectContext];
    [managedObj setValuesForKeysWithDictionary:dic];
}

/**
 *  删除
 *
 *  @param name      <#name description#>
 *  @param predicate <#predicate description#>
 */
- (void)deleteDataWithClassName:(NSString *)name predicate:(NSPredicate *)predicate{
    NSArray *backArr = [self selectDataFromClassName:name predicate:predicate sortkeys:nil];
    for (NSManagedObject *obj in backArr) {
        [self.managedObjectContext deleteObject:obj];
    }
}

/**
 *  根据谓词查询全部数据
 *
 *  @param name      表名
 *  @param predicate 查询谓词
 *  @param sortkeys  排序字段
 *
 *  @return <#return value description#>
 */
- (NSArray *)selectDataFromClassName:(NSString *)name predicate:(NSPredicate *)predicate sortkeys:(NSArray *)sortkeys{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:name];
    if (predicate) {
        [request setPredicate:predicate];
    }
    if (sortkeys) {
        NSMutableArray *sortDescriptorKeys = [NSMutableArray new];
        for (NSString *key in sortkeys) {
            NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc]initWithKey:key ascending:YES];
            [sortDescriptorKeys addObject:sortDesc];
        }
        [request setSortDescriptors:sortDescriptorKeys];
    }
    NSArray *backArr = [self.managedObjectContext executeFetchRequest:request error:nil];
    return backArr;
}

/**
 *  根据谓词查询 分页数据
 *
 *  @param name      表名
 *  @param predicate 谓词
 *  @param sortkeys  排序字段
 *  @param index     页码
 *  @param countData 每页数量
 *
 *  @return <#return value description#>
 */
-(NSArray*)selectDataFromClassName:(NSString*)name predicate:(NSPredicate*)predicate sortkeys:(NSArray*)sortkeys fromIndex:(NSInteger)index rowCount:(NSInteger)countData {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:name];
    if (countData > 0) {
        [request setFetchLimit:countData];
    }
    [request setFetchOffset:index * countData];
    
    if (predicate) {
        [request setPredicate:predicate];
    }
    if (sortkeys) {
        NSMutableArray *sortDescriptorKeys = [NSMutableArray new];
        for (NSString *key in sortkeys) {
            NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc]initWithKey:key ascending:YES];
            [sortDescriptorKeys addObject:sortDesc];
        }
        [request setSortDescriptors:sortDescriptorKeys];
    }
    NSArray *backArr = [self.managedObjectContext executeFetchRequest:request error:nil];
    return backArr;
}



/**
 *  修改数据库
 *
 *  @param name      表名
 *  @param dic       要修改的字段 （组装字典）
 *  @param predicate 谓词
 */
-(void)modifyDataWithClassName:(NSString*)name attriDic:(NSDictionary*)dic predicate:(NSPredicate *)predicate{
    NSArray *backArr = [self selectDataFromClassName:name predicate:predicate sortkeys:nil];
    for (NSManagedObject *obj in backArr) {
        [obj setValuesForKeysWithDictionary:dic];
    }
    
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "cn.fanshaojie.QiQuJoke" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TicketCloud" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ticketCloud.sqlite"];
    NSLog(@"sqlitePath:%@",storeURL);
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (!_managedObjectContext) {
        
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    }
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] ) {
            if (![managedObjectContext save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
    }
}



@end
