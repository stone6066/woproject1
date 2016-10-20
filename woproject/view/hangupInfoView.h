//
//  hangupInfoView.h
//  woproject
//
//  Created by tianan-apple on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ticketFlowInfo;
@interface hangupInfoView : UIView
@property(nonatomic,strong)UILabel *myViewTitle;//视图标题
@property(nonatomic,strong)UILabel *operationTimeTitle;
@property(nonatomic,strong)UILabel *operationTime;//挂起时间
@property(nonatomic,strong)UILabel *userIdTitle;
@property(nonatomic,strong)UILabel *userId;//挂起人
@property(nonatomic,strong)UILabel *deptIdTitle;
@property(nonatomic,strong)UILabel *deptId;//工种
@property(nonatomic,strong)UILabel *hangupResonTitle;//挂起标题
@property(nonatomic,strong)UILabel *hangupReson;
@property(nonatomic,copy)NSString *operationPhone;


-(id)initWithFrame:(CGRect)frame;
-(void)asignDataToLab:(ticketFlowInfo*)modelData;
@end
