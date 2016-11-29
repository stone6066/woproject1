//
//  VideoDetailViewController.m
//  woproject
//
//  Created by tianan-apple on 2016/11/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "VideoDetailCollectionViewCell.h"
#import "ChannelModel.h"
#import "DeviceModel.h"
#import "VideoViewController.h"
#import "PlayerViewController.h"
#import "MindNet.h"
#import <qysdk/QYType.h>
#import "HeadView.h"
#import "StringUtils.h"
#import "VideoModel.h"

@interface VideoDetailViewController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>

@end

@implementation VideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgDataSource=[[NSMutableArray alloc]init];
    [self loadTopNav];
    [self stdVarsInit];

    [self loadHomeCollectionView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id)init:(NSMutableArray *)channelList menuArg:(NSMutableArray*)menuArr{
    if (self==[super init]) {
        _dataSource=[[NSMutableArray alloc]init];
        _dataSource=channelList;
        _menuData=menuArr;
        _imageCount=0;
         [_imgDataSource removeAllObjects];
        [self stdGetVideoImg];
    }
    return self;
}

-(void)loadHomeCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TopStausHight+140, fDeviceWidth, fDeviceHeight-TopStausHight-140) collectionViewLayout:flowLayout];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    //-----------------------------------------
    
    self.collectionView.backgroundColor = bluebackcolor;//
    [self.collectionView registerNib:[UINib nibWithNibName:@"VideoDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];
    //[self.collectionView registerClass:[VideoDetailCollectionViewCell class]  forCellWithReuseIdentifier:@"CollectionCell"];
    
   
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     [self drawOnlineCamNum];
    return  _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    NSDictionary *dict= _dataSource[indexPath.item];
    ChannelModel *CM=[[ChannelModel alloc]init];
    CM.channelName=[dict objectForKey:@"channelName"];
    CM.channelNo=[dict objectForKey:@"channelNo"];
    if (_imgDataSource.count==_dataSource.count) {
        CM.channelImgName=_imgDataSource[indexPath.item];
    }
    [cell showCellView:CM];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict= _dataSource[indexPath.item];
    NSString *channelNo=[dict objectForKey:@"channelNo"];
    NSString *channelName=[dict objectForKey:@"channelName"];
    NSLog(@"channelNo:%@",channelNo);
    
    DeviceModel *model=[[DeviceModel alloc]init];
    model.status=YES;
    model.device_id=[channelNo longLongValue];
    if(model.status)
    {
        
        PlayerViewController *view= [[PlayerViewController alloc]initWithDat:model title:channelName];
        // VideoViewController *view= [[VideoViewController alloc]initWithDat:model];
        //        view.naDelegate=self.naDelegate;
        view.view.backgroundColor=[UIColor whiteColor];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:true];
       //  self.hidesBottomBarWhenPushed = NO;
        
       
    }

    
}

//有多少个section；
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //有多少个一维数组；
    return 1;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((fDeviceWidth - 10) / 2, 125);
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
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
    
    _videotabledata=[[NSMutableArray alloc]init];
    _provinceArr=[[NSMutableArray alloc]init];
    _cityArr=[[NSMutableArray alloc]init];
    _projectArr=[[NSMutableArray alloc]init];
    
    _forProjectList=[[NSMutableArray alloc]init];
    _forCityList=[[NSMutableArray alloc]init];
    _forProvinceList=[[NSMutableArray alloc]init];
    
    _forProvinceList= [DownLoadBaseData readBaseData:@"forCity.plist"];
    for (NSDictionary * dict in _forProvinceList) {
        [_provinceArr addObject:[dict objectForKey:@"name"]];
    }
    _provinceId=_menuData[0];
    [self stdGetCityFromProvinceId:_provinceId];
    
    _forProjectList=_menuData[6];
    for (NSDictionary * dict in _forProjectList) {
        [_projectArr addObject:[dict objectForKey:@"name"]];
    }
    
    
    
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    
    [self.view addSubview:menu];
    _menu = menu;
    
    //menuData 0._provinceId 1._provinceName 2._cityName 3_projectName 4._cityIndex 5.projectIndex
    
    
    NSInteger pIndex=[self getProvinceIndex:_provinceId];
    
    NSString *cityIndex=_menuData[4];
    NSString *projectIndex=_menuData[5];
    
    [menu setTitleAtIndex:_menuData[1] forIndex:0 selectIndex:pIndex];
    [menu setTitleAtIndex:_menuData[2] forIndex:1 selectIndex:[cityIndex integerValue]];
    [menu setTitleAtIndex:_menuData[3] forIndex:2 selectIndex:[projectIndex integerValue]];
    // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    //[menu selectDefalutIndexPath];
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
                [self stdGetCityFromProvinceId:_provinceId];
            }
            else
            {
                _provinceId=nil;
                [_cityArr removeAllObjects];
                //[_cityArr addObject:@"请选择城"];
                
            }
            if (_cityArr.count>0) {
                [menu setTitleAtIndex:_cityArr[0] forIndex:1 selectIndex:0];
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
            [self stdGetVideoPragram:_projectId];            break;
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
            for (NSDictionary * dict in _forCityList) {
                [_cityArr addObject:[dict objectForKey:@"name"]];
            }
            //[_menu reloadData];
            return;
        }
        
    }
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


//获取视频列表
-(void)stdGetVideoPragram:(NSString*)pid{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/getVideoList"];
    if (!pid) {
        [_dataSource removeAllObjects];
        [self.collectionView reloadData];
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
                                              if (_videotabledata.count>0) {
                                                  VmModel=_videotabledata[0];
                                                  _dataSource=VmModel.channelList;
                                              }
                                              
                                              
                                              [self.collectionView reloadData];
                                              _imageCount=0;
                                               [_imgDataSource removeAllObjects];
                                              [self stdGetVideoImg];
                                              
                                              
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
            //[_dataSource removeAllObjects];
            _dataSource=nil;
            [self.collectionView reloadData];
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
                NSLog(@"视频登录成功！%@",_projectId);
                [self stdGetVideoPragram:_projectId];//@"632891200"
                //[self DeviceList];
                [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidBecomeActiveNotification object:NULL];
            }
        }];
    }
}

-(void)drawOnlineCamNum{
    UIView * numVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+45, fDeviceWidth, 40)];
    
    numVc.backgroundColor=[UIColor whiteColor];
    UIImageView *iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 18, 21)];
    iconImg.image=[UIImage imageNamed:@"smallvideo"];
    [numVc addSubview:iconImg];
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(43, 13, 130, 20)];
    [titleLbl setFont:[UIFont systemFontOfSize:14]];
    [titleLbl setTextColor:videobluetxtcolor];
    titleLbl.text=@"在线摄像头数量：";
    [titleLbl sizeToFit];
    [numVc addSubview:titleLbl];
    
    UILabel *titleLblnum=[[UILabel alloc]initWithFrame:CGRectMake(titleLbl.frame.origin.x+titleLbl.frame.size.width+3, 0, 100, 20)];
    [titleLblnum setFont:[UIFont systemFontOfSize:17]];
     titleLblnum.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(36.0)];
    [titleLblnum setTextColor:videobluetxtcolor];
    titleLblnum.text=[NSString stringWithFormat:@"%lu",(unsigned long)_dataSource.count];
     [titleLblnum sizeToFit];
    [numVc addSubview:titleLblnum];
    
    UILabel *titleLblGe=[[UILabel alloc]initWithFrame:CGRectMake(titleLblnum.frame.origin.x+titleLblnum.frame.size.width+3, 12, 40, 20)];
    [titleLblGe setFont:[UIFont systemFontOfSize:14]];
    [titleLblGe setTextColor:videobluetxtcolor];
    titleLblGe.text=@"个";
    [numVc addSubview:titleLblGe];
    [self.view addSubview:numVc];
}

-(void)stdGetVideoImg{
    
   
    // for (NSDictionary *dict in _dataSource)
    {
        NSDictionary *dict=_dataSource[_imageCount];
        NSString *channelNo=[dict objectForKey:@"channelNo"];
        NSString *paths=[NSString stringWithFormat:@"%@myvideo%ld%@",DocumentBasePath,(long)_imageCount,@".png"];
        
        [[MindNet sharedManager]GetCaptureImage:[channelNo longLongValue] imagePath:paths callBack:^(int32_t ret) {
            if (ret==0) {
                
                [_imgDataSource addObject:paths];
                _imageCount++;
                if (_imageCount<_dataSource.count) {
                    [self stdGetVideoImg];
                }
                if (_imgDataSource.count==_dataSource.count) {
                    [_collectionView reloadData];
                }
                
            }
        }];
        
    }
    
    //[DocumentBasePath stringByAppendingFormat:@"/%@", @"png"];
   
    
}

@end
