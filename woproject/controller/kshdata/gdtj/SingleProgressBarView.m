//
//  SingleProgressBarView.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "SingleProgressBarView.h"
#import "THProgressView.h"
#import  "LDProgressView.h"

@interface SingleProgressBarView ()

@property (nonatomic, strong) LDProgressView  *progressBarRoundedSlim;
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
        _count.font =[UIFont boldSystemFontOfSize:18];
    }
    return _count;
}

- (LDProgressView *)progressBarRoundedSlim {
    if (!_progressBarRoundedSlim) {
        _progressBarRoundedSlim = [[LDProgressView alloc] init];
        [self addSubview:_progressBarRoundedSlim];
        [_progressBarRoundedSlim mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_word.mas_bottom);
            make.right.equalTo(self).offset(-8);
            make.left.equalTo(self).offset(8);
            make.height.equalTo(@18);
        }];
        
        
        _progressBarRoundedSlim.flat = @YES;
        _progressBarRoundedSlim.animate = @YES;
        _progressBarRoundedSlim.showStroke = @NO;
        _progressBarRoundedSlim.progressInset = @2;
        _progressBarRoundedSlim.showBackground = @NO;
        _progressBarRoundedSlim.outerStrokeWidth = @1;
        _progressBarRoundedSlim.type = LDProgressSolid;
        
        _progressBarRoundedSlim.textAlignment = NSTextAlignmentCenter;
        [_progressBarRoundedSlim overrideProgressTextColor:[UIColor whiteColor]];
        
        [self addSubview:_progressBarRoundedSlim];

        
    }
    return _progressBarRoundedSlim;
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
    if ([_totalCount isEqualToString:@"0"]) {
        _totalCount =@"100";
    }
    _progressBarRoundedSlim.progress = [_countStr integerValue] / [_totalCount floatValue] ;
    [_progressBarRoundedSlim overrideProgressText:_countStr];

}

- (void)setCircleColor:(UIColor *)circleColor {
    
    _progressBarRoundedSlim.color = circleColor;

    

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
