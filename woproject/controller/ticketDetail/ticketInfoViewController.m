//
//  ticketInfoViewController.m
//  woproject
//
//  Created by tianan-apple on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ticketInfoViewController.h"
#import "ticketInfo.h"
#import "ticketFlowInfo.h"
#import "baoxiuInfoView.h"
#import "paidanInfoView.h"
#import "jiedanInfoView.h"
#import "daochangInfoView.h"
#import "hangupInfoView.h"
#import "tickoperateViewController.h"
#import "backOrderViewInfo.h"
#import "ShowImgViewController.h"
@interface ticketInfoViewController ()<stdImgDelegate,stdPaidanImgDelegate,stdHangUpImgDelegate,stdBackOrderImgDelegate>

@end

@implementation ticketInfoViewController

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

-(void)drawDetailView:(ticketInfo*)myInfo{
     CGFloat ScrollHeigh=fDeviceHeight;
    UIScrollView *scollVc=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    
     /*---------工单状态----------------*/
    CGFloat topTitleVcHigh=30;
    UIView *topTitleVc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, topTitleVcHigh)];
    topTitleVc.backgroundColor=bluebackcolor;
    UILabel *myOrderState=[[UILabel alloc]initWithFrame:CGRectMake(5, 2, 100, 20)];
    myOrderState.text=@"工单状态";
    [myOrderState setFont:[UIFont systemFontOfSize:15]];
    myOrderState.textColor=deepbluetxtcolor;
    [topTitleVc addSubview:myOrderState];
    [scollVc addSubview:topTitleVc];
    
    CGFloat orderTitleVcHigh=50;
    UIView *orderTitleVc=[[UIView alloc]initWithFrame:CGRectMake(0, 30, fDeviceWidth, orderTitleVcHigh)];
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
    
    CGFloat firstY=orderTitleVcHigh+topTitleVcHigh;
    /*---------报修信息----------------*/

    baoxiuInfoView * BXVc=[[baoxiuInfoView alloc]initWithFrame:CGRectMake(0, firstY, fDeviceWidth, BXVcHigh)];
    [BXVc asignDataToLab:myInfo];
    [scollVc addSubview:BXVc];
     BXVc.stdImgDelegate =self;
    _daochang=@"0";
    
    /*-------工单流转信息--*/
    CGFloat hh=[self drawOrderInfoList:myInfo parentVc:scollVc];
    /*-------工单流转信息--*/
    
    
    ScrollHeigh=topTitleVcHigh+topTitleVcHigh+BXVcHigh+hh;
    [scollVc setContentSize:CGSizeMake(fDeviceWidth, ScrollHeigh)];
    [self.view addSubview:scollVc];
    
    
        /*----------处置----------*/
    UIButton * operateBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, fDeviceHeight-40, fDeviceWidth, 40)];
    
    [operateBtn addTarget:self action:@selector(clickoperatebtn) forControlEvents:UIControlEventTouchUpInside];
    
    [operateBtn setTitle:@"处置"forState:UIControlStateNormal];// 添加文字
    operateBtn.backgroundColor=bluetxtcolor;
    [self.view addSubview:operateBtn];

    
    /*----------处置----------*/
}

//0.派单；1.接单；2.到场；3.完成；4.核查；5.退单；6.挂起；7.协助
-(CGFloat)drawOrderInfoList:(ticketInfo *)tinfo parentVc:(UIScrollView *)PVc{
    NSArray *flowArr=tinfo.ticketFlowList;
    NSString *operations;
    CGFloat pvcHeigh=0;
    CGFloat firstY=30+50;


  
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
                    
                        _daochang=@"1";
                        daochangInfoView * DCvc=[[daochangInfoView alloc]initWithFrame:CGRectMake(0, firstY+BXVcHigh+pvcHeigh, fDeviceWidth, DCvcHigh)];
                        _daochangTime=[DCvc asignDataToLab:dict];
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
                    _daochang=@"0";
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
    tickoperateViewController *oprateVc=[[tickoperateViewController alloc]init:_daochang confTime:_daochangTime];
    oprateVc.view.backgroundColor=bluebackcolor;
    [oprateVc setOrderId:_ListId];
    [self.navigationController pushViewController:oprateVc animated:YES];

}

-(NSInteger)haveInfoForType:(NSString*)types  infoData:(ticketInfo *)modelData{
    NSArray *flowArr=modelData.ticketFlowList;
    NSString *operations;
    NSInteger rtnI=0;
    @try {
        if (flowArr) {
            for (ticketFlowInfo *dict in flowArr) {
                operations=dict.operation;
                if ([operations isEqualToString:types]) {
                    rtnI=1;
                }
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"结构不对爆炸了");
    } @finally {
        return rtnI;
    }


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
