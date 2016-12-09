//
//  EquipmentHealthController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "EquipmentHealthController.h"

#import "MaxMinView.h"
#import "DoubleSlidingContainer.h"
#import "TTLineChartView.h"
#import "TTHistoryDataObject.h"
#import "DropMenuListView.h"
#import "listCell.h"



@interface EquipmentHealthController ()  <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, strong) NSMutableArray *yValuesArr;
@property (nonatomic, strong) NSMutableArray *chartArr;

@property (nonatomic, strong) NSArray *xData;
@property (nonatomic, strong) NSArray *downDataArr;

#pragma mark -
#pragma mark baseUI
@property (strong, nonatomic) IBOutlet UILabel *healthTitleLb;

@property (strong, nonatomic) IBOutlet UILabel *sortInC;
@property (strong, nonatomic) IBOutlet UILabel *health;
@property (strong, nonatomic) IBOutlet UILabel *questions;
@property (strong, nonatomic) IBOutlet UILabel *healthGrade;
@property (strong, nonatomic) IBOutlet UIImageView *gradeColor;



@property (nonatomic, strong)  DropMenuListView *listMenu;
@property (nonatomic, strong) UIView *listView;
@property (nonatomic, strong) UITableView *tablevlist;


@property (nonatomic, copy) NSString *dateStr;


@property (nonatomic, strong) NSArray *rowDataArr;

@property (nonatomic, copy) NSString *tempStr;
@property (nonatomic, strong) NSArray *tempArr;

@property (nonatomic, assign) NSInteger choose;

@property(nonatomic,strong)NSArray *forProjectList; //项目列表

@property(nonatomic,strong)NSArray *forCityList; //省





@property (nonatomic, strong) NSArray *dateArr;

@property (nonatomic, strong) UITableView *dateTab;

@property (nonatomic, strong) UIButton *backbt;

@property (nonatomic, strong) UIButton *dateListBt;


@end

@implementation EquipmentHealthController

- (void)manuallyProperties {
    [super initFrontProperties];
    _chartArr = [NSMutableArray arrayWithCapacity:0];
    _yValuesArr = [NSMutableArray arrayWithCapacity:0];
    //不允许有重复的标题
    self.titles = @[@"综合健康度",@"消防类健康度",@"安防类健康度",@"照明类健康度",@"楼控类健康度"];

}


- (void)initUI {
    
    _dateArr = @[
                 @{@"word":@"年",@"code":@"year"},
                 @{@"word":@"月",@"code":@"month"},
                 @{@"word":@"周",@"code":@"week"},
                 @{@"word":@"日",@"code":@"day"}
                 ];
    

    _rowDataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self loadTopNav];
    [self stdVarsInit];
    [self listMenu];
    [self setCursor];
}


- (void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    topLbl.text=@"设备健康度";
    [topLbl setFont:[UIFont systemFontOfSize:18]];
    [topLbl setTextAlignment:NSTextAlignmentCenter];
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    
    _dateListBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dateListBt setFrame:CGRectMake(fDeviceWidth - 60, 28, 50, 25)];
    [_dateListBt addTarget:self action:@selector(showList) forControlEvents:UIControlEventTouchUpInside];
    _dateListBt.titleLabel.font = [UIFont systemFontOfSize:14];
    _dateListBt.layer.cornerRadius = 5;
    _dateListBt.layer.masksToBounds = YES;
    //    _dateListBt setImage:[UIImage] forState:(UIControlState)
    [_dateListBt setTitle:_dateArr[3][@"word"] forState:(UIControlStateNormal)];
    _dateListBt .backgroundColor = RGB(61, 71, 83);
    [TopView addSubview:_dateListBt];
    
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


- (void)showList {
    
    _backbt = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [ApplicationDelegate.window addSubview:_backbt];
    [_backbt mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(ApplicationDelegate.window);
    }];
    [_backbt addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    _dateTab = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _dateTab.layer.cornerRadius = 5;
    _dateTab.layer.masksToBounds = YES;
    [_backbt addSubview:_dateTab];
    [_dateTab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backbt).offset(54);
        make.right.equalTo(_backbt).offset(-10);
        make.height.equalTo(@100);
        make.width.equalTo(@50);
    }];
    _dateTab.delegate = self;
    _dateTab.dataSource = self;
    //    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dateTab.scrollEnabled = NO;
    
}

- (void)back {
    [_backbt removeFromSuperview];
    _backbt = nil;
}


- (DropMenuListView *)listMenu {
    if (!_listMenu) {
        
        _listMenu = [[DropMenuListView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, 44)];
        
        [self.view addSubview:_listMenu];
        
        _listMenu.leftLb.text = _prov;
        _listMenu.middleLb.text = _cit;
        _listMenu.rightLb.text = _proj;
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
                _rowDataArr = _areas;
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




- (void)setCursor {
    DoubleSlidingContainer *doubleSlidingContainer = [[DoubleSlidingContainer alloc] init];
    [doubleSlidingContainer setFrame:CGRectMake(0, 250, fDeviceWidth, 320)];
    doubleSlidingContainer.titleArr = self.titles;
    doubleSlidingContainer.contentArr = [self creatSubViews];

    [self.view addSubview:doubleSlidingContainer];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(dealwith:) name:@"lalalallalalalala" object:nil];

}
- (void)dealwith:(NSNotification *)noti {
    _healthTitleLb.text = [NSString stringWithFormat:@"%@:" ,noti.userInfo[@"content"] ];
}

- (NSMutableArray *)creatSubViews{
    NSMutableArray *pageViews = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titles.count; i++) {

        UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH , 320)];
        view.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
        TTLineChartView *lineChartView = [[TTLineChartView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 200)];
        lineChartView.showBackgroundView = YES;
        lineChartView.heightOffset = 34;
        lineChartView.widthOffset = 17.5;
        [view addSubview:lineChartView];
        lineChartView.tag = 100 + i;
        MaxMinView *maxMinView  = [[MaxMinView alloc] init];
        [maxMinView setFrame:CGRectMake(fDeviceWidth * 0.05, 230, fDeviceWidth * 0.9, 40)];
        maxMinView.backgroundColor = RGB(230, 230, 230);
        [view addSubview:maxMinView];
        
        [pageViews addObject:view];    }
    [_chartArr addObjectsFromArray:pageViews];

    return pageViews;
}



#pragma mark -
#pragma mark 网络请求

- (void)gsHandleData{
    if (self.provinceIdStr.length == 0) {
        self.provinceIdStr = @"";
    }
    if (self.cityIdStr.length == 0) {
        self.cityIdStr = @"";
    }
    if (self.projectIdStr.length ==0) {
        self.projectIdStr = @"";
    }
    if (self.dateStr.length == 0) {
        self.dateStr = @"day";
    }
    
 
    NSDictionary *param = @{
                            @"uid":ApplicationDelegate.myLoginInfo.Id,
                            @"ukey":ApplicationDelegate.myLoginInfo.ukey,
                            @"provinceId":self.provinceIdStr,
                            @"cityId":self.cityIdStr,
                            @"projectId":self.projectIdStr,
                            @"dateType":self.dateStr
                            };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forDeviceHealthData"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    WS(weakSelf);
    
    [GSHttpManager httpManagerPostParameter:param toHttpUrlStr:urlstr  success:^(id result) {
//        NSLog(@"%@", result);
        
        [SVProgressHUD dismiss];
        
        [weakSelf endDealWith:result];
        
    } orFail:^(NSError *error) {
        
    }];
}
#pragma mark -
#pragma mark 数据处理

- (void)endDealWith:(id)result {
    
    if (_yValuesArr.count > 0) {
        [_yValuesArr removeAllObjects];
    }
    _yValuesArr = @[result[@"alarmArr"],result[@"automationArr"],result[@"generalArr"],result[@"lightingArr"],result[@"securityArr"]].mutableCopy;
    _xData = result[@"xDate"];
    for (int i = 0; i < 5; i++) {
        
        NSMutableArray *sourceData = [NSMutableArray array];
        
        [sourceData addObjectsFromArray:_yValuesArr[i]];
        
        NSMutableArray *historyData = [NSMutableArray array];
        for (int i = 0; i < sourceData.count; i++) {
            TTHistoryDataObject *obj = [[TTHistoryDataObject alloc] init];
            obj.displayX = [NSString stringWithFormat:@"%@", @(i)];
            obj.detailX = [NSString stringWithFormat:@"%@", sourceData[i]];
            obj.yValue = sourceData[i];
            obj.ring = i == 0 ? @0 : @((([sourceData[i] floatValue] - [sourceData[i - 1] floatValue]) / [sourceData[i - 1] floatValue]) * 100);
            [historyData addObject:obj];
        }
        
        TTLineChartView *lineChartView = [_chartArr[i] viewWithTag:100 + i];
        lineChartView.historyData = historyData;
        [lineChartView refreshUIWithElementData:sourceData];
        
        
    }

    
    _sortInC.text = [NSString stringWithFormat:@"%@", result[@"rank"]];
    _health.text = [NSString stringWithFormat:@"%@",result[@"realHealth"]];
    _questions.text = [NSString stringWithFormat:@"%@",result[@"generalFaultCount"]];
    _healthGrade.text = [NSString stringWithFormat:@"%@",result[@"grade"]];
    [_gradeColor setImage:[UIImage imageNamed:[NSString stringWithFormat:@"nhfx_color%@",result[@"grade"]]]];
    
    _downDataArr = @[
                            @{
                                @"Max":[NSString stringWithFormat:@"%@",result[@"alarmMax"]],
                                @"Min":[NSString stringWithFormat:@"%@",result[@"alarmMin"]],
                                @"Avg":[NSString stringWithFormat:@"%@",result[@"alarmAvg"]],
                                },
                            @{
                                @"Max":[NSString stringWithFormat:@"%@",result[@"automationMax"]],
                                @"Min":[NSString stringWithFormat:@"%@",result[@"automationMin"]],
                                @"Avg":[NSString stringWithFormat:@"%@",result[@"automationAvg"]],

                                },
                            @{
                                @"Max":[NSString stringWithFormat:@"%@",result[@"generalMax"]],
                                @"Min":[NSString stringWithFormat:@"%@",result[@"generalMin"]],
                                @"Avg":[NSString stringWithFormat:@"%@",result[@"generalAvg"]],

                                },
                            @{
                                @"Max":[NSString stringWithFormat:@"%@",result[@"lightingMax"]],
                                @"Min":[NSString stringWithFormat:@"%@",result[@"lightingMin"]],
                                @"Avg":[NSString stringWithFormat:@"%@",result[@"lightingAvg"]],

                                },
                            @{
                                @"Max":[NSString stringWithFormat:@"%@",result[@"securityMax"]],
                                @"Min":[NSString stringWithFormat:@"%@",result[@"securityMin"]],
                                @"Avg":[NSString stringWithFormat:@"%@",result[@"securityAvg"]],
                                },
                            ];
    
    for (NSInteger i = 0; i < _chartArr.count ; i ++) {
        UIView *vi = _chartArr[i];
        MaxMinView *chartView = vi.subviews[1];
        chartView.countDic = _downDataArr[i];
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
    
    if ([tableView isEqual:_dateTab]) {
        
        return 4;
        
    } else {
        
        return _rowDataArr.count;
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([tableView isEqual:_dateTab]) {
        static NSString *cellName = @"cellname";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        }
        cell.textLabel.text = _dateArr[indexPath.row][@"word"];
        
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor blackColor];
        if ([cell.textLabel.text isEqualToString:_dateListBt.titleLabel.text]) {
            cell.textLabel.textColor = RGB(130, 219, 250);
        }
        
        cell.backgroundColor = RGB(255, 255, 255);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        listCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"baseListCell"];
        
        cell.name = _rowDataArr[indexPath.row];
        
        if ([_tempStr isEqualToString:cell.name]) {
            cell.current = YES;
        } else {
            cell.current =NO;
        }
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_dateTab]) {
        return 25;
    } else {
        return 40;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual: _dateTab]) {
        [_dateListBt setTitle:_dateArr[indexPath.row][@"word"] forState:(UIControlStateNormal)];
        
        self.dateStr =_dateArr[indexPath.row][@"code"];
        
        [self gsHandleData];
        
        [self back];
        
    } else {
        
        
        
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
}


-(void)stdVarsInit{
    
    _forCityList = [DownLoadBaseData readBaseData:@"forCity.plist"];
    for (NSDictionary *dic in _forCityList) {
        if ([dic[@"name"] isEqualToString:_prov]) {
            _tempArr = dic[@"city"];
        }
    }
    _forProjectList= [DownLoadBaseData readBaseData:@"forProjectList.plist"];
    
}


- (void)setProj:(NSString *)proj {
    if (_proj != proj) {
        _proj = proj;
    }
}
- (void)setCit:(NSString *)cit {
    if (_cit != cit) {
        _cit = cit;
    }
}

- (void)setProv:(NSString *)prov {
    if (_prov != prov) {
        _prov = prov;
    }
}

- (void)setProjectIdStr:(NSString *)projectIdStr {
    if (_projectIdStr != projectIdStr) {
        _projectIdStr = projectIdStr;
    }
}
- (void)setCityIdStr:(NSString *)cityIdStr {
    if (_cityIdStr != cityIdStr) {
        _cityIdStr = cityIdStr;
    }
}

- (void)setProvinceIdStr:(NSString *)provinceIdStr {
    if (_provinceIdStr != provinceIdStr) {
        _provinceIdStr = provinceIdStr;
    }
}

- (void)setClassifys:(NSMutableArray *)classifys {
    if (_classifys != classifys) {
        _classifys = classifys;
    }
}

- (void)setAreas:(NSMutableArray *)areas {
    if (_areas != areas) {
        _areas = areas;
    }
}

- (void)setSorts:(NSMutableArray *)sorts {
    if (_sorts != sorts) {
        _sorts = sorts;
    }
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
