//
//  MyinfoViewController.m
//  woproject
//
//  Created by 徐洋 on 16/10/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MyinfoViewController.h"
#import "PublicDefine.h"
#import "stdPubFunc.h"
#import "InfoSettingViewController.h"
#import "SettingVC.h"

@interface MyinfoViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *myInfoTabView;
@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UIButton *iconImg;
@property (nonatomic, strong) UILabel *nameLabel;

@end

static NSString *myInfoIdentifier = @"myInfoIdentifier";

@implementation MyinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"male"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"male"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"我的";
        
        self.tabBarItem.title=tittxt;
        
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    }
    return self;
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _infoArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myInfoIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myInfoIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:_infoArray[indexPath.section][@"img"]];
    cell.textLabel.text = _infoArray[indexPath.section][@"text"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = RGB(232, 239, 247);
    return view;
}
#pragma mark Action
- (void)infoSettingAction:(UIButton *)sender
{
    InfoSettingViewController *infoVC = [[InfoSettingViewController alloc] init];
    infoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoVC animated:YES];
}
- (void)settingAction:(UIBarButtonItem *)sender
{
    SettingVC *vc = [[SettingVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UI
- (void)initUI
{
    self.topTitle = @"我的";
    self.isHiddenBackItem = YES;
    self.infoArray = @[@{@"img":@"wd_icon01",@"text":@"我的报修"},@{@"img":@"wd_icon02",@"text":@"我的派单"},@{@"img":@"wd_icon03",@"text":@"我的工单"},@{@"img":@"wd_icon04",@"text":@"我的权限"}];
    self.headImgView = [UIImageView new];
    self.headImgView.backgroundColor = [UIColor redColor];
    self.headImgView.frame = CGRectMake(0, 0, fDeviceWidth, 180);
    _myInfoTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight - 64) style:UITableViewStylePlain];
    _myInfoTabView.tableFooterView = [UIView new];
    _myInfoTabView.tableHeaderView = self.headImgView;
    _myInfoTabView.backgroundColor = RGB(232, 239, 247);
    _myInfoTabView.delegate = self;
    _myInfoTabView.dataSource = self;
    _myInfoTabView.scrollEnabled = NO;
    [self.view addSubview:_myInfoTabView];
    self.iconImg = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconImg.layer.cornerRadius = 40.f;
    self.iconImg.backgroundColor = [UIColor yellowColor];
    [self.iconImg setImage:[UIImage imageNamed:ApplicationDelegate.myLoginInfo.image] forState:normal];
    [self.iconImg addTarget:self action:@selector(infoSettingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headImgView addSubview:self.iconImg];
    [self.iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImgView.mas_centerY);
        make.centerX.equalTo(_headImgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.text = ApplicationDelegate.myLoginInfo.name?ApplicationDelegate.myLoginInfo.name:@"测试";
    _nameLabel.textColor = RGB(256, 256, 256);
    [self.headImgView addSubview:_nameLabel];
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImg.mas_bottom).offset(10);
        make.centerX.equalTo(_iconImg);
    }];
    [_nameLabel sizeToFit];
    _myInfoTabView.tableHeaderView.userInteractionEnabled = YES;
    self.rightTitle = @"设置";
    [self.righButon addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
}

@end

