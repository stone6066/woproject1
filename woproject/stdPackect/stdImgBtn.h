//
//  stdImgBtn.h
//  PropertyManage
//
//  Created by tianan-apple on 16/6/30.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StdImgButtonDelegate <NSObject>
-(void)stdImgClickDelegate:(NSInteger)sendId;
@end
@interface stdImgBtn : UIView
@property(nonatomic,strong)id<StdImgButtonDelegate> stdImgBtnDelegate;
@property(nonatomic,strong)UIImageView *btnImg;
@property(nonatomic,strong)UILabel *btnLbl;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,assign)NSInteger senderId;

-(id)initWithFrame:(CGRect)frame imgName:(NSString*)imgstr lblName:(NSString*)lblstr sendId:(NSInteger)sId;
@end
