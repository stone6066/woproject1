//
//  PaidanViewController.m
//  woproject
//
//  Created by tianan-apple on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "PaidanViewController.h"
#import "DOPDropDownMenu.h"
#import "DownLoadBaseData.h"
#import "ticketList.h"
#import "ticketListTableViewCell.h"
#import "PaiDanDetailViewController.h"

@interface PaidanViewController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>
@property (nonatomic, strong) NSMutableArray *classifys;
@property (nonatomic, strong) NSMutableArray *cates;
@property (nonatomic, strong) NSMutableArray *ticketStatusArr;
@property (nonatomic, strong) NSMutableArray *areas;

@property (nonatomic, strong) NSMutableArray *sorts;
@property (nonatomic, weak) DOPDropDownMenu *menu;


@end

@implementation PaidanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self stdVarsInit];
    [self loadListTable];
    //[self downforYjgdList:_priority systemFault:_systemId priority:_priority];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    topLbl.text=@"派单";
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
        default:
            break;
            
    }
    _pageindex=0;
    _sortid=@"0";
    //[_tabledata removeAllObjects];
    [self downforYjgdList:_projectId systemFault:_systemId priority:_priority ticketStatus:_ticketStatus];
    NSLog(@"projectId:%@ systemId:%@ priority:%@ _ticketStatus:%@",_projectId,_systemId,_priority,_ticketStatus);
}


-(void)downforYjgdList:(NSString*)pid systemFault:(NSString*)sid priority:(NSString*)priorityId ticketStatus:(NSString*)tid{
    [SVProgressHUD showWithStatus:k_Status_Load];
    

    NSMutableDictionary * paramDict=[[NSMutableDictionary alloc]init];
    
    [paramDict setObject:@"" forKey:@"uid"];
    [paramDict setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
    [paramDict setObject:@"0" forKey:@"status"];
    //[paramDict setObject:[NSString stringWithFormat:@"%ld",(long)_pageindex] forKey:@"sort_id"];
    [paramDict setObject:[NSString stringWithFormat:@"%@",_sortid] forKey:@"sort_id"];
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
                                              ticketList *Tlist=[[ticketList alloc]init];
                                              NSMutableArray *datatmp=[Tlist asignInfoWithDict:jsonDic];
                                              if (datatmp.count>0) {
                                                  Tlist=datatmp[datatmp.count-1];
                                                  _sortid=Tlist.Id;
                                              }
                                              
                                              if (_pageindex==0) {
                                                  [_tabledata removeAllObjects];
                                                  _tabledata=datatmp;
                                                  
                                              }
                                              else
                                              {
                                                  [_tabledata addObjectsFromArray:datatmp];
                                              }
                                                  
                                              [_TableView reloadData];
                                              
                                              
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




static NSString * const TicketCellId = @"TicketCellId";
-(void)loadListTable{
    
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 65+50, fDeviceWidth, fDeviceHeight-50-65-MainTabbarHeight)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.backgroundColor=collectionBgdColor;
    
    [self.TableView registerNib:[UINib nibWithNibName:NSStringFromClass([ticketListTableViewCell class]) bundle:nil] forCellReuseIdentifier:TicketCellId];
    self.TableView.backgroundColor=bluebackcolor;
    [self.view addSubview:self.TableView];
    
    // 下拉刷新
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageindex=0;
        _sortid=@"0";
        
         [self downforYjgdList:_projectId systemFault:_systemId priority:_priority ticketStatus:_ticketStatus];
        [weakSelf.TableView.mj_header endRefreshing];
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 上拉刷新
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (_tabledata.count>0) {
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
        [weakSelf.TableView.mj_footer endRefreshing];
    }];
}


#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tabledata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ticketListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellId forIndexPath:indexPath];
    //
    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    ticketList *dm=_tabledata[indexPath.item];
    [cell showCellView:dm];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 241;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ticketListTableViewCell *svc =(ticketListTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",svc.Id);
    
    PaiDanDetailViewController *gggdDetailVc=[[PaiDanDetailViewController alloc]init:svc.Id];
    [gggdDetailVc setMyViewTitle:@"派单详情"];
    
    gggdDetailVc.view.backgroundColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gggdDetailVc animated:NO];
    
}


@end
