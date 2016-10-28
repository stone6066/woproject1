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
            self.userView.userID = ApplicationDelegate.myLoginInfo.name;
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
            self.phoneView.phone = ApplicationDelegate.myLoginInfo.phone;
            [self.phoneView.saveButton addTarget:self action:@selector(savePhone) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.phoneView];
            break;
    }
}
#pragma mark Delegate
- (void)savePassward:(NSString *)opwd newPwd:(NSString *)npwd
{
    [self.view endEditing:YES];
    NSString *urlStr = [NSString stringWithFormat:@"%@/support/sys/forModifyPwd", BaseUrl];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [SVProgressHUD showWithStatus:k_Status_Load];
    [ApplicationDelegate.httpManager POST:urlStr parameters:@{@"ukey":ApplicationDelegate.myLoginInfo.ukey,@"uid":ApplicationDelegate.myLoginInfo.Id,@"password_old":opwd,@"password_new":npwd} progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSError* error;
            NSDictionary* jsonDic = [NSJSONSerialization
                                     JSONObjectWithData:responseObject
                                     options:kNilOptions
                                     error:&error];
            
            NSString *suc=[jsonDic objectForKey:@"s"];
            NSString *msg=[jsonDic objectForKey:@"m"];
            //
            if ([suc isEqualToString:@"0"]) {
                //成功
                [SVProgressHUD showSuccessWithStatus:msg];
                NSLog(@"======== %@", jsonDic);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                //失败
                [SVProgressHUD showErrorWithStatus:msg];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Network];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:k_Error_Network];
    }];
}
- (void)saveUserID
{
    [self.userView.userIDFD resignFirstResponder];
    ApplicationDelegate.myLoginInfo.name = self.userView.userIDFD.text;
    NSString *urlStr = [NSString stringWithFormat:@"%@support/sys/forModifyName", BaseUrl];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [SVProgressHUD showWithStatus:k_Status_Load];
    [ApplicationDelegate.httpManager POST:urlStr parameters:@{@"ukey":ApplicationDelegate.myLoginInfo.ukey,@"uid":ApplicationDelegate.myLoginInfo.Id,@"name":self.userView.userIDFD.text} progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSError* error;
            NSDictionary* jsonDic = [NSJSONSerialization
                                     JSONObjectWithData:responseObject
                                     options:kNilOptions
                                     error:&error];
            
            NSString *suc=[jsonDic objectForKey:@"s"];
            NSString *msg=[jsonDic objectForKey:@"m"];
            //
            if ([suc isEqualToString:@"0"]) {
                //成功
                [SVProgressHUD showSuccessWithStatus:msg];
                NSLog(@"======== %@", jsonDic);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                //失败
                [SVProgressHUD showErrorWithStatus:msg];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Network];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:k_Error_Network];
    }];
}
- (void)savePhone
{
    [self.phoneView.phoneFD resignFirstResponder];
    ApplicationDelegate.myLoginInfo.phone = self.phoneView.phoneFD.text;
    NSString *urlStr = [NSString stringWithFormat:@"%@support/sys/forModifyPhone", BaseUrl];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [SVProgressHUD showWithStatus:k_Status_Load];
    [ApplicationDelegate.httpManager POST:urlStr parameters:@{@"ukey":ApplicationDelegate.myLoginInfo.ukey,@"uid":ApplicationDelegate.myLoginInfo.Id,@"phone":self.phoneView.phoneFD.text} progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSError* error;
            NSDictionary* jsonDic = [NSJSONSerialization
                                     JSONObjectWithData:responseObject
                                     options:kNilOptions
                                     error:&error];
            
            NSString *suc=[jsonDic objectForKey:@"s"];
            NSString *msg=[jsonDic objectForKey:@"m"];
            //
            if ([suc isEqualToString:@"0"]) {
                //成功
                [SVProgressHUD showSuccessWithStatus:msg];
                NSLog(@"======== %@", jsonDic);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                //失败
                [SVProgressHUD showErrorWithStatus:msg];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Network];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:k_Error_Network];
    }];
}

@end

