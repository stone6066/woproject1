//
//  LoginViewController.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "LoginViewController.h"
#import "PublicDefine.h"
#import "loginInfo.h"
#import "stdPubFunc.h"


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

-(void)loadLoginView{
    UIImageView *backImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight)];
    backImg.image=[UIImage imageNamed:@"backImg"];
    [self.view addSubview:backImg];
    
//    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake((fDeviceWidth-172)/2, fDeviceHeight/10, 172, 136)];
//    logoImg.image=[UIImage imageNamed:@"login"];
//    [self.view addSubview:logoImg];
    
    _UsrTxtF = [[UITextField alloc] initWithFrame:CGRectMake(20, fDeviceHeight/2-50, fDeviceWidth-40, 30)];
    [self stdInitTxtF:_UsrTxtF hintxt:@"用户名"];
    
    
    _PassTxtF = [[UITextField alloc] initWithFrame:CGRectMake(20, fDeviceHeight/2, fDeviceWidth-40, 30)];
    [self stdInitTxtF:_PassTxtF hintxt:@"密码"];
    _PassTxtF.secureTextEntry = YES;
    
    [self.view addSubview:_UsrTxtF];
    [self.view addSubview:_PassTxtF];
    _UsrTxtF.text=[stdPubFunc readUserMsg];
    _PassTxtF.text=[stdPubFunc readPassword];
    UIImageView *logobtnImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, fDeviceHeight/2+50, fDeviceWidth-20, 50)];
    logobtnImg.image=[UIImage imageNamed:@"logBtn"];
    [self.view addSubview:logobtnImg];
    
    _LoginBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, fDeviceHeight/2+47, fDeviceWidth, 50)];
    
    [_LoginBtn addTarget:self action:@selector(clickloginbtn) forControlEvents:UIControlEventTouchUpInside];
    
    [_LoginBtn setTitle:@"登   录"forState:UIControlStateNormal];// 添加文字
    _LoginBtn.backgroundColor=[UIColor blueColor];
    [self.view addSubview:_LoginBtn];
    
    UILabel * zhuceLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, fDeviceHeight/2+100, fDeviceWidth-20, 20)];
    zhuceLbl.text=@"注册新用户";
    [zhuceLbl setTextAlignment:NSTextAlignmentCenter];
    [zhuceLbl setTextColor:topSearchBgdColor];
    [zhuceLbl setFont:[UIFont systemFontOfSize:14]];
    
    UIButton *zhuceBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, fDeviceHeight/2+100, fDeviceWidth-20, 20)];
    [zhuceBtn addTarget:self action:@selector(clickzhucebtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuceLbl];
    [self.view addSubview:zhuceBtn];
}
-(void)clickzhucebtn{
   
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
    txtF.layer.borderWidth = 1.0f; // set borderWidth as you want.
    txtF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:hintstr attributes:@{NSForegroundColorAttributeName:txtColor}];
    txtF.delegate=self;
}

//登录
-(void)loginNetFuc:(NSString*)usr passWord:(NSString*)psw{
    [SVProgressHUD showWithStatus:k_Status_Load];

    NSDictionary *paramDict = @{
                                @"id":@"hong",
                                @"password":@"admin"
                                };

    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/sys/login"];

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
                                         
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              loginInfo *LGIN=[[loginInfo alloc]init];
                                              ApplicationDelegate.myLoginInfo=[LGIN asignInfoWithDict:jsonDic];
                                              [stdPubFunc saveLoginInfo:_UsrTxtF.text password:_PassTxtF.text];
                                              [SVProgressHUD dismiss];
                                              [stdPubFunc stdShowMessage:msg];
                                              [self loginSuccPro];
                                              
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
