//
//  SettingCell.m
//  woproject
//
//  Created by 徐洋 on 16/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "SettingCell.h"
#import "PublicDefine.h"
#import "stdPubFunc.h"

@interface SettingCell ()

@property (nonatomic, strong) UILabel *qrLabel;

@end

@implementation SettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubViews];
    }
    return self;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    switch (index) {
        case 0:
        case 1:
        case 2:
        {
            _nameLabel.hidden = NO;
            _setSwitch.hidden = NO;
            _qrImgView.hidden = YES;
            _qrLabel.hidden = YES;
            _loginOut.hidden = YES;
            if (index == 0) {
                [_setSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"setting_notice"]];
            }else if (index == 1){
                [_setSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"setting_sound"]];
            }else{
                [_setSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"setting_vibration"]];
            }
        }
            break;
        case 3:
        {
            _nameLabel.hidden = NO;
            _setSwitch.hidden = YES;
            _qrImgView.hidden = YES;
            _qrLabel.hidden = YES;
            _loginOut.hidden = YES;
        }
            break;
        case 4:
        {
            _nameLabel.hidden = YES;
            _setSwitch.hidden = YES;
            _qrImgView.hidden = NO;
            _qrLabel.hidden = NO;
            _loginOut.hidden = YES;
        }
            break;
        case 5:
        {
            _nameLabel.hidden = YES;
            _setSwitch.hidden = YES;
            _qrImgView.hidden = YES;
            _qrLabel.hidden = YES;
            _loginOut.hidden = NO;
        }
            break;
    }
}

- (void)switchAction:(UISwitch *)sender
{
    switch (_index) {
        case 0:
            [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"setting_notice"];
            [stdPubFunc stdShowMessage:@"通知"];
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"setting_sound"];
            [stdPubFunc stdShowMessage:@"声音"];
            break;
        case 2:
            [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"setting_vibration"];
            [stdPubFunc stdShowMessage:@"振动"];
            break;
            
        default:
            break;
    }
}

- (void)setSubViews
{
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    _setSwitch = [UISwitch new];
    _setSwitch.onTintColor = RGB(22, 125, 250);
    [self.contentView addSubview:_setSwitch];
    [_setSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    _qrImgView = [UIImageView new];
    [self.contentView addSubview:_qrImgView];
    _loginOut = [UILabel new];
    _loginOut.text = @"退出登录";
    _loginOut.backgroundColor = RGB(22, 125, 250);
    _loginOut.textColor = [UIColor whiteColor];
    _loginOut.textAlignment = 1;
    _loginOut.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_loginOut];
    _qrLabel = [UILabel new];
    _qrLabel.font = [UIFont systemFontOfSize:12];
    _qrLabel.text = @"扫描二位码下载APP";
    [self.contentView addSubview:_qrLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.bottom.offset(0);
    }];
    [_setSwitch mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel.mas_centerY);
        make.right.offset(-20);
    }];
    [_loginOut mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.offset(0);
    }];
    [_qrLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.offset(-10);
    }];
    [_qrLabel sizeToFit];
    [_qrImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.offset(10);
    }];
    
}

@end
