//
//  MyPermissionsVC.m
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MyPermissionsVC.h"
#import "MyPermissionsCell.h"
#import "JYJSON.h"

@interface MyPermissionsVC ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *mypermissionsIdentifier = @"mypermissionsIdentifier";

@implementation MyPermissionsVC

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = RGB(232, 239, 247);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

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
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPermissionsCell *cell = [tableView dequeueReusableCellWithIdentifier:mypermissionsIdentifier];
    if (!cell) {
        cell = [[MyPermissionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mypermissionsIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    NSInteger index = indexPath.row % 2;
    switch (index) {
        case 0:
            cell.backgroundColor = [UIColor whiteColor];
            break;
        case 1:
            cell.backgroundColor = RGB(232, 239, 247);
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger count = ApplicationDelegate.myLoginInfo.projectList.count;
    return 135 + (count - 1) * 14;
}
#pragma mark UI
- (void)initUI
{
    self.topTitle = @"我的管辖范围";
    [self.view addSubview:self.tableView];
    /**
     获取数据源
     */
    [ApplicationDelegate.myLoginInfo.roleList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        roleList *role = (roleList *)obj;
        NSDictionary *dic = @{@"roleName":role.level,@"userName":role.name,@"projectList":ApplicationDelegate.myLoginInfo.projectList};
        MyPermissionsModel *model = [MyPermissionsModel yy_modelWithJSON:dic];
        [self.dataArray addObject:model];
    }];
    [self.tableView showEmptyMessage:k_jurisdiction dataSourceCount:self.dataArray.count];
    [self.tableView reloadData];
}

@end
