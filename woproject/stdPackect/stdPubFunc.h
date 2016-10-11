//
//  stdPubFunc.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface stdPubFunc : NSObject
+(void)stdShowMessage:(NSString *)message;

+(NSString*)readUserMsg;

+(NSString*)readUserUid;

+(NSString*)readUserNick;

+(NSString*)readUserName;

+(NSString*)readPassword;

+(void)setIsLogin:(NSString*)islogin;

+(void)saveLoginInfo:(NSString*)usrname password:(NSString*)psw;

+(NSString*)getIsLogin;

+(void)savePassWord:(NSString*)psw;

+(void)saveToUserDefaults:(id)obj myKey:(NSString*)mkey;

+(id)readFormUserDefaults:(NSString*)mkey;
@end
