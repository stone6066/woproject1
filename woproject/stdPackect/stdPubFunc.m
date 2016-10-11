//
//  stdPubFunc.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "stdPubFunc.h"
#import "PublicDefine.h"


@implementation stdPubFunc

+(void)stdShowMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    //label.frame = CGRectMake(10, 5, lblW, lblH);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((fDeviceWidth -LabelSize.width - 20)/2, fDeviceHeight/2-50, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:5.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}




+(NSString*)readUserMsg{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * Msg = [user objectForKey:NSUserDefaultsMsg];
    return Msg;
}
+(NSString*)readUserUid{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * UserUid = [user objectForKey:NSUserDefaultsUid];
    return UserUid;
}
+(NSString*)readUserNick{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * UserNick = [user objectForKey:NSUserDefaultsNick];
    return UserNick;
}

+(void)setIsLogin:(NSString*)islogin{
    NSUserDefaults *myuser = [NSUserDefaults standardUserDefaults];
    [myuser setObject:islogin forKey:NSUserIsLogin];
    [myuser synchronize];
}
+(NSString*)getIsLogin{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * islogin = [user objectForKey:NSUserIsLogin];
    return islogin;
}


+(NSString*)readUserName{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * UserName = [user objectForKey:NSUserDefaultsUsers];
    return UserName;
}
+(NSString*)readPassword{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * psw = [user objectForKey:NSUserDefaultsPsw];
    return psw;
}

+(void)saveLoginInfo:(NSString*)usrname password:(NSString*)psw{
    NSUserDefaults *myuser = [NSUserDefaults standardUserDefaults];
    [myuser setObject:usrname forKey:NSUserDefaultsMsg];
    [myuser setObject:psw forKey:NSUserDefaultsPsw];
    [myuser synchronize];
}
+(void)savePassWord:(NSString*)psw{
    NSUserDefaults *myuser = [NSUserDefaults standardUserDefaults];
    [myuser setObject:psw forKey:NSUserDefaultsPsw];
    [myuser synchronize];
}

+(void)saveToUserDefaults:(id)obj myKey:(NSString*)mkey{
    NSUserDefaults *myuser = [NSUserDefaults standardUserDefaults];
    [myuser setObject:obj forKey:mkey];
    [myuser synchronize];
}
+(id)readFormUserDefaults:(NSString*)mkey{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user objectForKey:mkey];
}
@end
