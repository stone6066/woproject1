//
//  JDDetailView.h
//  woproject
//
//  Created by 徐洋 on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZModel;

@interface JDDetailView : UIView

@property (nonatomic, strong) LZModel *model;
@property (nonatomic, strong) UILabel *gzLabel;

@end
