//
//  ProgressbarSetView.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ProgressbarSetView.h"
#import "SingleProgressBarView.h"


@interface ProgressbarSetView ()

@property (nonatomic, strong) NSArray *wordArr;
@property (nonatomic, strong) NSArray *colorArr;
@property (nonatomic, strong) NSMutableArray *anntionArr;

@end

@implementation ProgressbarSetView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        _wordArr = @[@"未派单" , @"未完成" , @"已完成"];
        _colorArr = @[[UIColor greenColor], [UIColor blueColor],[UIColor lightGrayColor]];
        _anntionArr = [NSMutableArray arrayWithCapacity:0];
        [self setSingleView];
    }
    return self;
}

- (void)setSingleView {
    for (int i = 0;i < 3; i ++) {
        SingleProgressBarView *singleProgressBarView = [[SingleProgressBarView alloc] init];
        [self addSubview:singleProgressBarView];
        [singleProgressBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(fDeviceWidth *0.9 / 3 * i);
            make.width.equalTo(@(fDeviceWidth*0.9 / 3));
        }];
        singleProgressBarView.wordStr = _wordArr[i];
        singleProgressBarView.circleColor = _colorArr[i];
    }
}
- (void)setCountArr:(NSArray *)countArr {
    if (_countArr != countArr) {
        _countArr = countArr;
    }
    NSInteger count = 0;
    for (NSString *str in _countArr) {
        NSInteger count1 = [str integerValue];
        count += count1;
    }
    for (NSInteger i = 0; i < 3; i ++) {
        SingleProgressBarView *singleProgressBarView = self.subviews[i];
        singleProgressBarView.totalCount = [NSString stringWithFormat:@"%ld", count];
        singleProgressBarView.countStr = _countArr[i];
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
