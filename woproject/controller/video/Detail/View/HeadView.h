//
//  HeadView.h
//  mindeye
//
//  Created by wholeally on 15/2/15.
//  Copyright (c) 2015年 wholeally. All rights reserved.

#import <UIKit/UIKit.h>

#import "DeviceModel.h"
@class  DeviceGroup ;

@protocol HeadViewDelegate <NSObject>

@optional
- (void)clickHeadView;

@end

@interface HeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) DeviceModel *deviceGroup;

@property (nonatomic, weak) id<HeadViewDelegate> delegate;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end
