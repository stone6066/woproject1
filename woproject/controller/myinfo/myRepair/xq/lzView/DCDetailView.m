//
//  DCDetailView.m
//  woproject
//
//  Created by 徐洋 on 2016/10/26.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DCDetailView.h"
#import "LZModel.h"

@interface DCDetailView ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dcsjlabel;//到场时间
@property (nonatomic, strong) UILabel *dcsjContent;
@property (nonatomic, strong) UILabel *dcrContent;//到场人

@end

@implementation DCDetailView

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
    _dcsjContent.text = [self stdTimeToStr:model.operationTime];
    _dcrContent.text = model.operationUser;
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [objDateformat stringFromDate: date];
}

- (void)setSubViews
{
    _titleView = [UIView new];
    _titleView.backgroundColor = RGB(230, 239, 247);
    [self addSubview:_titleView];
    _titleLabel = [UILabel new];
    _titleLabel.text = @"到场信息";
    _titleLabel.textColor = RGB(26, 71, 113);
    _titleLabel.font = k_text_font(14);
    [_titleView addSubview:_titleLabel];
    _dcsjlabel = [UILabel new];
    _dcsjlabel.text = @"到场时间:";
    _dcsjlabel.font = k_text_font(14);
    _dcsjlabel.textAlignment = 2;
    [self addSubview:_dcsjlabel];
    _dcsjContent = [UILabel new];
    _dcsjContent.font = k_text_font(14);
    [self addSubview:_dcsjContent];
    _dcrLabel = [UILabel new];
    _dcrLabel.text = @"到场人:";
    _dcrLabel.font = k_text_font(14);
    _dcrLabel.textAlignment = 2;
    [self addSubview:_dcrLabel];
    _dcrContent = [UILabel new];
    _dcrContent.font = k_text_font(14);
    [self addSubview:_dcrContent];
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
    [_dcsjlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@70);
        make.left.offset(10);
        make.top.equalTo(_titleView.mas_bottom).offset(10);
    }];
    [_dcsjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dcsjlabel);
        make.left.equalTo(_dcsjlabel.mas_right);
    }];
    [_dcrLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_dcsjlabel);
        make.top.equalTo(_dcsjlabel.mas_bottom).offset(5);
    }];
    [_dcrContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dcrLabel);
        make.left.equalTo(_dcrLabel.mas_right);
    }];
}

@end
