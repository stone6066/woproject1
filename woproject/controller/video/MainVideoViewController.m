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
#import "HeadView.h"
#import "StringUtils.h"
#import "VideoViewController.h"
#import "VideoModel.h"
#import "VideoTableViewCell.h"
#import "VideoDetailViewController.h"

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
    _videotabledata=[[NSMutableArray alloc]init];
    _provinceArr=[[NSMutableArray alloc]init];
    _cityArr=[[NSMutableArray alloc]init];
    _projectArr=[[NSMutableArray alloc]init];
    
    _forProjectList=[[NSMutableArray alloc]init];
    _forCityList=[[NSMutableArray alloc]init];
    _forProvinceList=[[NSMutableArray alloc]init];
    _projectAllData=[[NSMutableArray alloc]init];
    
    
    [self loadListTable];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ConnectNetwork) name:kNotifyReconnection object:nil];
    //[self ConnectNetwork];
    // Do any additional setup after loading the view.
    [self downgetProjectList:nil city:nil];//下载默认项目
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[self downgetProjectList:nil city:nil];
    

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
    [_provinceArr removeAllObjects];
    [_projectArr removeAllObjects];
    [_cityArr removeAllObjects];
    _forProvinceList= [DownLoadBaseData readBaseData:@"forCity.plist"];
   
    for (NSDictionary * dict in _forProvinceList) {
        [_provinceArr addObject:[dict objectForKey:@"name"]];
    }

    [self stdGetCityFromProvinceId:_provinceId];
    
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
    //[menu selectDefalutIndexPath];
    NSInteger pIndex=[self getProvinceIndex:_provinceId];
    
    [menu setTitleAtIndex:_provinceName forIndex:0 selectIndex:pIndex];
    [menu setTitleAtIndex:_cityName forIndex:1 selectIndex:0];
    [menu setTitleAtIndex:_projectName forIndex:2 selectIndex:0];

    [self ConnectNetwork];
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
            if (indexPath.row>=0) {
                dict=_forProvinceList[indexPath.row];
                _provinceId=[dict objectForKey:@"id"];
                _provinceName=[dict objectForKey:@"name"];
                [self stdGetCityFromProvinceId:_provinceId];
            }
            else
            {
                _provinceId=nil;
                [_cityArr removeAllObjects];
//                [_cityArr addObject:@"请选择城"];
                
            }
            if (_cityArr.count>0) {
                [menu setTitleAtIndex:_cityArr[0] forIndex:1 selectIndex:0];
                //[menu setTitleAtIndex:_cityArr[0] forIndex:1];
            }
            [self downgetProjectList1:_provinceId city:_cityId];
            break;
        case 1://城市
            if (indexPath.row>=0) {
                dict=_forCityList[indexPath.row];
                _cityId=[dict objectForKey:@"id"];
                _cityName=[dict objectForKey:@"name"];
                _cityIndex=indexPath.row;
            }
            else
            {
                _cityId=nil;
            }
            [self downgetProjectList1:_provinceId city:_cityId];
            break;
        case 2://项目
            if (indexPath.row>=0) {
                dict=_forProjectList[indexPath.row];
                _projectId=[dict objectForKey:@"id"];
                _projectIndex=indexPath.row;
            }
            else
            {
                _projectId=nil;
            }
            [self stdGetVideoPragram:_projectId];

            break;
        default:
            break;
            
    }
    _pageindex=0;
    _sortid=@"0";
    //[self downforYjgdList:_projectId systemFault:_systemId priority:_priority];
    NSLog(@"_provinceId:%@ _cityId:%@ _projectId:%@",_provinceId,_cityId,_projectId);
    //

}

-(void)stdGetCityFromProvinceId:(NSString *)pid{
    for (NSDictionary * dict in _forProvinceList) {
        NSString *tmpid=[dict objectForKey:@"id"];
        if ([pid isEqualToString:tmpid]) {
            _forCityList=[dict objectForKey:@"city"];
            [_cityArr removeAllObjects];
            if (_forCityList.count>0) {
                NSDictionary * dict1=_forCityList[0];
                _cityId=[dict1 objectForKey:@"id"];//去除列表第一个城市id
            }
            
            for (NSDictionary * dict in _forCityList) {
                [_cityArr addObject:[dict objectForKey:@"name"]];
            }
            return;
        }
        [_cityArr addObject:@"无城市列表"];
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
                NSLog(@"视频登录成功！%@",_projectId);
                [self stdGetVideoPragram:_projectId];//@"632891200"
                //[self DeviceList];
                //[[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidBecomeActiveNotification object:NULL];
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
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _videotabledata.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellId forIndexPath:indexPath];
    VideoModel *vmtmp=_videotabledata[indexPath.row];
    
    [cell showCellView:vmtmp];
    return cell;
}


#pragma mark----实现跳转，就是缺少导航控制器
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //menuArr:0._provinceId 1._provinceName 2._cityName 3_projectName 4._cityIndex 5.projectIndex 6.forProjectList
    NSMutableArray *menuArr=[[NSMutableArray alloc]initWithObjects:_provinceId,_provinceName, _cityName,_projectName,@(_cityIndex),@(_projectIndex),_forProjectList,nil];
    VideoModel *vmtmp=_videotabledata[indexPath.row];
    VideoDetailViewController *detailVc=[[VideoDetailViewController alloc]init:vmtmp.channelList menuArg:menuArr];
    detailVc.view.backgroundColor=[UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:true];
    //self.hidesBottomBarWhenPushed = NO;
}

static NSString * const TicketCellId = @"mainVideoCellId";
-(void)loadListTable{
    
    self.deviceTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 65+50, fDeviceWidth, fDeviceHeight-65-MainTabbarHeight)];
    self.deviceTable.delegate=self;
    self.deviceTable.dataSource=self;
    
    self.deviceTable.tableFooterView = [[UIView alloc]init];
    self.deviceTable.backgroundColor=collectionBgdColor;
    self.deviceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.deviceTable registerNib:[UINib nibWithNibName:NSStringFromClass([VideoTableViewCell class]) bundle:nil] forCellReuseIdentifier:TicketCellId];
    self.deviceTable.backgroundColor=bluebackcolor;
    [self.view addSubview:self.deviceTable];
    
    
}





//获取视频列表
-(void)stdGetVideoPragram:(NSString*)pid{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/getVideoList"];
    if (!pid) {
        [_videotabledata removeAllObjects];
        [self.deviceTable reloadData];
        [SVProgressHUD dismiss];
        return;
    }
    NSDictionary *paramDict = @{
                                @"uid":ApplicationDelegate.myLoginInfo.Id,
                                @"ukey":ApplicationDelegate.myLoginInfo.ukey,
                                @"projectId":pid,
                                @"v":ApplicationDelegate.myLoginInfo.v
                                };

    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          NSLog(@"视频返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              [SVProgressHUD dismiss];
                                              VideoModel *VmModel=[[VideoModel alloc]init];
                                              _videotabledata=[VmModel asignInfoWithDict:jsonDic];
                                              [self.deviceTable reloadData];
                                              
                                          } else {
                                              //失败
                                              [SVProgressHUD dismiss];
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                         
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                     
                                  }];
    
}



//获项目列表
-(void)stdGetProjectForVideo{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forProjectList"];
    
    NSDictionary *paramDict = @{
                                @"uid":ApplicationDelegate.myLoginInfo.Id,
                                @"ukey":ApplicationDelegate.myLoginInfo.ukey,
                                @"v":ApplicationDelegate.myLoginInfo.v
                                };
    
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          NSLog(@"视频返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              [SVProgressHUD dismiss];
                                              VideoModel *VmModel=[[VideoModel alloc]init];
                                              _videotabledata=[VmModel asignInfoWithDict:jsonDic];
                                              [self.deviceTable reloadData];
                                              
                                          } else {
                                              //失败
                                              [SVProgressHUD dismiss];
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                          
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                      
                                  }];
    
}

-(void)downgetProjectList:(NSString*)provinceId city:(NSString*)cityId{//下载项目列表
    [SVProgressHUD showWithStatus:k_Status_Load];
    
//    NSDictionary *paramDict = @{
//                                @"uid":ApplicationDelegate.myLoginInfo.Id,
//                                @"ukey":ApplicationDelegate.myLoginInfo.ukey
//                                };
    NSMutableDictionary * paramDict=[[NSMutableDictionary alloc]init];
    
    [paramDict setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"uid"];
    [paramDict setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
    if (provinceId!=nil) {
         [paramDict setObject:provinceId forKey:@"provinceId"];
    }
    if (cityId!=nil) {
        [paramDict setObject:cityId forKey:@"cityId"];
    }
   
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/getProjectList"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"下载项目返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                              _projectAllData=[idict objectForKey:@"Data"];
                                              [self praseProjectArr:_projectAllData];
                                              
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
}


-(void)downgetProjectList1:(NSString*)provinceId city:(NSString*)cityId{//下载项目列表
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    //    NSDictionary *paramDict = @{
    //                                @"uid":ApplicationDelegate.myLoginInfo.Id,
    //                                @"ukey":ApplicationDelegate.myLoginInfo.ukey
    //                                };
    NSMutableDictionary * paramDict=[[NSMutableDictionary alloc]init];
    
    [paramDict setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"uid"];
    [paramDict setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
    if (provinceId!=nil) {
        [paramDict setObject:provinceId forKey:@"provinceId"];
    }
    if (cityId!=nil) {
        [paramDict setObject:cityId forKey:@"cityId"];
    }
    
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/getProjectList"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"下载项目返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                              _projectAllData=[idict objectForKey:@"Data"];
                                              [self praseProjectArr1:_projectAllData];
                                              
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
}

-(NSInteger)getProvinceIndex:(NSString*)provinceId{
    NSInteger myIndex=0;
    for (NSDictionary* dict in _forProvinceList ) {
        NSString * pid=[dict objectForKey:@"id"];
       
        if ([pid isEqualToString:provinceId]) {
            return myIndex;
        }
         myIndex++;
    }
    return 0;
}
-(void)praseProjectArr:(NSArray*)pdata{
    @try {
        [_forProjectList removeAllObjects];
        //_projectId
        if (pdata.count>0) {//第一次要显示的省市项目
            NSDictionary *dict1 = pdata[0];
            _projectId=[dict1 objectForKey:@"id"];
            _provinceId=[dict1 objectForKey:@"provinceId"];
            _cityId=[dict1 objectForKey:@"cityId"];
            _projectName=[dict1 objectForKey:@"name"];
            _provinceName=[dict1 objectForKey:@"provinceName"];
            _cityName=[dict1 objectForKey:@"cityName"];
            
        }
        
        for (NSDictionary *dict in pdata) {
            NSMutableDictionary * dictTmp=[[NSMutableDictionary alloc]init];
            
            [dictTmp setObject:[dict objectForKey:@"id"] forKey:@"id"];
            [dictTmp setObject:[dict objectForKey:@"name"]forKey:@"name"];
            [_forProjectList addObject:dictTmp];

        }
        if (_forProjectList.count<1) {
            NSMutableDictionary * dictTmp=[[NSMutableDictionary alloc]init];
            [dictTmp setObject:@"" forKey:@"id"];
            [dictTmp setObject:@"无项目" forKey:@"name"];
            [_forProjectList addObject:dictTmp];
            _projectName=@"无项目";
            _projectId=nil;
            [_projectArr removeAllObjects];
            for (NSDictionary * dict in _forProjectList) {
                [_projectArr addObject:[dict objectForKey:@"name"]];
            }
            [_menu setTitleAtIndex:_projectName forIndex:2 selectIndex:0];
        }
    } @catch (NSException *exception) {
        NSLog(@"视频参数数组解析错误");
    } @finally {
        if (pdata.count>0) {
            [self stdVarsInit];
        }
        else{
            [_videotabledata removeAllObjects];
            [self.deviceTable reloadData];
        }
        
    }
}

-(void)praseProjectArr1:(NSArray*)pdata{
    @try {
        [_forProjectList removeAllObjects];
        //_projectId
        if (pdata.count>0) {//第一次要显示的省市项目
            NSDictionary *dict1 = pdata[0];
            _projectId=[dict1 objectForKey:@"id"];
            _provinceId=[dict1 objectForKey:@"provinceId"];
            _cityId=[dict1 objectForKey:@"cityId"];
            _projectName=[dict1 objectForKey:@"name"];
            _provinceName=[dict1 objectForKey:@"provinceName"];
            _cityName=[dict1 objectForKey:@"cityName"];
            
        }
        
        for (NSDictionary *dict in pdata) {
            NSMutableDictionary * dictTmp=[[NSMutableDictionary alloc]init];
            
            [dictTmp setObject:[dict objectForKey:@"id"] forKey:@"id"];
            [dictTmp setObject:[dict objectForKey:@"name"]forKey:@"name"];
            [_forProjectList addObject:dictTmp];
            
        }
        if (_forProjectList.count<1) {
            NSMutableDictionary * dictTmp=[[NSMutableDictionary alloc]init];
            [dictTmp setObject:@"" forKey:@"id"];
            [dictTmp setObject:@"无项目" forKey:@"name"];
            [_forProjectList addObject:dictTmp];
            _projectName=@"无项目";
            _projectId=nil;
            [_projectArr removeAllObjects];
            for (NSDictionary * dict in _forProjectList) {
                [_projectArr addObject:[dict objectForKey:@"name"]];
            }
            [_menu setTitleAtIndex:_projectName forIndex:2 selectIndex:0] ;
        }
    } @catch (NSException *exception) {
        NSLog(@"视频参数数组解析错误");
    } @finally {
        if (pdata.count>0) {
            [_projectArr removeAllObjects];
            for (NSDictionary * dict in _forProjectList) {
                [_projectArr addObject:[dict objectForKey:@"name"]];
            }
            [_menu setTitleAtIndex:_projectArr[0] forIndex:2 selectIndex:0];
            [self ConnectNetwork];
        }
        else{
            [_videotabledata removeAllObjects];
            [self.deviceTable reloadData];
        }
        
    }
}

-(NSInteger)getIndexOfString:(NSArray*)arr searchStr:(NSString*)ss{
    for (NSInteger i=0; i<arr.count; i++) {
        NSString *tmp=arr[i];
        if ([ss isEqualToString:tmp]) {
            return i;
        }
    }
    return -1;
}

-(NSMutableArray*)getProjectArrFromProvince:(NSString*)provinceId city:(NSString*)cityId{
    NSMutableArray *rtnArr=[[NSMutableArray alloc]init];
    if (!provinceId) {
        for (NSDictionary *dict in _projectAllData) {
            NSString *pid=[dict objectForKey:@"provinceId"];
            if ([pid isEqualToString:provinceId]) {
                NSMutableDictionary * dictTmp=[[NSMutableDictionary alloc]init];
                [dictTmp setObject:[dict objectForKey:@"id"] forKey:@"id"];
                [dictTmp setObject:[dict objectForKey:@"name"]forKey:@"name"];
                [rtnArr addObject:dictTmp];
            }
        }
        return rtnArr;
    }
    if (!cityId) {
        for (NSDictionary *dict in _projectAllData) {
            NSString *pid=[dict objectForKey:@"cityId"];
            if ([pid isEqualToString:cityId]) {
                NSMutableDictionary * dictTmp=[[NSMutableDictionary alloc]init];
                
                [dictTmp setObject:[dict objectForKey:@"id"] forKey:@"id"];
                [dictTmp setObject:[dict objectForKey:@"name"]forKey:@"name"];
                
                [rtnArr addObject:dictTmp];
            }
        }
        return rtnArr;
    }
    return rtnArr;
}

@end
