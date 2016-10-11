//
//  stdCellVc.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/21.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StdButtonDelegate <NSObject>
-(void)clickDelegate:(NSInteger)sendId;
@end

@interface stdCellVc : UIView
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *txtLable;
@property(nonatomic,strong)UIImageView *iconImg;
@property(nonatomic,strong)UIImageView *lookImg;
@property(nonatomic,assign)NSInteger senderId;
@property(nonatomic,strong)id<StdButtonDelegate> stdDelegate;

-(id)initWithFrame:(CGRect)frame iocnImg:(NSString*)iconImgName titleName:(NSString*)titleStr txtName:(NSString*)txtStr lookImg:(NSString*)lookStr sendid:(NSInteger)sendId;

@end
