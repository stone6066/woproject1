//
//  MRCell.h
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRModel.h"

@interface MRCell : UITableViewCell

@property (nonatomic, strong) MRModel *model;
/**
 0-我的报修 1-我的派单 2-我的工单
 */
@property (nonatomic, copy) NSString *type;

@end
