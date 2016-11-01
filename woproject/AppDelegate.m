//
//  AppDelegate.m
//  woproject
//
//  Created by tianan-apple on 16/10/9.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "AppDelegate.h"
#import "APIKey.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "DownLoadBaseData.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import <AudioToolbox/AudioToolbox.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate,UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [AMapServices sharedServices].apiKey = (NSString *)APIKey;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initProperty];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self configureAPIKey];
    
    
    /*-------jpush------*/
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    // 注册通知（自定义）
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidReceiveMessage:)
                                                 name:kJPFNetworkDidReceiveMessageNotification
                                               object:nil];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert|UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
            //在block中会传入布尔值granted，表示用户是否同意
            if (granted) {
                //如果用户权限申请成功，设置通知中心的代理
                [UNUserNotificationCenter currentNotificationCenter].delegate = self;
            }
        }];
    }
 
   
    /*-------jpush------*/
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    tabBarViewController = [[UITabBarController alloc]init];
    [self.window setRootViewController:tabBarViewController];
    StdRootController *stdRootV=[[StdRootController alloc]init];
    
    [stdRootV SetUpStdRootView:tabBarViewController];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rootVC) name:@"rootvc" object:nil];

    return YES;
}

- (void)rootVC
{
    tabBarViewController = [[UITabBarController alloc]init];
    [self.window setRootViewController:tabBarViewController];
    StdRootController *stdRootV=[[StdRootController alloc]init];
    
    [stdRootV SetUpStdRootView:tabBarViewController];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"drawHome" object:nil];
}

/**
 *  初始化应用程序的属性
 */
- (void) initProperty
{
    self.httpManager = [AFHTTPSessionManager manager];
    self.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.isLogin=NO;
    self.isRmbPsw=NO;
    
    // [self downDictData];//下载故障类型字典
    //    [self downLoadDictVerson:@"getFarmType"];//下载农场类型
}
- (void)applicationWillResignActive:(UIApplication *)application {
    //    [APService stopLogPageView:@"aa"];
    // Sent when the application is about to move from active to inactive state.
    // This can occur for certain types of temporary interruptions (such as an
    // incoming phone call or SMS message) or when the user quits the application
    // and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down
    // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate
    // timers, and store enough application state information to restore your
    // application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called
    // instead of applicationWillTerminate: when the user quits.
    
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the
    // application was inactive. If the application was previously in the
    // background, optionally refresh the user interface.
    // 在app进入前台后，将icon右上角的红字置为0
    /*
     // 这里是为了在点击icon图标使APP进入前台的情况下清除通知栏消息，可根据需求开启
     NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
     badge = badge == 1 ? 2 : 1;
     [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
     */
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if
    // appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
    //[rootViewController addNotificationCount];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
        //[rootViewController addNotificationCount];
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
       // [rootViewController addNotificationCount];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        //[rootViewController addNotificationCount];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


// 接收到自定义消息事件
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSString *content = [userInfo valueForKey:@"content"];
    
    NSString *mystr=[content stringByReplacingOccurrencesOfString:@"\\\"" withString:@""];
    NSDictionary *tmpdict=[self dictionaryWithJsonString:mystr];
    _Msgtype = [tmpdict objectForKey:@"type"];
    
    NSLog(@"自定义消息userInfo:%@",userInfo);
    NSLog(@"mytype:%@",_Msgtype);
    
    if ([_Msgtype isEqualToString:@"4"]) {//工单数目变化
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationJiguang
                                                            object:content];
        
    }
    else if ([_Msgtype isEqualToString:@"3"]) {//单点登录
        NSDictionary *dicttmp=[tmpdict objectForKey:@"title"];
        _logoutUid=[dicttmp objectForKey:@"uid"];
        [JPUSHService setAlias:@"" callbackSelector:nil object:self];//解除setAlias绑定
        [self singleLogin];
    }
    else{
        [self tiketInfoTurn:@"您有新工单请查看"];
    
    }
}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

-(void)singleLogin{
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"该账号已在其他设备登录"
                                   message:@"请退出当前账号"
                                  delegate:self
                         cancelButtonTitle:@"确定"
                         otherButtonTitles:nil, nil];
        [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{//
            if ([_Msgtype isEqualToString:@"3"]) {//单点登录
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLogout
                                                                    object:_logoutUid];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTicketTurn
                                                                    object:_Msgtype];
            }
        }break;
        default:
            break;
    }
}

-(void)tiketInfoTurn:(NSString*)thint{
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:thint
                               message:@"确定查看"
                              delegate:self
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:@"取消", nil];
    [alert show];

}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    BOOL notice = [[NSUserDefaults standardUserDefaults] boolForKey:@"setting_notice"];
    BOOL vibration = [[NSUserDefaults standardUserDefaults] boolForKey:@"setting_vibration"];
    BOOL isSound = [[NSUserDefaults standardUserDefaults] boolForKey:@"setting_sound"];
    if (vibration) {
        //振动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    if (notice && !isSound) {
        //有弹窗无声音
        completionHandler(UNNotificationPresentationOptionAlert);
    }else if (!notice && isSound){
        //无弹窗有声音
        completionHandler(UNNotificationPresentationOptionSound);
    }else if(notice && isSound){
        //有弹窗有声音
        completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound);
    }else{
        //无弹窗无声音
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    [stdPubFunc stdShowMessage:@"收到自定义通知"];
}











@end
