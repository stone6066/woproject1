//
//  PDDetailView.m
//  woproject
//
//  Created by 徐洋 on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "PDDetailView.h"
#import "LZModel.h"

@interface PDDetailView ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pdsjLabel;//派单时间
@property (nonatomic, strong) UILabel *pdsjContent;
@property (nonatomic, strong) UILabel *pdrLabel;//派单人
@property (nonatomic, strong) UILabel *pdrContent;
@property (nonatomic, strong) UILabel *jdrLabel;//接单人
@property (nonatomic, strong) UILabel *jdrContent;
@property (nonatomic, strong) UILabel *gzLabel;//工种
@property (nonatomic, strong) UILabel *gzContent;
@property (nonatomic, strong) UIButton *pdPhone;

@end

@implementation PDDetailView

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
    NSLog(@"派单详情:%@", model);
    _pdsjContent.text = [self stdTimeToStr:model.operationTime];
    _pdrContent.text = model.operationUser;
    _gzContent.text = model.jobName;
    _jdrContent.text = model.userId;
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
    _titleLabel.text = @"派单信息";
    _titleLabel.textColor = RGB(26, 71, 113);
    _titleLabel.font = k_text_font(14);
    [_titleView addSubview:_titleLabel];
    _pdsjLabel = [UILabel new];
    _pdsjLabel.text = @"派单时间:";
    _pdsjLabel.font = k_text_font(14);
    _pdsjLabel.textAlignment = 2;
    [self addSubview:_pdsjLabel];
    _pdsjContent = [UILabel new];
    _pdsjContent.font = k_text_font(14);
    [self addSubview:_pdsjContent];
    _pdrLabel = [UILabel new];
    _pdrLabel.text = @"派单人:";
    _pdrLabel.font = k_text_font(14);
    _pdrLabel.textAlignment = 2;
    [self addSubview:_pdrLabel];
    _pdrContent = [UILabel new];
    _pdrContent.font = k_text_font(14);
    [self addSubview:_pdrContent];
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
    _yxjLabel = [UILabel new];
    _yxjLabel.text = @"优先级:";
    _yxjLabel.font = k_text_font(14);
    _yxjLabel.textAlignment = 2;
    [self addSubview:_yxjLabel];
    _yxjContent = [UILabel new];
    _yxjContent.font = k_text_font(14);
    [self addSubview:_yxjContent];
    _pdPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pdPhone setImage:[UIImage imageNamed:@"tel"] forState:normal];
    _pdPhone.layer.cornerRadius = 20.f;
    _pdPhone.layer.masksToBounds = YES;
    [_pdPhone addTarget:self action:@selector(callForPdPhone:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_pdPhone];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    WS(weakSelf);
    [_titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf).offset(0);
        make.height.mas_equalTo(@40);
    }];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.equalTo(_titleView);
    }];
    [_pdsjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.mas_equalTo(@70);
        make.top.equalTo(_titleView.mas_bottom).offset(10);
    }];
    [_pdsjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pdsjLabel);
        make.left.equalTo(_pdsjLabel.mas_right).offset(0);
    }];
    [_pdrLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_pdsjLabel);
        make.top.equalTo(_pdsjLabel.mas_bottom).offset(5);
    }];
    [_pdrContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pdrLabel);
        make.left.equalTo(_pdrLabel.mas_right);
    }];
    [_jdrLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_pdsjLabel);
        make.top.equalTo(_pdrLabel.mas_bottom).offset(5);
    }];
    [_jdrContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jdrLabel);
        make.left.equalTo(_jdrLabel.mas_right).offset(0);
    }];
    [_gzLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_pdsjLabel);
        make.top.equalTo(_jdrLabel.mas_bottom).offset(5);
    }];
    [_gzContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gzLabel);
        make.left.equalTo(_gzLabel.mas_right);
    }];
    [_yxjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gzLabel.mas_bottom).offset(5);
        make.width.left.equalTo(_pdsjLabel);
    }];
    [_yxjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_yxjLabel);
        make.left.equalTo(_yxjLabel.mas_right);
    }];
    [_pdPhone mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.offset(-20);
        make.top.equalTo(_titleView.mas_bottom).offset(20);
    }];
}

@end
