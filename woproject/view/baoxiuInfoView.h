//
//  baoxiuInfoView.h
//  woproject
//
//  Created by tianan-apple on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface baoxiuInfoView : UIView
@property(nonatomic,strong)UILabel *myViewTitle;//视图标题
@property(nonatomic,strong)UILabel *repairTimetitle;
@property(nonatomic,strong)UILabel *repairTime;//保修时间
@property(nonatomic,strong)UILabel *repairPersonTitle;
@property(nonatomic,strong)UILabel *repairPerson;//报修人
@property(nonatomic,strong)UILabel *projectNameTitle;
@property(nonatomic,strong)UILabel *projectName;//项目名称
@property(nonatomic,strong)UILabel *faultDevTitle;
@property(nonatomic,strong)UILabel *faultDev;//故障设备
@property(nonatomic,strong)UILabel *faultPosTitle;
@property(nonatomic,strong)UILabel *faultPos;//故障位置
@property(nonatomic,strong)UILabel *priorityTitle;
@property(nonatomic,strong)UILabel *priority;//优先级
@property(nonatomic,strong)UILabel *faultDescTitle;
@property(nonatomic,strong)UILabel *faultDesc;//故障描述
@end
