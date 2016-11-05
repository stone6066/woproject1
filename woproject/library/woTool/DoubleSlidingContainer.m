//
//  DoubleSlidingContainer.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/26.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DoubleSlidingContainer.h"


#define titleW         fDeviceWidth / 3.0


@interface DoubleSlidingContainer () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScr;
@property (nonatomic, strong) UIScrollView *contentScr;

@end

@implementation DoubleSlidingContainer



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self titleScr];
        [self contentScr];
    }
    return self;
}

- (UIScrollView *)titleScr {
    
    if (!_titleScr) {
        _titleScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, 45)];
        _titleScr.showsVerticalScrollIndicator = NO;
        _titleScr.showsHorizontalScrollIndicator = NO;
        [self addSubview:_titleScr];
    }
    
    return _titleScr;
}

- (UIScrollView *)contentScr {
    
    if (!_contentScr) {
        _contentScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, fDeviceWidth, 275)];
        _contentScr.showsVerticalScrollIndicator = NO;
        _contentScr.showsHorizontalScrollIndicator = NO;
        _contentScr.pagingEnabled = YES;
        _contentScr.delegate = self;
        [self addSubview:_contentScr];
    }
    
    return _contentScr;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger a = scrollView.contentOffset.x / fDeviceWidth + 10;
    UIButton  *bt = [_titleScr viewWithTag: a];
    [self titleClick:bt];
}


- (void)setTitleArr:(NSArray *)titleArr {
    if (_titleArr != titleArr) {
        _titleArr = titleArr;
    }
    
    for (NSInteger i = 0; i < _titleArr.count; i ++) {
        UIButton *bt = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [bt setTitleColor:RGB(140, 140, 140) forState:(UIControlStateNormal)];

        [_titleScr addSubview:bt];
        [bt setFrame:CGRectMake(titleW * i, 0, titleW, 45)];
        [bt setTitle:_titleArr[i] forState:(UIControlStateNormal)];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        bt.tag = i + 10;
        [bt addTarget:self action:@selector(titleClick:) forControlEvents:(UIControlEventTouchUpInside)];
        if (bt.tag == 10) {
             [bt setTitleColor:RGB(60, 60, 60) forState:(UIControlStateNormal)];
            bt.titleLabel.font = [UIFont systemFontOfSize:16];

        }
        
    }
    
    _titleScr.contentSize = CGSizeMake(titleW *_titleArr.count, 0);
    
    _contentScr.contentSize = CGSizeMake(fDeviceWidth *_titleArr.count, 0);
   
}
- (void) setContentArr:(NSArray *)contentArr {
    if (_contentArr != contentArr) {
        _contentArr = contentArr;
    }
    int i = 0;
    for (UIView *view in _contentArr) {
        [_contentScr addSubview:view];
        [view setFrame:CGRectMake(fDeviceWidth * i, 0, fDeviceWidth, 275)];
        i ++;
    }
}


- (void)titleClick:(UIButton *)bt {
    
    bt.titleLabel.font = [UIFont systemFontOfSize:16];
    [bt setTitleColor:RGB(60, 60, 60) forState:(UIControlStateNormal)];

    for (UIButton *bbt in _titleScr.subviews) {
        if (![bbt isEqual:bt]) {
            bbt.titleLabel.font = [UIFont systemFontOfSize:14];
            [bbt setTitleColor:RGB(140, 140, 140) forState:(UIControlStateNormal)];
        }
    }
    if (_titleScr.subviews.count > 3) {
        switch (bt.tag) {
            case 11:
                [_titleScr setContentOffset:CGPointMake(0, 0) animated:YES];
                break;
            case 12:
                [_titleScr setContentOffset:CGPointMake(titleW, 0) animated:YES];
                break;
            case 13:
                [_titleScr setContentOffset:CGPointMake(titleW * 2, 0) animated:YES];
                break;
            default:
                break;
        }
    }
    
    
    [_contentScr setContentOffset:CGPointMake((bt.tag-10) * fDeviceWidth, 0) animated:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"lalalallalalalala" object:nil userInfo:@{@"content":bt.titleLabel.text}];
    
    NSLog(@"123");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
