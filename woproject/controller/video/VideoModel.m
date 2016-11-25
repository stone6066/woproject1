//
//  VideoModel.m
//  woproject
//
//  Created by tianan-apple on 2016/11/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "VideoModel.h"
#import "ChannelModel.h"
@implementation VideoModel
- (NSMutableArray *)asignInfoWithDict:(NSDictionary *)dict{
    NSMutableArray *rtArr=[[NSMutableArray alloc]init];
    NSArray *tmpArr=dict[@"i"][@"Data"][@"deviceList"];
    @try {
        for (NSDictionary *md in tmpArr) {
            VideoModel * VM=[[VideoModel alloc]init];
            VM.projectName=[md objectForKey:@"projectName"];
            VM.deviceName=[md objectForKey:@"deviceName"];
            VM.deviceNo=[md objectForKey:@"deviceNo"];
            VM.channelList=[md objectForKey:@"channelList"];
            [rtArr addObject:VM];
        }
    } @catch (NSException *exception) {
        
    } @finally {
         return rtArr;
    }
    
}
@end
