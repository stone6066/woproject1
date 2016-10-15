//
//  InfoCell.h
//  woproject
//
//  Created by 徐洋 on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoCell : UITableViewCell

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) UIButton *icon;
@property (nonatomic, strong) UILabel *icon_label;

@end
