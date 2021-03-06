//
//  YjgdViewController.h
//  woproject
//
//  Created by tianan-apple on 16/10/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YjgdViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *FaultSyetemArr;//系统故障
@property(nonatomic,strong)NSArray *forProjectList;//项目列表
@property(nonatomic,strong)NSMutableArray *tabledata;

@property(nonatomic,strong)UITableView *TableView;
@property(nonatomic,assign)NSInteger pageindex;

@property(nonatomic,copy)NSString * projectId;//项目id
@property(nonatomic,copy)NSString * systemId;//系统故障id
@property(nonatomic,copy)NSString * priority;//优先级id 1高，2中，3低

@property(nonatomic,copy)NSString * sortid;//数据id 加载更多的时候使用，初始0
@end
