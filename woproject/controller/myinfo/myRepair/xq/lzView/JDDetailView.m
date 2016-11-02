//
//  JDDetailView.m
//  woproject
//
//  Created by 徐洋 on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "JDDetailView.h"
#import "LZModel.h"

@interface JDDetailView ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
/**
 接单
 */
@property (nonatomic, strong) UILabel *jdsjLabel;//接单时间
@property (nonatomic, strong) UILabel *jdsjContent;
@property (nonatomic, strong) UILabel *jdrLabel;//接单人
@property (nonatomic, strong) UILabel *jdrContent;
@property (nonatomic, strong) UILabel *gzContent;//工种
@property (nonatomic, strong) UIButton *jdPhone;

@end

@implementation JDDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setSubViews];
    }
    return self;
}

- (void)setModel:(LZModel *)model
{
    _model = model;
    NSLog(@"model:%@", model);
    _jdsjContent.text = [self stdTimeToStr:model.operationTime];
    _jdrContent.text = model.operationUser;
    _gzContent.text = model.jobName;
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [objDateformat stringFromDate: date];
}

- (void)callForPdPhone:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", _model.operationPhone]]];
}

- (void)setSubViews
{
    _titleView = [UIView new];
    _titleView.backgroundColor = RGB(230, 239, 247);
    [self addSubview:_titleView];
    _titleLabel = [UILabel new];
    _titleLabel.text = @"接单信息";
    _titleLabel.textColor = RGB(26, 71, 113);
    _titleLabel.font = k_text_font(14);
    [_titleView addSubview:_titleLabel];
    _jdsjLabel = [UILabel new];
    _jdsjLabel.text = @"接单时间:";
    _jdsjLabel.font = k_text_font(14);
    _jdsjLabel.textAlignment = 2;
    [self addSubview:_jdsjLabel];
    _jdsjContent = [UILabel new];
    _jdsjContent.font = k_text_font(14);
    [self addSubview:_jdsjContent];
    _jdrLabel = [UILabel new];
    _jdrLabel.text = @"接单人:";
    _jdrLabel.font = k_text_font(14);
    _jdrLabel.textAlignment = 2;
    [self addSubview:_jdrLabel];
    _jdrContent = [UILabel new];
    _jdrContent.font = k_text_font(14);
    [self addSubview:_jdrContent];
    _gzLabel = [UILabel new];
    _gzLabel.text = @"工种:";
    _gzLabel.font = k_text_font(14);
    _gzLabel.textAlignment = 2;
    [self addSubview:_gzLabel];
    _gzContent = [UILabel new];
    _gzContent.font = k_text_font(14);
    [self addSubview:_gzContent];
    _jdPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jdPhone setImage:[UIImage imageNamed:@"tel"] forState:normal];
    _jdPhone.layer.cornerRadius = 20.f;
    _jdPhone.layer.masksToBounds = YES;
    [_jdPhone addTarget:self action:@selector(callForPdPhone:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_jdPhone];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    WS(weakSelf);
    //接单
    [_titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf).offset(0);
        make.height.mas_equalTo(@40);
    }];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.equalTo(_titleView);
    }];
    [_jdsjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.mas_equalTo(@70);
        make.top.equalTo(_titleView.mas_bottom).offset(10);
    }];
    [_jdsjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jdsjLabel);
        make.left.equalTo(_jdsjLabel.mas_right).offset(0);
    }];
    [_jdrLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_jdsjLabel);
        make.top.equalTo(_jdsjLabel.mas_bottom).offset(5);
    }];
    [_jdrContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jdrLabel);
        make.left.equalTo(_jdrLabel.mas_right).offset(0);
    }];
    [_gzLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_jdsjLabel);
        make.top.equalTo(_jdrLabel.mas_bottom).offset(5);
    }];
    [_gzContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gzLabel);
        make.left.equalTo(_gzLabel.mas_right);
    }];
    [_jdPhone mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.equalTo(_titleView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}

@end
