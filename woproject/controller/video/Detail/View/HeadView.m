//
//  HeadView.m
//  QQ好友列表
//
//  Created by TianGe-ios on 14-8-21.
//  Copyright (c) 2014年 TianGe-ios. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "HeadView.h"
#import "DeviceModel.h"
#import "StringUtils.h"

@interface HeadView()

@property (weak, nonatomic) IBOutlet UIImageView *deviceIcon;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UILabel *deviceAddressLabel;
- (IBAction)headBtnClick;

@end

@implementation HeadView

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    
    static NSString *headIdentifier = @"headView";
    HeadView *cell = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:nil options:nil][0];
        
    }
    return cell;
}


- (void)setDeviceGroup:(DeviceModel *)deviceGroup
{
    _deviceGroup = deviceGroup;
    self.deviceNameLabel.text = [NSString stringWithFormat:@"%lld",deviceGroup.device_id] ;
    self.deviceAddressLabel.text =[NSString stringWithFormat:@"%lld",deviceGroup.device_id] ;
    if(!deviceGroup.status)
    {
     self.deviceNameLabel.textColor=[StringUtils colorWithHexString:@"#666666"];
     self.deviceAddressLabel.textColor=[StringUtils colorWithHexString:@"#666666"];
    }
    else
    {
        self.deviceNameLabel.textColor=[UIColor blackColor];
        self.deviceAddressLabel.textColor=[UIColor blackColor];
    }
}




- (IBAction)headBtnClick; {
    
    _deviceGroup.opened = !_deviceGroup.isOpened;
    if ([_delegate respondsToSelector:@selector(clickHeadView)]) {
        [_delegate clickHeadView];
    }

}
@end
