//
//  CircleAnnotationView.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "CircleAnnotationView.h"
#import "SingleAnnotation.h"

@interface CircleAnnotationView ()

@property (nonatomic, strong) UILabel *right;
@property (nonatomic, strong) UILabel *left;

@property (nonatomic, strong) NSArray *wordArr;
@property (nonatomic, strong) NSArray *colorArr;
@property (nonatomic, strong) NSMutableArray *anntionArr;

@end

@implementation CircleAnnotationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wordArr = @[@"高" , @"中" , @"低"];
        _colorArr = @[[UIColor blueColor], [UIColor brownColor],[UIColor greenColor]];
        _anntionArr = [NSMutableArray arrayWithCapacity:0];
        [self setSingleView];
        [self right];
        [self left];

    }
    return self;
}



- (void)setSingleView {
    for (int i = 0;i < 3; i ++) {
        SingleAnnotation *singleAnnotation = [[SingleAnnotation alloc] init];
        [self addSubview:singleAnnotation];
        [_anntionArr addObject:singleAnnotation];
        [singleAnnotation mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(fDeviceWidth / 3 * i);
            make.width.equalTo(@(fDeviceWidth / 3));
        }];
        singleAnnotation.wordStr = _wordArr[i];
        singleAnnotation.circleColor = _colorArr[i];
        singleAnnotation.countStr = _countArr[i];
    }
}

- (UILabel *)left {
    if (!_left) {
        _left = [[UILabel alloc] init];
        [self addSubview:_left];
        [_left mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(2, 20));
            make.centerY.equalTo(self);
            make.centerX.equalTo(self).offset(-fDeviceWidth / 6);
        }];
        _left.backgroundColor = RGB(190, 190, 190);
    }
    return _left;
}

- (UILabel *)right {
    if (!_right) {
        _right = [[UILabel alloc] init];
        [self addSubview:_right];
        [_right mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(2, 20));
            make.centerY.equalTo(self);
            make.centerX.equalTo(self).offset(fDeviceWidth / 6);

        }];
        _right.backgroundColor = RGB(190, 190, 190);
    }
    return _right;
}


- (void)setCountArr:(NSArray *)countArr {
    if (_countArr != countArr) {
        _countArr = countArr;
    
    }
    for (NSInteger i = 0; i < 3; i ++) {
        SingleAnnotation *singleAnnotation = _anntionArr[i];
        singleAnnotation.countStr = _countArr[i];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
