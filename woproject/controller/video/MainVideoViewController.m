//
//  MainVideoViewController.m
//  woproject
//
//  Created by tianan-apple on 2016/11/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//


#import "MainVideoViewController.h"
#import "MindNet.h"
#import "DeviceModel.h"
#import <qysdk/QYType.h>
#import "LocalityTree_Level1_Cell.h"
#import "HeadView.h"
#import "StringUtils.h"
#import "VideoViewController.h"

@interface MainVideoViewController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,HeadViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* deviceArray;
}
@property (nonatomic, strong) NSMutableArray *provinceArr;
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSMutableArray *projectArr;
@property (nonatomic, strong) NSMutableArray *sorts;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@property(nonatomic,strong) UITableView* deviceTable;

@end

@implementation MainVideoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self stdVarsInit];
    [self loadListTable];
//    _deviceTable.delegate=self;
//    _deviceTable.dataSource=self;
//    self.deviceTable.tableFooterView=[UIView new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ConnectNetwork) name:kNotifyReconnection object:nil];
    //[self ConnectNetwork];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self ConnectNetwork];

}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    topLbl.text=@"视频";
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

-(void)stdVarsInit{
    //   self.classifys = @[@"项目名称",@"故障系统",@"优先级",@"酒店"];
    
    _provinceArr=[[NSMutableArray alloc]init];
    _cityArr=[[NSMutableArray alloc]init];
    _projectArr=[[NSMutableArray alloc]init];
    
    _forProjectList=[[NSMutableArray alloc]init];
    _forCityList=[[NSMutableArray alloc]init];
    _forProvinceList=[[NSMutableArray alloc]init];
    
    _forProvinceList= [DownLoadBaseData readBaseData:@"forCity.plist"];
    [_provinceArr addObject:@"请选择省"];
    for (NSDictionary * dict in _forProvinceList) {
        [_provinceArr addObject:[dict objectForKey:@"name"]];
    }
    
    [_cityArr addObject:@"请选择城"];
    
    _forProjectList= [DownLoadBaseData readBaseData:@"forProjectList.plist"];
    [_projectArr addObject:@"请选择项"];
    for (NSDictionary * dict in _forProjectList) {
        [_projectArr addObject:[dict objectForKey:@"name"]];
    }
    
    
    
    
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
        return self.provinceArr.count;
    }else if (column == 1){
        return self.cityArr.count;
    }else {
        return self.projectArr.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.provinceArr[indexPath.row];
    } else if (indexPath.column == 1){
        return self.cityArr[indexPath.row];
    } else {
        return self.projectArr[indexPath.row];
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
        return nil;//[@(arc4random()%1000) stringValue];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return nil;//[@(arc4random()%1000) stringValue];
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
//- (NSIndexPath *)menu:(DOPDropDownMenu *)menu willSelectRowAtIndexPath:(DOPIndexPath *)indexPath{
//    [menu reloadData];
//    return nil;
//}
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
    
    NSDictionary * dict;
    
    switch (indexPath.column) {
            
        case 0://省份
            if (indexPath.row>0) {
                dict=_forProvinceList[indexPath.row-1];
                _provinceId=[dict objectForKey:@"id"];
                [self stdGetCityFromProvinceId:_provinceId];
            }
            else
            {
                _provinceId=nil;
                [_cityArr removeAllObjects];
                [_cityArr addObject:@"请选择城"];
                
            }
            [menu setTitleAtIndex:_cityArr[0] forIndex:1];
            _cityId=nil;
            break;
        case 1://城市
            if (indexPath.row>0) {
                dict=_forCityList[indexPath.row-1];
                _cityId=[dict objectForKey:@"id"];
            }
            else
            {
                _cityId=nil;
            }
            break;
        case 2://项目
            if (indexPath.row>0) {
                dict=_forProjectList[indexPath.row-1];
                _projectId=[dict objectForKey:@"id"];
            }
            else
            {
                _projectId=nil;
            }
            break;
        default:
            break;
            
    }
    _pageindex=0;
    _sortid=@"0";
    //[self downforYjgdList:_projectId systemFault:_systemId priority:_priority];
    NSLog(@"_provinceId:%@ _cityId:%@ _projectId:%@",_provinceId,_cityId,_projectId);
}

-(void)stdGetCityFromProvinceId:(NSString *)pid{
    for (NSDictionary * dict in _forProvinceList) {
        NSString *tmpid=[dict objectForKey:@"id"];
        if ([pid isEqualToString:tmpid]) {
            _forCityList=[dict objectForKey:@"city"];
            [_cityArr removeAllObjects];
            [_cityArr addObject:@"请选择城"];
            for (NSDictionary * dict in _forCityList) {
                [_cityArr addObject:[dict objectForKey:@"name"]];
            }
            //[_menu reloadData];
            return;
        }
        
    }
}

/*视频相关*/
-(void) ConnectNetwork
{
    //if(![[MindNet sharedManager] hasLogin])
    {
        [[MindNet sharedManager] loginSession:^(int32_t ret) {
            if(ret==0)
            {
                [self DeviceList];
                [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidBecomeActiveNotification object:NULL];
            }
        }];
    }
}



-(void) DeviceList
{
    
    [[MindNet sharedManager] getDeviceSuccess:^(NSArray *ret) {
        deviceArray=[NSMutableArray array];
        NSLog(@"ret:%@",ret);
        for(int i=0; i<ret.count; i++)
        {
            QY_DEVICE_INFO deviceinfo;
            NSValue* valueObj =[ret objectAtIndex:i];
            [valueObj getValue:&deviceinfo];
            DeviceModel * device =[DeviceModel new];
            device.device_id=deviceinfo.deviceID;
            device.status=deviceinfo.status;
            device.subDeviceList=[NSMutableArray array];
            [deviceArray addObject:device];
            NSLog(@"deviceArray:%@",deviceArray);
            
            [[MindNet sharedManager]getChanelwithDevid:device
                                           withsuccess:^(NSArray *ret) {
                                               QY_CHANNEL_INFO chanel;
                                               
                                               for(NSValue* valueObj in ret)
                                               {
                                                   [valueObj getValue:&chanel];
                                                   
                                                   DeviceModel * chanleDevice =[DeviceModel new];
                                                   chanleDevice.device_id=chanel.channelID;
                                                   chanleDevice.status=chanel.status;
                                                   [device.subDeviceList addObject:chanleDevice];
                                                   
                                               }
                                               [self.deviceTable reloadData];
                                           } ];
        }
    }];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return deviceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DeviceModel *device= [deviceArray objectAtIndex:section];
    return  device.subDeviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LocalityTree_Level1_Cell *cell = [LocalityTree_Level1_Cell cellWithTableView:tableView];
    
    DeviceModel *deviceGroup = deviceArray[indexPath.section];
    DeviceModel *subdevice =deviceGroup.subDeviceList[indexPath.row];
    cell.channelLineLabel.text =deviceGroup.status&& subdevice.status?@"在线":@"离线";
    
    cell.channelNameLabel.text =[NSString stringWithFormat:@"%lld",subdevice.device_id];
    
    //    SLLog(@"显示。。。。。。  %@",subdevice.calledName);
    if(deviceGroup.status&&subdevice.status)
    {
        cell.channelLineLabel.textColor=[UIColor blackColor];
        cell.channelNameLabel.textColor=[UIColor blackColor];
        if(subdevice.localimage!=nil)
        {
            [cell.channelIcon setImage:subdevice.localimage];
            [cell.channelIcon setHighlightedImage:subdevice.localimage];
            cell.channelIcon.backgroundColor=[UIColor clearColor];
            
        }
        else
        {
            [cell.channelIcon setHighlightedImage:[UIImage imageNamed:@"passageway"]];
            [cell.channelIcon setImage:[UIImage imageNamed:@"passageway"]];
            cell.channelIcon.backgroundColor=[UIColor clearColor];
        }
    }
    else
    {
        cell.channelLineLabel.textColor=[StringUtils colorWithHexString:@"#666666"];
        cell.channelNameLabel.textColor=[StringUtils colorWithHexString:@"#666666"];
        [cell.channelIcon setHighlightedImage:[UIImage imageNamed:@"passageway"]];
        [cell.channelIcon setImage:[UIImage imageNamed:@"passageway"]];
        cell.channelIcon.backgroundColor=[UIColor clearColor];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    
    headView.delegate = self;
    headView.deviceGroup = deviceArray[section];
    
    return headView;
}
#pragma mark----实现跳转，就是缺少导航控制器
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceModel *model=[deviceArray[indexPath.section] subDeviceList][indexPath.row];
    
    if(model.status)
    {
        VideoViewController *view= [[VideoViewController alloc]initWithDat:model];
        //        view.naDelegate=self.naDelegate;
        [self.navigationController pushViewController:view animated:true];
    }
}

static NSString * const TicketCellId = @"mainVideoCellId";
-(void)loadListTable{
    
    self.deviceTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 65+50, fDeviceWidth, fDeviceHeight-65-MainTabbarHeight)];
    self.deviceTable.delegate=self;
    self.deviceTable.dataSource=self;
    
    self.deviceTable.tableFooterView = [[UIView alloc]init];
    self.deviceTable.backgroundColor=collectionBgdColor;
    self.deviceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.deviceTable registerNib:[UINib nibWithNibName:NSStringFromClass([LocalityTree_Level1_Cell class]) bundle:nil] forCellReuseIdentifier:TicketCellId];
    self.deviceTable.backgroundColor=bluebackcolor;
    [self.view addSubview:self.deviceTable];
    
    
}

@end
