//
//  PaiDanDetailViewController.m
//  woproject
//
//  Created by tianan-apple on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "PaiDanDetailViewController.h"
#import "ticketInfo.h"
#import "ticketFlowInfo.h"
#import "baoxiuInfoView.h"
#import "paidanInfoView.h"
#import "jiedanInfoView.h"
#import "daochangInfoView.h"
#import "hangupInfoView.h"
#import "backOrderViewInfo.h"
#import "PaidanViewController.h"
#import "ShowImgViewController.h"
#import "ComboxView.h"

#define kDropDownListTag1 1000
@interface PaiDanDetailViewController ()<StdComBoxDelegate,stdImgDelegate,stdPaidanImgDelegate,stdHangUpImgDelegate,stdBackOrderImgDelegate>

@end

@implementation PaiDanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self downforYjgdInfo];
    // Do any additional setup after loading the view.
}
-(id)init:(NSString *)listId{
    if (self==[super init]) {
        _ListId=listId;
    }
    return self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setListId:(NSString *)ListId{
    _ListId=ListId;
}

-(void)setMyViewTitle:(NSString *)myViewTitle{
    _myViewTitle=myViewTitle;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadTopNav];
    //    [self downforYjgdInfo];
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    topLbl.text=_myViewTitle;
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


-(void)downforYjgdInfo{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSMutableDictionary * paramDict=[[NSMutableDictionary alloc]init];
    
    [paramDict setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"uid"];
    [paramDict setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
    [paramDict setObject:_ListId forKey:@"tid"];
    [paramDict setObject:ApplicationDelegate.myLoginInfo.v forKey:@"v"];
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forTicketInfo"];
    
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
                                          NSLog(@"已接工单详情返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              [SVProgressHUD dismiss];
                                              ticketInfo *tickInfo=[[ticketInfo alloc]init];
                                              _myTicketInfo=[tickInfo asignInfoWithDict:jsonDic];
                                              [self drawDetailView:_myTicketInfo];
                                              
                                              
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
-(void)drawCombox:(UIScrollView*)Svc{
    CGFloat offsetX=15;
    CGFloat offsetY=15;
    CGFloat BoxHeigh=40;
    CGFloat BoxWidth=fDeviceWidth-offsetX*2;
    _priorityBox = [[ComboxView alloc] initWithFrame:CGRectMake(offsetX, offsetY, BoxWidth, BoxHeigh) titleStr:@"优先级：" tagFlag:0];
    _priorityBox.stdTableDelegate=self;
    [Svc addSubview:_priorityBox];
   
    _jobNameBox = [[ComboxView alloc] initWithFrame:CGRectMake(offsetX, offsetY+15+BoxHeigh, BoxWidth, BoxHeigh) titleStr:@"工种：" tagFlag:1];
    _jobNameBox.stdTableDelegate=self;
    [Svc addSubview:_jobNameBox];
    
    
    _operationUserBox = [[ComboxView alloc] initWithFrame:CGRectMake(offsetX, offsetY+(15+BoxHeigh)*2, BoxWidth, BoxHeigh) titleStr:@"接单人：" tagFlag:2];
    _operationUserBox.stdTableDelegate=self;
    [Svc addSubview:_operationUserBox];

}
-(void)stdComBoxClickDelegate:(NSString *)sendId tag:(NSInteger)tagFlag
{
    switch (tagFlag) {
        case 0://优先级
            
            break;
        case 1://工种
            _operationUserBox.job_id=sendId;
            [_operationUserBox resetCombox];//接单人联动清空
            break;
        case 2://接单人
            
            break;

        default:
            break;
    }

}
-(void)drawDetailView:(ticketInfo*)myInfo{
    CGFloat ScrollHeigh=fDeviceHeight;
    UIScrollView *scollVc=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    
    [self drawCombox:scollVc];
    /*---------工单状态----------------*/
    CGFloat topTitleVcHigh=30;
    CGFloat topTitleY=200;
    UIView *topTitleVc=[[UIView alloc]initWithFrame:CGRectMake(0, topTitleY, fDeviceWidth, topTitleVcHigh)];
    topTitleVc.backgroundColor=bluebackcolor;
    UILabel *myOrderState=[[UILabel alloc]initWithFrame:CGRectMake(5, 2, 100, 20)];
    myOrderState.text=@"工单状态";
    [myOrderState setFont:[UIFont systemFontOfSize:15]];
    myOrderState.textColor=deepbluetxtcolor;
    [topTitleVc addSubview:myOrderState];
    [scollVc addSubview:topTitleVc];
    
    CGFloat orderTitleVcHigh=50;
    UIView *orderTitleVc=[[UIView alloc]initWithFrame:CGRectMake(0, topTitleY+30, fDeviceWidth, orderTitleVcHigh)];
    UILabel *currStateLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 80, 20)];
    currStateLab.text=@"当前状态：";
    [currStateLab setFont:[UIFont systemFontOfSize:14]];
    currStateLab.textColor=graytxtcolor;
    [orderTitleVc addSubview:currStateLab];
    
    
    UILabel *currStateTxtLab=[[UILabel alloc]initWithFrame:CGRectMake(90, 10, 70, 20)];
    currStateTxtLab.text=myInfo.status;
    currStateTxtLab.textColor=highbluetxtcolor;
    [currStateTxtLab setFont:[UIFont systemFontOfSize:18]];
    [orderTitleVc addSubview:currStateTxtLab];
    
    
    
    
    UILabel *orderNumLab=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth*2/3, 10, 80, 20)];
    orderNumLab.text=@"工单编号：";
    orderNumLab.textColor=graytxtcolor;
    [orderNumLab setFont:[UIFont systemFontOfSize:14]];
    [orderTitleVc addSubview:orderNumLab];
    
    
    UILabel *orderNumTxtLab=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth*2/3+70, 10, 70, 20)];
    orderNumTxtLab.text=myInfo.Id;
    orderNumTxtLab.textColor=graytxtcolor;
    [orderNumTxtLab setFont:[UIFont systemFontOfSize:14]];
    [orderTitleVc addSubview:orderNumTxtLab];
    
    [scollVc addSubview:orderTitleVc];
    
    /*---------工单状态----------------*/
    
    CGFloat firstY=orderTitleVcHigh+topTitleVcHigh+topTitleY;
    /*---------报修信息----------------*/

    baoxiuInfoView * BXVc=[[baoxiuInfoView alloc]initWithFrame:CGRectMake(0, firstY, fDeviceWidth, BXVcHigh)];
    [BXVc asignDataToLab:myInfo];
    BXVc.stdImgDelegate =self;
    [scollVc addSubview:BXVc];
    
    
    /*-------工单流转信息--*/
    CGFloat hh=[self drawOrderInfoList:myInfo parentVc:scollVc];
    /*-------工单流转信息--*/
    
    
    ScrollHeigh=topTitleVcHigh+topTitleVcHigh+BXVcHigh+hh+topTitleY;
    [scollVc setContentSize:CGSizeMake(fDeviceWidth, ScrollHeigh)];
    [self.view addSubview:scollVc];
    
    
    /*----------接单----------*/
    UIButton * operateBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, fDeviceHeight-40, fDeviceWidth, 40)];
    
    [operateBtn addTarget:self action:@selector(clickoperatebtn) forControlEvents:UIControlEventTouchUpInside];
    
    [operateBtn setTitle:@"派单"forState:UIControlStateNormal];// 添加文字
    operateBtn.backgroundColor=bluetxtcolor;
    [self.view addSubview:operateBtn];
    
    
    /*----------接单----------*/
}

//0.派单；1.接单；2.到场；3.完成；4.核查；5.退单；6.挂起；7.协助
-(CGFloat)drawOrderInfoList:(ticketInfo *)tinfo parentVc:(UIScrollView *)PVc{
    NSArray *flowArr=tinfo.ticketFlowList;
    NSString *operations;
    CGFloat pvcHeigh=0;
    CGFloat firstY=30+50+200;


    
    @try {
        if (flowArr) {
            for (ticketFlowInfo *dict in flowArr) {
                operations=dict.operation;
                if ([operations isEqualToString:@"0"]) {//派单
                    paidanInfoView * PDvc=[[paidanInfoView alloc]initWithFrame:CGRectMake(0, firstY+BXVcHigh+pvcHeigh, fDeviceWidth, PDvcHigh)];
                    [PDvc asignDataToLab:dict priority:tinfo.priority];
                    [PVc addSubview:PDvc];
                    PDvc.stdPaidanImgDelegate=self;
                    pvcHeigh+=PDvcHigh;
                }
                else if ([operations isEqualToString:@"1"]) {//接单
                    jiedanInfoView * JDvc=[[jiedanInfoView alloc]initWithFrame:CGRectMake(0, firstY+BXVcHigh+pvcHeigh, fDeviceWidth, JDvcHigh)];
                    [JDvc asignDataToLab:dict];
                    [PVc addSubview:JDvc];
                    pvcHeigh+=JDvcHigh;
                }
                else if ([operations isEqualToString:@"2"]) {//到场
                    
                    daochangInfoView * DCvc=[[daochangInfoView alloc]initWithFrame:CGRectMake(0, firstY+BXVcHigh+pvcHeigh, fDeviceWidth, DCvcHigh)];
                    //_daochangTime=[DCvc asignDataToLab:dict];
                    [PVc addSubview:DCvc];
                    pvcHeigh+=DCvcHigh;
                }
                else if ([operations isEqualToString:@"5"]) {//退单
                    backOrderViewInfo * DCvc=[[backOrderViewInfo alloc]initWithFrame:CGRectMake(0, firstY+BXVcHigh+pvcHeigh, fDeviceWidth, PDvcHigh)];
                    [DCvc asignDataToLab:dict];
                    [PVc addSubview:DCvc];
                    DCvc.stdBackOrderImgDelegate=self;
                    pvcHeigh+=PDvcHigh;
                }
                else if ([operations isEqualToString:@"6"]) {//挂起
                    hangupInfoView * DCvc=[[hangupInfoView alloc]initWithFrame:CGRectMake(0, firstY+BXVcHigh+pvcHeigh, fDeviceWidth, PDvcHigh)];
                    [DCvc asignDataToLab:dict];
                     DCvc.stdHangUpImgDelegate=self;
                    [PVc addSubview:DCvc];
                    pvcHeigh+=PDvcHigh;
                }
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"结构不对爆炸了");
    } @finally {
        return pvcHeigh;
    }
    
    
}
-(void)clickoperatebtn{
    [self upInfoRepair:@"0"];
}

//0.派单；1.接单；2.到场；3.完成；4.核查；5.退单；6.挂起；7.协助
-(void)upInfoRepair:(NSString*)operationType{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSMutableDictionary * paramDict=[[NSMutableDictionary alloc]init];
    
    [paramDict setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"uid"];
    [paramDict setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
    [paramDict setObject:_ListId forKey:@"tid"];
    [paramDict setObject:operationType forKey:@"operation"];
    
    if (![_jobNameBox.data_id isEqualToString:@"-1"])
        [paramDict setObject:_priorityBox.data_id forKey:@"priority"];
    
    if (![_jobNameBox.data_id isEqualToString:@"-1"])
        [paramDict setObject:_jobNameBox.data_id forKey:@"job_id"];
    
    if (![_jobNameBox.data_id isEqualToString:@"-1"])
        [paramDict setObject:_operationUserBox.data_id forKey:@"user_id"];
    
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forTicketFlow"];
    
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
                                          NSLog(@"派单返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              [SVProgressHUD dismiss];
                                              [stdPubFunc stdShowMessage:@"派单成功"];
                                              [self pushPaidanView];
                                              
                                              
                                              
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

-(void)pushPaidanView{
    PaidanViewController *pdVc=[[PaidanViewController alloc]init];
    pdVc.view.backgroundColor=[UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pdVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)stdImageClickDelegate:(NSString *)imgUrl{
    ShowImgViewController * SIVC=[[ShowImgViewController alloc]init:imgUrl];
    SIVC.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:SIVC animated:YES];
    
}

-(void)stdPaidanClickDelegate:(NSString *)imgUrl{
    ShowImgViewController * SIVC=[[ShowImgViewController alloc]init:imgUrl];
    SIVC.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:SIVC animated:YES];
}
-(void)stdHangUpClickDelegate:(NSString *)imgUrl{
    ShowImgViewController * SIVC=[[ShowImgViewController alloc]init:imgUrl];
    SIVC.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:SIVC animated:YES];
}

-(void)stdBackOrderImgDelegate:(NSString *)imgUrl{
    ShowImgViewController * SIVC=[[ShowImgViewController alloc]init:imgUrl];
    SIVC.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:SIVC animated:YES];
}
@end
