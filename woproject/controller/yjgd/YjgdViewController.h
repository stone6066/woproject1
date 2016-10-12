//
//  YjgdViewController.h
//  woproject
//
//  Created by tianan-apple on 16/10/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YjgdViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *FaultSyetemArr;
@property(nonatomic,strong)NSArray *forProjectList;
@property(nonatomic,strong)NSMutableArray *tabledata;

@property(nonatomic,strong)UITableView *TableView;
@property(nonatomic,assign)NSInteger pageindex;
@end
