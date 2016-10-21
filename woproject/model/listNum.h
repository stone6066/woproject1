//
//  listNum.h
//  woproject
//
//  Created by tianan-apple on 2016/10/21.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//  主页工单数目

#import <Foundation/Foundation.h>

@interface listNum : NSObject
@property(nonatomic,copy)NSString *assignCount;//指定工单数
@property(nonatomic,copy)NSString *Id;
@property(nonatomic,copy)NSString *notRepairsCount;//未派单数（主页派单数量）
@property(nonatomic,copy)NSString *publicCount;//公共工单数
@property(nonatomic,copy)NSString *receivedCount;//已接工单数
@property(nonatomic,copy)NSString *repairsCount;//我的工单数
@property(nonatomic,copy)NSString *sendCount;//我的派单数
@property(nonatomic,copy)NSString *ticketCount;//我的工单数
@property(nonatomic,copy)NSString *ticketCountDay;//今日工单数
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *v;

- (listNum *)asignInfoWithDict:(NSDictionary *)dict;
@end
