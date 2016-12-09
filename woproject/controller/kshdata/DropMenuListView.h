//
//  DropMenuListView.h
//  woproject
//
//  Created by 关宇琼 on 2016/11/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const DropMenListViewToBaseViewControllerShowListNoti;


@interface DropMenuListView : UIView

@property (nonatomic, copy) NSString *superClassN;

- (void)setTitleContentWithArr:(NSArray *)arr;

@property (nonatomic, strong) UILabel *leftLb;
@property (nonatomic, strong) UILabel *middleLb;
@property (nonatomic, strong) UILabel *rightLb;

@property (nonatomic, strong) UIButton *leftBt;
@property (nonatomic, strong) UIButton *middleBt;
@property (nonatomic, strong) UIButton *rightBt;



@end
