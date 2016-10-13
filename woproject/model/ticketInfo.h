//
//  ticketInfo.h
//  woproject
//
//  Created by tianan-apple on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ticketInfo : NSObject
@property (nonatomic,copy)NSString *comparison;//
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *deviceId;
@property (nonatomic,copy)NSString *deviceName;
@property (nonatomic,copy)NSString *deviceType;
@property (nonatomic,copy)NSString *faultDesc;
@property (nonatomic,copy)NSString *faultId;
@property (nonatomic,copy)NSString *faultLevel;
@property (nonatomic,copy)NSString *faultPos;
@property (nonatomic,copy)NSString *Id;
@property (nonatomic,strong)NSMutableArray *imageList;
@property (nonatomic,copy)NSString *isNew;
@property (nonatomic,copy)NSString *jobId;
@property (nonatomic,copy)NSString *priority;
@property (nonatomic,copy)NSString *projectId;
@property (nonatomic,copy)NSString *repairUserId;
@property (nonatomic,copy)NSString *sortId;
@property (nonatomic,copy)NSString *source;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *systemId;
@property (nonatomic,copy)NSString *systemName;
@property (nonatomic,strong)NSMutableArray *ticketFlowList;
@property (nonatomic,copy)NSString *ticketNum;
@property (nonatomic,copy)NSString *ticketStatus;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *userPhone;
@property (nonatomic,copy)NSString *v;

- (ticketInfo *)asignInfoWithDict:(NSDictionary *)dict;
@end
