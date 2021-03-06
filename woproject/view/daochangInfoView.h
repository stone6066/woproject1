//
//  daochangInfoView.h
//  woproject
//
//  Created by tianan-apple on 16/10/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ticketFlowInfo;
@interface daochangInfoView : UIView
@property(nonatomic,strong)UILabel *myViewTitle;//视图标题
@property(nonatomic,strong)UILabel *operationTimeTitle;
@property(nonatomic,strong)UILabel *operationTime;//到场时间
@property(nonatomic,strong)UILabel *operationUserTitle;
@property(nonatomic,strong)UILabel *operationUser;//到场人
//@property(nonatomic,strong)UILabel *userIdTitle;
//@property(nonatomic,strong)UILabel *userId;//接单人
//@property(nonatomic,strong)UILabel *deptIdTitle;
//@property(nonatomic,strong)UILabel *deptId;//工种
//@property(nonatomic,strong)UILabel *priorityTitle;
//@property(nonatomic,strong)UILabel *priority;//优先级
@property(nonatomic,copy)NSString *operationPhone;


-(NSString*)asignDataToLab:(ticketFlowInfo*)modelData;
-(id)initWithFrame:(CGRect)frame;

@end
