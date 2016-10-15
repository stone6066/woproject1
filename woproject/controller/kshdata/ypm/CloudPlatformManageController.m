//
//  CloudPlatformManageController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "CloudPlatformManageController.h"
#import "ProjectListCell.h"

@interface CloudPlatformManageController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *listTBV;

#pragma mark -
#pragma mark data
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation CloudPlatformManageController



- (void)initUI {
    
    self.topTitle = @"总体概览";
    self.dateListShow = NO;
    
}

- (void)manuallyProperties {
    [super initFrontProperties];
}


- (void)setProperties {
    _listTBV.delegate = self;
    _listTBV.dataSource = self;
    _listTBV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTBV.tableFooterView = [UIView new];
}

#pragma mark -
#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellName = @"ProjectListCell";
    
    ProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] firstObject];
        
    }
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.dataDic = _dataArr[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)gsHandleData {
    NSDictionary *param = @{
                            @"uid":ApplicationDelegate.myLoginInfo.Id,
                            @"ukey":ApplicationDelegate.myLoginInfo.ukey,
                            @"provinceId":self.provinceIdStr,
                            @"cityId":self.cityIdStr,
                            @"projectId":self.projectIdStr
                            };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forProjectOrDetails"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    WS(weakSelf);
    
    [GSHttpManager httpManagerPostParameter:param toHttpUrlStr:urlstr  success:^(id result) {
        NSLog(@"%@", result);
        
        [SVProgressHUD dismiss];
        
        [weakSelf endDealWith:result];
        
    } orFail:^(NSError *error) {
        
    }];

}

#pragma mark -
#pragma mark 数据处理

- (void)endDealWith:(id)result {
    _dataArr = result;
    [_listTBV reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
