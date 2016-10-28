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
#import "IconVC.h"
#import "LoginViewController.h"

@interface InfoSettingViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *infoTabView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIAlertController *alert;

@end

@implementation InfoSettingViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

- (UIAlertController *)alert
{
    if (!_alert) {
         _alert = [UIAlertController alertControllerWithTitle:nil message:@"是否退出登录" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *loginOut = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/sys/logout"];
            [SVProgressHUD showWithStatus:k_Status_Load];
            urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [ApplicationDelegate.httpManager POST:urlstr
                                       parameters:@{@"id":ApplicationDelegate.myLoginInfo.Id}
                                         progress:^(NSProgress * _Nonnull uploadProgress) {}
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                              //http请求状态
                                              if (task.state == NSURLSessionTaskStateCompleted) {
                                                  NSError* error;
                                                  NSDictionary* jsonDic = [NSJSONSerialization
                                                                           JSONObjectWithData:responseObject
                                                                           options:kNilOptions
                                                                           error:&error];
                                                  
                                                  NSString *suc=[jsonDic objectForKey:@"s"];
                                                  NSString *msg=[jsonDic objectForKey:@"m"];
                                                  //
                                                  if ([suc isEqualToString:@"0"]) {
                                                      [SVProgressHUD showSuccessWithStatus:@"退出成功"];
                                                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                          //成功
                                                          LoginViewController *vc = [[LoginViewController alloc]init];
                                                          vc.loginSuccBlock = ^(LoginViewController *aqrvc){
                                                              NSLog(@"login_suc");
                                                              ApplicationDelegate.isLogin = YES;
                                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"rootvc" object:nil];
                                                          };
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"isLogin" object:nil];
                                                          self.hidesBottomBarWhenPushed = YES;
                                                          [self.navigationController pushViewController:vc animated:NO];
                                                          self.hidesBottomBarWhenPushed = NO;
                                                      });
                                                  } else {
                                                      //失败
                                                      [SVProgressHUD showErrorWithStatus:msg];
                                                  }
                                                  
                                              } else {
                                                  [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                              }
                                              
                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                              //请求异常
                                              [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                          }];
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [_alert addAction:loginOut];
        [_alert addAction:cancel];
    }
    return _alert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", ApplicationDelegate.myLoginInfo.phone);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.infoTabView reloadData];
}
#pragma mark Action
- (void)loginOutAction
{
    [self presentViewController:self.alert animated:YES completion:nil];
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
    return 5;
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
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:ApplicationDelegate.myLoginInfo.image] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            break;
        case 1:
            cell.icon_label.text = [NSString stringWithFormat:@"用户ID: %@", [ApplicationDelegate.myLoginInfo.name isKindOfClass:[NSNull class]]?@"":ApplicationDelegate.myLoginInfo.name];
            break;
        case 2:
            cell.icon_label.text = @"密码: ******";
            break;
        case 3:
            cell.icon_label.text = [NSString stringWithFormat:@"电话: %@", [ApplicationDelegate.myLoginInfo.phone isKindOfClass:[NSNull class]]?@"":ApplicationDelegate.myLoginInfo.phone];
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
        {
            [self.navigationController pushViewController:[[IconVC alloc] init] animated:YES];
        }
            break;
        case 1:
        case 2:
        case 3:
            [self ModifyInfo:indexPath.section];
            break;
        case 4:
        {
            [self loginOutAction];
        }
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

