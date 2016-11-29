//
//  MindNet.m
//  sdkDemo
//
//  Created by 吴怡顺 on 15/9/29.
//  Copyright © 2015年 吴怡顺. All rights reserved.
//

#import "MindNet.h"
#import <qysdk/QYSession.h>
#import "DeviceModel.h"
#import <qysdk/QYView.h>
@interface MindNet()<QYSessionDelegate>
{
    QYSession* session;
    QYView* talkView;
    QYView* replayView;
}
@end



@implementation MindNet

+ (MindNet *)sharedManager
{
    static MindNet *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc]initWithSession];
        [QYSession InitSDK: QY_LOG_INFO];

    });
    return sharedInstance;
}
-(id)initWithSession
{
    
    self=[super init];
    return self;
}
-(NSString *)stringByDecodingURLFormat:(NSString *)str

{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        
        str = [str stringByRemovingPercentEncoding];
        
    } else {
        
        str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    }
    
    return str;
    
}

- (void)loginSession:(void (^)(int32_t ret)) callback
{
    // Put setup code here. This method is called before the invocation of each test method in the class.
    session = [[QYSession alloc] init];
    NSLog(@"start login");
    NSDictionary *forProgram = [DownLoadBaseData readBaseData1:@"forVideo.plist"];
   
    NSString *serverIp=[forProgram objectForKey:@"serverIp"];
    NSString *portStr=[forProgram objectForKey:@"serverPort"] ;
    NSString *appId=[forProgram objectForKey:@"appID"];
    NSString *auth= [self stringByDecodingURLFormat:[forProgram objectForKey:@"auth"]];
    
    NSString *account=[forProgram objectForKey:@"account"];
        
    int portI=[portStr intValue];
    
    [session SetServer:serverIp port:portI ];//@"117.28.255.16"
        //@"czFYScb5pAu+Ze7rXhGh/+wasfGt6civRHegt/IPGEevW39JVXs32hEiZko5dHJPoabz311PZh/TMKCPIpX2FT9wD6vgn1Wh5DAFR53B2Zc="
        //此接口现在登陆失败，成功登陆sdk账户名和密码需要联系我们这边的人员还获取
    [session ViewerLogin:appId
                        auth:auth
                    callBack:^(int32_t ret) {
                        if(ret==0)
                        {
                            _hasLogin=YES;
                            [session SetEventDelegate:self];
                        }
                        callback(ret);
                        NSLog(@"Login complate: %d", ret);
                    }];
   
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [session Release];
}



- (void)getDeviceSuccess:(void (^)(NSArray *ret))success
{
    [session GetDeviceListcallBackWithArray:^(int32_t ret, NSMutableArray *array) {
        if(ret==0)
        {
            success(array);
        }
        else
            success(nil);
    }];
}

-(void)getChanelwithDevid:(DeviceModel*) device
              withsuccess:(void(^)(NSArray *ret)) success
{
    [session GetChannelList:device.device_id callBackWithArray:^(int32_t ret, NSMutableArray *array) {
        if(ret==0)
            success(array);
        else
            success(nil);
    }];

}


////查询天概要索引
//-(QY_DAYS_INDEX)getDayList:(long long) devid
//                    yearData:(int) year
//                   monthData:(int) month
//                  cloundData:(BOOL) clound
//{ss
//    QY_DAYS_INDEX searchResult={0};
//    [session GetStoreFileListDayIndex:devid
//                                 year:year
//                                month:month
//                                cloud:clound
//                            daysIndex:&searchResult];
//    
//    return searchResult;
//
//}


-(void)createVideoView:(long long) devid  callback:(void(^)(int32_t ret,QYView* view)) callback
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        QYView* videoView= [session CreateView:devid];

         //QYView* videoView= [session CreateView:1000001827001];
        NSLog(@"videoView=%@",videoView);
        if (videoView == nil)
        {
            callback(-1,nil);
        }
        else
        {
            [videoView StartConnectCallBack:^(int32_t ret) {
                if(ret==0)
                {
                    callback(ret,videoView);
                }
                else
                {
                    callback(ret,videoView);
                }
            }];
        }
    });
}

//-(void)createTalkView:(long long) devid  callback:(void(^)(int32_t ret,QYView* view)) callback
//{
//    QYView* videoView= [session CreateTalkView:devid];
//    [videoView StartConnectCallBack:^(int32_t ret) {
//        if(ret==0)
//        {
//            callback(ret,videoView);
//        }
//        else
//        {
//            callback(ret,nil);
//        }
//    }];
//
//}



//创建回放房间
-(void)createReplayView:(long long) devid
             CloudStroe:(BOOL) hasColund
               callback:(void(^)(int32_t ret,QYView* view)) callback
{

    QYView* videoView= [session CreateRePlayView:devid mode:hasColund];
    [videoView StartConnectCallBack:^(int32_t ret) {
        if(ret==0)
        {
            callback(ret,videoView);
        }
        else
        {
            callback(ret,nil);
        }
    }];

}

- (void)Release {
    _hasLogin=NO;
    [session Release];
}
//
//-(QYView*)createTalkView:(long long) devid
//{
//    QYView* videoView= [session CreateTalkView:devid];
//    [videoView StartConnect];
//
//    return videoView;
//}
//
//
//-(QYView*)createReplayView:(long long) devid
//                CloudStroe:(BOOL) hasColund
//{
//    QYView* videoView= [session CreateRePlayView:devid mode:hasColund];
//    [videoView StartConnect];
//
//    return videoView;
//}
//  断开通知
-(void)onDisConnect:(QY_DISCONNECT_REASON) reason
{   //session断开时调用
    NSLog(@"aaaaa");
}

//- (void)setAlamConfig:(uint64_t)channelID type:(QY_ALARM_TYPE)type config:(QY_ALARM_CONFIG*)config callBack:(void(^)(int32_t ret))callback{
//    
//    [session SetAlarmConfig:channelID type:type config:config callBack:^(int32_t ret) {
//     callback(ret);
// }];
//}
//
//
//-(void)GetAlarmConfig:(uint64_t)channelID type:(QY_ALARM_TYPE)type callBackWithAlarmConfig:(void (^)(int32_t stdRet, QY_ALARM_CONFIG stdConfig))callback{
//    [session GetAlarmConfig:channelID type:type callBackWithAlarmConfig:^(int32_t ret, QY_ALARM_CONFIG config) {
//    callback(ret,config);
//}];
//
//}

-(void)stdSetConfig:(uint64_t)channelID configEnable:(int)myEnable callBackWithAlarmConfig:(void (^)(int32_t))callback{
    [session GetAlarmConfig:channelID type:0 callBackWithAlarmConfig:^(int32_t ret, QY_ALARM_CONFIG config) {
        if (ret==0) {
            config.enable=myEnable;
            [session SetAlarmConfig:channelID type:0 config:&config callBack:^(int32_t ret) {
                callback(ret);
            }];

        }
    }];
}

-(void)stdGetConfig:(uint64_t)channelID callBackWithAlarmConfig:(void (^)(int32_t stdRet,int myEnable))callback{
    [session GetAlarmConfig:channelID type:0 callBackWithAlarmConfig:^(int32_t ret, QY_ALARM_CONFIG config) {
        if (ret==0) {
            callback(ret,config.enable);
        }
    }];

}

-(void)stdGetVideoQuality:(uint64_t)channelID callBack:(void(^)(int32_t stdRet,int action,NSArray *list))callBack{
    [session GetVideoQuality:channelID callBack:^(int32_t ret, enum QY_VIDEO_QUALITY action, NSArray *list) {
        if (ret==0) {
            callBack(ret,action,list);
        }
    }];

}

-(void)stdSetVideoQuality:(uint64_t)channelID action:(int)action callBack:(void(^)(int32_t stdRet))callBack{
    [session SetVideoQuality:action ChanelNO:channelID callBack:^(int32_t ret) {
        callBack(ret);
    }];
    
}

-(void)stdGetStoreFileList:(uint64_t)channelID year:(int)year month:(int)month cloud:(int)cloud callBackWithDayIndex:(void (^)(int32_t ret,QY_DAYS_INDEX config))callback{
    [session GetStoreFileListDayIndex:channelID year:year month:month cloud:cloud callBackWithDayIndex:^(int32_t ret, QY_DAYS_INDEX config) {
    callback(ret,config);
    }];

}

-(void)GetCaptureImage:(uint64_t)ChanelNo imagePath:(NSString*)path callBack:(void(^)(int32_t ret))callback{
    [session GetDeviceCapture:ChanelNo savePaht:path callBack:^(int32_t ret) {
        callback(ret);
    }];

}
@end
