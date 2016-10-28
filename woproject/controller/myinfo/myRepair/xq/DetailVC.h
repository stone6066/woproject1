//
//  DetailVC.h
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "WPViewController.h"

@interface DetailVC : WPViewController

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *v;
/**
 0-报修 1-派单 2-工单
 */
@property (nonatomic, copy) NSString *type;

@end
