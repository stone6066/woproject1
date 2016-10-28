//
//  WCDetailView.h
//  woproject
//
//  Created by 徐洋 on 2016/10/26.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZModel;

@interface WCDetailView : UIView

@property (nonatomic, strong) LZModel *model;
@property (nonatomic, strong) UILabel *wxjgContent;
@property (nonatomic, strong) UIImageView *imgView1;

@end
