//
//  SingleAnalysisView.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "SingleAnalysisView.h"

@interface SingleAnalysisView ()

@property (nonatomic ,strong) UILabel *signLb;
@property (nonatomic ,strong) UILabel *nameLb;

@property (nonatomic ,strong) UILabel *accountedLb;
@property (nonatomic, strong) UILabel *countLb;



@end


@implementation SingleAnalysisView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self signLb];
        [self nameLb];
        [self accountedLb];
        [self countLb];
    }
    return self;
}

- (UILabel *)signLb {
    if (!_signLb) {
        _signLb = [[UILabel alloc] init];
        [self addSubview:_signLb];
        [_signLb setFrame:CGRectMake(15, 11, 8, 8)];
        
        _signLb.backgroundColor = [UIColor greenColor];
        
    }
    return _signLb;
}
- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        [self addSubview:_nameLb];
        [_nameLb setFrame:CGRectMake(25, 0, (fDeviceWidth/4 -25) * 0.6, 30)];
        _nameLb.textAlignment = 1;
        _nameLb.font = [UIFont systemFontOfSize:16];

    }
    return _nameLb;
}
- (UILabel *)accountedLb {
    if (!_accountedLb) {
        _accountedLb = [[UILabel alloc] init];
        [self addSubview:_accountedLb];
        [_accountedLb setFrame:CGRectMake((fDeviceWidth/4 -25) * 0.6 + 25, 0, (fDeviceWidth/4 - 25) * 0.4, 30)];
        _accountedLb.textColor = [UIColor lightGrayColor];
        _accountedLb.font = [UIFont systemFontOfSize:10];
    }
    return _accountedLb;
}
- (UILabel *)countLb {
    if (!_countLb) {
        _countLb = [[UILabel alloc] init];
        [self addSubview:_countLb];
        [_countLb setFrame:CGRectMake(0, 30, fDeviceWidth/4, 40)];
        _countLb.textAlignment = 1;
        _countLb.font = [UIFont boldSystemFontOfSize:23];
    }
    return _countLb;
}

- (void)setData:(NSDictionary *)data {
    if (_data != data) {
        _data = data;
    }
    _signLb.backgroundColor = _data[@"color"];
    _nameLb.text = _data[@"name"];
    _accountedLb.text = [NSString stringWithFormat:@"%@%%", _data[@"zhanbi"]];
    _countLb.text = _data[@"count"];
    NSLog(@"%@", _data);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
