//
//  CloudPlatformManageController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "CloudPlatformManageController.h"
#import "mainBv.h"
#import "InfoDetailsView.h"
#import "DropMenuListView.h"
#import "listCell.h"


@interface CloudPlatformManageController () <UITableViewDelegate, UITableViewDataSource> {
    BOOL infodetails;
}


@property (strong, nonatomic)  mainBv *mainBv;

@property (nonatomic, strong) InfoDetailsView *detailsV;

@property (nonatomic, strong)  DropMenuListView *listMenu;
@property (nonatomic, strong) UIView *listView;
@property (nonatomic, strong) UITableView *tablevlist;

@property (nonatomic, copy) NSString *cityIdStr;
@property (nonatomic, copy) NSString *projectIdStr;
@property (nonatomic, copy) NSString *provinceIdStr;

@property (nonatomic, strong) NSArray *rowDataArr;

@property (nonatomic, copy) NSString *tempStr;
@property (nonatomic, strong) NSArray *tempArr;

@property (nonatomic, assign) NSInteger choose;

@property(nonatomic,strong)NSArray *forProjectList; //项目列表

@property(nonatomic,strong)NSArray *forCityList; //省

@property (nonatomic, strong) NSMutableArray *classifys;

@property (nonatomic, strong) NSMutableArray *areas;

@property (nonatomic, strong) NSMutableArray *sorts;

@property (nonatomic, strong) UILabel *topLbl;
@end

@implementation CloudPlatformManageController



- (void)initUI {
    _classifys = [NSMutableArray arrayWithCapacity:0];
    _sorts = [NSMutableArray arrayWithCapacity:0];
    _areas = [NSMutableArray arrayWithCapacity:0];
    _rowDataArr = [NSMutableArray arrayWithCapacity:0];
    [self loadTopNav];
    [self stdVarsInit];
    [self listMenu];
    [self mainBv];
    [self detailsV];
}


- (void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    _topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    _topLbl.text=@"总体概览";
    [_topLbl setFont:[UIFont systemFontOfSize:18]];
    [_topLbl setTextAlignment:NSTextAlignmentCenter];
    [_topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:_topLbl];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 27, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [TopView addSubview:backimg];
    
    UILabel *hintLbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 29, 30, 20)];
    hintLbl.text=@"返回";
    [hintLbl setFont:[UIFont systemFontOfSize:14]];
    [hintLbl setTextAlignment:NSTextAlignmentCenter];
    [hintLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:hintLbl];
    
    
    
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    [self.view addSubview:TopView];
}
-(void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (DropMenuListView *)listMenu {
    if (!_listMenu) {
        
        _listMenu = [[DropMenuListView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, 44)];
        
        [self.view addSubview:_listMenu];
        
        
        [_listMenu.rightBt addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_listMenu.middleBt addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_listMenu.leftBt addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }
    return _listMenu;
}

- (void)buttonClick:(UIButton *)bt {
    
    
    _choose = bt.tag;
    
    if (_listView) {
        [_listView removeFromSuperview];
        _listView = nil;
        return;
    }
    
    switch (bt.tag) {
            
        case 1: {
            
            [self listView];
            _tempStr = _listMenu.leftLb.text;
            _rowDataArr = _classifys;
            
        }
            
            break;
            
        case 2: {
            if ([_listMenu.leftLb.text isEqualToString:@"请选择省"]) {
                [SVProgressHUD showInfoWithStatus:@"请先选择省"];
                return;
            } else {
                
                [self listView];
                _tempStr = _listMenu.middleLb.text;
            }
            
        }
            
            break;
            
        case 3: {
            if ([_listMenu.leftLb.text isEqualToString:@"请选择省"]) {
                [SVProgressHUD showInfoWithStatus:@"请先选择省"];
                return;
            } else if ([_listMenu.middleLb.text isEqualToString:@"请选择市"]) {
                [SVProgressHUD showInfoWithStatus:@"请先选择市"];
                return;
            } else {
                [self listView];
                _tempStr = _listMenu.rightLb.text;
                _rowDataArr = _sorts;
            }
            
        }
            
            break;
            
    }
    
    [_tablevlist reloadData];
}


- (mainBv *)mainBv {
    if (!_mainBv) {
        _mainBv = [[mainBv alloc ] initWithFrame:CGRectMake(0, 108, fDeviceWidth, fDeviceHeight - 108)];
        [self.view addSubview:_mainBv];
        _mainBv.hidden = NO;
    }
    return _mainBv;
}

- (InfoDetailsView *)detailsV {
    
    if (!_detailsV) {
        
        _detailsV = [[InfoDetailsView alloc] initWithFrame:CGRectMake(0, 108, fDeviceWidth, fDeviceHeight - 108)];
        
        [self.view addSubview:_detailsV];
        
        _detailsV.hidden = YES;
        
    }
    
    return _detailsV;
    
}
- (void)manuallyProperties {
    [super initFrontProperties];
    infodetails = NO;

}


- (void)setProperties {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}


- (void)gsHandleData {
    
    if (self.provinceIdStr.length == 0) {
        self.provinceIdStr = @"";
    }
    if (self.cityIdStr.length == 0) {
        self.cityIdStr = @"";
    }
    if (self.projectIdStr.length ==0) {
        self.projectIdStr = @"";
    }
    NSDictionary *param = @{
                            @"uid":ApplicationDelegate.myLoginInfo.Id,
                            @"ukey":ApplicationDelegate.myLoginInfo.ukey,
                            @"provinceId":self.provinceIdStr,
                            @"cityId":self.cityIdStr,
                            @"projectId":self.projectIdStr
                            };
    
    infodetails = self.projectIdStr.length > 0 ? YES : NO;
    
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
    if (infodetails) {
        _mainBv.hidden = YES;
        _detailsV.hidden = NO;
        _detailsV.dataDic = result;
        _detailsV.backgroundColor = [UIColor redColor];
      _topLbl.text = @"项目信息";
    } else {
        _topLbl.text = @"总体概览";
        _mainBv.hidden = NO;
        _detailsV.hidden = YES;
        _mainBv.dicArr = result;
    }
}

- (UIView *)listView {
    
    if (!_listView) {
        
        _listView = [[UIView alloc] initWithFrame:CGRectMake(0, 108, fDeviceWidth, fDeviceHeight - 108)];
        [self.view addSubview:_listView];
        
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, fDeviceHeight - 133, fDeviceWidth, 25)];
        
        [_listView addSubview:imgv];
        
        imgv.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [imgv addGestureRecognizer:tap];
        
        [imgv setImage:[UIImage imageNamed:@"icon_chose_bottom"]];
        
        _tablevlist = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight - 133) style:(UITableViewStylePlain)];
        [_listView addSubview:_tablevlist];
        _tablevlist.delegate = self;
        _tablevlist.dataSource = self;
        [_tablevlist registerNib:[UINib nibWithNibName:@"listCell" bundle:nil] forCellReuseIdentifier:@"baseListCell"];
        _tablevlist.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tablevlist.tableFooterView = [[UIView alloc] init];
        _listView.backgroundColor = [UIColor whiteColor];
        
    }
    return _listView;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self buttonClick:nil];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _rowDataArr.count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    listCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"baseListCell"];
    
    cell.name = _rowDataArr[indexPath.row];
    
    if ([_tempStr isEqualToString:cell.name]) {
        cell.current = YES;
    } else {
        cell.current =NO;
    }
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (_choose) {
            
        case   1: {
            
            if (indexPath.row !=0) {
                
                NSDictionary *dic = _forCityList[indexPath.row -1];
                
                _listMenu.leftLb.text = dic[@"name"];
                
                if (_provinceIdStr != dic[@"id"]) {
                    
                    _listMenu.middleLb.text = @"请选择市";
                    _listMenu.rightLb.text = @"请选择项";
                    _cityIdStr = @"";
                    
                    _projectIdStr = @"";
                    
                    _provinceIdStr = dic[@"id"];
                    
                }
                
                _tempArr = dic [@"city"];
                
                if (_areas.count > 0) {
                    
                    [_areas removeAllObjects];
                    
                }
                
                [_areas addObject:@"请选择市"];
                
                for (NSDictionary *dict in dic[@"city"]) {
                    
                    NSString *names=[dict objectForKey:@"name"];
                    
                    [self.areas addObject:names];
                    
                }
                
                _rowDataArr  = [NSArray arrayWithArray:_areas];
                
            } else {
                _listMenu.leftLb.text = @"请选择省";
                _listMenu.middleLb.text = @"请选择市";
                _listMenu.rightLb.text = @"请选择项";
                _cityIdStr = @"";
                _projectIdStr = @"";
                _provinceIdStr = @"";
                
            }
            
        }
            
            break;
            
        case 2: {
            
            if (indexPath.row !=0) {
                
                NSDictionary *dic = _tempArr[indexPath.row - 1];
                
                _listMenu.middleLb.text = dic[@"name"];
                if (_cityIdStr != dic[@"id"]) {
                    
                    _listMenu.rightLb.text = @"请选择项";
                    
                    _projectIdStr = @"";
                    
                    _cityIdStr = dic[@"id"];
                    
                }
                
            } else {
                _listMenu.middleLb.text = @"请选择市";
                _listMenu.rightLb.text = @"请选择项";
                _projectIdStr = @"";
                _cityIdStr =@"";
                
            }
            
        }
            
            break;
            
        case 3:
            
            if (indexPath.row != 0) {
                NSDictionary *dic = _forProjectList[indexPath.row - 1];
                _listMenu.rightLb.text = dic[@"name"];
                _projectIdStr = dic[@"id"];
                
            } else {
                _listMenu.rightLb.text = @"请选择项";
                _projectIdStr = @"";
                
            }
            
            
            break;
            
            
    }
    
    [self buttonClick:nil];
    [self gsHandleData];
    
}



-(void)stdVarsInit{
    
    _forCityList = [DownLoadBaseData readBaseData:@"forCity.plist"];
    [_classifys addObject:@"请选择省"];
    
    for (NSDictionary *dict in _forCityList) {
        NSString *names=[dict objectForKey:@"name"];
        [_classifys addObject:names];
    }
    
    _forProjectList= [DownLoadBaseData readBaseData:@"forProjectList.plist"];
    
    [_sorts addObject:@"请选择项"];
    
    for (NSDictionary * dict in _forProjectList) {
        NSString *names=[dict objectForKey:@"name"];
        [_sorts addObject:names];
    }
    
}



- (void)setArr:(NSArray *)arr {
    if (_arr != arr) {
        _arr = arr;
    }
//    [self.listMenu setTitleContentWithArr:arr];
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
