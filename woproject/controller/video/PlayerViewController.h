//
//  PlayerViewController.h
//  woproject
//
//  Created by tianan-apple on 2016/11/26.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceModel.h"
@interface PlayerViewController : UIViewController

@property(nonatomic,strong)UIView* videoView;
@property(nonatomic,strong)UIView* controllView;

@property (strong, nonatomic)  UIView *talkView;

@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) UIButton *upBtn;
@property (strong, nonatomic) UIButton *downBtn;
@property (strong, nonatomic) UIButton *centerBtn;

@property (strong, nonatomic) UIButton *talkBtn;
@property (strong, nonatomic) UIButton *bufangBtn;
@property (strong, nonatomic) UIButton *huazhiBtn;
@property (strong, nonatomic) UIButton *fanzhuanBtn;
@property (strong, nonatomic) UIButton *huifangBtn;
@property (strong, nonatomic) UILabel *bufangLbl;
@property (strong, nonatomic) UILabel *huazhiLbl;
@property (strong, nonatomic) UIView *huazhiShowView;
@property (strong, nonatomic) UITableView *huazhiTable;
@property (strong, nonatomic) NSMutableArray *huazhiData;
@property (strong, nonatomic) NSMutableArray *huazhiIdData;
@property(nonatomic,copy)NSString *topTitle;
@property(nonatomic,assign)int alamEnable;//0布防解除  1布防中

@property (strong, nonatomic) UIView *turnShowView;
-(id)initWithDat:(DeviceModel*) dev title:(NSString*)tStr;
@end
