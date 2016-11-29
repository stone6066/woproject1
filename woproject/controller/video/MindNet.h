//
//  MindNet.h
//  sdkDemo
//
//  Created by 吴怡顺 on 15/9/29.
//  Copyright © 2015年 吴怡顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceModel.h"
#import <qysdk/QYView.h>

@interface MindNet : NSObject
+ (MindNet *)sharedManager;
-(id)initWithSession;

@property(nonatomic,assign)  BOOL hasLogin;


- (void)loginSession:(void (^)(int32_t ret)) callback;

//获取设备
- (void)getDeviceSuccess:(void (^)(NSArray *ret))success;

//获取子设备
-(void)getChanelwithDevid:(DeviceModel*) device
              withsuccess:(void(^)(NSArray *ret)) success;
//查询天概要索引
-(QY_DAYS_INDEX)getDayList:(long long) devid
            yearData:(int) year
           monthData:(int) month
          cloundData:(BOOL) clound;




//创建预览房间
-(void)createVideoView:(long long) devid  callback:(void(^)(int32_t ret,QYView* view)) callback;
//创建对讲房间
-(void)createTalkView:(long long) devid  callback:(void(^)(int32_t ret,QYView* view)) callback;

//创建回放房间
-(void)createReplayView:(long long) devid
                CloudStroe:(BOOL) hasColund
                  callback:(void(^)(int32_t ret,QYView* view)) callback;

- (void)Release;

-(void)stdSetConfig:(uint64_t)channelID configEnable:(int)myEnable callBackWithAlarmConfig:(void (^)(int32_t))callback;

-(void)stdGetConfig:(uint64_t)channelID  callBackWithAlarmConfig:(void (^)(int32_t stdRet,int myEnable))callback;

-(void)stdGetVideoQuality:(uint64_t)channelID callBack:(void(^)(int32_t stdRet,int action,NSArray *list))callBack;

-(void)stdSetVideoQuality:(uint64_t)channelID action:(int)action callBack:(void(^)(int32_t stdRet))callBack;

-(void)stdGetStoreFileList:(uint64_t)channelID year:(int)year month:(int)month cloud:(int)cloud callBackWithDayIndex:(void (^)(int32_t ret,QY_DAYS_INDEX config))callback;
-(void)GetCaptureImage:(uint64_t)ChanelNo imagePath:(NSString*)path callBack:(void(^)(int32_t ret))callback;
@end
