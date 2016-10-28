//
//  PJDView.m
//  woproject
//
//  Created by 徐洋 on 2016/10/23.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "PJDView.h"

@interface PJDView ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pjsjLabel;//评价时间
@property (nonatomic, strong) UILabel *pjsjContent;
@property (nonatomic, strong) UILabel *pjrLabel;//评价人
@property (nonatomic, strong) UILabel *pjrContent;
@property (nonatomic, strong) UILabel *gzLabel;//工种
@property (nonatomic, strong) UILabel *gzContent;
@property (nonatomic, strong) UILabel *pjxxLabel;//评价信息
@property (nonatomic, strong) UILabel *sfxfLabel;//是否修复
@property (nonatomic, strong) UILabel *sfxfContent;
@property (nonatomic, strong) UILabel *wxpjLabel;//维修评价
@property (nonatomic, strong) UILabel *wxpjContent;
@property (nonatomic, strong) UILabel *pjyjLabel;//评价意见
@property (nonatomic, strong) UIImageView *imgView2;//图片
@property (nonatomic, strong) UIImageView *imgView3;
@property (nonatomic, strong) UIButton *pjrBtn;//电话

@end

@implementation PJDView

- (instancetype)init
{
    if (self = [super init]) {
        [self setSubViews];
    }
    return self;
}

- (void)callForPjrPhone
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", _model.operationPhone]]];
}

- (void)setSubViews
{
    _titleView = [UIView new];
    _titleView.backgroundColor = RGB(230, 239, 247);
    [self addSubview:_titleView];
    _titleLabel = [UILabel new];
    _titleLabel.text = @"评价人信息";
    _titleLabel.textColor = RGB(26, 71, 113);
    _titleLabel.font = k_text_font(14);
    [_titleView addSubview:_titleLabel];
    _pjsjLabel = [UILabel new];
    _pjsjLabel.text = @"评价时间:";
    _pjsjLabel.textAlignment = 2;
    _pjsjLabel.font = k_text_font(14);
    [self addSubview:_pjsjLabel];
    _pjsjContent = [UILabel new];
    _pjsjContent.font = k_text_font(14);
    [self addSubview:_pjsjContent];
    _pjrLabel = [UILabel new];
    _pjrLabel.text = @"评价人:";
    _pjrLabel.textAlignment = 2;
    _pjrLabel.font = k_text_font(14);
    [self addSubview:_pjrLabel];
    _pjrContent = [UILabel new];
    _pjrContent.font = k_text_font(14);
    [self addSubview:_pjrContent];
    _gzLabel = [UILabel new];
    _gzLabel.text = @"工种:";
    _gzLabel.textAlignment = 2;
    _gzLabel.font = k_text_font(14);
    [self addSubview:_gzLabel];
    _gzContent = [UILabel new];
    _gzContent.font = k_text_font(14);
    [self addSubview:_gzContent];
    _pjxxLabel = [UILabel new];
    _pjxxLabel.text = @"评价信息";
    _pjxxLabel.textColor = RGB(26, 71, 113);
    _pjxxLabel.font = k_text_font(14);
    [self addSubview:_pjxxLabel];
    _sfxfLabel = [UILabel new];
    _sfxfLabel.text = @"本故障是否修复:";
    _sfxfLabel.textAlignment = 2;
    _sfxfLabel.font = k_text_font(14);
    [self addSubview:_sfxfLabel];
    _sfxfContent = [UILabel new];
    _sfxfContent.font = k_text_font(14);
    [self addSubview:_sfxfContent];
    _wxpjLabel = [UILabel new];
    _wxpjLabel.text = @"本次维修评价:";
    _wxpjLabel.textAlignment = 2;
    _wxpjLabel.font = k_text_font(14);
    [self addSubview:_wxpjLabel];
    _wxpjContent = [UILabel new];
    _wxpjContent.font = k_text_font(14);
    [self addSubview:_wxpjContent];
    _pjyjLabel = [UILabel new];
    _pjyjLabel.text = @"评价意见:";
    _pjyjLabel.font = k_text_font(14);
    [self addSubview:_pjyjLabel];
    _pjyjContent = [UILabel new];
    _pjyjContent.numberOfLines = 0;
    _pjyjContent.font = k_text_font(14);
    [self addSubview:_pjyjContent];
    _imgView1 = [UIImageView new];
    [self addSubview:_imgView1];
    _imgView2 = [UIImageView new];
    [self addSubview:_imgView2];
    _imgView3 = [UIImageView new];
    [self addSubview:_imgView3];
    _pjrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pjrBtn setImage:[UIImage imageNamed:@"tel"] forState:normal];
    _pjrBtn.layer.cornerRadius = 20.f;
    _pjrBtn.layer.masksToBounds = YES;
    [_pjrBtn addTarget:self action:@selector(callForPjrPhone) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_pjrBtn];
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
    [_pjsjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@70);
        make.top.equalTo(_titleView.mas_bottom).offset(10);
        make.left.offset(10);
    }];
    [_pjsjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pjsjLabel.mas_right).offset(0);
        make.top.equalTo(_pjsjLabel);
    }];
    [_pjrLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(_pjsjLabel);
        make.top.equalTo(_pjsjLabel.mas_bottom).offset(5);
    }];
    [_pjrContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pjrLabel.mas_right).offset(0);
        make.top.equalTo(_pjrLabel);
    }];
    [_gzLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(_pjsjLabel);
        make.top.equalTo(_pjrLabel.mas_bottom).offset(5);
    }];
    [_gzContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gzLabel.mas_right).offset(0);
        make.top.equalTo(_gzLabel);
    }];
    [_pjxxLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pjsjLabel);
        make.top.equalTo(_gzLabel.mas_bottom).offset(10);
    }];
    [_sfxfLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_pjxxLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(@115);
    }];
    [_sfxfContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sfxfLabel.mas_right).offset(0);
        make.top.equalTo(_sfxfLabel);
    }];
    [_wxpjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sfxfLabel.mas_bottom).offset(5);
        make.left.width.equalTo(_sfxfLabel);
    }];
    [_wxpjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_wxpjLabel.mas_right).offset(0);
        make.top.equalTo(_wxpjLabel);
    }];
    [_pjyjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_wxpjLabel.mas_bottom).offset(5);
    }];
    [_pjyjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pjyjLabel.mas_bottom).offset(5);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    [_imgView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.offset(10);
        make.top.equalTo(_pjyjContent.mas_bottom).offset(10);
    }];
    [_imgView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_imgView1);
        make.left.equalTo(_imgView1.mas_right).offset(10);
    }];
    [_imgView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_imgView1);
        make.left.equalTo(_imgView2.mas_right).offset(10);
    }];
    [_pjrBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(_titleView.mas_bottom).offset(20);
        make.right.offset(-20);
    }];
}

@end
