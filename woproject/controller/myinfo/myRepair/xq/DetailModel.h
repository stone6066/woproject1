//
//  DetailModel.h
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject<YYModel>

/**
 工单ID
 */
@property (nonatomic, copy) NSString *Id;
/**
 图片数组
 */
@property (nonatomic, copy) NSArray *imageList;
/**
 优先级
 */
@property (nonatomic, copy) NSString *priority;
/**
 状态
 */
@property (nonatomic, copy) NSString *status;
/**
 工单编号
 */
@property (nonatomic, copy) NSString *ticketNum;
/**
 故障描述
 */
@property (nonatomic, copy) NSString *faultDesc;
/**
 项目名称
 */
@property (nonatomic, copy) NSString *projectId;
/**
 报修时间
 */
@property (nonatomic, copy) NSString *createTime;
/**
 报修人
 */
@property (nonatomic, copy) NSString *userName;
/**
 故障设备
 */
@property (nonatomic, copy) NSString *deviceName;
/**
 故障位置
 */
@property (nonatomic, copy) NSString *faultPos;
/**
 工单流转记录列表
 */
@property (nonatomic, copy) NSArray *ticketFlowList;



@property (nonatomic, copy) NSString *comparison;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *deviceType;
@property (nonatomic, copy) NSString *faultId;
@property (nonatomic, copy) NSString *faultLevel;
@property (nonatomic, copy) NSString *isNew;
@property (nonatomic, copy) NSString *jobId;
@property (nonatomic, copy) NSString *repairUserId;
@property (nonatomic, copy) NSString *sortId;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *systemId;
@property (nonatomic, copy) NSString *systemName;
@property (nonatomic, copy) NSString *ticketStatus;
@property (nonatomic, copy) NSString *userPhone;
@property (nonatomic, copy) NSString *v;

@end
