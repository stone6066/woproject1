//
//  ticketList.m
//  woproject
//  工单数据模型
//  Created by tianan-apple on 16/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ticketList.h"

@implementation ticketList
- (NSMutableArray *)asignInfoWithDict:(NSDictionary *)dict{
    NSMutableArray *rtnArr=[[NSMutableArray alloc]init];
    NSDictionary *idict = [dict objectForKey:@"i"];
    NSDictionary *dictArray = [idict objectForKey:@"Data"];
    
    
    for (NSDictionary * loopdict in dictArray) {
        ticketList *tList=[[ticketList alloc]init];
        tList.comparison=[loopdict objectForKey:@"comparison"];
        tList.createTime=[[loopdict objectForKey:@"createTime"]stringValue];
        tList.deviceId=[loopdict objectForKey:@"deviceId"];
        tList.deviceName=[loopdict objectForKey:@"deviceName"];
        tList.faultDesc=[loopdict objectForKey:@"faultDesc"];
        tList.faultId=[loopdict objectForKey:@"faultId"];
        tList.faultLevel=[loopdict objectForKey:@"faultLevel"];
        tList.faultPos=[loopdict objectForKey:@"faultPos"];
        tList.Id=[loopdict objectForKey:@"id"];
        tList.jobId=[loopdict objectForKey:@"jobId"];
        tList.priority=[loopdict objectForKey:@"priority"];
        tList.projectId=[loopdict objectForKey:@"projectId"];
        tList.repairUserId=[loopdict objectForKey:@"repairUserId"];
        tList.sortId=[loopdict objectForKey:@"sortId"];
        tList.source=[loopdict objectForKey:@"source"];
        tList.status=[loopdict objectForKey:@"status"];
        tList.systemId=[loopdict objectForKey:@"systemId"];
        tList.systemName=[loopdict objectForKey:@"systemName"];
        tList.ticketNum=[loopdict objectForKey:@"ticketNum"];
        tList.ticketStatus=[loopdict objectForKey:@"ticketStatus"];
        tList.userName=[loopdict objectForKey:@"userName"];
        tList.userPhone=[loopdict objectForKey:@"userPhone"];
        tList.v=[loopdict objectForKey:@"v"];
        [rtnArr addObject:tList];
    }
    
    
    return rtnArr;
}
@end
