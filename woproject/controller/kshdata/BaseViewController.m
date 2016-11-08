//
//  BaseViewController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "BaseViewController.h"
#import "DropMenuListView.h"
#import "listCell.h"


@interface BaseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *classifys;

@property (nonatomic, strong) NSMutableArray *areas;

@property (nonatomic, strong) NSMutableArray *sorts;

@property (nonatomic, strong)  DropMenuListView *listMenu;
@property (nonatomic, strong) UIView *listView;
@property (nonatomic, strong) UITableView *tablevlist;

@property (nonatomic) NSNumber *choose;
@property (nonatomic, copy) NSString *tempStr;
@property (nonatomic, strong) NSArray *tempArr;

@property (nonatomic, strong) NSArray *rowDataArr;

@property (nonatomic, strong) UITableView *dateTab;

@property (nonatomic, assign) NSInteger change;


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

- (void)addNoti {
    
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
    [self addNoti];
    [self gsHandleData];
    [self initUI];
    [self setProperties];
    [self loadTopNav];
    [self listMenu];
    // 添加下拉菜单
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual: _dateTab]) {
        [_dateListBt setTitle:_dateArr[indexPath.row][@"word"] forState:(UIControlStateNormal)];
        
        self.dateStr =_dateArr[indexPath.row][@"code"];
        
        [self gsHandleData];
        
        [self back];
        
    } else {
        _change = 0;
        
        
        switch ([_choose integerValue]) {
                
            case   1: {
                
                if (indexPath.row !=0) {
                    
                    NSDictionary *dic = _forCityList[indexPath.row -1];
                    
                    if (_provinceIdStr != dic[@"id"]) {
                        
                        _cityIdStr = @"";
                        
                        _change = 2;
                        
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
                    
                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
                    
                    _rowDataArr  = [NSArray arrayWithArray:_areas];
                    
                } else {
                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
                    _cityIdStr = @"";
                    _projectIdStr = @"";
                    _provinceIdStr = @"";
                    
                }
                
            }
                
                break;
                
            case 2: {
                
                if (indexPath.row !=0) {
                    
                    NSDictionary *dic = _tempArr[indexPath.row - 1];
                    
                    NSLog(@"%@", dic);
                    if (_cityIdStr != dic[@"id"]) {
                        _change = 3;
                        
                        _projectIdStr = @"";
                        
                        _cityIdStr = dic[@"id"];
                        
                    }
                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
                    
                } else {
                    
                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
                    _projectIdStr = @"";
                    _cityIdStr =@"";
                    
                }
                
            }
                
                break;
                
            case 3:
                
                
                if (indexPath.row != 0) {
                    NSDictionary *dic = _forProjectList[indexPath.row - 1];
                    _projectIdStr = dic[@"id"];
                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
                } else {
                    _projectIdStr = @"";
                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
                }
                
                
                break;
                
            default:
                break;
        }
        
        

        
        [self gsHandleData];
        
        
    }
    

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

}

- (DropMenuListView *)listMenu {
    
    if (!_listMenu) {
        _listMenu = [[DropMenuListView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, 44)];
        [self.view addSubview:_listMenu];
        _listMenu.superClassN = NSStringFromClass([self class]);
        [_listMenu setTitleContentWithArr:@[@"请选择省", @"请选择市", @"请选择项"]];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(dropMenListViewToBaseViewControllerShowListNoti:) name:NSStringFromClass([self class]) object: nil];
        
        
        NSLog(@"%@", NSStringFromClass([self class]));
    }
    return _listMenu;
}

- (void)dropMenListViewToBaseViewControllerShowListNoti:(NSNotification *)noti {
    
    _choose = noti.userInfo[@"choose"];
    
    _tempStr = noti.userInfo[@"lbtext"];
    if ([noti.userInfo[@"show"] isEqual:@1]) {
        [self listView];
        if ([_choose isEqual:@1]) {
            _rowDataArr = [NSArray arrayWithArray:_classifys];
        } else if ([_choose isEqual:@2]) {
            _rowDataArr = [NSArray arrayWithArray:_areas];
        } else {
            _rowDataArr = [NSArray arrayWithArray:_sorts];
        }
        
        [_tablevlist reloadData];
        
    } else {
        
        [self listViewHiddenWith:@""];
        
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
    [self listViewHiddenWith:@""];
}

- (void)listViewHiddenWith:(NSString *)str {
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:[NSString stringWithFormat:@"remove%@", NSStringFromClass([self class])] object:nil userInfo:@{@"choose":_choose, @"lbtext":str, @"change":@(_change)}];
    
    [_listView removeFromSuperview];
    
    _listView = nil;
    
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
