//
//  GdtjViewController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "GdtjViewController.h"
#import "CircleAnnotationView.h"
#import "ProgressbarSetView.h"
#import "PNChartDelegate.h"
#import "PNChart.h"
#import "DropMenuListView.h"
#import "listCell.h"
 
@interface GdtjViewController () <PNChartDelegate, UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic) SCCircleChart * circleChart;
@property (nonatomic) SCCircleChart * circleChart1;
@property (nonatomic) SCCircleChart * circleChart2;

@property (nonatomic, strong) UILabel *gdTilte;
@property (nonatomic, strong) UILabel *gdallCount;

@property (nonatomic, strong) CircleAnnotationView *annotationView;
@property (nonatomic, strong) ProgressbarSetView *progressbarSetView;

@property (nonatomic, strong) UILabel *eachListCount;


@property (nonatomic) PNBarChart * barChart;




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

@implementation GdtjViewController


- (void)manuallyProperties {
    

}


- (void)initUI {
    
    
    _dateArr = @[
                 @{@"word":@"年",@"code":@"year"},
                 @{@"word":@"月",@"code":@"month"},
                 @{@"word":@"周",@"code":@"week"},
                 @{@"word":@"日",@"code":@"day"}
                 ];
    
//    _classifys = [NSMutableArray arrayWithCapacity:0];
//    _sorts = [NSMutableArray arrayWithCapacity:0];
//    _areas = [NSMutableArray arrayWithCapacity:0];
    _rowDataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self loadTopNav];
    [self stdVarsInit];
    [self listMenu];
    [self backScrollV];
    
    
    [self circleChart];
    [self circleChart1];
    [self circleChart2];
    
    [self gdTilte];
    
    [self gdallCount];

    [self annotationView];
    [self progressbarSetView];
    [self eachListCount];
    [self barChart];
   
}


- (void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    topLbl.text=@"工单统计";
    [topLbl setFont:[UIFont systemFontOfSize:18]];
    [topLbl setTextAlignment:NSTextAlignmentCenter];
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 27, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [TopView addSubview:backimg];
    
    UILabel *hintLbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 29, 30, 20)];
    hintLbl.text=@"返回";
    [hintLbl setFont:[UIFont systemFontOfSize:14]];
    [hintLbl setTextAlignment:NSTextAlignmentCenter];
    [hintLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:hintLbl];
    
    
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





- (UIScrollView *)backScrollV {
    if (!_backScrollV) {
        _backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 108, fDeviceWidth, fDeviceHeight - 108)];
        _backScrollV.contentSize =CGSizeMake(0, 650);
        _backScrollV.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_backScrollV];
    }
    return _backScrollV;
}

#pragma mark -
#pragma mark 环图

- (SCCircleChart *)circleChart {
    if (!_circleChart) {
        
        _circleChart = [[SCCircleChart alloc] initWithFrame:CGRectMake(0,37.0, SCREEN_WIDTH, 140.0)
                                                          total:@10
                                                        current:@0
                                                      clockwise:YES color:RGB(190, 190, 190)]  ;
        _circleChart.backgroundColor = [UIColor clearColor];
        
        [_circleChart setStrokeColor:[UIColor clearColor]];

        [_circleChart setStrokeColorGradientStart:[UIColor blueColor]];
        
        [_circleChart strokeChart];
        
        [self.backScrollV addSubview:_circleChart];
       
    }
    return _circleChart;
}

- (SCCircleChart *)circleChart1 {
    
    if (!_circleChart1) {
        
        _circleChart1 = [[SCCircleChart alloc] initWithFrame:CGRectMake(0,22.0, SCREEN_WIDTH, 170.0)
                                                      total:@10
                                                    current:@0
                                                              clockwise:YES color:RGB(210, 210  , 210)];
        _circleChart1.backgroundColor = [UIColor clearColor];
        [_circleChart1 setStrokeColor:[UIColor clearColor]];

        [_circleChart1 setStrokeColorGradientStart:[UIColor brownColor]];
        [_circleChart1 strokeChart];
        
        [self.backScrollV addSubview:_circleChart1];
        
    }
    return _circleChart1;
}

- (SCCircleChart *)circleChart2 {
    if (!_circleChart2) {
        
        _circleChart2 = [[SCCircleChart alloc] initWithFrame:CGRectMake(0,7.0, SCREEN_WIDTH, 200.0)
                                                      total:@10
                                                    current:@0
                                                  clockwise:YES color:RGB(230, 230, 230)];
        _circleChart2.backgroundColor = [UIColor clearColor];
        
        [_circleChart2 setStrokeColor:[UIColor clearColor]];
        
        [_circleChart2 setStrokeColorGradientStart:[UIColor greenColor]];
        
        [_circleChart2 strokeChart];
        
        [self.backScrollV addSubview:_circleChart2];
        
    }
    return _circleChart2;
}

- (UILabel *)gdTilte {
 
    if (!_gdTilte) {
        _gdTilte = [[UILabel alloc] init];
        [_backScrollV addSubview:_gdTilte];
        [_gdTilte mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backScrollV);
            make.top.equalTo(self.backScrollV).offset(90);
        }];
        _gdTilte.textAlignment = 1;
        _gdTilte.text = @"今日工单总数";
        
        _gdTilte.font = [UIFont systemFontOfSize:13.0];
        _gdTilte.textColor = RGB(80, 80, 80);
    }
    
    return _gdTilte;
}

- (UILabel *)gdallCount {
    if (!_gdallCount) {
        _gdallCount = [[UILabel alloc] init];
        [_backScrollV addSubview:_gdallCount];
        [_gdallCount mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backScrollV);
            make.top.equalTo(_gdTilte.mas_bottom).offset(8);
        }];
        _gdallCount.textAlignment = 1;
        
        _gdallCount.font = [UIFont boldSystemFontOfSize: 25.0];
        
    }
    return _gdallCount;
}

- (CircleAnnotationView *)annotationView {
    if (!_annotationView) {
        _annotationView = [[CircleAnnotationView alloc] init];
        [_backScrollV addSubview:_annotationView];
        [_annotationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_circleChart2.mas_bottom).offset(8);
            make.centerX.equalTo(_backScrollV);
            make.size.mas_equalTo(CGSizeMake(fDeviceWidth, 50));
        }];
        
        
    }
    return _annotationView;
}


- (ProgressbarSetView *)progressbarSetView {
    
    if (!_progressbarSetView) {
        _progressbarSetView = [[ProgressbarSetView alloc] init];
        [_backScrollV addSubview:_progressbarSetView];
        [_progressbarSetView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_annotationView.mas_bottom).offset(8);
            make.centerX.equalTo(_backScrollV);
            make.height.equalTo(@66);
            make.width.equalTo(@(fDeviceWidth * 0.9));
        }];
        _progressbarSetView.backgroundColor = RGB(230, 230, 230);
        

    }
    
    return _progressbarSetView;
    
}

- (UILabel *)eachListCount {
    if (!_eachListCount) {
        _eachListCount  = [[UILabel alloc] init];
        [_backScrollV addSubview:_eachListCount];
        [_eachListCount mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_progressbarSetView.mas_bottom).offset(20);
            make.left.equalTo(_backScrollV).offset(20);
        }];
        _eachListCount.attributedText = [MJYUtils attributeStr:@"各工种工单数" changePartStr:@"各工种工单数" withFont:18 andColor:RGB(0,0,0)];
    }
    return _eachListCount;
}



#pragma mark - 
#pragma mark 柱图

#pragma mark -
#pragma mark 柱图
    - (PNBarChart *)barChart {
        if (!_barChart) {
            static NSNumberFormatter *barChartFormatter;
            if (!barChartFormatter){
                barChartFormatter = [[NSNumberFormatter alloc] init];
                barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
                barChartFormatter.allowsFloats = NO;
                barChartFormatter.maximumFractionDigits = 0;
            }
            
            self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(8, 400, SCREEN_WIDTH -16, 200.0)];
            //        self.barChart.showLabel = NO;
            self.barChart.backgroundColor = [UIColor clearColor];
            self.barChart.yLabelFormatter = ^(CGFloat yValue){
                return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
            };
            
            self.barChart.yChartLabelWidth = 20.0;
            self.barChart.chartMarginLeft = 30.0;
            self.barChart.chartMarginRight = 10.0;
            self.barChart.showChartBorder = NO;
            self.barChart.chartMarginTop = 5.0;
            self.barChart.chartMarginBottom = 10.0;
            
            
            self.barChart.labelMarginTop = 5.0;
            self.barChart.showChartBorder = YES;
            [self.barChart setXLabels:@[@"暖通",@"强电",@"弱电",@"水工",@"综合",@"其他"]];
                 
            [self.barChart setStrokeColors:@[[UIColor blueColor],[UIColor purpleColor],[UIColor greenColor],[UIColor yellowColor],[UIColor orangeColor],[UIColor cyanColor]]];
            self.barChart.isGradientShow = NO;
            self.barChart.isShowNumbers = YES;
            
            [self.barChart strokeChart];
            
            self.barChart.delegate = self;
            
            [self.backScrollV addSubview:self.barChart];
            
        }
        return _barChart;
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

    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forTicketCount"];
    
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
    NSNumber *num = nil;
    if ([result[@"total"] isEqualToNumber:@0] ) {
        num = @100;
    } else {
        num = result[@"total"];
    }
    
    
    [_circleChart updateChartByCurrent:result[@"high"] byTotal:num];

    [_circleChart1 updateChartByCurrent:result[@"middle"] byTotal:num];

    [_circleChart2 updateChartByCurrent:result[@"low"] byTotal:num];
    
    _gdallCount.text = [NSString stringWithFormat:@"%@", result[@"total"]];
    
    _annotationView.countArr =@[[NSString stringWithFormat:@"%@", result[@"high"]],[NSString stringWithFormat:@"%@", result[@"middle"]], [NSString stringWithFormat:@"%@", result[@"low"]]];
    
    _progressbarSetView.countArr =@[[NSString stringWithFormat:@"%@", result[@"notRepair"]],[NSString stringWithFormat:@"%@", result[@"unFinish"]], [NSString stringWithFormat:@"%@", result[@"completed"]]];
    
    
     [_barChart updateChartData:@[result[@"hv"],result[@"se"],result[@"le"],result[@"ww"],result[@"syn"],result[@"other"]]];
    
    
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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
