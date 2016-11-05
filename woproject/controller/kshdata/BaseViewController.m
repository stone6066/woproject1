//
//  BaseViewController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () <DOPDropDownMenuDataSource,DOPDropDownMenuDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *classifys;

@property (nonatomic, strong) NSMutableArray *areas;

@property (nonatomic, strong) NSMutableArray *sorts;
@property (nonatomic, weak) DOPDropDownMenu *menu;

@property(nonatomic,strong)NSArray *forProjectList;//项目列表
@property(nonatomic,strong)NSArray *forCityList;//省



@property (nonatomic, strong) UIView *toptView;

@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIButton *backbt;

@property (nonatomic, strong) NSArray *dateArr;

@property (nonatomic, strong) UIButton *dateListBt;

@property (nonatomic, strong) NSDictionary *tempProStr;

@end

@implementation BaseViewController


- (void)initFrontProperties {
    _dateArr = @[
                 @{@"word":@"年",@"code":@"year"},
                 @{@"word":@"月",@"code":@"month"},
                 @{@"word":@"周",@"code":@"week"},
                 @{@"word":@"日",@"code":@"day"}
                 ];
    _dateStr = @"day";
    _projectIdStr = @"";
    _provinceIdStr = @"";
    _cityIdStr = @"";
    _classifys = [NSMutableArray arrayWithCapacity:0];
    _sorts = [NSMutableArray arrayWithCapacity:0];
    _areas = [NSMutableArray arrayWithCapacity:0];
   
}

- (void)manuallyProperties {
    
}

- (void)initUI {
    
}

- (void)setProperties {
    
}

- (void)gsHandleData{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = RGB(240, 240, 240);
    [self manuallyProperties];
    [self gsHandleData];
    [self initUI];
    [self setProperties];
    [self loadTopNav];
    [self stdVarsInit];
    
    // Do any additional setup after loading the view.
}


- (void)loadTopNav{
    
    _toptView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    _toptView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    _topLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    _topLabel.text = _topTitle;
    [_topLabel setFont:[UIFont systemFontOfSize:18]];
    [_topLabel setTextAlignment:NSTextAlignmentCenter];
    [_topLabel setTextColor:[UIColor whiteColor]];
    
    [_toptView addSubview:_topLabel];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 27, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [_toptView addSubview:backimg];
    
    UILabel *hintLbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 29, 30, 20)];
    hintLbl.text=@"返回";
    [hintLbl setFont:[UIFont systemFontOfSize:14]];
    [hintLbl setTextAlignment:NSTextAlignmentCenter];
    [hintLbl setTextColor:[UIColor whiteColor]];
    
    [_toptView addSubview:hintLbl];
    
    _dateListBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dateListBt setFrame:CGRectMake(fDeviceWidth - 60, 28, 50, 25)];
    [_dateListBt addTarget:self action:@selector(showList) forControlEvents:UIControlEventTouchUpInside];
    _dateListBt.hidden = !_dateListShow;
    _dateListBt.titleLabel.font = [UIFont systemFontOfSize:14];
    _dateListBt.layer.cornerRadius = 5;
    _dateListBt.layer.masksToBounds = YES;
//    _dateListBt setImage:[UIImage] forState:(UIControlState)
    [_dateListBt setTitle:_dateArr[3][@"word"] forState:(UIControlStateNormal)];
    _dateListBt .backgroundColor = RGB(61, 71, 83);
    [_toptView addSubview:_dateListBt];
    [self.view addSubview:_toptView];

    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [_toptView addSubview:back];
    [self.view addSubview:_toptView];
    
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
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    tab.layer.cornerRadius = 5;
    tab.layer.masksToBounds = YES;
    [_backbt addSubview:tab];
    [tab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backbt).offset(54);
        make.right.equalTo(_backbt).offset(-10);
        make.height.equalTo(@100);
        make.width.equalTo(@50);
    }];
    tab.delegate = self;
    tab.dataSource = self;
//    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    tab.scrollEnabled = NO;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_dateListBt setTitle:_dateArr[indexPath.row][@"word"] forState:(UIControlStateNormal)];
    
    self.dateStr =_dateArr[indexPath.row][@"code"];
    
    [self gsHandleData];
    
    [self back];
    
}
- (void)back {
    [_backbt removeFromSuperview];
    _backbt = nil;
}

- (void)setTopTitle:(NSString *)topTitle {
    if (_topTitle != topTitle) {
        _topTitle = topTitle;
    }
    _topLabel.text = _topTitle;
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
    
    [_areas addObject:@"请选择市"];
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;
    
    // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    [menu selectDefalutIndexPath];
}


- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.classifys.count;
    }else if (column == 1){
        return self.areas.count;
    }else {
        return self.sorts.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
    if (indexPath.column == 0) {
        return self.classifys[indexPath.row];
    } else if (indexPath.column == 1){
        return self.areas[indexPath.row];
    } else {
        return self.sorts[indexPath.row];
    }
}

// new datasource

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0 || indexPath.column == 1) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.row];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0 && indexPath.item >= 0) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.item];
    }
    return nil;
}

// new datasource

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column < 2) {
//        return [@(arc4random()%1000) stringValue];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    //return [@(arc4random()%1000) stringValue];
    return nil;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    //    if (column == 0) {
    //        if (row == 0) {
    //            return self.cates.count;
    //        } else if (row == 2){
    //            return self.movices.count;
    //        } else if (row == 3){
    //            return self.hostels.count;
    //        }
    //    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    //    if (indexPath.column == 0) {
    //        if (indexPath.row == 0) {
    //            return self.cates[indexPath.item];
    //        } else if (indexPath.row == 2){
    //            return self.movices[indexPath.item];
    //        } else if (indexPath.row == 3){
    //            return self.hostels[indexPath.item];
    //        }
    //    }
    return nil;
}



- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
    if (indexPath.item >= 0) {
        
    }else {
        
        switch (indexPath.column) {
            case 0: {
                
                

                if (indexPath.row !=0) {
                    NSDictionary *dic = _forCityList[indexPath.row -1];
                    
                    if (_areas.count > 0) {
                        [_areas removeAllObjects];
                    }
                    [_areas addObject:@"请选择市"];
                    
                    for (NSDictionary *dict in dic[@"city"]) {
                        NSString *names=[dict objectForKey:@"name"];
                        [self.areas addObject:names];
                    }
                    
//                    if (_tempStr.length ==0) {
//                        _tempStr =  dic[@"name"];
//                    } else {
//                        if ([_tempStr isEqualToString:dic[@"name"]]) {
//                            
//                        } else {
//                                                        _tempStr = dic[@"name"];
//                        }
//                    }
//                    
//                                       NSLog(@"%@", dic[@"name"]);
                    _provinceIdStr = dic[@"id"];
                    _tempProStr = dic;
                } else {
                    if (_areas.count > 0) {
                        [_areas removeAllObjects];
                    }
                    [_areas addObject:@"请选择市"];
                    _provinceIdStr = @"";
                   
                    _cityIdStr = @"";
                }
 
            }
                
                break;
            case 1: {
                
                if (indexPath.row !=0) {
                    NSDictionary *dic = _tempProStr[@"city"][indexPath.row - 1];

                    if (_provinceIdStr.length > 0) {
                        if ([dic[@"parentId"] isEqualToString:_provinceIdStr]) {
                            _cityIdStr = dic[@"id"];
                        }
                    } else {
                        [SVProgressHUD showInfoWithStatus:@"请先选择省份"];
                        return;
                    }
                    
                } else {
                    _cityIdStr = @"";
                }
            }
                
                break;
            case 2:
                
                break;
            default:
                break;
        }
    
        NSLog(@"%@", _areas);
        
        
        
        [self gsHandleData];
        
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}

- (void)setDateListShow:(BOOL)dateListShow {
    if (_dateListShow != dateListShow) {
        _dateListShow = dateListShow;
    }
}

- (void)setDateStr:(NSString *)dateStr {
    if (_dateStr != dateStr) {
        _dateStr = dateStr;
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
