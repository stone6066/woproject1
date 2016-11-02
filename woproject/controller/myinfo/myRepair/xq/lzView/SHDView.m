//
//  SHDView.m
//  woproject
//
//  Created by 徐洋 on 2016/10/23.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "SHDView.h"

@interface SHDView ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *shsjLabel;//审核时间
@property (nonatomic, strong) UILabel *shsjContent;
@property (nonatomic, strong) UILabel *shrLabel;//审核人
@property (nonatomic, strong) UILabel *shrContent;
@property (nonatomic, strong) UILabel *gzLabel;//工种
@property (nonatomic, strong) UILabel *gzContent;
@property (nonatomic, strong) UILabel *shxxLabel;//审核信息
@property (nonatomic, strong) UILabel *shyjLabel;//审核意见

@end

@implementation SHDView

- (instancetype)init
{
    if (self = [super init]) {
        [self setSubViews];
    }
    return self;
}

- (void)setModel:(LZModel *)model
{
    _model = model;
}

- (void)setSubViews
{
    _titleView = [UIView new];
    _titleView.backgroundColor = RGB(230, 239, 247);
    [self addSubview:_titleView];
    _titleLabel = [UILabel new];
    _titleLabel.text = @"审核人信息";
    _titleLabel.textColor = RGB(26, 71, 113);
    _titleLabel.font = k_text_font(14);
    [_titleView addSubview:_titleLabel];
    _shsjLabel = [UILabel new];
    _shsjLabel.text = @"审核时间:";
    _shsjLabel.textAlignment = 2;
    _shsjLabel.font = k_text_font(14);
    [self addSubview:_shsjLabel];
    _shsjContent = [UILabel new];
    _shsjContent.font = k_text_font(14);
    [self addSubview:_shsjContent];
    _shrLabel = [UILabel new];
    _shrLabel.text = @"审核人:";
    _shrLabel.textAlignment = 2;
    _shrLabel.font = k_text_font(14);
    [self addSubview:_shrLabel];
    _shrContent = [UILabel new];
    _shrContent.font = k_text_font(14);
    [self addSubview:_shrContent];
    _gzLabel = [UILabel new];
    _gzLabel.text = @"工种:";
    _gzLabel.textAlignment = 2;
    _gzLabel.font = k_text_font(14);
    [self addSubview:_gzLabel];
    _gzContent = [UILabel new];
    _gzContent.font = k_text_font(14);
    [self addSubview:_gzContent];
    _shxxLabel = [UILabel new];
    _shxxLabel.text = @"审核信息";
    _shxxLabel.textColor = RGB(26, 71, 113);
    _shxxLabel.font = k_text_font(14);
    [self addSubview:_shxxLabel];
    _shyjLabel = [UILabel new];
    _shyjLabel.text = @"审核意见:";
    _shyjLabel.font = k_text_font(14);
    [self addSubview:_shyjLabel];
    _shyjContent = [UILabel new];
    _shyjContent.numberOfLines = 0;
    _shyjContent.font = k_text_font(14);
    [self addSubview:_shyjContent];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(@40);
    }];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.equalTo(_titleView);
    }];
    [_shsjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@70);
        make.top.equalTo(_titleView.mas_bottom).offset(10);
        make.left.offset(10);
    }];
    [_shsjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shsjLabel.mas_right).offset(0);
        make.top.equalTo(_shsjLabel);
    }];
    [_shrLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(_shsjLabel);
        make.top.equalTo(_shsjLabel.mas_bottom).offset(5);
    }];
    [_shrContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shsjLabel.mas_right).offset(0);
        make.top.equalTo(_shrLabel);
    }];
    [_gzLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(_shsjLabel);
        make.top.equalTo(_shrLabel.mas_bottom).offset(5);
    }];
    [_gzContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gzLabel.mas_right).offset(0);
        make.top.equalTo(_gzLabel);
    }];
    [_shxxLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shsjLabel);
        make.top.equalTo(_gzLabel.mas_bottom).offset(10);
    }];
    [_shyjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_shxxLabel.mas_bottom).offset(10);
    }];
    [_shyjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shsjLabel.mas_bottom).offset(5);
        make.left.offset(10);
        make.right.offset(-10);
    }];
}

@end
