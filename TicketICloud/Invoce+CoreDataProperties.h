//
//  Invoce+CoreDataProperties.h
//  TicketICloud
//
//  Created by 王会洲 on 16/3/11.
//  Copyright © 2016年 hzbj. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Invoce.h"

NS_ASSUME_NONNULL_BEGIN

@interface Invoce (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *invoceid;
@property (nullable, nonatomic, retain) NSString *kpf;
@property (nullable, nonatomic, retain) NSString *titles;

@end

NS_ASSUME_NONNULL_END
