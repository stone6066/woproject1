//
//  ModifyPwdView.m
//  woproject
//
//  Created by 徐洋 on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ModifyPwdView.h"
#import "PublicDefine.h"
#import "stdPubFunc.h"

@interface ModifyPwdView ()

@property (nonatomic, strong) UITextField *pwdFD;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIView *originalBackView;
@property (nonatomic, strong) UIView *pwdBackView;
@property (nonatomic, strong) UIView *pwdAgainBackView;
@property (nonatomic, strong) UITextField *originalPwdFD;
@property (nonatomic, strong) UITextField *againPwdFD;
@property (nonatomic, strong) UILabel *originalLabel;
@property (nonatomic, strong) UILabel *pwdLabel;
@property (nonatomic, strong) UILabel *pwdAgainLabel;

@end

@implementation ModifyPwdView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
        self.backgroundColor = RGB(232, 239, 247);
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
#pragma mark Action
- (void)saveButtonAction:(UIButton *)sender
{
    [_originalPwdFD resignFirstResponder];
    [_pwdFD resignFirstResponder];
    [_againPwdFD resignFirstResponder];
    if (_originalPwdFD.text.length == 0) {
        [stdPubFunc stdShowMessage:@"请输入原密码"];
        return;
    }else{
//        if (![_originalPwdFD.text isEqualToString:@""]) {
//            [stdPubFunc stdShowMessage:@"原密码输入错误，请重新输入"];
//            return;
//        }
        if (![self checkInputPassword:_originalPwdFD.text] && _originalPwdFD.text.length > 0) {
            [stdPubFunc stdShowMessage:@"密码只能是大小写字母、数字，请重新输入"];
            return;
        }
    }
    if (_pwdFD.text.length == 0) {
        [stdPubFunc stdShowMessage:@"请输入新密码"];
        return;
    }else{
        if (![self checkInputPassword:_pwdFD.text] && _pwdFD.text.length > 0) {
            [stdPubFunc stdShowMessage:@"密码只能是大小写字母、数字，请重新输入"];
            return;
        }
    }
    if (_againPwdFD.text.length == 0) {
        [stdPubFunc stdShowMessage:@"请再次输入新密码"];
        return;
    }else{
        if (![self checkInputPassword:_againPwdFD.text] && _againPwdFD.text.length > 0) {
            [stdPubFunc stdShowMessage:@"密码只能是大小写字母、数字，请重新输入"];
            return;
        }
    }
    if (![self passwardIsRepeatWithPwd:_pwdFD.text andAgainPwd:_againPwdFD.text]) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(savePassward:)]) {
            [self.delegate savePassward:_pwdFD.text];
        }
    }
}
#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _originalPwdFD) {
#warning 判断原密码
//        if (![_originalPwdFD.text isEqualToString:@""]) {
//            [stdPubFunc stdShowMessage:@"原密码输入错误，请重新输入"];
//            return;
//        }
        if (![self checkInputPassword:_originalPwdFD.text] && _originalPwdFD.text.length > 0) {
            [stdPubFunc stdShowMessage:@"密码只能是大小写字母、数字，请重新输入"];
        }
    }else if (textField == _pwdFD){
        if (![self passwardIsRepeatWithPwd:_pwdFD.text andAgainPwd:_againPwdFD.text]) {
            if (![self checkInputPassword:_pwdFD.text] && _pwdFD.text.length > 0) {
                [stdPubFunc stdShowMessage:@"密码只能是大小写字母、数字，请重新输入"];
            }
        }
    }else{
        if (![self passwardIsRepeatWithPwd:_againPwdFD.text andAgainPwd:_pwdFD.text]) {
            if (![self checkInputPassword:_againPwdFD.text] && _againPwdFD.text.length > 0) {
                [stdPubFunc stdShowMessage:@"密码只能是大小写字母、数字，请重新输入"];
            }
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _originalPwdFD) {
        [_originalPwdFD resignFirstResponder];
        [_pwdFD becomeFirstResponder];
    }else if (textField == _pwdFD){
        [_pwdFD resignFirstResponder];
        [_againPwdFD becomeFirstResponder];
    }else{
        [_againPwdFD resignFirstResponder];
    }
    return YES;
}
/**
 不能输入空格
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}
#pragma mark Public
/**
 验证密码格式(大小写字母、数字,6-18位)

 @param text 密码

 @return YES-符合  NO-不符合
 */
- (BOOL)checkInputPassword:(NSString *)text
{
    NSString *regular = @"^[\\w!]{6,18}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    return [predicate evaluateWithObject:text];
}
/**
 判断新密码两次输入是否一致

 @param pwd  新密码
 @param aPwd 再次输入的密码

 @return YES-重复  NO-不重复
 */
- (BOOL)passwardIsRepeatWithPwd:(NSString *)pwd andAgainPwd:(NSString *)aPwd
{
    if (pwd.length == 0 || aPwd.length == 0) {
        return NO;
    }
    if (![pwd isEqualToString:aPwd]) {
        [stdPubFunc stdShowMessage:@"新密码输入不一致，请重新输入"];
        return YES;
    }
    return NO;
}
#pragma mark UI
- (void)setSubViews
{
    _originalBackView = [UIView new];
    _originalBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_originalBackView];
    _pwdBackView = [UIView new];
    _pwdBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pwdBackView];
    _pwdAgainBackView = [UIView new];
    _pwdAgainBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pwdAgainBackView];
    _saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_saveButton setTitle:@"保存" forState:normal];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:normal];
    [_saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.backgroundColor = RGB(22, 125, 250);
    [self addSubview:_saveButton];
    _originalLabel = [UILabel new];
    _originalLabel.text = @"原密码:";
    _originalLabel.font = [UIFont systemFontOfSize:14];
    [_originalBackView addSubview:_originalLabel];
    _pwdLabel = [UILabel new];
    _pwdLabel.text = @"新密码:";
    _pwdLabel.font = [UIFont systemFontOfSize:14];
    [_pwdBackView addSubview:_pwdLabel];
    _pwdAgainLabel = [UILabel new];
    _pwdAgainLabel.text = @"确认新密码:";
    _pwdAgainLabel.font = [UIFont systemFontOfSize:14];
    [_pwdAgainBackView addSubview:_pwdAgainLabel];
    _originalPwdFD = [UITextField new];
    _originalPwdFD.font = [UIFont systemFontOfSize:14];
    _originalPwdFD.clearButtonMode = UITextFieldViewModeWhileEditing;
    _originalPwdFD.delegate = self;
    _originalPwdFD.returnKeyType = UIReturnKeyNext;
    [_originalBackView addSubview:_originalPwdFD];
    _pwdFD = [UITextField new];
    _pwdFD.font = [UIFont systemFontOfSize:14];
    _pwdFD.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdFD.delegate = self;
    _pwdFD.returnKeyType = UIReturnKeyNext;
    [_pwdBackView addSubview:_pwdFD];
    _againPwdFD = [UITextField new];
    _againPwdFD.font = [UIFont systemFontOfSize:14];
    _againPwdFD.clearButtonMode = UITextFieldViewModeWhileEditing;
    _againPwdFD.delegate = self;
    _againPwdFD.returnKeyType = UIReturnKeyDone;
    [_pwdAgainBackView addSubview:_againPwdFD];
    _originalPwdFD.secureTextEntry = YES;
    _pwdFD.secureTextEntry = YES;
    _againPwdFD.secureTextEntry = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_originalBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.right.offset(0);
        make.height.mas_equalTo(@40);
    }];
    [_pwdBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_originalBackView);
        make.top.equalTo(_originalBackView.mas_bottom).offset(20);
    }];
    [_pwdAgainBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_originalBackView);
        make.top.equalTo(_pwdBackView.mas_bottom).offset(20);
    }];
    [_saveButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_originalBackView);
        make.top.equalTo(_pwdAgainBackView.mas_bottom).offset(20);
    }];
    [_originalLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(@55);
    }];
    [_pwdLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.bottom.offset(0);
        make.width.equalTo(_originalLabel);
    }];
    [_pwdAgainLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(@76);
    }];
    [_originalPwdFD mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_originalLabel.mas_right).offset(10);
        make.centerY.equalTo(_originalBackView.mas_centerY);
        make.right.offset(-20);
    }];
    [_pwdFD mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pwdLabel.mas_right).offset(10);
        make.right.offset(-20);
        make.centerY.equalTo(_pwdBackView.mas_centerY);
    }];
    [_againPwdFD mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_pwdAgainBackView.mas_centerY);
        make.left.equalTo(_pwdAgainLabel.mas_right).offset(10);
        make.right.offset(-20);
    }];
}

@end
