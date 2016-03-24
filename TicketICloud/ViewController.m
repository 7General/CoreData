//
//  ViewController.m
//  TicketICloud
//
//  Created by hzbj on 16/3/6.
//  Copyright © 2016年 hzbj. All rights reserved.
//

#import "ViewController.h"
#import "HZCoreMannger.h"



@interface ViewController ()


@property (nonatomic, strong) UIButton * plusButton;

@property (nonatomic, strong) UIButton * lookButton;

@property (nonatomic, strong) UIButton * editButton;

@property (nonatomic, strong) UIButton * delButton;

@property (nonatomic, strong) UIButton * distanceButton;
@property (nonatomic, assign) int  pageNumber;

@property (nonatomic, strong) UITextField * userName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    
//    NSDictionary * dict = @{@"data":@"{\"invoiceIdList\":[127]}"};
//    
//    NSLog(@"===>>>>%@",dict);
//                NSError *err;
//    NSData * jsonData = [[dict objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary * dicts = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
//    NSArray * arry = dicts[@"invoiceIdList"];
//    NSMutableArray * localArry = [[NSMutableArray alloc] init];
//    [localArry addObjectsFromArray:arry];
//    NSLog(@"======>>>>>%@",localArry);
//    
//    
//    
//    return;
    
    
    
    
    self.plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.plusButton.frame = CGRectMake(50, 100, 100, 50);
    self.plusButton.backgroundColor = [UIColor redColor];
    [self.plusButton setTitle:@"添加" forState:UIControlStateNormal];
    [self.view addSubview:self.plusButton];
    [self.plusButton addTarget:self action:@selector(plusAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.lookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lookButton.frame = CGRectMake(50, 180, 100, 50);
    self.lookButton.backgroundColor = [UIColor redColor];
    [self.lookButton setTitle:@"查找" forState:UIControlStateNormal];
    [self.view addSubview:self.lookButton];
    [self.lookButton addTarget:self action:@selector(lookAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editButton.frame = CGRectMake(50, 260, 100, 50);
    self.editButton.backgroundColor = [UIColor redColor];
    [self.editButton setTitle:@"更新" forState:UIControlStateNormal];
    [self.view addSubview:self.editButton];
    [self.editButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.userName = [[UITextField alloc] initWithFrame:CGRectMake(100, 320, 200, 40)];
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    self.userName.layer.borderColor = [UIColor redColor].CGColor;
        self.userName.layer.borderWidth = 2;
    [self.view addSubview:self.userName];
    
    
    self.delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.delButton.frame = CGRectMake(50, 380, 100, 50);
    self.delButton.backgroundColor = [UIColor redColor];
    [self.delButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.view addSubview:self.delButton];
    [self.delButton addTarget:self action:@selector(delAction) forControlEvents:UIControlEventTouchUpInside];

    self.distanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.distanceButton.frame = CGRectMake(50, 450, 100, 50);
    self.distanceButton.backgroundColor = [UIColor redColor];
    [self.distanceButton setTitle:@"排重赛选" forState:UIControlStateNormal];
    [self.view addSubview:self.distanceButton];
    [self.distanceButton addTarget:self action:@selector(distanceAction) forControlEvents:UIControlEventTouchUpInside];

}

-(void)plusAction {
    NSLog(@"添加");
    NSDictionary * dict = [[NSDictionary alloc] init];
    dict = @{@"invoceid":@"2001",@"kpf":@"京东dddd",@"titles":@"测试公司"};
    
    [[HZCoreMannger defaultManager] insertDataWithClassName:@"Invoce" attriDic:dict];
}

-(void)lookAction {
    NSLog(@"查找");

    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@" invoceid = %@",@"2001"];
    NSArray * arry =  [[HZCoreMannger defaultManager]selectDataFromClassName:@"Invoce" predicate:predicate sortkeys:nil];
    //NSLog(@"------%ld",arry.count);
    for (NSManagedObject *item in arry) {
        NSString *typeStr = [item valueForKey:@"titles"];
        NSLog(@"=============>>>>%@",typeStr);
       
    }
    
   NSArray * selectarry =  [[HZCoreMannger defaultManager] selectDataFromClassName:@"Invoce" predicate:predicate sortkeys:nil fromIndex:self.pageNumber rowCount:10];
    for (NSManagedObject *item in selectarry) {
        NSString *typeStr = [item valueForKey:@"titles"];
        NSLog(@"=============>>>>%@",typeStr);
        
    }
}
-(void)editAction {
    NSLog(@"更新");
    NSDictionary * dict = [[NSDictionary alloc] init];
    dict = @{@"kpf":self.userName.text,@"titles":@"0000测试公司osJoin"};
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@" invoceid = %@",@"2026"];
    [[HZCoreMannger defaultManager] modifyDataWithClassName:@"Invoce" attriDic:dict predicate:predicate];
}

-(void)delAction {
    NSLog(@"删除");
    //NSPredicate * predicate = [NSPredicate predicateWithFormat:@" invoceid = %@",@"2026"];
    [[HZCoreMannger defaultManager] deleteDataWithClassName:@"Invoce" predicate:nil];
}


-(void)distanceAction {
    

    NSArray * selectArry = [[HZCoreMannger defaultManager] selectDistinctDataFromClassName:@"Invoce" predicate:nil sortkeys:nil Distinctkeys:@[@"kpf",@"titles"]];
        for (NSManagedObject *item in selectArry) {
            NSString *typeStr = [item valueForKey:@"kpf"];
            NSString *typeStrTitle = [item valueForKey:@"titles"];
            NSLog(@"=============>>>>%@===@%@",typeStr,typeStrTitle);
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
