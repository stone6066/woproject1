//
//  ModifyPhoneView.m
//  woproject
//
//  Created by 徐洋 on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ModifyPhoneView.h"
#import "PublicDefine.h"
#import "stdPubFunc.h"

@interface ModifyPhoneView ()

@property (nonatomic, strong) UIView *backView;

@end

@implementation ModifyPhoneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(232, 239, 247);
        [self setSubViews];
    }
    return self;
}

- (void)textChange
{
    if (_phoneFD.text.length > 10) {
        _saveButton.enabled = YES;
        _saveButton.backgroundColor = RGB(22, 125, 250);
    }else{
        _saveButton.enabled = NO;
        _saveButton.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)setPhone:(NSString *)phone
{
    _phone = phone;
    _phoneFD.text = [phone isKindOfClass:[NSNull class]]?@"":phone;
    if (phone.length > 10) {
        _saveButton.enabled = YES;
        _saveButton.backgroundColor = RGB(22, 125, 250);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= 11) {
        return NO;
    }
    return YES;
}

- (void)setSubViews
{
    _backView = [UIView new];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    _phoneFD = [UITextField new];
    _phoneFD.placeholder = @"请输入电话号码";
    _phoneFD.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneFD.font = [UIFont systemFontOfSize:14];
    _phoneFD.delegate = self;
    _phoneFD.keyboardType = UIKeyboardTypeNumberPad;
    [_backView addSubview:_phoneFD];
    
    _saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_saveButton setTitle:@"保存" forState:normal];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:normal];
    _saveButton.enabled = NO;
    _saveButton.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_saveButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.right.offset(0);
        make.height.mas_equalTo(@40);
    }];
    [_phoneFD mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView.mas_centerY);
        make.left.offset(20);
        make.right.offset(-20);
    }];
    [_saveButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_backView.mas_bottom).offset(20);
        make.height.mas_equalTo(@40);
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
