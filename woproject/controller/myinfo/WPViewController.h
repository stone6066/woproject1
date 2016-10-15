//
//  WPViewController.h
//  woproject
//
//  Created by 徐洋 on 16/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPViewController : UIViewController

@property (nonatomic, copy) NSString *topTitle;
@property (nonatomic, assign) BOOL isHiddenBackItem;
@property (nonatomic, strong) UIButton *righButon;
@property (nonatomic, copy) NSString *rightTitle;
@property (nonatomic, strong) UIImage *rightImage;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIImage *leftImage;
/**
 back
 */
- (void)clickleftbtn;
- (void)initUI;

@end
