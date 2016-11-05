//
//  MRCell.m
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MRCell.h"

@interface MRCell ()

@property (nonatomic, strong) UILabel *gzsbLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *jdsjLabel;
@property (nonatomic, strong) UILabel *xmmcLabel;
@property (nonatomic, strong) UILabel *yxjLabel;
@property (nonatomic, strong) UILabel *xmmsLabel;
@property (nonatomic, strong) UILabel *xmmsContent;
@property (nonatomic, strong) UIImageView *img;

@end

@implementation MRCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubViews];
    }
    return self;
}

- (void)setModel:(MRModel *)model
{
    _model = model;
    NSLog(@"%@", model);
    _gzsbLabel.text = [NSString stringWithFormat:@"故障设备:%@", model.deviceName];

    _stateLabel.text = model.ticketStatus;

    _jdsjLabel.text = [NSString stringWithFormat:@"报修时间:  %@", [self stdTimeToStr:model.createTime]];
    _xmmcLabel.text = [NSString stringWithFormat:@"项目名称:  %@", model.projectId];
    _yxjLabel.text = model.priority != nil?[NSString stringWithFormat:@"优先级:  %@", model.priority]:@"优先级: 无";
    _xmmsContent.text = model.faultDesc;
    _img.hidden = [model.isNew isEqualToString:@"1"]?NO:[model.isNew isEqualToString:@"2"]?YES:NO;
}

- (void)setType:(NSString *)type
{
    if ([type isEqualToString:@"2"]) {
        _jdsjLabel.text = [_jdsjLabel.text stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@"完成"];
    }
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
    _gzsbLabel = [UILabel new];
    _gzsbLabel.font = k_text_font(14);
    _gzsbLabel.textColor = RGB(135, 137, 176);
    [self.contentView addSubview:_gzsbLabel];
    _stateLabel = [UILabel new];
    _stateLabel.font = k_text_font(18);
    _stateLabel.textColor = RGB(89, 148, 184);
    [self.contentView addSubview:_stateLabel];
    _lineView = [UIView new];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_lineView];
    _jdsjLabel = [UILabel new];
    _jdsjLabel.font = k_text_font(14);
    _jdsjLabel.textColor = RGB(123, 123, 123);
    [self.contentView addSubview:_jdsjLabel];
    _xmmcLabel = [UILabel new];
    _xmmcLabel.font = k_text_font(14);
    _xmmcLabel.textColor = RGB(123, 123, 123);
    [self.contentView addSubview:_xmmcLabel];
    _yxjLabel = [UILabel new];
    _yxjLabel.font = k_text_font(14);
    _yxjLabel.textColor = RGB(123, 123, 123);
    [self.contentView addSubview:_yxjLabel];
    _xmmsLabel = [UILabel new];
    _xmmsLabel.font = k_text_font(14);
    _xmmsLabel.textColor = RGB(123, 123, 123);
    _xmmsLabel.text = @"项目描述:";
    [self.contentView addSubview:_xmmsLabel];
    _xmmsContent = [UILabel new];
    _xmmsContent.font = k_text_font(14);
    _xmmsContent.textColor = RGB(123, 123, 123);
    _xmmsContent.numberOfLines = 0;
    [self.contentView addSubview:_xmmsContent];
    _img = [UIImageView new];
    _img.image = [UIImage imageNamed:@"new"];
    [self addSubview:_img];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_gzsbLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(10);
    }];
    [_stateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_gzsbLabel);
        make.right.offset(-10);
    }];
    [_img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(_stateLabel.mas_left).offset(-10);
        make.centerY.equalTo(_stateLabel);
    }];
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_gzsbLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(@1);
    }];
    [_jdsjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_lineView.mas_bottom).offset(10);
    }];
    [_xmmcLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_jdsjLabel.mas_bottom).offset(10);
    }];
    [_yxjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_xmmcLabel.mas_bottom).offset(10);
    }];
    [_xmmsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_yxjLabel.mas_bottom).offset(10);
    }];
    [_xmmsContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_xmmsLabel.mas_bottom).offset(5);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.lessThanOrEqualTo(@50);
    }];
}

@end
