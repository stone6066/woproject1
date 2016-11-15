//
//  MainVideoViewController.h
//  woproject
//
//  Created by tianan-apple on 2016/11/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainVideoViewController : UIViewController
@property(nonatomic,strong)NSMutableArray *forProjectList;//项目列表
@property(nonatomic,strong)NSArray *forProvinceList;//项目列表
@property(nonatomic,strong)NSArray *forCityList;//项目列表
@property(nonatomic,strong)NSMutableArray *videotabledata;
@property(nonatomic,strong)NSMutableArray *projectAllData;//省市项目全部数据

@property(nonatomic,assign)NSInteger pageindex;

@property(nonatomic,copy)NSString * projectId;//项目id
@property(nonatomic,copy)NSString * provinceId;//
@property(nonatomic,copy)NSString * cityId;//

@property(nonatomic,copy)NSString * projectName;//项目
@property(nonatomic,copy)NSString * provinceName;//
@property(nonatomic,copy)NSString * cityName;//


@property(nonatomic,assign)NSInteger provinceIndex;
@property(nonatomic,assign)NSInteger cityIndex;
@property(nonatomic,assign)NSInteger projectIndex;

@property(nonatomic,copy)NSString * sortid;//数据id 加载更多的时候使用，初始0


@end
