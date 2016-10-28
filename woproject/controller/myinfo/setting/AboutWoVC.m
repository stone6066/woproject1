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

@end

@implementation AboutWoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(232, 239, 247);
}

- (NSString *)getSystemVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *str = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"版本号 : Wo %@", str];
}

- (void)initUI
{
    self.topTitle = @"关于Wo";
    WS(weakSelf);
    _iconImgView = [UIImageView new];
    UIImage *img = [UIImage imageNamed:@"wo"];
    _iconImgView.image = img;
    [self.view addSubview:_iconImgView];
    [_iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(img.size.width, img.size.height));
        make.top.offset(90);
    }];
    _sysLabel = [UILabel new];
    _sysLabel.text = [self getSystemVersion];
    _sysLabel.font = k_text_font(12);
    _sysLabel.textColor = RGB(81, 81, 81);
    _sysLabel.textAlignment = 1;
    [self.view addSubview:_sysLabel];
    [_sysLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImgView.mas_bottom).offset(10);
        make.centerX.equalTo(_iconImgView);
    }];
    [_sysLabel sizeToFit];
    _msgLabel = [UILabel new];
    _msgLabel.font = k_text_font(12);
    _msgLabel.text = @"北京中创慧谷数据科技有限公司\n©2015-2016版权所有";
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
