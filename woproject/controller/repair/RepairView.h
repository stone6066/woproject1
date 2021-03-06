//
//  RepairView.h
//  woproject
//
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNModel.h"
#import "FSModel.h"
#import "DTModel.h"

@protocol RepairViewDelegate <NSObject>

- (void)openPhotosAndCamera:(UIButton *)button;

@end

@interface RepairView : UIView<UITextViewDelegate>

@property (nonatomic, strong) UIButton *repairButton;
@property (nonatomic, strong) UILabel *PNTapLabel;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITextView *describeTextView;
@property (nonatomic, strong) UIButton *imgBtn1;
@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;
@property (nonatomic, strong) UIImageView *imgView3;
@property (nonatomic, assign) id<RepairViewDelegate> delegate;

- (NSDictionary *)getParams;
- (void)clearUI;

@end
