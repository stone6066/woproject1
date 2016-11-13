//
//  VideoDetailViewController.h
//  woproject
//
//  Created by tianan-apple on 2016/11/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoDetailViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic)NSMutableArray *dataSource;
@property (nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *forProjectList;//项目列表
@property(nonatomic,strong)NSArray *forProvinceList;//项目列表
@property(nonatomic,strong)NSArray *forCityList;//项目列表
@property(nonatomic,strong)NSMutableArray *videotabledata;


@property(nonatomic,assign)NSInteger pageindex;

@property(nonatomic,copy)NSString * projectId;//项目id
@property(nonatomic,copy)NSString * provinceId;//系统故障id
@property(nonatomic,copy)NSString * cityId;//优先级id 1高，2中，3低
@property(nonatomic,copy)NSString * sortid;//数据id 加载更多的时候使用，初始0
@property (nonatomic, strong) NSMutableArray *provinceArr;
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSMutableArray *projectArr;
@property (nonatomic, strong) NSMutableArray *sorts;
@property (nonatomic, weak) DOPDropDownMenu *menu;

-(id)init:(NSMutableArray *)channelList;
@end
