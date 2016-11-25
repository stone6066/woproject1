//
//  LoopProgressSetView.m
//  STLoopProgressView
//
//  Created by 关宇琼 on 2016/10/31.
//  Copyright © 2016年 saitjr. All rights reserved.
//

#import "LoopProgressSetView.h"
#import "STLoopProgressView.h"

@interface LoopProgressSetView ()

@property (strong, nonatomic)  STLoopProgressView *loopProgressView;
@property (strong, nonatomic)  STLoopProgressView *loopProgressView1;

@property (strong, nonatomic)  STLoopProgressView *loopProgressView2;
@property (strong, nonatomic)  STLoopProgressView *loopProgressView3;
@property (nonatomic, strong) UILabel *contentLabel;


@end


@implementation LoopProgressSetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loopProgressView3];
        [self loopProgressView2];
        [self loopProgressView1];
        [self loopProgressView];
        [self contentLabel];
    }
    return self;
}

- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        [_contentLabel setFrame:CGRectMake(50, 70, 100, 50)];
        [self addSubview:_contentLabel];
        _contentLabel.textAlignment = 1;
        
    }
    
    return _contentLabel;
}

- (void)setTitleContent:(NSString *)titleContent {
    if (_titleContent != titleContent) {
        _titleContent = titleContent;
    }
    _contentLabel.attributedText = [MJYUtils attributeStr:[NSString stringWithFormat:@"%@kcge", _titleContent] changePartStr:[NSString stringWithFormat:@"%@", _titleContent] withFont:30 andColor:RGB(0,0,0)];

}

- (STLoopProgressView *)loopProgressView {
    if (!_loopProgressView) {
        _loopProgressView = [[STLoopProgressView  alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) withContent:RGB(45, 169, 243)];
        self.loopProgressView.persentage = 0.3;
        self.loopProgressView.backgroundColor = [UIColor clearColor];
     
        [self addSubview:_loopProgressView];
    }
    return  _loopProgressView;
}

- (STLoopProgressView *)loopProgressView1 {
    if (!_loopProgressView1) {
        _loopProgressView1 = [[STLoopProgressView  alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) withContent:RGB(78, 210, 143)];
        self.loopProgressView1.persentage = 0.5;
        self.loopProgressView1.backgroundColor = [UIColor clearColor];
        self.loopProgressView1.startColor = [UIColor redColor];
        [self addSubview:_loopProgressView1];
    }
    return  _loopProgressView1;
}

- (STLoopProgressView *)loopProgressView2 {
    if (!_loopProgressView2) {
        _loopProgressView2 = [[STLoopProgressView  alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) withContent:RGB(244, 193, 65)];
        self.loopProgressView2.persentage = 0.7;
        self.loopProgressView2.backgroundColor = [UIColor clearColor];
        [self addSubview:_loopProgressView2];
    }
    return  _loopProgressView2;
}


- (STLoopProgressView *)loopProgressView3 {
    if (!_loopProgressView3) {
        _loopProgressView3 = [[STLoopProgressView  alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) withContent:RGB(222, 227, 234)];
        self.loopProgressView3.persentage = 0.9;
        self.loopProgressView3.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0f];
        [self addSubview:_loopProgressView3];
    }
    return  _loopProgressView3;
}

- (void)setContentArr:(NSArray <NSNumber *> *)contentArr {
    
//    CGFloat all = [contentArr[1] floatValue] +[contentArr[0] floatValue] +[contentArr[2] floatValue] +[contentArr[3] floatValue];
    NSLog(@"%f",[contentArr[0] floatValue] / 100.0);
    self.loopProgressView.persentage = [contentArr[0] floatValue] / 100.0;
    self.loopProgressView1.persentage = ([contentArr[1] floatValue] +[contentArr[0] floatValue] ) /100.0;
    self.loopProgressView2.persentage = ([contentArr[1] floatValue] +[contentArr[0] floatValue] +[contentArr[2] floatValue]) /100.0;
    self.loopProgressView3.persentage = ([contentArr[1] floatValue] +[contentArr[0] floatValue] +[contentArr[2] floatValue] +[contentArr[3] floatValue] )/ 100.0;
}


@end
