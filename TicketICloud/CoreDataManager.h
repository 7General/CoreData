//
//  MarkMannger.h
//  TicketCloud
//
//  Created by ysyc_liu on 16/3/9.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface CoreDataManager : NSObject

+ (CoreDataManager*)defaultManager;
/**
 *  添加
 *
 *  @param name 表名
 *  @param dic  <#dic description#>
 */
-(void)insertDataWithClassName:(NSString*)name attriDic:(NSDictionary*)dic;

/**
 *  删除
 *
 *  @param name      <#name description#>
 *  @param predicate <#predicate description#>
 */
-(void)deleteDataWithClassName:(NSString*)name predicate:(NSPredicate*)predicate ;
/**
 *  查询
 *
 *  @param name      <#name description#>
 *  @param predicate <#predicate description#>
 *  @param sortkeys  <#sortkeys description#>
 *
 *  @return <#return value description#>
 */
-(NSArray*)selectDataFromClassName:(NSString*)name predicate:(NSPredicate*)predicate sortkeys:(NSArray*)sortkeys;

/**
 *  根据谓词查询分页数据
 *
 *  @param name      <#name description#>
 *  @param predicate <#predicate description#>
 *  @param sortkeys  <#sortkeys description#>
 *  @param index     <#index description#>
 *  @param countData <#countData description#>
 *
 *  @return <#return value description#>
 */
-(NSArray*)selectDataFromClassName:(NSString*)name predicate:(NSPredicate*)predicate sortkeys:(NSArray*)sortkeys fromIndex:(NSInteger)index rowCount:(NSInteger)countData;

/**
 *  更新
 *
 *  @param name      <#name description#>
 *  @param dic       <#dic description#>
 *  @param predicate <#predicate description#>
 */
-(void)modifyDataWithClassName:(NSString*)name attriDic:(NSDictionary*)dic predicate:(NSPredicate *)predicate;

@property (readonly, strong, nonatomic) NSManagedObjectContext       * managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel         * managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;



@end

