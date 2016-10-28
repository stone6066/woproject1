//
//  listNum.m
//  woproject
//
//  Created by tianan-apple on 2016/10/21.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "listNum.h"

@implementation listNum
- (listNum *)asignInfoWithDict:(NSDictionary *)dict
{
    NSDictionary *idict=[dict objectForKey:@"i"];
    listNum *numInfo=[[listNum alloc]init];
    NSDictionary *datadict=[idict objectForKey:@"Data"];
    @try {//Data=@"",真坑的接口
        numInfo.Id=[datadict objectForKey:@"id"];
        numInfo.assignCount=[datadict objectForKey:@"assignCount"];
        numInfo.notRepairsCount=[datadict objectForKey:@"notRepairsCount"];
        numInfo.publicCount=[datadict objectForKey:@"publicCount"];
        numInfo.receivedCount=[datadict objectForKey:@"receivedCount"];
        numInfo.repairsCount=[datadict objectForKey:@"repairsCount"];
        numInfo.sendCount=[datadict objectForKey:@"sendCount"];
        numInfo.ticketCount=[datadict objectForKey:@"ticketCount"];
        numInfo.ticketCountDay=[datadict objectForKey:@"ticketCountDay"];
        numInfo.userId=[datadict objectForKey:@"userId"];
        numInfo.v=[datadict objectForKey:@"v"];
    } @catch (NSException *exception) {
        NSLog(@"字典为空");
    } @finally {
        return numInfo;
    }
    
    
    
}
@end
