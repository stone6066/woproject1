//
//  LoginViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property(nonatomic,strong)UITextField *UsrTxtF;
@property(nonatomic,strong)UITextField *PassTxtF;
@property(nonatomic,strong)UIButton *LoginBtn;
@property(nonatomic,strong)UIButton *actionBtn;
@property(nonatomic,strong)UIButton *checkbox;
@property(nonatomic,strong)UIImageView *cancelVc;
@property(nonatomic,strong)UIImageView *cancelVc1;
@property (nonatomic, copy) void (^loginSuccBlock) (LoginViewController *);
@property (nonatomic, copy) void (^loginFailBlock) (LoginViewController *);
@end
