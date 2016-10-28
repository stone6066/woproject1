//
//  backOrderViewInfo.h
//  woproject
//
//  Created by tianan-apple on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol stdBackOrderImgDelegate <NSObject>
-(void)stdBackOrderImgDelegate:(NSString*)imgUrl;
@end

@class ticketFlowInfo;
@interface backOrderViewInfo : UIView
@property(nonatomic,strong)UILabel *myViewTitle;//视图标题
@property(nonatomic,strong)UILabel *operationTimeTitle;
@property(nonatomic,strong)UILabel *operationTime;//退单时间
@property(nonatomic,strong)UILabel *userIdTitle;
@property(nonatomic,strong)UILabel *userId;//退单人

@property(nonatomic,strong)UILabel *hangupResonTitle;//退单描述
@property(nonatomic,strong)UILabel *hangupReson;
@property(nonatomic,copy)NSString *operationPhone;

@property(nonatomic,strong)UIButton *phonebtn;//拨打电话

@property(nonatomic,strong)NSMutableArray *imgArr;//图片imageList
@property(nonatomic,strong)id<stdBackOrderImgDelegate> stdBackOrderImgDelegate;
-(id)initWithFrame:(CGRect)frame;
-(void)asignDataToLab:(ticketFlowInfo*)modelData;
@end
