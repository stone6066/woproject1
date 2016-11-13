//
//  VideoTableViewCell.m
//  woproject
//
//  Created by tianan-apple on 2016/11/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "VideoModel.h"
@implementation VideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showCellView:(VideoModel*)dataModel{
    self.projectName.text=dataModel.projectName;
    self.buildName.text=dataModel.deviceName;
    self.devNo=dataModel.deviceNo;
    NSInteger i=dataModel.channelList.count;
    if (i>0) {
        self.camNum.text=[NSString stringWithFormat:@"%ld",(long)i];
        self.nonCam.hidden=YES;
        self.onlineCam.hidden=NO;
        self.camIcon.hidden=NO;
        self.unitGe.hidden=NO;
        self.camNum.hidden=NO;
    }
    else{
        self.nonCam.hidden=NO;
        self.onlineCam.hidden=YES;
        self.camIcon.hidden=YES;
        self.unitGe.hidden=YES;
        self.camNum.hidden=YES;

    }
    
}

@end
