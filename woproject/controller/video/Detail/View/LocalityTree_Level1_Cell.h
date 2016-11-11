//
//  Locality_Level1_Cell.h
//  mindeye
//
//  Created by wholeally on 15/2/16.
//  Copyright (c) 2015年 wholeally. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LocalityTree_Level1_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *channelIcon;
@property (weak, nonatomic) IBOutlet UILabel *channelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *channelLineLabel;
+(instancetype)cellWithTableView:(UITableView *)tableView ;
@end
