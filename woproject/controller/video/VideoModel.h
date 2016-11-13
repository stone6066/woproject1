//
//  VideoModel.h
//  woproject
//
//  Created by tianan-apple on 2016/11/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property(nonatomic,copy)NSString *projectName;//项目名称
@property(nonatomic,copy)NSString *deviceName;//设备名称
@property(nonatomic,copy)NSString *deviceNo;//设备编号
@property(nonatomic,strong)NSMutableArray *channelList;//频道列表

- (NSMutableArray *)asignInfoWithDict:(NSDictionary *)dict;
@end
