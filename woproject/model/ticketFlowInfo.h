//
//  ticketFlowInfo.h
//  woproject
//
//  Created by tianan-apple on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//  工单流转记录

#import <Foundation/Foundation.h>

@interface ticketFlowInfo : NSObject
@property (nonatomic,copy)NSString *deptId;//工种
@property (nonatomic,copy)NSString *Id;
@property (nonatomic,strong)NSMutableArray *imageList;
@property (nonatomic,copy)NSString *isValid;
@property (nonatomic,copy)NSString *jobName;
@property (nonatomic,copy)NSString *operation;//操作动作：0.派单；1.接单；2.到场；3.完成；4.核查；5.退单；6.挂起
@property (nonatomic,copy)NSString *operationPhone;
@property (nonatomic,copy)NSString *operationTime;
@property (nonatomic,copy)NSString *operationUser;//操作人名称(根据状态定义名称，比如operation=0，operationUser显示为派单人)
@property (nonatomic,copy)NSString *result;
@property (nonatomic,copy)NSString *ticketId;
@property (nonatomic,copy)NSString *userId;//派单信息里的接单人
@property (nonatomic,copy)NSString *v;

@end
