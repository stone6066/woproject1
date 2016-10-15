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
@interface ticketInfoViewController ()

@end

@implementation ticketInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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
    [self downforYjgdInfo];
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
    CGFloat BXVcHigh=360;
    baoxiuInfoView * BXVc=[[baoxiuInfoView alloc]initWithFrame:CGRectMake(0, firstY, fDeviceWidth, BXVcHigh)];
    [BXVc asignDataToLab:myInfo];
    [scollVc addSubview:BXVc];
     /*---------报修信息----------------*/
    
    
    /*----------派单信息----------------*/
    CGFloat PDvcHigh=0;
    if (1==[self haveInfoForType:@"0" infoData:myInfo]) {
        PDvcHigh=230;
        paidanInfoView * PDvc=[[paidanInfoView alloc]initWithFrame:CGRectMake(0, firstY+BXVcHigh, fDeviceWidth, PDvcHigh)];
        [PDvc asignDataToLab:myInfo];
        [scollVc addSubview:PDvc];
    };
    
    /*----------派单信息----------------*/
    
    /*----------接单信息----------------*/
    CGFloat JDvcHigh=0;
    if (1==[self haveInfoForType:@"1" infoData:myInfo]){
        JDvcHigh=170;
    jiedanInfoView * JDvc=[[jiedanInfoView alloc]initWithFrame:CGRectMake(0, firstY+BXVcHigh+JDvcHigh, fDeviceWidth, JDvcHigh)];
    [JDvc asignDataToLab:myInfo];
    [scollVc addSubview:JDvc];
    }
    /*----------接单信息----------------*/
    
    
    /*----------到场信息----------------*/
    CGFloat DCvcHigh=0;
    if (1==[self haveInfoForType:@"2" infoData:myInfo]){
    DCvcHigh=150;
    daochangInfoView * DCvc=[[daochangInfoView alloc]initWithFrame:CGRectMake(0, firstY+BXVcHigh+JDvcHigh+DCvcHigh, fDeviceWidth, DCvcHigh)];
    [DCvc asignDataToLab:myInfo];
    [scollVc addSubview:DCvc];
    }
    /*----------到场信息----------------*/
    
    ScrollHeigh=topTitleVcHigh+topTitleVcHigh+BXVcHigh+PDvcHigh+JDvcHigh+DCvcHigh;
    [scollVc setContentSize:CGSizeMake(fDeviceWidth, ScrollHeigh)];
    [self.view addSubview:scollVc];
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
@end
