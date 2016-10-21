//
//  DropDown.m
//  UICombox
//
//  Created by Ralbatr on 14-3-17.
//  Copyright (c) 2014年 Ralbatr. All rights reserved.
//

#import "ComboxView.h"

@implementation ComboxView

-(id)initWithFrame:(CGRect)frame titleStr:(NSString*)tstr tagFlag:(NSInteger)tagI
{
    if (frame.size.height<200) {
        frameHeight = 200;
    }else{
        frameHeight = frame.size.height;
    }
    tabheight = frameHeight-30;
    
    frame.size.height = 30.0f;
    _tagFlag=tagI;
    _job_id=@"-1";
    _data_id=@"-1";
    self = [super initWithFrame:frame];
    
    if(self){
        showList = NO; //默认不显示下拉框
        
        [self creatTableView:frame];
        UIView *comboxBackGroudVc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
        comboxBackGroudVc.backgroundColor=MyGrayColor;
        UIView *comboxVc=[[UIView alloc]initWithFrame:CGRectMake(1, 1, frame.size.width-2, 40-2)];
        comboxVc.backgroundColor=[UIColor whiteColor];
        [comboxBackGroudVc addSubview:comboxVc];
        
        UILabel *comboxTitle=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 50, 20)];
        comboxTitle.text=tstr;
        [comboxTitle setFont:[UIFont systemFontOfSize:12]];
        [comboxTitle setTextColor:[UIColor blackColor]];
        [comboxVc addSubview:comboxTitle];
        
        
        if (!_textLbl) {
            _textLbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 5, frame.size.width-70, 30)];
            [_textLbl setFont:[UIFont systemFontOfSize:12]];
            _textLbl.text=@"---------";
            [comboxVc addSubview:_textLbl];
        }
        UIImageView * arrowDown=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-40, 12, 20, 12)];
        arrowDown.image=[UIImage imageNamed:@"downArrow"];
        [comboxVc addSubview:arrowDown];
        
        if (!_viewBtn) {
            _viewBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
             [_viewBtn addTarget:self action:@selector(viewBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [comboxBackGroudVc addSubview:_viewBtn];
        }
        
        [self addSubview:comboxBackGroudVc];
        
    }
    return self;
}

-(void)resetCombox{
    _textLbl.text=@"---------";
    _data_id=@"-1";
}
-(void)viewBtnClick{
    switch (_tagFlag) {
        case 0://优先级
            _tableArray = [[NSMutableArray alloc]initWithObjects:@"高",@"中",@"低",nil];
            _tableIdArray= [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",nil];
            [self dropdown];
            break;
        case 1://工种
            [self downforWorkType];
            break;
        case 2:
            if ([_job_id isEqualToString:@"-1"]) {
                [stdPubFunc stdShowMessage:@"请选择上一级列表"];
            }
            else
                [self downforUserList:_job_id];
            break;
        default:
            break;
    }

}

- (void)creatTableView:(CGRect)frame
{
    _dropTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 0)];
    _dropTableView.delegate = self;
    _dropTableView.dataSource = self;
    _dropTableView.hidden = YES;
}


- (void)closeTableView
{
    if (showList) {
        self.hidden = YES;
        NSLog(@"在选择状态");
    }
}

-(void)dropdown{

    if (showList)
    {//如果下拉框已显示，移除
        [self stdRemoveView];
    }
    else
    {//如果下拉框尚未显示，则进行显示
        [_dropTableView reloadData];
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        [self addSubview:_dropTableView];        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        _dropTableView.hidden = NO;
        showList = YES;//显示下拉框
        
        CGRect frame = _dropTableView.frame;
        frame.size.height = 0;
        _dropTableView.frame = frame;
        frame.size.height = tabheight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        _dropTableView.frame = frame;
        [UIView commitAnimations];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        _textLbl.text = [_tableArray objectAtIndex:[indexPath row]];
        [self stdRemoveView];
        _data_id=[_tableIdArray objectAtIndex:[indexPath row]] ;
        [self.stdTableDelegate  stdComBoxClickDelegate:_data_id tag:_tagFlag];
    } @catch (NSException *exception) {
        NSLog(@"comboxDidSelectRowAtIndexPath err");
    } @finally {
        ;
    }
   

}

-(void)stdRemoveView{
    showList = NO;
    _dropTableView.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = _dropTableView.frame;
    frame.size.height = 0;
    _dropTableView.frame = frame;
    //选择完后，移除
    [_dropTableView removeFromSuperview];

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(NSMutableArray *)stdProjectList:(NSArray*)inArr{//自己重组一下数组，原数组有null，保存失败
    NSMutableArray *rtnArr=[[NSMutableArray alloc]init];
    for (NSDictionary * dict in inArr) {
        NSMutableDictionary * dictTmp=[[NSMutableDictionary alloc]init];
        
        [dictTmp setObject:[dict objectForKey:@"id"] forKey:@"id"];
        [dictTmp setObject:[dict objectForKey:@"name"]forKey:@"name"];
        [rtnArr addObject:dictTmp];
    }
    return rtnArr;
}
-(void)downforWorkType{//下载工种列表
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSDictionary *paramDict = @{
                                @"uid":ApplicationDelegate.myLoginInfo.Id,
                                @"ukey":ApplicationDelegate.myLoginInfo.ukey
                                };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forWorkType"];
    
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
                                          NSLog(@"下载工种返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                              NSArray *sysData=[idict objectForKey:@"Data"];
                                              
                                              [self loadDataToLocalArr:sysData];
                                              [self dropdown];
                                              
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


-(void)downforUserList:(NSString*)jobId{//下载工种对应的人员信息
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSDictionary *paramDict = @{
                                @"uid":ApplicationDelegate.myLoginInfo.Id,
                                @"ukey":ApplicationDelegate.myLoginInfo.ukey,
                                @"job_id":jobId
                                };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/sys/forUserList"];
    
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
                                          NSLog(@"下载人员信息返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                              NSArray *sysData=[idict objectForKey:@"Data"];
                                              [self loadDataToLocalArr:sysData];
                                              [self dropdown];
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

-(void)loadDataToLocalArr:(NSArray*)idata{
    NSMutableArray *idArr=[[NSMutableArray alloc]init];
    NSMutableArray *nameArr=[[NSMutableArray alloc]init];
    @try {
        for (NSDictionary * dictTmp in idata) {
            [idArr addObject:[dictTmp objectForKey:@"id"]] ;
            [nameArr addObject:[dictTmp objectForKey:@"name"]] ;
        }
    } @catch (NSException *exception) {
        NSLog(@"loadDataToLocalArr err");
    } @finally {
        _tableArray=nameArr;
        _tableIdArray=idArr;
    }


}
@end
