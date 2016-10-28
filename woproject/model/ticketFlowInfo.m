//
//  ticketFlowInfo.m
//  woproject
//
//  Created by tianan-apple on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ticketFlowInfo.h"

@implementation ticketFlowInfo
-(NSMutableArray*)asignDataFromDict:(NSDictionary*)dict{
    NSArray *ticketFlowArr=[dict objectForKey:@"ticketFlowList"];
    NSMutableArray *InfoArr=[[NSMutableArray alloc]init];
    for (NSDictionary *InfoDict in ticketFlowArr) {
        ticketFlowInfo *tickF=[[ticketFlowInfo alloc]init];
        tickF.deptId=[InfoDict objectForKey:@"deptId"];
        tickF.Id=[InfoDict objectForKey:@"id"];
        tickF.isValid=[InfoDict objectForKey:@"isValid"];
        tickF.jobName=[InfoDict objectForKey:@"jobName"];
        tickF.operation=[InfoDict objectForKey:@"operation"];
        tickF.operationPhone=[InfoDict objectForKey:@"operationPhone"];
        tickF.operationTime=[[InfoDict objectForKey:@"operationTime"]stringValue];
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
    return InfoArr;
}
@end
