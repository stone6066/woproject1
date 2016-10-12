//
//  ticketListTableViewCell.m
//  woproject
//
//  Created by tianan-apple on 16/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ticketListTableViewCell.h"
#import "ticketList.h"

@implementation ticketListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showCellView:(ticketList*)dataModel{
    _devName.text=dataModel.deviceName;
    _ticketType.text=dataModel.ticketStatus;
    _createTime.text=[self stdTimeToStr:dataModel.createTime];
    _projectName.text=dataModel.projectId;
    _level.text=dataModel.faultLevel;
    _detail.text=dataModel.faultDesc;
    _Id=dataModel.Id;

}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    return [objDateformat stringFromDate: date];
}

@end
