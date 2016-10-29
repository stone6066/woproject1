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
#import "QRVC.h"
#import "MyRepairVC.h"
#import "MyPermissionsVC.h"
#import "MyOrderVC.h"
#import "MyPDVC.h"

@interface MyinfoViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *myInfoTabView;
@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *nameLabel;

@end

static NSString *myInfoIdentifier = @"myInfoIdentifier";

@implementation MyinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss" object:nil];
    [self loginInfo];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myInfoIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:_infoArray[indexPath.section][@"img"]];
    cell.textLabel.text = _infoArray[indexPath.section][@"text"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    switch (indexPath.section) {
        case 0:
            cell.detailTextLabel.text = ApplicationDelegate.mylistNum.repairsCount;
            break;
        case 1:
            cell.detailTextLabel.text = ApplicationDelegate.mylistNum.sendCount;
            break;
        case 2:
            cell.detailTextLabel.text = ApplicationDelegate.mylistNum.ticketCount;
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            MyRepairVC *vc = [[MyRepairVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            MyPDVC *vc = [[MyPDVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            MyOrderVC *vc = [[MyOrderVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            MyPermissionsVC *vc = [[MyPermissionsVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
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
- (void)openQRAction:(UIButton *)sender
{
    QRVC *vc = [[QRVC alloc] init];
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
    self.headImgView.image = [UIImage imageNamed:@"wo_bg"];
    self.headImgView.frame = CGRectMake(0, 0, fDeviceWidth, 180);
    _myInfoTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight - 64) style:UITableViewStylePlain];
    _myInfoTabView.tableFooterView = [UIView new];
    _myInfoTabView.tableHeaderView = self.headImgView;
    _myInfoTabView.backgroundColor = RGB(232, 239, 247);
    _myInfoTabView.delegate = self;
    _myInfoTabView.dataSource = self;
    _myInfoTabView.scrollEnabled = NO;
    [self.view addSubview:_myInfoTabView];
    UIView *tmpView = [UIView new];
    tmpView.backgroundColor = [UIColor whiteColor];
    [self.headImgView addSubview:tmpView];
    tmpView.layer.cornerRadius = 45;
    tmpView.layer.masksToBounds = YES;
    [tmpView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImgView.mas_centerY);
        make.centerX.equalTo(_headImgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(90, 90));

    }];
    self.iconImg = [UIImageView new];
    self.iconImg.layer.cornerRadius = 40.f;
    [tmpView addSubview:self.iconImg];
    [self.iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImgView.mas_centerY);
        make.centerX.equalTo(_headImgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    self.iconImg.userInteractionEnabled = YES;
    self.iconImg.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoSettingAction:)];
    [self.iconImg addGestureRecognizer:tap];
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = RGB(256, 256, 256);
    [self.headImgView addSubview:_nameLabel];
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImg.mas_bottom).offset(10);
        make.centerX.equalTo(_iconImg);
    }];
    [_nameLabel sizeToFit];
    _myInfoTabView.tableHeaderView.userInteractionEnabled = YES;
    self.rightImage = [UIImage imageNamed:@"shezhi"];
    [self.righButon addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    self.leftImage = [UIImage imageNamed:@"sys"];
    [self.leftButton addTarget:self action:@selector(openQRAction:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginInfo) name:@"isLogin" object:nil];
}

- (void)loginInfo
{
    _nameLabel.text = ApplicationDelegate.myLoginInfo.name?ApplicationDelegate.myLoginInfo.name:@"测试";
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:ApplicationDelegate.myLoginInfo.image] placeholderImage:[UIImage imageNamed:@"touxiang"]];
}

@end

