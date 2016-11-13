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

@interface VideoDetailViewController ()

@end

@implementation VideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self stdVarsInit];

    [self loadHomeCollectionView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id)init:(NSMutableArray *)channelList{
    if (self==[super init]) {
        _dataSource=channelList;
    }
    return self;
}

-(void)loadHomeCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TopStausHight+150, fDeviceWidth, fDeviceHeight-TopStausHight-150-79) collectionViewLayout:flowLayout];
    
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
    return  _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    NSDictionary *dict= _dataSource[indexPath.item];
    ChannelModel *CM=[[ChannelModel alloc]init];
    CM.channelName=[dict objectForKey:@"channelName"];
    CM.channelNo=[dict objectForKey:@"channelNo"];
    [cell showCellView:CM];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict= _dataSource[indexPath.item];
    NSString *channelNo=[dict objectForKey:@"channelNo"];
    NSLog(@"channelNo:%@",channelNo);
    
    DeviceModel *model=[[DeviceModel alloc]init];
    model.status=YES;
    model.device_id=[channelNo integerValue];
    if(model.status)
    {
        VideoViewController *view= [[VideoViewController alloc]initWithDat:model];
        //        view.naDelegate=self.naDelegate;
        [self.navigationController pushViewController:view animated:true];
    }

    
}

//有多少个section；
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //有多少个一维数组；
    return 1;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((fDeviceWidth - 40) / 2, (fDeviceWidth - 40) / 2);
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0,20,0,20);
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(self.collectionView.frame.size.width, 50);
//}

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
@end
