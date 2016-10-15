//
//  SingleProgressBarView.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "SingleProgressBarView.h"

@interface SingleProgressBarView ()

@property (nonatomic, strong) YLProgressBar  *progressBarRoundedSlim;
@property (nonatomic, strong) UILabel  *count;
@property (nonatomic, strong) UILabel  *word;

@end


@implementation SingleProgressBarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self word];
        [self count];
        [self progressBarRoundedSlim];
        
    }
    return self;
}


- (UILabel *)word {
    if (!_word) {
        
        _word = [[UILabel alloc] init];
        
        [self addSubview:_word];
        
        [_word mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(8);
            make.top.equalTo(self);
            make.height.equalTo(@40);
            
        }];
        
        _word.font =[UIFont systemFontOfSize:15];
        _word.textColor = RGB(140, 140, 140);
        
        _word.text = @"未完成";
    }
    return _word;
}


- (UILabel *)count {
    if (!_count) {
        _count = [[UILabel alloc] init];
        [self addSubview:_count];
        [_count mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-8);
            make.top.equalTo(self);
            make.left.equalTo(_word.mas_right).offset(8);
            make.height.equalTo(@40);
        }];
        _count.textColor = RGB(0,0, 0);
        _count.font =[UIFont boldSystemFontOfSize:20];
    }
    return _count;
}

- (YLProgressBar *)progressBarRoundedSlim {
    if (!_progressBarRoundedSlim) {
        _progressBarRoundedSlim = [[YLProgressBar alloc] init];
        [self addSubview:_progressBarRoundedSlim];
        [_progressBarRoundedSlim mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_word.mas_bottom);
            make.right.equalTo(self).offset(-8);
            make.left.equalTo(self).offset(8);
            make.height.equalTo(@18);
        }];
        [self initRoundedSlimProgressBar];
        
    }
    return _progressBarRoundedSlim;
}

- (void)initRoundedSlimProgressBar
{
    _progressBarRoundedSlim.trackTintColor = [UIColor whiteColor];
    _progressBarRoundedSlim.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeTrack;
    
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [_progressBarRoundedSlim setProgress:progress animated:animated];
}



- (void)setWordStr:(NSString *)wordStr {
    if (_wordStr != wordStr) {
        _wordStr = wordStr;
    }
    _word.text = _wordStr;
}

- (void)setCountStr:(NSString *)countStr {
    if (_countStr != countStr) {
        _countStr = countStr;
    }
    _count.text = _countStr;
    NSLog(@"%@", _countStr);
    [self setProgress:[_countStr integerValue] / [_totalCount floatValue] animated:YES];
}

- (void)setCircleColor:(UIColor *)circleColor {
    _progressBarRoundedSlim.uniformTintColor = YES;
    _progressBarRoundedSlim.stripesColor = circleColor;
    _progressBarRoundedSlim.progressTintColor = circleColor;
}

- (void)setTotalCount:(NSString *)totalCount {
    if (_totalCount != totalCount) {
        _totalCount = totalCount;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
