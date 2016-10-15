//
//  ActionUserViewController.h
//  woproject
//
//  Created by tianan-apple on 16/10/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionUserViewController : UIViewController
@property(nonatomic,strong)UITextField *MobileTxtF;
@property(nonatomic,strong)UITextField *PswTxtF;
@property(nonatomic,strong)UITextField *PswTxtF1;
@property(nonatomic,strong)UIButton *actionBtn;

@property (nonatomic, copy) void (^actionSuccBlock) (ActionUserViewController *);
@property (nonatomic, copy) void (^actionFailBlock) (ActionUserViewController *);

@end
