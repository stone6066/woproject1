//
//  stdTextField.h
//  nongcloud
//
//  Created by tianan-apple on 16/7/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol stdTextFieldDelegate <NSObject>
-(void)TextFieldDelegate:(UIButton*)sender;
@end

@interface stdTextField : UIView
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIImageView *iconImg;
@property(nonatomic,assign)NSInteger senderId;
@property(nonatomic,copy)NSString *txtId;
@property(nonatomic,strong)id<stdTextFieldDelegate> stdtxtDelegate;
-(void)setTitleLableTxt:(NSString*)txt;
-(void)setTxtId:(NSString *)txtId;
-(id)initWithFrame:(CGRect)frame titletxt:(NSString *)txt stdImg:(NSString*)img sendtag:(NSInteger)sendId;
@end
