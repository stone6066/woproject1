//
//  InfoSettingViewController.m
//  woproject
//
//  Created by 徐洋 on 16/10/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "InfoSettingViewController.h"
#import "stdPubFunc.h"
#import "InfoCell.h"
#import "ModifyVC.h"

@interface InfoSettingViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *infoTabView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation InfoSettingViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.dataArray addObject:@"icon"];
    [self.dataArray addObject:@"徐洋"];
    [self.dataArray addObject:@"*****"];
    [self.dataArray addObject:@"13244588225"];
    [self.dataArray addObject:@"loginout"];
}
#pragma mark Action
- (void)loginOutAction
{
    [stdPubFunc stdShowMessage:@"退出登录"];
}
- (void)ModifyInfo:(NSInteger)index
{
    ModifyVC *vc = [[ModifyVC alloc] init];
    vc.type = index;
    [self.navigationController pushViewController:vc animated:YES];
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
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld", indexPath.section]];
    if (!cell) {
        cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld", indexPath.section]];
    }
    if (indexPath.section != 4) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.section;
    switch (indexPath.section) {
        case 0:
            cell.icon_label.text = @"头像:";
            cell.icon.backgroundColor = [UIColor redColor];
            break;
        case 1:
            cell.icon_label.text = [NSString stringWithFormat:@"用户ID: %@", self.dataArray[indexPath.section]];
            break;
        case 2:
            cell.icon_label.text = [NSString stringWithFormat:@"密码: %@", self.dataArray[indexPath.section]];
            break;
        case 3:
            cell.icon_label.text = [NSString stringWithFormat:@"电话: %@", self.dataArray[indexPath.section]];
            break;
        case 4:
            //按钮
            break;
    }
    return cell;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            NSLog(@"修改头像");
            break;
        case 1:
        case 2:
        case 3:
            [self ModifyInfo:indexPath.section];
            break;
        case 4:
            [self loginOutAction];
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    switch (indexPath.section) {
        case 0:
            height = 88;
            break;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = RGB(232, 239, 247);
    return view;
}
#pragma mark UI
- (void)initUI
{
    self.topTitle = @"个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
    _infoTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight - 64) style:UITableViewStylePlain];
    _infoTabView.tableFooterView = [UIView new];
    _infoTabView.backgroundColor = RGB(232, 239, 247);
    _infoTabView.delegate = self;
    _infoTabView.dataSource = self;
    _infoTabView.scrollEnabled = NO;
    [self.view addSubview:_infoTabView];
}

@end

