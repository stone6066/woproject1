//
//  UIView+WPEmptyView.m
//  woproject
//
//  Created by 徐洋 on 2016/10/30.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "UIView+WPEmptyView.h"
#import <objc/runtime.h>

static void *messagelabel = (void *)@"messagelabel";

@interface UIView ()

@property (nonatomic, strong) UILabel *msgLabel;

@end

@implementation UIView (WPEmptyView)

- (void)showEmptyMessage:(NSString *)msg dataSourceCount:(NSInteger)count
{
    if (count != 0) {
        [self.msgLabel removeFromSuperview];
        return;
    }else{
        self.msgLabel.text = msg;
        [self addSubview:self.msgLabel];
        self.msgLabel.frame = CGRectMake(0, 60, fDeviceWidth, 40);
    }
}

- (void)setMsgLabel:(UILabel *)msgLabel
{
    objc_setAssociatedObject(self, &messagelabel, msgLabel, OBJC_ASSOCIATION_RETAIN);

}

- (UILabel *)msgLabel
{
    if (!objc_getAssociatedObject(self, &messagelabel)) {
        self.msgLabel = [UILabel new];
        self.msgLabel.font = k_text_font(14);
        self.msgLabel.textAlignment = 1;
    }
    return objc_getAssociatedObject(self, &messagelabel);
}

@end
