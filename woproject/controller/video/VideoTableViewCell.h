//
//  VideoTableViewCell.h
//  woproject
//
//  Created by tianan-apple on 2016/11/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;
@interface VideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *camNum;//个数
@property (weak, nonatomic) IBOutlet UILabel *projectName;//项目名称
@property (weak, nonatomic) IBOutlet UILabel *buildName;//建筑名称
@property (weak, nonatomic) IBOutlet UILabel *nonCam;
@property (weak, nonatomic) IBOutlet UILabel *onlineCam;
@property (weak, nonatomic) IBOutlet UIImageView *camIcon;
@property (weak, nonatomic) IBOutlet UILabel *unitGe;
@property(nonatomic,copy)NSString *devNo;

-(void)showCellView:(VideoModel*)dataModel;
@end
