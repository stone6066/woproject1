//
//  ModifyPhoneView.h
//  woproject
//
//  Created by 徐洋 on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPhoneView : UIView
<
UITextFieldDelegate
>

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, strong) UITextField *phoneFD;
@property (nonatomic, strong) UIButton *saveButton;

@end
