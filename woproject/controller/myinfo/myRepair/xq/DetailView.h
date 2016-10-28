//
//  DetailView.h
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailModel;

@protocol DetailViewDelegate <NSObject>

- (void)detailViewButtonAction:(NSString *)gd;

@end

@interface DetailView : UIView

@property (nonatomic, strong) DetailModel *model;
@property (nonatomic, assign) id<DetailViewDelegate> delegate;
@property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, copy) NSString *type;

@end
