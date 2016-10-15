//
//  SettingVC.m
//  woproject
//
//  Created by 徐洋 on 16/10/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "SettingVC.h"
#import "stdPubFunc.h"
#import "SettingCell.h"
#import "AboutWoVC.h"

@interface SettingVC ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SettingVC
{
    CGRect orignailRect;
    UIButton *backBtn;
    UIImageView *qrImg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.nameLabel.text = self.dataArray[indexPath.section];
    cell.qrImgView.backgroundColor = [UIColor redColor];
    cell.index = indexPath.section;
    return cell;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 3:
            [self.navigationController pushViewController:[[AboutWoVC alloc] init] animated:YES];
            break;
        case 4:
        {
            UIWindow *window = [[UIApplication sharedApplication].delegate window];
            backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            backBtn.frame = [UIScreen mainScreen].bounds;
            backBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            [backBtn addTarget:self action:@selector(dissmissQR:) forControlEvents:UIControlEventTouchUpInside];
            SettingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            qrImg = [UIImageView new];
            qrImg.backgroundColor = [UIColor cyanColor];
            qrImg.frame = CGRectMake(cell.qrImgView.frame.origin.x, 309, cell.qrImgView.frame.size.width, cell.qrImgView.frame.size.height);
            orignailRect = qrImg.frame;
            [window addSubview:backBtn];
            [backBtn addSubview:qrImg];
            CGFloat width = fDeviceWidth * .6;
            CGFloat x = fDeviceWidth * .2;
            CGFloat y = (fDeviceHeight - width) / 2;
            [UIView animateWithDuration:.5f animations:^{
                qrImg.frame = CGRectMake(x, y, width, width);
                backBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];            }];
        }
            break;
        case 5:
        {
            [stdPubFunc stdShowMessage:@"退出登录"];
        }
            break;
    }
}
- (void)dissmissQR:(UIButton *)sender
{
    [UIView animateWithDuration:.5 animations:^{
        qrImg.frame = orignailRect;
        backBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }completion:^(BOOL finished) {
        [backBtn removeFromSuperview];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) {
        return 140.f;
    }
    return 40.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    v.backgroundColor = RGB(232, 239, 247);
    return v;
}
#pragma mark UI
- (void)initUI
{
    self.topTitle = @"设置";
    _dataArray = @[].mutableCopy;
    [_dataArray addObject:@"信息提示通知"];
    [_dataArray addObject:@"声音"];
    [_dataArray addObject:@"振动"];
    [_dataArray addObject:@"关于Wo"];
    [_dataArray addObject:@"二维码"];
    [_dataArray addObject:@"退出登录"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight - 64) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = RGB(232, 239, 247);
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

@end
