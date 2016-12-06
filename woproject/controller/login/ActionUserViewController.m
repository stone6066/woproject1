//
//  ActionUserViewController.m
//  woproject
//
//  Created by tianan-apple on 16/10/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ActionUserViewController.h"
#import "loginInfo.h"
#import "stdPubFunc.h"

@interface ActionUserViewController ()<UITextFieldDelegate>

@end

@implementation ActionUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self loadTopNav];
    [self drawActionUsrVc];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_MobileTxtF resignFirstResponder];
    [_PswTxtF resignFirstResponder];
    [_PswTxtF1 resignFirstResponder];
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

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    topLbl.text=@"用户激活";
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

-(void)drawActionUsrVc{
    UIImageView *backImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    backImg.image=[UIImage imageNamed:@"login_bg"];
    [self.view addSubview:backImg];
    
    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake((fDeviceWidth-100)/2, fDeviceHeight/10+TopSeachHigh, 100, 100)];
    logoImg.image=[UIImage imageNamed:@"login_icon"];
    [self.view addSubview:logoImg];
    
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, fDeviceHeight/10+110+TopSeachHigh, fDeviceWidth, 30)];
    titleLbl.text=@"移动运维";
    [titleLbl setTextColor:[UIColor blackColor]];
    [titleLbl setFont:[UIFont systemFontOfSize:18]];
    [titleLbl setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:titleLbl];

    
    _MobileTxtF = [[UITextField alloc] initWithFrame:CGRectMake(70, fDeviceHeight/2-50+TopSeachHigh, fDeviceWidth-100, 30)];
    [self stdInitTxtF:_MobileTxtF hintxt:@"请输入手机号"];
    
    
    _PswTxtF = [[UITextField alloc] initWithFrame:CGRectMake(70, fDeviceHeight/2+TopSeachHigh, fDeviceWidth-100, 30)];
    [self stdInitTxtF:_PswTxtF hintxt:@"请输入密码"];
    _PswTxtF.secureTextEntry = YES;
    
    _PswTxtF1 = [[UITextField alloc] initWithFrame:CGRectMake(70, fDeviceHeight/2+TopSeachHigh+50, fDeviceWidth-100, 30)];
    [self stdInitTxtF:_PswTxtF1 hintxt:@"请再次输入密码"];
    _PswTxtF1.secureTextEntry = YES;
    
    [self.view addSubview:_MobileTxtF];
    [self.view addSubview:_PswTxtF];
    [self.view addSubview:_PswTxtF1];
    
    UIImageView *usrImg=[[UIImageView alloc]initWithFrame:CGRectMake(40, fDeviceHeight/2-43+TopSeachHigh, 15, 17)];
    usrImg.image=[UIImage imageNamed:@"hh_login01"];
    
    UIImageView *pswImg=[[UIImageView alloc]initWithFrame:CGRectMake(40, fDeviceHeight/2+7+TopSeachHigh, 15, 17)];
    pswImg.image=[UIImage imageNamed:@"hh_login02"];
    
    UIImageView *pswImg1=[[UIImageView alloc]initWithFrame:CGRectMake(40, fDeviceHeight/2+57+TopSeachHigh, 15, 17)];
    pswImg1.image=[UIImage imageNamed:@"hh_login02"];
    
    [self.view addSubview:usrImg];
    [self.view addSubview:pswImg];
    [self.view addSubview:pswImg1];
    
    _actionBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, fDeviceHeight/2+TopSeachHigh+100, fDeviceWidth, 40)];
    
    [_actionBtn addTarget:self action:@selector(actloginbtn) forControlEvents:UIControlEventTouchUpInside];
    
    [_actionBtn setTitle:@"用户激活"forState:UIControlStateNormal];// 添加文字
    _actionBtn.backgroundColor=bluetxtcolor;
    [self.view addSubview:_actionBtn];

    
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


-(void)actloginbtn{
    if (_MobileTxtF.text.length<1) {
        [stdPubFunc stdShowMessage:@"手机号不能为空，请重新输入"];
        return;
    }
    if (_PswTxtF1.text.length<1) {
        [stdPubFunc stdShowMessage:@"登入密码不能为空，请重新输入"];
        return;
    }
    if (_PswTxtF.text.length<1) {
        [stdPubFunc stdShowMessage:@"登入密码不能为空，请重新输入"];
        return;
    }
   
    if (![_PswTxtF.text isEqualToString:_PswTxtF1.text]) {
         [stdPubFunc stdShowMessage:@"密码输入不一致，请重新输入"];
        return;
    }
    if (![self numberOrlate:_PswTxtF.text]) {
        [stdPubFunc stdShowMessage:@"密码只能是大小写字母、数字，请重新输入"];
        return;
    }
    if (_PswTxtF.text.length<6) {
        [stdPubFunc stdShowMessage:@"密码长度必须是6-18个字符，请重新输入"];
        return;
    }
    if (_PswTxtF.text.length>18) {
        [stdPubFunc stdShowMessage:@"密码长度必须是6-18个字符，请重新输入"];
        return;
    }
    [self ActionNetFuc:_MobileTxtF.text passWord:_PswTxtF.text];
       
}

-(BOOL)numberOrlate:(NSString*)mystring{
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"];
    s = [s invertedSet];
    NSRange r = [mystring rangeOfCharacterFromSet:s];
    if (r.location !=NSNotFound)
    {
        return NO;
    }
    return YES;
}
-(NSDictionary *)makeUpLoadDict{
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    
    [dict setObject:_MobileTxtF.text forKey:@"id"];
    [dict setObject:_PswTxtF.text forKey:@"password"];
    //NSLog(@"dict:%@",[self dictionaryToJson:dict]);
    
    
    return dict;
    
}

//激活
-(void)ActionNetFuc:(NSString*)usr passWord:(NSString*)psw{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/sys/activate"];
    
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
                                              [SVProgressHUD dismiss];
                                              [self showAlert];
                                              
                                              
                                              
                                          } else {
                                              //失败
                                              [SVProgressHUD dismiss];
                                              [stdPubFunc stdShowMessage:@"该用户不存在，请重新激活"];
                                              if(self.actionFailBlock)
                                                  self.actionFailBlock(self);
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                          if(self.actionFailBlock)
                                              self.actionFailBlock(self);
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                      if(self.actionFailBlock)
                                          self.actionFailBlock(self);
                                  }];
    
}
-(void)showAlert{
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"该用户已激活"
                               message:@"立即登录"
                              delegate:self
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:nil, nil];
    [alert show];

}

//您有新工单请查看
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{//
//            loginInfo *LGIN=[[loginInfo alloc]init];
//            ApplicationDelegate.myLoginInfo=[LGIN asignInfoWithDict:jsonDic];
//            [stdPubFunc stdShowMessage:@"激活成功"];
//            [self actionSuccPro];
//            [stdPubFunc isSaveLoginInfo:@"0"];
            [self.navigationController popViewControllerAnimated:YES];
            }break;
        default:
            break;
    }
}



-(void)actionSuccPro{
    [self.navigationController popViewControllerAnimated:NO];
    if(self.actionSuccBlock)
        self.actionSuccBlock(self);
}
@end
