//
//  BaseViewController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()


//



@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIButton *backbt;


//
//@property (nonatomic, strong) NSDictionary *tempProStr;

@end

@implementation BaseViewController


- (void)initFrontProperties {
   
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
//    [self loadTopNav];
//    [self listMenu];
    // 添加下拉菜单
//    [self stdVarsInit];
    
    // Do any additional setup after loading the view.
}



//- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if ([tableView isEqual:_dateTab]) {
//        
//        return 4;
//        
//    } else {
//        
//        return _rowDataArr.count;
//
//    }
//    
//}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 1;
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if ([tableView isEqual:_dateTab]) {
//        static NSString *cellName = @"cellname";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
//        }
//        cell.textLabel.text = _dateArr[indexPath.row][@"word"];
//        
//        
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.textLabel.textColor = [UIColor blackColor];
//        if ([cell.textLabel.text isEqualToString:_dateListBt.titleLabel.text]) {
//            cell.textLabel.textColor = RGB(130, 219, 250);
//        }
//        
//        cell.backgroundColor = RGB(255, 255, 255);
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//
//    } else {
//        
//        listCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"baseListCell"];
//        
//        cell.name = _rowDataArr[indexPath.row];
//        
//        if ([_tempStr isEqualToString:cell.name]) {
//            cell.current = YES;
//        } else {
//            cell.current =NO;
//        }
//        
//        return cell;
//    }
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([tableView isEqual:_dateTab]) {
//        return 25;
//    } else {
//        return 44;
//    }
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if ([tableView isEqual: _dateTab]) {
//        
//        [_dateListBt setTitle:_dateArr[indexPath.row][@"word"] forState:(UIControlStateNormal)];
//        
//        self.dateStr =_dateArr[indexPath.row][@"code"];
//        
//        [self gsHandleData];
//        
//        [self back];
//        
//    } else {
//        _change = 0;
//        
//        switch ([_choose integerValue]) {
//                
//            case   1: {
//                
//                if (indexPath.row !=0) {
//                    
//                    NSDictionary *dic = _forCityList[indexPath.row -1];
//                    
//                    if (_provinceIdStr != dic[@"id"]) {
//                        
//                        _cityIdStr = @"";
//                        
//                        _change = 2;
//                        
//                        _projectIdStr = @"";
//                        
//                        _provinceIdStr = dic[@"id"];
//                        
//                    }
//                    
//                    
//                    _tempArr = dic [@"city"];
//                    
//                    if (_areas.count > 0) {
//                        
//                        [_areas removeAllObjects];
//                        
//                    }
//                    
//                    [_areas addObject:@"请选择市"];
//                    
//                    for (NSDictionary *dict in dic[@"city"]) {
//                        
//                        NSString *names=[dict objectForKey:@"name"];
//                        
//                        [self.areas addObject:names];
//                        
//                    }
//                    
//                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
//                    
//                    _rowDataArr  = [NSArray arrayWithArray:_areas];
//                    
//                } else {
//                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
//                    _cityIdStr = @"";
//                    _projectIdStr = @"";
//                    _provinceIdStr = @"";
//                    
//                }
//                
//            }
//                
//                break;
//                
//            case 2: {
//                
//                if (indexPath.row !=0) {
//                    
//                    NSDictionary *dic = _tempArr[indexPath.row - 1];
//                    
//              
//                    if (_cityIdStr != dic[@"id"]) {
//                        
//                        _change = 3;
//                        
//                        _projectIdStr = @"";
//                        
//                        _cityIdStr = dic[@"id"];
//                        
//                    }
//                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
//                    
//                } else {
//                    
//                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
//                    _projectIdStr = @"";
//                    _cityIdStr =@"";
//                    
//                }
//                
//            }
//                
//                break;
//                
//            case 3:
//                
//                
//                if (indexPath.row != 0) {
//                    NSDictionary *dic = _forProjectList[indexPath.row - 1];
//                    _projectIdStr = dic[@"id"];
//                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
//                } else {
//                    _projectIdStr = @"";
//                     [self listViewHiddenWith:_rowDataArr[indexPath.row]];
//                }
//                
//                
//                break;
//                
//            default:
//                break;
//        }
//        
//
//        [self gsHandleData];
//        
//        
//    }
//    
//
//}
//- (void)back {
//    [_backbt removeFromSuperview];
//    _backbt = nil;
//}



//-(void)stdVarsInit{
//    _forCityList = [DownLoadBaseData readBaseData:@"forCity.plist"];
//    [_classifys addObject:@"请选择省"];
//    
//    for (NSDictionary *dict in _forCityList) {
//        NSString *names=[dict objectForKey:@"name"];
//        [_classifys addObject:names];
//    }
//    
//    _forProjectList= [DownLoadBaseData readBaseData:@"forProjectList.plist"];
//    
//    [_sorts addObject:@"请选择项"];
//    
//    for (NSDictionary * dict in _forProjectList) {
//        NSString *names=[dict objectForKey:@"name"];
//        [_sorts addObject:names];
//    }
//
//}
//
//- (DropMenuListView *)listMenu {
//    
//    if (!_listMenu) {
//        _listMenu = [[DropMenuListView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, 44)];
//        [self.view addSubview:_listMenu];
//        _listMenu.superClassN = NSStringFromClass([self class]);
//        [_listMenu setTitleContentWithArr:@[@"请选择省", @"请选择市", @"请选择项"]];
//        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//        [center addObserver:self selector:@selector(dropMenListViewToBaseViewControllerShowListNoti:) name:NSStringFromClass([self class]) object: nil];
//        
//        
//    
//    }
//    return _listMenu;
//}
//
//- (void)dropMenListViewToBaseViewControllerShowListNoti:(NSNotification *)noti {
//    
//    _choose = noti.userInfo[@"choose"];
//    
//    _tempStr = noti.userInfo[@"lbtext"];
//    if ([noti.userInfo[@"show"] isEqual:@1]) {
//        [self listView];
//        if ([_choose isEqual:@1]) {
//            _rowDataArr = [NSArray arrayWithArray:_classifys];
//        } else if ([_choose isEqual:@2]) {
//            _rowDataArr = [NSArray arrayWithArray:_areas];
//        } else {
//            _rowDataArr = [NSArray arrayWithArray:_sorts];
//        }
//

//        [_tablevlist reloadData];
//        
//    } else {
//        
//        [self listViewHiddenWith:@""];
//        
//    }
//    
//}
//
//- (UIView *)listView {
//    
//    if (!_listView) {
//        
//        _listView = [[UIView alloc] initWithFrame:CGRectMake(0, 108, fDeviceWidth, fDeviceHeight - 108)];
//        [self.view addSubview:_listView];
//        
//        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, fDeviceHeight - 133, fDeviceWidth, 25)];
//        
//        [_listView addSubview:imgv];
//        
//        imgv.userInteractionEnabled = YES;
//        
//        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//        
//        [imgv addGestureRecognizer:tap];
//        
//        [imgv setImage:[UIImage imageNamed:@"icon_chose_bottom"]];
//        
//        _tablevlist = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight - 133) style:(UITableViewStylePlain)];
//        [_listView addSubview:_tablevlist];
//        _tablevlist.delegate = self;
//        _tablevlist.dataSource = self;
//        [_tablevlist registerNib:[UINib nibWithNibName:@"listCell" bundle:nil] forCellReuseIdentifier:@"baseListCell"];
//        _tablevlist.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tablevlist.tableFooterView = [[UIView alloc] init];
//        _listView.backgroundColor = [UIColor whiteColor];
//        
//    }
//    return _listView;
//}
//
//- (void)tap:(UITapGestureRecognizer *)tap {
//    [self listViewHiddenWith:@""];
//}
//
//- (void)listViewHiddenWith:(NSString *)str {
//    
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center postNotificationName:[NSString stringWithFormat:@"remove%@", NSStringFromClass([self class])] object:nil userInfo:@{@"choose":_choose, @"lbtext":str, @"change":@(_change)}];
//    
//    [_listView removeFromSuperview];
//    
//    _listView = nil;
//    
//}
//
//
//



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
