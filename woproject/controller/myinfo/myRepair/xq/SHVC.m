//
//  SHVC.m
//  woproject
//
//  Created by 徐洋 on 2016/10/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "SHVC.h"

@interface SHVC ()

@property (nonatomic, strong) UILabel *shLabel;
@property (nonatomic, strong) UITextView *shTextView;
@property (nonatomic, strong) UIButton *qrshButton;

@end

@implementation SHVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)buttonAction:(UIButton *)sender
{
    [_shTextView resignFirstResponder];
}

- (void)initUI
{
    self.topTitle = @"审核";
    self.view.backgroundColor = RGB(232, 239, 247);
    _shLabel = [UILabel new];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"审核意见*:"];
    [str addAttribute: NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(4, 1)];
    _shLabel.attributedText = str;
    _shLabel.font = k_text_font(14);
    [self.view addSubview:_shLabel];
    [_shLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(104);
    }];
    _shTextView = [UITextView new];
    _shTextView.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:_shTextView];
    [_shTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_shLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(180);
    }];
    _qrshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _qrshButton.backgroundColor = RGB(21, 125, 251);
    _qrshButton.titleLabel.font = k_text_font(14);
    [_qrshButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_qrshButton setTitle:@"确认审核" forState:normal];
    [_qrshButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.view addSubview:_qrshButton];
    [_qrshButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shTextView.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(@40);
    }];
}

@end
