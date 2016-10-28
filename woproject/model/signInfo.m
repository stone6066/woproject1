//
//  signInfo.m
//  woproject
//
//  Created by tianan-apple on 16/10/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "signInfo.h"

@implementation signInfo
- (NSMutableArray *)asignInfoWithDict:(NSDictionary *)dict
{
    NSMutableArray *rtnArr=[[NSMutableArray alloc]init];
    NSDictionary *idict=[dict objectForKey:@"i"];

    NSDictionary *datadict=[idict objectForKey:@"Data"];
    @try {//Data=@"",真坑的接口
        for (NSDictionary *detailDict in datadict) {
            signInfo *signTmp=[[signInfo alloc]init];
            signTmp.Id=[detailDict objectForKey:@"id"];
            signTmp.latitude=[detailDict objectForKey:@"latitude"];
            signTmp.location=[detailDict objectForKey:@"location"];
            signTmp.longitude=[detailDict objectForKey:@"longitude"];
            signTmp.signTime=[[detailDict objectForKey:@"signTime"]stringValue];
            signTmp.status=[detailDict objectForKey:@"status"];
            signTmp.uid=[detailDict objectForKey:@"uid"];
            signTmp.v=[detailDict objectForKey:@"v"];
            [rtnArr addObject:signTmp];
        }
    } @catch (NSException *exception) {
        NSLog(@"字典为空");
    } @finally {
        return rtnArr;
    }
    

    
}
@end
