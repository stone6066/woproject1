//
//  AboutWoVC.m
//  woproject
//
//  Created by 徐洋 on 16/10/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "AboutWoVC.h"

@interface AboutWoVC ()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *sysLabel;
@property (nonatomic, strong) UILabel *msgLabel;
@property (nonatomic, strong) UIView *topView;

@end

@implementation AboutWoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(232, 239, 247);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.view addSubview:self.topView];
    WS(weakSelf);
    [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 44));
        make.centerX.equalTo(weakSelf.navigationController.view.mas_centerX);
        make.top.offset(20);
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.topView removeFromSuperview];
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [UIView new];
        UILabel *label = [UILabel new];
        label.text = @"关于";
        label.textColor = [UIColor whiteColor];
        [_topView addSubview:label];
        UIImageView *img = [UIImageView new];
        img.image = [UIImage imageNamed:@"login02"];
        [_topView addSubview:img];
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.offset(0);
        }];
        [label sizeToFit];
        [img mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.right.offset(0);
            make.centerY.equalTo(_topView);
        }];
    }
    return _topView;
}

- (NSString *)getSystemVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *str = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"版本号 : V %@", str];
}

- (void)initUI
{
    WS(weakSelf);
    _iconImgView = [UIImageView new];
    UIImage *img = [UIImage imageNamed:@"login02"];
    _iconImgView.image = img;
    [self.view addSubview:_iconImgView];
    [_iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(img.size.width, img.size.height));
        make.top.offset(90);
    }];
    UILabel *label = [UILabel new];
    label.text = @"移动运维";
    label.font = k_text_font(12);
    label.textColor = RGB(81, 81, 81);
    label.textAlignment = 1;
    [self.view addSubview:label];
    [label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_iconImgView.mas_bottom).offset(10);
    }];
    _sysLabel = [UILabel new];
    _sysLabel.text = [self getSystemVersion];
    _sysLabel.font = k_text_font(12);
    _sysLabel.textColor = RGB(81, 81, 81);
    _sysLabel.textAlignment = 1;
    [self.view addSubview:_sysLabel];
    [_sysLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(10);
        make.centerX.equalTo(_iconImgView);
    }];
    [_sysLabel sizeToFit];
    _msgLabel = [UILabel new];
    _msgLabel.font = k_text_font(12);
    _msgLabel.text = @"海南易建科技股份有限公司\n©2016版权所有";
    _msgLabel.textColor = RGB(81, 81, 81);
    _msgLabel.numberOfLines = 0;
    _msgLabel.textAlignment = 1;
    [self.view addSubview:_msgLabel];
    [_msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.offset(-30);
    }];
    [_msgLabel sizeToFit];
}

@end
