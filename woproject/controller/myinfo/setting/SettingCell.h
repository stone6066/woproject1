//
//  SettingCell.h
//  woproject
//
//  Created by 徐洋 on 16/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UISwitch *setSwitch;
@property (nonatomic, strong) UIImageView *qrImgView;
@property (nonatomic, strong) UILabel *loginOut;

@end
