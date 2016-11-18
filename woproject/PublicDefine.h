//
//  PublicDefine.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/22.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#ifndef StdTaoYXApp_PublicDefine_h
#define StdTaoYXApp_PublicDefine_h

#import <CoreFoundation/CoreFoundation.h>
#import "AppDelegate.h"

#import "BaseViewController.h"
#import "DownLoadBaseData.h"


#import "MJRefresh.h"
#import "SVProgressHUD.h"

#import <Masonry/Masonry.h>
#import "YYModel.h"
#import "DOPDropDownMenu.h"
#import "SDPhotoBrowser.h"

//#import "PNChartDelegate.h"
//#import "PNChart.h"
#import "SCChart.h"
#import "YLProgressBar.h"
#import "UIImageView+WebCache.h"
#import "UIView+WPEmptyView.h"

#define UISCREENHEIGHT  self.view.bounds.size.height
#define UISCREENWIDTH  self.view.bounds.size.width

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define StatusBarHeight (IOS7==YES ? 0 : 20)
#define BackHeight      (IOS7==YES ? 0 : 15)

#define fNavBarHeigth (IOS7==YES ? 64 : 44)

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height-StatusBarHeight)
#define HomeCellImgHeight (100)
#define HomeCellHeight (203)
#define MainTabbarHeight (50)
#define ConstCityName @"北京"
#define TopSeachHigh (65)
#define AdHight (160)
#define NavTopHight (90)
#define HomeADHeigh ((fDeviceWidth*9)/16)
#define TopStausHight (20)


#define BXVcHigh 400//报修高度
#define PDvcHigh 270//派单
#define JDvcHigh 210//接单
#define DCvcHigh 190//到场
//每次服务器返回的数据条数
#define srvDataCount (2)
//#define NSUserDefaultsUserName @"userName"
//#define NSUserDefaultsUserPWD @"userPWD"
#define NSUserJSESSIONID @"JSESSIONID"
#define NSUserTypeData @"MyTypeData"

#define NSUserDefaultsMsg @"userMsg"
#define NSUserRmbMsg @"RmbMsg"

#define NSUserDefaultsUid @"userUid"
#define NSUserDefaultsNick @"userNickName"
#define NSUserDefaultsUsers @"userName"
#define NSUserDefaultsPsw @"password"
#define NSUserIsLogin @"IsLogin"
#define NSUserLoginMsg @"userMsg"
#define NSUserVideoMsg @"VideoMsg"
//#define NetUrl @"http://shop.anquan365.org/nst/common.htm?"
#define MainUrl @"http://shop.anquan365.org/"
#define MainToken @"tao-yx.com"
#define BaseUrl @"http://120.132.124.11/ticket/"
//@"http://139.129.218.74:8080/ticket/"
#define BasePath @"mobile/interface/"

#define kNotifyDisconnection @"c" //断开
#define kNotifyReconnection @"kNotifyReconnection" //重联

//#define BaseUrl @"http://192.168.0.65:8080/paistore_m_site/"
//#define BasePath @"interface/"


#define MainTabbarColor ([UIColor whiteColor])
#define NSUserDefaultsCityInfo @"CityInfo"
#define NSUserDefaultsCityName @"CityName"
#define NSUserDefaultsTypeInfo @"TypeInfo"
#define NSUserDefaultsTypeName @"TypeName"
#define DefaultsImage @"noPic"
#define NotificationJiguang @"jiguangMessage"
#define NotificationLogout @"NotificationLogout"
#define NotificationTicketTurn @"NotificationTicketTurn"

#define HomeAdUrl1 @"http://img-ta-01.b0.upaiyun.com/14609471436342429.jpg"
#define HomeAdUrl2 @"http://img-ta-01.b0.upaiyun.com/14609471436342429.jpg"
#define HomeAdUrl3 @"http://img-ta-01.b0.upaiyun.com/14609471436342429.jpg"
#define kImageDefaultName @"defaultImg"

#define ApplicationDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

/*
 * 文件、目录
 */
#define DocumentBasePath ((NSString *)[(NSArray *)NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  objectAtIndex:0])

/*
 *常用网络状态
 */
#define k_Status_Load                @"加载中..."
#define k_Status_Publish             @"发布中..."
#define k_Status_Praise              @"点赞中..."
#define k_Status_Register            @"注册中..."
#define k_Status_Login               @"登录中..."
#define k_Status_VerifyCode          @"验证中..."
#define k_Status_GetVerifyCode       @"验证码发送中..."
#define k_Status_UpLoad              @"图片上传中,请耐心等待."
#define k_Status_Advice              @"意见提交中..."
#define k_Status_SubmitOrder         @"订单提交中..."
#define k_Status_Upload              @"上传中..."
#define k_Status_Delete              @"删除中..."
#define k_Status_Verity              @"验证中..."

/**
 *完成类型
 */
#define k_Success_Load               @"完毕"


/*
 *错误类型
 */
#define k_Notification_Flow          @"k_Notification_Flow"
#define k_Error_Network              @"网络不给力"
#define k_Error_DataError            @"数据异常"
#define k_Error_WebViewError         @"加载失败"
#define k_Error_Unknown              @"未知的错误"
#define k_Error_Service              @"验证失败请联系客户"
#define k_Error_Publish              @"发布失败"
#define k_Error_TelHasJoin           @"该手机号已经注册"
#define k_Error_PasswordNotSame      @"密码输入不一致"
#define k_Error_login                @"用户名或密码错误"
#define k_Error_LoginOverTime        @"账号登录过期,请重新登录"
#define k_Error_Advice               @"意见提交失败"
#define k_Error_Emoji                @"请不要输入表情"
#define k_Error_Address              @"请选择所在地区"
#define k_Error_AddressDetail        @"请输入详细信息"
#define k_Error_VerifyCode           @"验证码错误"





/**
 *格式错误
 */
#define k_FormatError_Username       @"用户名格式错误"
#define k_FormatError_Name           @"姓名格式错误"
#define k_FormatError_VerifyCode     @"验证码格式错误"
#define k_FormatError_Tel            @"手机号格式错误"
#define k_FormatError_Password       @"密码格式错误"
#define k_FormatError_PasswordSubmit @"确认密码格式错误"
#define k_FormatError_NickName       @"昵称格式不正确"
#define k_FormatError_Consignee      @"收货人格式错误"

#define k_jurisdiction @"无管辖范围"
#define k_empty_messgae @"无数据"


// 2.获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

#define navigationBarColor RGB(33, 192, 174)
#define separaterColor RGB(200, 199, 204)
#define tabTxtColor RGB(103, 103, 103)
#define collectionBgdColor RGB(237, 237, 237)
#define topSearchBgdColor RGB(1, 172, 102)
#define SettingViewColor RGB(239, 239, 244)
#define MyGrayColor RGB(238, 238, 238)
#define txtColor RGB(103, 103, 103)
#define spritLineColor RGB(218, 218, 218)
#define stausBarColor RGB(5, 147, 89)
#define cellNameColor RGB(6, 116, 71)
#define whiteTxtColor RGB(238, 231, 203)
#define chartFillColor RGB(214, 242, 230)


#define yjgdColor RGB(0, 162, 255)
#define pdColor RGB(61, 223, 122)
#define zdjdColor RGB(5, 204, 165)
#define gggdColor RGB(253, 193, 19)
#define kqColor RGB(141, 72, 249)
#define kshsjColor RGB(79, 100, 255)
#define videoColor RGB(241, 130, 86)

#define tabbarcolor RGB(41, 53, 65)
#define homebackcolor RGB(45, 60, 79)
#define topviewcolor RGB(41, 51, 63)
#define topxiancolor RGB(90, 106, 122)
#define bluebackcolor RGB(241, 248, 253)//淡蓝色背景
#define deepbluetxtcolor RGB(22, 73, 122)//工单详情蓝色字体
#define bluetxtcolor RGB(21, 132, 254)//登录蓝色字体
#define graytxtcolor RGB(120, 120, 120)//灰色字体
#define highbluetxtcolor RGB(32, 132, 249)//已接单 蓝色字体
#define videobluetxtcolor RGB(58, 75, 105)//视频界面暗蓝色字体 （在线摄像头）
#define txtViewMaxLen (70)

#pragma mark -

#if __has_feature(objc_instancetype)

#undef	AS_SINGLETON
#define AS_SINGLETON

#undef	AS_SINGLETON
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#undef	DEF_SINGLETON
#define DEF_SINGLETON( ... ) \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#else	// #if __has_feature(objc_instancetype)

#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}

#endif	// #if __has_feature(objc_instancetype)

#undef	DEF_SINGLETON_AUTOLOAD
#define DEF_SINGLETON_AUTOLOAD( __class ) \
DEF_SINGLETON( __class ) \
+ (void)load \
{ \
[self sharedInstance]; \
}

#pragma mark -

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS8_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#define IOS7_OR_EARLIER		( !IOS8_OR_LATER )
#define IOS6_OR_EARLIER		( !IOS7_OR_LATER )
#define IOS5_OR_EARLIER		( !IOS6_OR_LATER )
#define IOS4_OR_EARLIER		( !IOS5_OR_LATER )
#define IOS3_OR_EARLIER		( !IOS4_OR_LATER )

#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS7_OR_LATER		(NO)
#define IOS6_OR_LATER		(NO)
#define IOS5_OR_LATER		(NO)
#define IOS4_OR_LATER		(NO)
#define IOS3_OR_LATER		(NO)

#define IS_SCREEN_4_INCH	(NO)
#define IS_SCREEN_35_INCH	(NO)

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

/**
 *     Reachability单利
 */

#define  gs_ReachabilityManager  [AFNetworkReachabilityManager sharedManager]

#define gs_NotifiCenter [NSNotificationCenter defaultCenter]


/* 避免循环持有 */
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define k_text_font(obj) [UIFont systemFontOfSize:obj]


#endif
