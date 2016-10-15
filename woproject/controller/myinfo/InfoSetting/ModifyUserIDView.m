//
//  ModifyUserIDView.m
//  woproject
//
//  Created by 徐洋 on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ModifyUserIDView.h"
#import "PublicDefine.h"
#import "stdPubFunc.h"

@interface ModifyUserIDView ()

@property (nonatomic, strong) UIView *backView;

@end

@implementation ModifyUserIDView

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
    if (_userIDFD.text.length > 0) {
        _saveButton.enabled = YES;
        _saveButton.backgroundColor = RGB(22, 125, 250);
    }else{
        _saveButton.enabled = NO;
        _saveButton.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)setUserID:(NSString *)userID
{
    _userID = userID;
    _userIDFD.text = userID;
    if (userID.length > 0) {
        _saveButton.enabled = YES;
        _saveButton.backgroundColor = RGB(22, 125, 250);
    }
}

- (void)setSubViews
{
    _backView = [UIView new];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    _userIDFD = [UITextField new];
    _userIDFD.placeholder = @"请输入用户ID";
    _userIDFD.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userIDFD.font = [UIFont systemFontOfSize:14];
    _userIDFD.delegate = self;
    [_backView addSubview:_userIDFD];
    
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
    [_userIDFD mas_remakeConstraints:^(MASConstraintMaker *make) {
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
