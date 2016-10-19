//
//  tickoperateViewController.m
//  woproject
//
//  Created by tianan-apple on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "tickoperateViewController.h"

@interface tickoperateViewController ()<UITextViewDelegate>

@end

@implementation tickoperateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self drawMainView];
    
    
    
    // Do any additional setup after loading the view.
}
-(id)init:(NSString *)isConf confTime:(NSString*)timeStr{
    if (self==[super init]) {
        _IsConfom=isConf;
        _confTime=timeStr;
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    UIBarButtonItem *done =    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(leaveEditMode)] ;
    self.navigationItem.rightBarButtonItem = done;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)leaveEditMode {
    [self.descTxt resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setOrderId:(NSString *)OrderId{
    _OrderId=OrderId;
}
-(void)setIsConfom:(NSString *)IsConfom{
    _IsConfom=IsConfom;
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    topLbl.text=@"处置";
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


-(void)stdSetBtn:(UIButton *)btn btnTxt:(NSString*)hinttxt{
    [btn addTarget:self action:@selector(clickbtnFunc:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:hinttxt forState:UIControlStateNormal];// 添加文字
    btn.backgroundColor=bluetxtcolor;
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    //[self.view addSubview:btn];
}

-(void)stdSamleSetBtn:(UIButton *)btn btnTxt:(NSString*)hinttxt{
    [btn addTarget:self action:@selector(clickbtnFunc:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:hinttxt forState:UIControlStateNormal];// 添加文字
   
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
   
    if ([_IsConfom isEqualToString:@"0"]) {
        btn.enabled=NO;
        btn.backgroundColor=[UIColor whiteColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else
    {
        btn.enabled=YES;
        btn.backgroundColor=bluetxtcolor;
         [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    //[self.view addSubview:btn];
}

-(void)stdSetAddImgBtn:(UIButton *)btn{
    [btn addTarget:self action:@selector(clickbtnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setImage:[UIImage imageNamed:@"baoxiujiahao"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if ([_IsConfom isEqualToString:@"0"]) {
        btn.enabled=NO;
    }
    else{
        btn.enabled=YES;
    }

    //[self.view addSubview:btn];
}
-(void)drawMainView{
    
    CGFloat controllX=15;
    CGFloat firstLineY=15;
    CGFloat btnWidth=(fDeviceWidth-controllX*3)/2;
    CGFloat btnHeigh=40;
    CGFloat littleBtnWidth=(fDeviceWidth-controllX*4)/3;
    
    CGFloat ScrollHeigh=fDeviceHeight;
    UIScrollView *scollVc=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    
    if (!_scanBtn) {
        _scanBtn=[[UIButton alloc]initWithFrame:CGRectMake(controllX, firstLineY, btnWidth, btnHeigh)];
        _scanBtn.tag=100;
        [self stdSetBtn:_scanBtn btnTxt:@"扫描二维码"];
        [scollVc addSubview:_scanBtn];
        
    }
    if (!_confomBtn) {
        _confomBtn=[[UIButton alloc]initWithFrame:CGRectMake(controllX*2+btnWidth, firstLineY, btnWidth, btnHeigh)];
        _confomBtn.tag=101;
        [self stdSetBtn:_confomBtn btnTxt:@"点击确认到场"] ;
        if ([_IsConfom isEqualToString:@"1"]) {
            _confomBtn.enabled=NO;
            _confomBtn.backgroundColor=[UIColor whiteColor];
            [_confomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _confTimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(controllX, _scanBtn.frame.origin.y+_scanBtn.frame.size.height+5, fDeviceWidth-40, 30)];
            _confTimeLbl.text=[NSString stringWithFormat:@"%@%@",@"到场时间：",_confTime];
            [_confTimeLbl setFont:[UIFont systemFontOfSize:14]];
            [_confTimeLbl setTextColor:bluetxtcolor];
            [scollVc addSubview:_confTimeLbl];
            
        }
        else{
            _confomBtn.enabled=YES;
            _confomBtn.backgroundColor=bluetxtcolor;
            [_confomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        [scollVc addSubview:_confomBtn];
    }
    if (!_hangupBtn) {
        _hangupBtn=[[UIButton alloc]initWithFrame:CGRectMake(controllX, firstLineY+btnHeigh*2, littleBtnWidth, btnHeigh)];
        _hangupBtn.tag=102;
        [self stdSamleSetBtn:_hangupBtn btnTxt:@"挂起"];
        [scollVc addSubview:_hangupBtn];
    }
    if (!_backOrderBtn) {
        _backOrderBtn=[[UIButton alloc]initWithFrame:CGRectMake(controllX*2+littleBtnWidth, firstLineY+btnHeigh*2, littleBtnWidth, btnHeigh)];
        _backOrderBtn.tag=103;
        [self stdSamleSetBtn:_backOrderBtn btnTxt:@"退单"];
        [scollVc addSubview:_backOrderBtn];
    }
    if (!_assistBtn) {
        _assistBtn=[[UIButton alloc]initWithFrame:CGRectMake(controllX*3+littleBtnWidth*2, firstLineY+btnHeigh*2, littleBtnWidth, btnHeigh)];
        _assistBtn.tag=104;
         [self stdSamleSetBtn:_assistBtn btnTxt:@"协助"];
        [scollVc addSubview:_assistBtn];
    }
    if (!_turnBtn) {
        _turnBtn=[[UIButton alloc]initWithFrame:CGRectMake(controllX, firstLineY+btnHeigh*4, littleBtnWidth, btnHeigh)];
        _turnBtn.tag=105;
        [self stdSamleSetBtn:_turnBtn btnTxt:@"转单"];
        [scollVc addSubview:_turnBtn];
    }

    
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"维修结果*:"];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor blackColor]
                range:NSMakeRange(0,4)];
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor redColor]
                range:NSMakeRange(4,1)];

    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor blackColor]
                range:NSMakeRange(5,1)];
    
    UILabel *descLbl=[[UILabel alloc]initWithFrame:CGRectMake(controllX, firstLineY+btnHeigh*4+btnHeigh+20, 100, 30)];
    descLbl.attributedText=str;
    [scollVc addSubview:descLbl];
    //[self.view addSubview:descLbl];
    
    if (!_descTxt) {
        _descTxt=[[UITextView alloc]initWithFrame:CGRectMake(controllX,firstLineY+btnHeigh*4+btnHeigh+20+32, fDeviceWidth-controllX*2,120)];
        [self.view addSubview:_descTxt];
        if ([_IsConfom isEqualToString:@"0"]) {
            _descTxt.editable=NO;
        }
        else
            _descTxt.editable=YES;
        _descTxt.delegate=self;
        [scollVc addSubview:_descTxt];
        
    }
    
    if (!_addImg1) {
        _addImg1=[[UIButton alloc]initWithFrame:CGRectMake(controllX, _descTxt.frame.origin.y+_descTxt.frame.size.height+15, 40, 40)];
        _addImg1.tag=200;
        [self stdSetAddImgBtn:_addImg1];
        [scollVc addSubview:_addImg1];
    }
    
    if (!_addImg2) {
        _addImg2=[[UIButton alloc]initWithFrame:CGRectMake(controllX+45, _descTxt.frame.origin.y+_descTxt.frame.size.height+15, 40, 40)];
        _addImg2.tag=201;
        
        [self stdSetAddImgBtn:_addImg2];
        [scollVc addSubview:_addImg2];
    }

    
    if (!_addImg3) {
        _addImg3=[[UIButton alloc]initWithFrame:CGRectMake(controllX+45*2, _descTxt.frame.origin.y+_descTxt.frame.size.height+15, 40, 40)];
        _addImg3.tag=202;
        [self stdSetAddImgBtn:_addImg3];
        [scollVc addSubview:_addImg3];
    }

    if (!_doneBtn) {
        _doneBtn=[[UIButton alloc]initWithFrame:CGRectMake(controllX, _addImg3.frame.origin.y+_addImg3.frame.size.height+15, fDeviceWidth-controllX*2, 40)];
        _doneBtn.tag=300;
        [_doneBtn setTitle:@"维修完成" forState:UIControlStateNormal];// 添加文字
        [_doneBtn addTarget:self action:@selector(clickbtnFunc:) forControlEvents:UIControlEventTouchUpInside];
        
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        
        if ([_IsConfom isEqualToString:@"0"]) {
            _doneBtn.enabled=NO;
            _doneBtn.backgroundColor=[UIColor whiteColor];
            [_doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        else{
            _doneBtn.enabled=YES;
            _doneBtn.backgroundColor=bluetxtcolor;
            [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [scollVc addSubview:_doneBtn];
        
    }
    ScrollHeigh=_doneBtn.frame.origin.y+_doneBtn.frame.size.height+15;
    [scollVc setContentSize:CGSizeMake(fDeviceWidth, ScrollHeigh)];
    scollVc.backgroundColor=bluebackcolor;
    [self.view addSubview:scollVc];
}
-(void)clickbtnFunc:(UIButton*)btn{
    NSLog(@"btn:%ld",(long)btn.tag);
    switch (btn.tag) {
        case 100://扫描二维码
            
            break;
        case 101://点击确认到场
            [self upInfoRepair:@"2"];
            break;
        case 102://挂起
            
            break;
        case 103://退单
            
            break;
        case 104://协助
            
            break;
        case 105://转单
            
            break;
            
        case 200://添加照片1
            
            break;
            
        case 201://添加照片2
            
            break;
            
        case 202://添加照片3
            
            break;
        case 300://维修完成
            
            break;
            
        default:
            break;
    }
    
}
-(void)confomSuccessBack{
    _hangupBtn.backgroundColor=bluetxtcolor;
    _hangupBtn.enabled=YES;
    _backOrderBtn.backgroundColor=bluetxtcolor;
    _backOrderBtn.enabled=YES;
    _assistBtn.backgroundColor=bluetxtcolor;
    _assistBtn.enabled=YES;
    _turnBtn.backgroundColor=bluetxtcolor;
    _turnBtn.enabled=YES;
    _doneBtn.backgroundColor=bluetxtcolor;
    _doneBtn.enabled=YES;
    _descTxt.editable=YES;
    
    
}
//0.派单；1.接单；2.到场；3.完成；4.核查；5.退单；6.挂起；7.协助
-(void)upInfoRepair:(NSString*)operationType{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSMutableDictionary * paramDict=[[NSMutableDictionary alloc]init];
    
    [paramDict setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"uid"];
    [paramDict setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
    [paramDict setObject:_OrderId forKey:@"tid"];
    [paramDict setObject:operationType forKey:@"operation"];
    [paramDict setObject:_descTxt.text forKey:@"result"];

    
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
                                          NSLog(@"上报维修返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              [SVProgressHUD dismiss];
                                              
                                              
                                              
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


@end