//
//  SingleAnnotation.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "SingleAnnotation.h"

@interface SingleAnnotation ()

@property (nonatomic, strong) UILabel *word;
@property (nonatomic, strong) UIImageView *circle;
@property (nonatomic, strong) UILabel *count;

@end


@implementation SingleAnnotation


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self circle];
        
        [self word];
     
        [self count];
    }
    return self;
}

- (UILabel *)word {
    if (!_word) {
        
        _word = [[UILabel alloc] init];
        [self addSubview:_word];
        [_word mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(_circle);
            make.right.equalTo(_circle.mas_left).offset(-8);
           
        }];
    
        _word.font =[UIFont systemFontOfSize:15];
        
    }
    return _word;
}

- (UIImageView *)circle {
    if (!_circle) {
        _circle = [[UIImageView alloc] init];
        [self addSubview:_circle];
        [_circle mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        _circle.layer.cornerRadius = 6;
        _circle.layer.masksToBounds = YES;
    }
    return _circle;
}


- (UILabel *)count {
    if (!_count) {
        _count = [[UILabel alloc] init];
        [self addSubview:_count];
        [_count mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_circle);
            make.left.equalTo(_circle.mas_right).offset(8);
        }];
        _count.textColor = RGB(140,140, 140);
        _count.font =[UIFont systemFontOfSize:15];
    }
    return _count;
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
}


- (void)setCircleColor:(UIColor *)circleColor {
    _circle.backgroundColor = circleColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
