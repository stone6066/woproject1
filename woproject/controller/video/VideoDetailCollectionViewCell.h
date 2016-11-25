//
//  VideoDetailCollectionViewCell.h
//  woproject
//
//  Created by tianan-apple on 2016/11/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChannelModel;
@interface VideoDetailCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *VideoImg;
@property (weak, nonatomic) IBOutlet UILabel *txtDetail;
@property(nonatomic,copy)NSString* channelNo;
-(void)showCellView:(ChannelModel*)dataModel;
@end
