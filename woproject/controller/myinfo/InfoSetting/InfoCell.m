//
//  InfoCell.m
//  woproject
//
//  Created by 徐洋 on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "InfoCell.h"
#import "PublicDefine.h"
#import "stdPubFunc.h"

@interface InfoCell ()

@property (nonatomic, strong) UILabel *loginOutLabel;

@end

@implementation InfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubViews];
    }
    return self;
}

- (void)setIndex:(NSUInteger)index
{
    _index = index;
    switch (index) {
        case 0:
            _icon.hidden = NO;
            _icon_label.hidden = NO;
            _loginOutLabel.hidden = YES;
            break;
        case 1:
        case 2:
        case 3:
            _icon.hidden = YES;
            _icon_label.hidden = NO;
            _loginOutLabel.hidden = YES;
            break;
        case 4:
            _icon.hidden = YES;
            _icon_label.hidden = YES;
            _loginOutLabel.hidden = NO;
            break;
    }
}

- (void)setSubViews
{
    _icon_label = [UILabel new];
    _icon_label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_icon_label];
    _icon = [UIImageView new];
    [self.contentView addSubview:_icon];
    _loginOutLabel = [UILabel new];
    _loginOutLabel.text = @"退出登录";
    _loginOutLabel.textAlignment = 1;
    _loginOutLabel.textColor = [UIColor whiteColor];
    _loginOutLabel.backgroundColor = RGB(22, 125, 250);
    [self.contentView addSubview:_loginOutLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_icon_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.bottom.offset(0);
    }];
    [_icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_icon_label);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.equalTo(_icon_label.mas_right).offset(10);
    }];
    _icon.layer.cornerRadius = 30.f;
    _icon.layer.masksToBounds = YES;
    [_loginOutLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
