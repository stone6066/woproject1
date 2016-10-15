//
//  ModifyPwdView.h
//  woproject
//
//  Created by 徐洋 on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModifyPwdDelegate <NSObject>

- (void)savePassward:(NSString *)pwd;

@end

@interface ModifyPwdView : UIView
<
    UITextFieldDelegate
>

@property (nonatomic, assign) id<ModifyPwdDelegate> delegate;

@end
