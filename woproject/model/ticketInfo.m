//
//  ticketInfo.m
//  woproject
//
//  Created by tianan-apple on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ticketInfo.h"
#import "ticketFlowInfo.h"

@implementation ticketInfo
- (ticketInfo *)asignInfoWithDict:(NSDictionary *)dict
{
    //NSMutableArray *rtnArr=[[NSMutableArray alloc]init];
    NSDictionary *idict=[dict objectForKey:@"i"];
    
    NSDictionary *datadict=[idict objectForKey:@"Data"];
    
    ticketInfo* tickInfo=[[ticketInfo alloc]init];
    
    @try {//Data=@"",真坑的接口
        //for (NSDictionary *detailDict in datadict)
        {
            tickInfo.comparison=[datadict objectForKey:@"comparison"];
            tickInfo.createTime=[[datadict objectForKey:@"createTime"]stringValue];
            tickInfo.deviceId=[datadict objectForKey:@"deviceId"];
            tickInfo.deviceName=[datadict objectForKey:@"deviceName"];
            tickInfo.deviceType=[datadict objectForKey:@"deviceType"];
            tickInfo.faultDesc=[datadict objectForKey:@"faultDesc"];
            tickInfo.faultId=[datadict objectForKey:@"faultId"];
            tickInfo.faultLevel=[datadict objectForKey:@"faultLevel"];
            tickInfo.Id=[datadict objectForKey:@"id"];
            tickInfo.isNew=[datadict objectForKey:@"isNew"];
            tickInfo.jobId=[datadict objectForKey:@"jobId"];
            tickInfo.priority=[datadict objectForKey:@"priority"];
            tickInfo.projectId=[datadict objectForKey:@"projectId"];
            tickInfo.repairUserId=[datadict objectForKey:@"repairUserId"];
            tickInfo.sortId=[datadict objectForKey:@"sortId"];
            tickInfo.source=[datadict objectForKey:@"source"];
            tickInfo.status=[datadict objectForKey:@"status"];
            tickInfo.systemId=[datadict objectForKey:@"systemId"];
            tickInfo.systemName=[datadict objectForKey:@"systemName"];
            tickInfo.ticketNum=[datadict objectForKey:@"ticketNum"];
            tickInfo.ticketStatus=[datadict objectForKey:@"ticketStatus"];
            tickInfo.userName=[datadict objectForKey:@"userName"];
            tickInfo.userPhone=[datadict objectForKey:@"userPhone"];
            tickInfo.v=[datadict objectForKey:@"v"];
            
            /*------------imageList--------------------------------*/
            NSArray *imagArr=[datadict objectForKey:@"imageList"];
            NSMutableArray *UrlArr=[[NSMutableArray alloc]init];
            for (NSDictionary *imgDict in imagArr) {
                NSString *imgUrl=[imgDict objectForKey:@"url"];
                [UrlArr addObject:imgUrl];
            }
            tickInfo.imageList=UrlArr;
            /*------------imageList--------------------------------*/
            
            /*------------ticketFlowList--------------------------------*/
            NSArray *ticketFlowArr=[datadict objectForKey:@"ticketFlowList"];
            NSMutableArray *InfoArr=[[NSMutableArray alloc]init];
            for (NSDictionary *InfoDict in ticketFlowArr) {
                ticketFlowInfo *tickF=[[ticketFlowInfo alloc]init];
                tickF.deptId=[InfoDict objectForKey:@"deptId"];
                tickF.Id=[InfoDict objectForKey:@"id"];
                tickF.isValid=[InfoDict objectForKey:@"isValid"];
                tickF.jobName=[InfoDict objectForKey:@"jobName"];
                tickF.operation=[InfoDict objectForKey:@"operation"];
                tickF.operationPhone=[InfoDict objectForKey:@"operationPhone"];
                tickF.operationTime=[InfoDict objectForKey:@"operationTime"];
                tickF.operationUser=[InfoDict objectForKey:@"operationUser"];
                tickF.ticketId=[InfoDict objectForKey:@"ticketId"];
                tickF.result=[InfoDict objectForKey:@"result"];
                tickF.userId=[InfoDict objectForKey:@"userId"];
                tickF.v=[InfoDict objectForKey:@"v"];
                
                NSArray *imagArr=[InfoDict objectForKey:@"imageList"];
                NSMutableArray *UrlArr=[[NSMutableArray alloc]init];
                for (NSDictionary *imgDict in imagArr) {
                    NSString *imgUrl=[imgDict objectForKey:@"url"];
                    [UrlArr addObject:imgUrl];
                }
                tickF.imageList=UrlArr;
                
                [InfoArr addObject:tickF];
            }
           /*------------ticketFlowList--------------------------------*/
            
            tickInfo.ticketFlowList=InfoArr;
            
        }
    } @catch (NSException *exception) {
        NSLog(@"字典为空");
    } @finally {
        return tickInfo;
    }
    
    
    
}
@end
