//
//  STLoopProgressView.h
//  STLoopProgressView
//
//  Created by TangJR on 6/29/15.
//  Copyright (c) 2015 tangjr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, STClockWiseType) {
    STClockWiseYes,
    STClockWiseNo
};

@interface STLoopProgressView : UIView


- (instancetype)initWithFrame:(CGRect)frame withContent:(UIColor *)color;

@property (assign, nonatomic) CGFloat persentage;

@property (nonatomic, strong) UIColor *startColor;


@end
