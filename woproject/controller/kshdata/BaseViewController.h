//
//  BaseViewController.h
//  woproject
//
//  Created by 关宇琼 on 2016/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController 

@property (nonatomic, copy) NSString *topTitle;

@property (nonatomic, assign) BOOL dateListShow;


@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, copy) NSString *provinceIdStr;
@property (nonatomic, copy) NSString *cityIdStr;
@property (nonatomic, copy) NSString *projectIdStr;



- (void)initFrontProperties;

@end
