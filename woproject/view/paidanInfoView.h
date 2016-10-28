//
//  paidanInfoView.h
//  woproject
//
//  Created by tianan-apple on 16/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol stdPaidanImgDelegate <NSObject>
-(void)stdPaidanClickDelegate:(NSString*)imgUrl;
@end
@class ticketFlowInfo;
@interface paidanInfoView : UIView
@property(nonatomic,strong)UILabel *myViewTitle;//视图标题
@property(nonatomic,strong)UILabel *operationTimeTitle;
@property(nonatomic,strong)UILabel *operationTime;//派单时间
@property(nonatomic,strong)UILabel *operationUserTitle;
@property(nonatomic,strong)UILabel *operationUser;//派单人
@property(nonatomic,strong)UILabel *userIdTitle;
@property(nonatomic,strong)UILabel *userId;//接单人
@property(nonatomic,strong)UILabel *deptIdTitle;
@property(nonatomic,strong)UILabel *deptId;//工种
@property(nonatomic,strong)UILabel *priorityTitle;
@property(nonatomic,strong)UILabel *priority;//优先级
@property(nonatomic,copy)NSString *operationPhone;
@property(nonatomic,strong)UIButton *phonebtn;//拨打电话
@property(nonatomic,strong)NSMutableArray *imgArr;//图片imageList


@property(nonatomic,strong)id<stdPaidanImgDelegate> stdPaidanImgDelegate;


-(void)asignDataToLab:(ticketFlowInfo*)modelData priority:(NSString*)pstr;
-(id)initWithFrame:(CGRect)frame;
@end
