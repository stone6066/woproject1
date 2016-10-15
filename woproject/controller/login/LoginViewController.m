//
//  LoginViewController.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "LoginViewController.h"
#import "loginInfo.h"
#import "stdPubFunc.h"
#import "ActionUserViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self std_regsNotification];
    [self loadLoginView];
    // Do any additional setup after loading the view.
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_UsrTxtF resignFirstResponder];
    [_PassTxtF resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder]; //键盘按下return，这句代码可以隐藏 键盘
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}


-(void)checkboxClick:(UIButton *)btn
{
    _checkbox.selected = !_checkbox.selected;
    ApplicationDelegate.isRmbPsw=_checkbox.selected ;
}

 -(void)UsrtextFieldDidChange:(UITextField *) TextField{
     if (TextField.text.length>0) {
//         if (!_cancelVc) {
//             _cancelVc=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-35, fDeviceHeight/2-40, 11, 12)];
//             _cancelVc.image=[UIImage imageNamed:@"cancle"];
//             [self.view addSubview:_cancelVc];
//             UIButton *usrClearBtn=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-35, fDeviceHeight/2-50, 40, 40)];
//             [self.view addSubview:usrClearBtn];
//             //usrClearBtn.backgroundColor=[UIColor blueColor];
//             usrClearBtn.tag=101;
//             [usrClearBtn addTarget:self action:@selector(clearbtnClick:) forControlEvents:UIControlEventTouchUpInside];
//         }
         _cancelVc.hidden=NO;
     }
     else
     {
         _cancelVc.hidden=YES;
     }
 }

-(void)PswtextFieldDidChange:(UITextField *) TextField{
    if (TextField.text.length>0) {
//        if (!_cancelVc1) {
//            _cancelVc1=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-35, fDeviceHeight/2+10, 11, 12)];
//            _cancelVc1.image=[UIImage imageNamed:@"cancle"];
//            [self.view addSubview:_cancelVc1];
//            
//            UIButton *usrClearBtn=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-35, fDeviceHeight/2, 40, 40)];
//            [self.view addSubview:usrClearBtn];
//            
//            usrClearBtn.tag=102;
//            [usrClearBtn addTarget:self action:@selector(clearbtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            
//        }
        _cancelVc1.hidden=NO;
    }
    else
    {
        _cancelVc1.hidden=YES;
    }
}

-(void)clearbtnClick:(UIButton*)btn{
    if (btn.tag==101) {
        _UsrTxtF.text=@"";
    }
    else
        _PassTxtF.text=@"";
}
-(void)loadLoginView{
    UIImageView *backImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight)];
    backImg.image=[UIImage imageNamed:@"login_bg"];
    [self.view addSubview:backImg];
    
    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake((fDeviceWidth-100)/2, fDeviceHeight/10, 100, 100)];
    logoImg.image=[UIImage imageNamed:@"login_icon"];
    [self.view addSubview:logoImg];
    
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, fDeviceHeight/10+110, fDeviceWidth, 30)];
    titleLbl.text=@"工单管理";
    [titleLbl setTextColor:[UIColor blackColor]];
    [titleLbl setFont:[UIFont systemFontOfSize:18]];
    [titleLbl setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:titleLbl];
    
    _UsrTxtF = [[UITextField alloc] initWithFrame:CGRectMake(70, fDeviceHeight/2-50, fDeviceWidth-100, 30)];
    [self stdInitTxtF:_UsrTxtF hintxt:@"请输入用户ID/手机号/身份证号"];
    
    [_UsrTxtF addTarget:self action:@selector(UsrtextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _PassTxtF = [[UITextField alloc] initWithFrame:CGRectMake(70, fDeviceHeight/2, fDeviceWidth-100, 30)];
    [self stdInitTxtF:_PassTxtF hintxt:@"请输入密码"];
    _PassTxtF.secureTextEntry = YES;
    [_PassTxtF addTarget:self action:@selector(PswtextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:_UsrTxtF];
    [self.view addSubview:_PassTxtF];
    

    UIImageView *usrImg=[[UIImageView alloc]initWithFrame:CGRectMake(40, fDeviceHeight/2-43, 15, 17)];
    usrImg.image=[UIImage imageNamed:@"hh_login01"];
    
    UIImageView *pswImg=[[UIImageView alloc]initWithFrame:CGRectMake(40, fDeviceHeight/2+7, 15, 17)];
    pswImg.image=[UIImage imageNamed:@"hh_login02"];

    [self.view addSubview:usrImg];
    [self.view addSubview:pswImg];
    
    UIView * geLine1=[[UIView alloc]initWithFrame:CGRectMake(10, fDeviceHeight/2-50+31, fDeviceWidth-20, 0.5)];
    UIView * geLine2=[[UIView alloc]initWithFrame:CGRectMake(10, fDeviceHeight/2+31, fDeviceWidth-20, 0.5)];
    geLine1.backgroundColor=graytxtcolor;
    geLine2.backgroundColor=graytxtcolor;
    [self.view addSubview:geLine1];
    [self.view addSubview:geLine2];
    
    UIButton * remPswBtn=[[UIButton alloc]initWithFrame:CGRectMake(40, fDeviceHeight/2+31+10, 100, 30)];
    [remPswBtn addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    //remPswBtn.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:remPswBtn];
    
    _checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect checkboxRect = CGRectMake(40, fDeviceHeight/2+31+20, 15, 15);
    [_checkbox setFrame:checkboxRect];
    
    [_checkbox setImage:[UIImage imageNamed:@"checkbox_off.png"] forState:UIControlStateNormal];
    [_checkbox setImage:[UIImage imageNamed:@"checkbox_on.png"] forState:UIControlStateSelected];
    
    [_checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_checkbox];
    UILabel *remPswLbl=[[UILabel alloc]initWithFrame:CGRectMake(40+18,fDeviceHeight/2+31+17, 80, 20)];
    remPswLbl.text=@"记住密码";
    [remPswLbl setTextColor:[UIColor grayColor]];
    [remPswLbl setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:remPswLbl];
    

    _LoginBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, fDeviceHeight-150, fDeviceWidth, 40)];
    
    [_LoginBtn addTarget:self action:@selector(clickloginbtn) forControlEvents:UIControlEventTouchUpInside];
    
    [_LoginBtn setTitle:@"登录"forState:UIControlStateNormal];// 添加文字
    _LoginBtn.backgroundColor=bluetxtcolor;
    [self.view addSubview:_LoginBtn];
    
    
    _actionBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, fDeviceHeight-150+40+10, fDeviceWidth, 40)];
    
    [_actionBtn addTarget:self action:@selector(clickzhucebtn) forControlEvents:UIControlEventTouchUpInside];
    
    [_actionBtn setTitle:@"用户激活"forState:UIControlStateNormal];// 添加文字
    [_actionBtn setTitleColor:bluetxtcolor forState:UIControlStateNormal];//bluetxtcolor;
    _actionBtn.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_actionBtn];
    
    UILabel * hintLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, fDeviceHeight-60, fDeviceWidth-20, 40)];
    [hintLbl setTextAlignment:NSTextAlignmentCenter];
    [hintLbl setTextColor:graytxtcolor];
    [hintLbl setFont:[UIFont systemFontOfSize:12]];
    hintLbl.numberOfLines = 0;
    hintLbl.text=@"如果遇到账户信息泄漏，忘记密码，诈骗等账号安全问题请联系系统管理员";
    [self.view addSubview:hintLbl];
    
    if (!_cancelVc1) {
        _cancelVc1=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-35, fDeviceHeight/2+10, 11, 12)];
        _cancelVc1.image=[UIImage imageNamed:@"cancle"];
        [self.view addSubview:_cancelVc1];
        
        UIButton *usrClearBtn=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-35, fDeviceHeight/2, 40, 40)];
        [self.view addSubview:usrClearBtn];
        
        usrClearBtn.tag=102;
        [usrClearBtn addTarget:self action:@selector(clearbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    _cancelVc1.hidden=YES;
    
    if (!_cancelVc) {
        _cancelVc=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-35, fDeviceHeight/2-40, 11, 12)];
        _cancelVc.image=[UIImage imageNamed:@"cancle"];
        [self.view addSubview:_cancelVc];
        UIButton *usrClearBtn=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-35, fDeviceHeight/2-50, 40, 40)];
        [self.view addSubview:usrClearBtn];
        //usrClearBtn.backgroundColor=[UIColor blueColor];
        usrClearBtn.tag=101;
        [usrClearBtn addTarget:self action:@selector(clearbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    _cancelVc.hidden=YES;
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * rmbPsw = [user objectForKey:NSUserRmbMsg];
    
    if ([rmbPsw isEqualToString:@"1"]) {
        _checkbox.selected=YES;
        ApplicationDelegate.isRmbPsw=YES;
        _UsrTxtF.text=[stdPubFunc readUserMsg];
        _PassTxtF.text=[stdPubFunc readPassword];
        _cancelVc1.hidden=NO;
        _cancelVc.hidden=NO;
        [self clickloginbtn];//记住密码 自动登录
    }
    else
    {
        _checkbox.selected=NO;
        ApplicationDelegate.isRmbPsw=NO;
    }
}
-(void)clickzhucebtn{
    ActionUserViewController *actionUsrVc=[[ActionUserViewController alloc]init];
    actionUsrVc.actionSuccBlock = ^(ActionUserViewController *aqrvc){
        NSLog(@"action_suc");
        //ApplicationDelegate.isLogin = YES;
        [self loginSuccPro];
    };

    
    actionUsrVc.view.backgroundColor=[UIColor whiteColor];
     self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:actionUsrVc animated:YES];
    
}
-(void)clickloginbtn{

//    if ( _UsrTxtF.text.length<1) {
//        [stdPubFunc stdShowMessage:@"请填写用户名"];
//        return;
//    }
//    if ( _PassTxtF.text.length<1) {
//        [stdPubFunc stdShowMessage:@"请填写密码"];
//        return;
//    }
    [self loginNetFuc:_UsrTxtF.text passWord:_PassTxtF.text];
}

-(void)loginSuccPro{
    [self.navigationController popViewControllerAnimated:NO];
    if(self.loginSuccBlock)
        self.loginSuccBlock(self);
}
-(void)stdInitTxtF:(UITextField*)txtF hintxt:(NSString*)hintstr{
    txtF.backgroundColor = [UIColor clearColor];
    [txtF setTintColor:[UIColor blueColor]];
    [txtF setFont:[UIFont systemFontOfSize:13]];
    txtF.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    txtF.textColor=txtColor;
    txtF.layer.borderColor = [UIColor grayColor].CGColor; // set color as you want.
    txtF.layer.borderWidth = 0.0f; // set borderWidth as you want.
    txtF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:hintstr attributes:@{NSForegroundColorAttributeName:txtColor}];
    txtF.delegate=self;
}

-(NSDictionary *)makeUpLoadDict{
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    
    [dict setObject:@"hong" forKey:@"id"];
    [dict setObject:@"admin" forKey:@"password"];
    NSLog(@"dict:%@",[self dictionaryToJson:dict]);
    
    
    return dict;
    
}

-(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

//登录
-(void)loginNetFuc:(NSString*)usr passWord:(NSString*)psw{
    [SVProgressHUD showWithStatus:k_Status_Load];


    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/sys/login"];

    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:[self makeUpLoadDict]
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                         
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              loginInfo *LGIN=[[loginInfo alloc]init];
                                              ApplicationDelegate.myLoginInfo=[LGIN asignInfoWithDict:jsonDic];
                                              
                                              [SVProgressHUD dismiss];
                                              [stdPubFunc stdShowMessage:msg];
                                              [self loginSuccPro];
                                              if (ApplicationDelegate.isRmbPsw) {
                                                  
                                                  [stdPubFunc isSaveLoginInfo:@"1"];
                                                  [stdPubFunc saveLoginInfo:_UsrTxtF.text password:_PassTxtF.text];
                                              }
                                              else{
                                                  [stdPubFunc isSaveLoginInfo:@"0"];
                                              }
                                              
                                          } else {
                                              //失败
                                              [SVProgressHUD showErrorWithStatus:msg];
                                              if(self.loginFailBlock)
                                                  self.loginFailBlock(self);
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                          if(self.loginFailBlock)
                                              self.loginFailBlock(self);
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                      if(self.loginFailBlock)
                                          self.loginFailBlock(self);
                                  }];
    
}


-(void)loadMoreCollectionViewData:(NSString*)usr passWord:(NSString*)psw{
    [SVProgressHUD showWithStatus:k_Status_Load];
    //http://localhost:8080/propies/index/notice?communityId=1&page=1&pagesize=20
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                @"pageNo":[NSString stringWithFormat:@"%d",1],
                                @"pageSize":[NSString stringWithFormat:@"%d",20]
                                };
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@%@",BaseUrl,BasePath,@"interface/getgoodsnew.htm?usr=",usr,@"&psw=",psw];
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
                                          //NSLog(@"数据：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"result"];
                                          
                                          //
                                          if ([suc isEqualToString:@"true"]) {
                                              //成功

                                            [SVProgressHUD dismiss];
                                            [self loginSuccPro];
                                            
                                          } else {
                                              //失败
                                              [SVProgressHUD showErrorWithStatus:k_Error_WebViewError];
                                              if(self.loginFailBlock)
                                                  self.loginFailBlock(self);
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                          if(self.loginFailBlock)
                                              self.loginFailBlock(self);
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                      if(self.loginFailBlock)
                                          self.loginFailBlock(self);
                                  }];
    
}
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSUserLoginMsg
                                                  object:nil];
    
}

-(void)std_regsNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(execute:)
                                                 name:NSUserLoginMsg
                                               object:nil];
    

}

- (void)execute:(NSNotification *)notification {
    if([notification.name isEqualToString:NSUserLoginMsg] ){
        loginInfo *logtmp=notification.object;
//        _UsrTxtF.text=logtmp.usrlog;
//        _PassTxtF.text=logtmp.usrpsw;
        [self clickloginbtn];
    }
}

@end
