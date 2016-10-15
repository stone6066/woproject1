//
//  ModifyVC.m
//  woproject
//
//  Created by 徐洋 on 16/10/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ModifyVC.h"
#import "stdPubFunc.h"
#import "ModifyUserIDView.h"
#import "ModifyPwdView.h"
#import "ModifyPhoneView.h"

@interface ModifyVC ()
<
ModifyPwdDelegate
>

@property (nonatomic, strong) ModifyUserIDView *userView;
@property (nonatomic, strong) ModifyPwdView *pwdView;
@property (nonatomic, strong) ModifyPhoneView *phoneView;

@end

@implementation ModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setType:(NSInteger)type
{
    _type = type;
    switch (type) {
        case 1:
        {
            self.topTitle = @"用户ID";
            self.userView = [[ModifyUserIDView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight - 64)];
            [self.userView.saveButton addTarget:self action:@selector(saveUserID) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.userView];
        }
            break;
        case 2:
            self.topTitle = @"密码更改";
            self.pwdView = [[ModifyPwdView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight - 64)];
            self.pwdView.delegate = self;
            [self.view addSubview:self.pwdView];
            break;
        case 3:
            self.topTitle = @"电话更改";
            self.phoneView = [[ModifyPhoneView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight - 64)];
            [self.phoneView.saveButton addTarget:self action:@selector(savePhone) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.phoneView];
            break;
    }
}
#pragma mark Delegate
- (void)savePassward:(NSString *)pwd
{
    NSLog(@"新密码:%@", pwd);
}
- (void)saveUserID
{
    NSLog(@"新用户ID:%@", self.userView.userIDFD.text);
}
- (void)savePhone
{
    NSLog(@"新手机号码:%@", self.phoneView.phoneFD.text);
}

@end

