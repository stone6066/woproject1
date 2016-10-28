//
//  jiedanInfoView.h
//  woproject
//
//  Created by tianan-apple on 16/10/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ticketFlowInfo;
@interface jiedanInfoView : UIView
@property(nonatomic,strong)UILabel *myViewTitle;//视图标题
@property(nonatomic,strong)UILabel *operationTimeTitle;
@property(nonatomic,strong)UILabel *operationTime;//接单时间
@property(nonatomic,strong)UILabel *userIdTitle;
@property(nonatomic,strong)UILabel *userId;//接单人
@property(nonatomic,strong)UILabel *deptIdTitle;
@property(nonatomic,strong)UILabel *deptId;//工种
@property(nonatomic,copy)NSString *operationPhone;


-(void)asignDataToLab:(ticketFlowInfo*)modelData;
-(id)initWithFrame:(CGRect)frame;
@end
