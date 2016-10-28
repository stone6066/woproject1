//
//  MyPDVC.m
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MyPDVC.h"
#import "DOPDropDownMenu.h"
#import "DownLoadBaseData.h"
#import "MRModel.h"
#import "MRCell.h"
#import "DetailVC.h"

@interface MyPDVC ()
<
    DOPDropDownMenuDataSource,
    DOPDropDownMenuDelegate,
    UITableViewDelegate,
    UITableViewDataSource
>

@property(nonatomic,strong)NSArray *FaultSyetemArr;//系统故障
@property(nonatomic,strong)NSArray *forProjectList;//项目列表

@property(nonatomic,assign)NSInteger pageindex;

@property(nonatomic,copy)NSString * projectId;//项目id
@property(nonatomic,copy)NSString * systemId;//系统故障id
@property(nonatomic,copy)NSString * priority;//优先级id 1高，2中，3低
@property(nonatomic,copy)NSString * ticketStatus;//0.未派单；1.未接单；2.已接单；3.已完成；4.已核查；5.已退单；6.已挂起

@property(nonatomic,copy)NSString * sortid;//数据id 加载更多的时候使用，初始0


@property (nonatomic, strong) NSMutableArray *classifys;
@property (nonatomic, strong) NSMutableArray *cates;
@property (nonatomic, strong) NSMutableArray *ticketStatusArr;
@property (nonatomic, strong) NSMutableArray *areas;

@property (nonatomic, strong) NSMutableArray *sorts;
@property (nonatomic, weak) DOPDropDownMenu *menu;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString * const myPaiDanIdentifier = @"myrepairIdentifier";

@implementation MyPDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108 , fDeviceWidth, fDeviceHeight - 108) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

- (void)initUI
{
    self.topTitle = @"我的派单";
    _sortid = @"0";
    [self stdVarsInit];
    [self.view addSubview:self.tableView];
    [self loadListTable];
}

-(void)downforYjgdList:(NSString*)pid systemFault:(NSString*)sid priority:(NSString*)priorityId ticketStatus:(NSString*)tid
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSMutableDictionary * paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"uid"];
    [paramDict setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
    [paramDict setObject:@"0" forKey:@"status"];
    [paramDict setObject:_sortid forKey:@"sort_id"];
    [paramDict setObject:ApplicationDelegate.myLoginInfo.v forKey:@"v"];
    if (_pageindex==0) {//获取最新数据
        [paramDict setObject:@"Greater" forKey:@"comparison"];
    }
    else//获取更多数据
        [paramDict setObject:@"less" forKey:@"comparison"];
    if (pid) {
        [paramDict setObject:pid forKey:@"projectId"];
    }
    if (sid) {
        [paramDict setObject:sid forKey:@"systemId"];
    }
    if (priorityId) {
        [paramDict setObject:priorityId forKey:@"priority"];
    }
    if (tid) {
        [paramDict setObject:tid forKey:@"ticketStatus"];
    }
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forTicketList"];
    
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
                                          //NSLog(@"派单返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              [SVProgressHUD dismiss];
                                              
                                              NSLog(@"%@", jsonDic[@"i"][@"Data"]);
                                              NSArray *datatmp = [NSArray yy_modelArrayWithClass:[MRModel class] json:jsonDic[@"i"][@"Data"]];
                                              if (datatmp.count>0) {
                                                  MRModel *model = [datatmp lastObject];
                                                  _sortid=model.Id;
                                              }
                                              
                                              if (_pageindex==0) {
                                                  [self.dataArray removeAllObjects];
                                                  [self.dataArray addObjectsFromArray:datatmp];
                                                  
                                              }
                                              else
                                              {
                                                  [self.dataArray addObjectsFromArray:datatmp];
                                              }
                                              
                                              [self.tableView reloadData];
                                              
                                              
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

-(void)stdVarsInit{
    
    _forProjectList=[[NSMutableArray alloc]init];
    _FaultSyetemArr=[[NSMutableArray alloc]init];
    _classifys=[[NSMutableArray alloc]init];
    _areas=[[NSMutableArray alloc]init];
    _sorts=[[NSMutableArray alloc]initWithObjects:@"优先级",@"高",@"中",@"低", nil];
    _ticketStatusArr=[[NSMutableArray alloc]initWithObjects:@"工单状态",@"未派单",@"未接单",@"已接单",@"已完成",@"已核查",@"已退单",@"已挂起", nil];
    _forProjectList= [DownLoadBaseData readBaseData:@"forProjectList.plist"];
    [_classifys addObject:@"项目名称"];
    for (NSDictionary * dict in _forProjectList) {
        NSString *names=[dict objectForKey:@"name"];
        NSLog(@"names:%@",names);
        [_classifys addObject:names];
    }
    _FaultSyetemArr= [DownLoadBaseData readBaseData:@"forFaultSyetem.plist"];
    [_areas addObject:@"故障系统"];
    for (NSDictionary * dict in _FaultSyetemArr) {
        [_areas addObject:[dict objectForKey:@"name"]];
    }
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;
    [menu selectDefalutIndexPath];
}


- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 4;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.classifys.count;
    }else if (column == 1){
        return self.areas.count;
    }else if (column == 2){
        return self.sorts.count;
    }
    else
    {
        return self.ticketStatusArr.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.classifys[indexPath.row];
    } else if (indexPath.column == 1){
        return self.areas[indexPath.row];
    } else if (indexPath.column == 2){
        return self.sorts[indexPath.row];
    }
    else
        return self.ticketStatusArr[indexPath.row];
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
    if (indexPath.column < 3) {
        return [@(arc4random()%1000) stringValue];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return [@(arc4random()%1000) stringValue];
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
    NSDictionary * dict;
    switch (indexPath.column) {
        case 0://项目
            if (indexPath.row>0) {
                dict=_forProjectList[indexPath.row-1];
                _projectId=[dict objectForKey:@"id"];
            }
            else
            {
                _projectId=nil;
            }
            break;
        case 1://系统故障
            if (indexPath.row>0) {
                dict=_FaultSyetemArr[indexPath.row-1];
                _systemId=[dict objectForKey:@"id"];
            }
            else
            {
                _systemId=nil;
            }
            break;
        case 2://优先级
            if (indexPath.row>0)
                _priority=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            else
                _priority=nil;
            break;
        case 3:
            if (indexPath.row>0)
                _ticketStatus=[NSString stringWithFormat:@"%ld",(long)indexPath.row-1];
            else
                _ticketStatus=nil;
            break;
    }
    _pageindex=0;
    _sortid=@"0";
    [self downforYjgdList:_projectId systemFault:_systemId priority:_priority ticketStatus:_ticketStatus];
    NSLog(@"projectId:%@ systemId:%@ priority:%@ _ticketStatus:%@",_projectId,_systemId,_priority,_ticketStatus);
}
#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MRCell *cell = [tableView dequeueReusableCellWithIdentifier:myPaiDanIdentifier];
    if (!cell) {
        cell = [[MRCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myPaiDanIdentifier];
    }
    MRModel *dm=self.dataArray[indexPath.row];
    cell.model = dm;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MRModel *model = self.dataArray[indexPath.row];
    DetailVC *vc = [[DetailVC alloc] init];
    vc.orderId = model.Id;
    vc.v = model.v;
    vc.type = @"1";
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)loadListTable{
    // 下拉刷新
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageindex=0;
        _sortid=@"0";
        
        [self downforYjgdList:_projectId systemFault:_systemId priority:_priority ticketStatus:_ticketStatus];
        [weakSelf.tableView.mj_header endRefreshing];
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (self.dataArray.count>0) {
            _pageindex+=srvDataCount;
            [self downforYjgdList:_projectId systemFault:_systemId priority:_priority ticketStatus:_ticketStatus];
            
        }
        else
        {
            _pageindex=0;
            _sortid=@"0";
            [self downforYjgdList:_projectId systemFault:_systemId priority:_priority ticketStatus:_ticketStatus];
            
        }
        
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 211;
}

@end
