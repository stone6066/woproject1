//
//  ModifyUserIDView.h
//  woproject
//
//  Created by 徐洋 on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyUserIDView : UIView
<
    UITextFieldDelegate
>

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, strong) UITextField *userIDFD;
@property (nonatomic, strong) UIButton *saveButton;

@end
