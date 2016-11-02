//
//  MRModel.h
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRModel : NSObject<YYModel>

/**
 id
 */
@property (nonatomic, copy) NSString *Id;
/**
 故障设备
 */
@property (nonatomic, copy) NSString *deviceName;
/**
 工单状态：0.未派单；1.未接单；2.已接单；3.已完成；4.已核查；5.已退单；6.已挂起
 */
@property (nonatomic, copy) NSString *status;
/**
 接单时间
 */
@property (nonatomic, copy) NSString *createTime;
/**
 项目名称
 */
@property (nonatomic, copy) NSString *projectId;
/**
 优先级
 */
@property (nonatomic, copy) NSString *priority;
/**
 项目描述
 */
@property (nonatomic, copy) NSString *faultDesc;

@property (nonatomic, copy) NSString *comparison;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *deviceType;
@property (nonatomic, copy) NSString *faultId;
@property (nonatomic, copy) NSString *faultLevel;
@property (nonatomic, copy) NSString *faultPos;
@property (nonatomic, copy) NSArray *imageList;
@property (nonatomic, copy) NSString *isNew;
@property (nonatomic, copy) NSString *jobId;
@property (nonatomic, copy) NSString *repairUserId;
@property (nonatomic, copy) NSString *sortId;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *systemId;
@property (nonatomic, copy) NSString *systemName;
@property (nonatomic, copy) NSArray *ticketFlowList;
@property (nonatomic, copy) NSString *ticketNum;
@property (nonatomic, copy) NSString *ticketStatus;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userPhone;
@property (nonatomic, copy) NSString *v;

@end
