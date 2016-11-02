//
//  PJVC.m
//  woproject
//
//  Created by 徐洋 on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "PJVC.h"
#import "PJView.h"

@interface PJVC ()

@property (nonatomic, strong) PJView *pjv;

@end

@implementation PJVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)doneAction:(UIButton *)sender
{
    NSLog(@"yes");
}

- (void)initUI
{
    self.topTitle = @"评价";
    _pjv = [[PJView alloc] init];
    [self.view addSubview:_pjv];
    WS(weakSelf);
    [_pjv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    [_pjv.qrtjBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
}

@end
