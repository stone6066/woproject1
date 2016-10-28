//
//  stdCallBtn.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface stdCallBtn : UIView
@property(nonatomic,strong)UILabel *titleLable;
-(id)initWithFrame:(CGRect)frame;
-(void)setLblText:(NSString*)mytitle;
@end
