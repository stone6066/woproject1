//
//  MaxMinView.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MaxMinView.h"

@interface MaxMinView ()

@property (nonatomic, strong) UILabel *maxLb;
@property (nonatomic, strong) UILabel *minLb;
@property (nonatomic, strong) UILabel *middleLb;
@property (nonatomic, strong) UILabel *maxCLb;
@property (nonatomic, strong) UILabel *minCLb;
@property (nonatomic, strong) UILabel *middleCLb;

@end

@implementation MaxMinView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.layer.cornerRadius = 20.0f;
        self.layer.masksToBounds = YES;
        
        [self maxLb];
        [self maxCLb];
        [self middleLb];
        [self middleCLb];
        [self minCLb];
        [self minLb];
        
    }
    return self;
}

- (UILabel *)maxLb {
    
    if (!_maxLb) {
        _maxLb = [[UILabel alloc] init];
        [self addSubview:_maxLb];
        [_maxLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.equalTo(@(fDeviceWidth *0.15));
        }];
        _maxLb.textAlignment = 2;
        _maxLb.font = [UIFont systemFontOfSize: 12];
        _maxLb.text = @"最大值:";
        
    }
    
    return _maxLb;
}
- (UILabel *)maxCLb {
    if (!_maxCLb) {
        _maxCLb = [[UILabel alloc] init];
        [self addSubview:_maxCLb];
        [_maxCLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            
            make.left.equalTo(_maxLb.mas_right);

            make.width.equalTo(@(fDeviceWidth *0.15));
        }];
        _maxCLb.textAlignment = 0;
        _maxCLb.font = [UIFont boldSystemFontOfSize: 15];
    }
    return _maxCLb;
}
- (UILabel *)middleLb {
    if (!_middleLb) {
        _middleLb = [[UILabel alloc] init];
        [self addSubview:_middleLb];
        [_middleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(_maxCLb.mas_right);
            make.width.equalTo(@(fDeviceWidth *0.15));
        }];
        _middleLb.textAlignment = 2;
        _middleLb.font = [UIFont systemFontOfSize: 12];
        _middleLb.text = @"平均值:";
    }
    return _middleLb;
}
- (UILabel *)middleCLb {
    if (!_middleCLb) {
        _middleCLb = [[UILabel alloc] init];
        [self addSubview:_middleCLb];
        [_middleCLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(_middleLb.mas_right);
            make.width.equalTo(@(fDeviceWidth *0.15));
        }];
        _middleCLb.textAlignment = 0;
        _middleCLb.font = [UIFont boldSystemFontOfSize: 15];


    }
    return _middleCLb;
}
- (UILabel *)minLb {
    if (!_minLb) {
        _minLb = [[UILabel alloc] init];
        [self addSubview:_minLb];
        [_minLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(_minCLb.mas_left);
            make.width.equalTo(@(fDeviceWidth *0.15));
        }];
        _minLb.textAlignment = 2;
        _minLb.font = [UIFont systemFontOfSize: 12];

        _minLb.text = @"最小值:";
    }
    return _minLb;
}

- (UILabel *)minCLb {
    if (!_minCLb) {
        _minCLb = [[UILabel alloc] init];
        [self addSubview:_minCLb];
        [_minCLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self);
            make.width.equalTo(@(fDeviceWidth *0.15));
        }];
        _minCLb.textAlignment =0;
        _minCLb.font = [UIFont boldSystemFontOfSize: 15];

        _minCLb.text = @"123";
    }
    return _minCLb;
}



- (void)setCountDic:(NSDictionary *)countDic {
    if (_countDic != countDic) {
        _countDic = countDic;
    }
    _maxCLb.text = _countDic[@"Max"];
    _middleCLb.text = _countDic[@"Avg"];
    _minCLb.text = _countDic[@"Min"];
}

/*
 
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
