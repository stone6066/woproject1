//
//  VideoDetailCollectionViewCell.m
//  woproject
//
//  Created by tianan-apple on 2016/11/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "VideoDetailCollectionViewCell.h"
#import "ChannelModel.h"

@implementation VideoDetailCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)showCellView:(ChannelModel*)dataModel{
    self.channelNo=dataModel.channelNo;
    self.txtDetail.text=dataModel.channelName;
}
@end
