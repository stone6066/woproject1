//
//  ticketList.h
//  woproject
//
//  Created by tianan-apple on 16/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

//comparison = "<null>";
//createTime = 1476071287000;
//deviceId = "<null>";
//deviceName = "--";
//deviceType = "<null>";
//faultDesc = hjdghhjj;
//faultId = "<null>";
//faultLevel = "<null>";
//faultPos = "<null>";
//id = 209;
//imageList =                 (
//);
//isNew = 2;
//jobId = "<null>";
//priority = "\U4f4e";
//projectId = "\U6d77\U5357\U5927\U53a6 (\U6d77\U5357\U7701 \U6d77\U53e3\U5e02)";
//repairUserId = "<null>";
//sortId = "<null>";
//source = "<null>";
//status = 2;
//systemId = "<null>";
//systemName = "<null>";
//ticketFlowList =                 (
//);
//ticketNum = "<null>";
//ticketStatus = "\U5df2\U63a5\U5355";
//userName = "<null>";
//userPhone = "<null>";
//v = 3;
#import <Foundation/Foundation.h>

@interface ticketList : NSObject
@property (nonatomic,copy)NSString *comparison;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *deviceId;
@property (nonatomic,copy)NSString *deviceName;//故障设备
@property (nonatomic,copy)NSString *deviceType;
@property (nonatomic,copy)NSString *faultDesc;//故障描述
@property (nonatomic,copy)NSString *faultId;
@property (nonatomic,copy)NSString *faultLevel;
@property (nonatomic,copy)NSString *faultPos;
@property (nonatomic,copy)NSString *Id;
@property (nonatomic,copy)NSString *isNew;
@property (nonatomic,copy)NSString *jobId;
@property (nonatomic,copy)NSString *priority;//优先级
@property (nonatomic,copy)NSString *projectId;//项目名称
@property (nonatomic,copy)NSString *repairUserId;
@property (nonatomic,copy)NSString *sortId;
@property (nonatomic,copy)NSString *source;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *systemId;
@property (nonatomic,copy)NSString *systemName;
@property (nonatomic,copy)NSString *ticketNum;
@property (nonatomic,copy)NSString *ticketStatus;//已接单 工单类型
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *userPhone;
@property (nonatomic,copy)NSString *v;
- (NSMutableArray *)asignInfoWithDict:(NSDictionary *)dict;
@end
