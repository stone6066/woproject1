//
//  HomeViewController.m
//  woproject
//
//  Created by tianan-apple on 16/10/9.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "PublicDefine.h"
#import "BaseMapViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "APIKey.h"

#import "stdMapViewController.h"


@interface HomeViewController ()
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@end

@implementation HomeViewController
@synthesize mapView     = _mapView;
@synthesize search      = _search;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMapView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"首页";
        
        self.tabBarItem.title=tittxt;
        
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
    if (!ApplicationDelegate.isLogin) {
        //显示登录页面
        LoginViewController *vc = [[LoginViewController alloc]init];
        vc.loginSuccBlock = ^(LoginViewController *aqrvc){
            NSLog(@"login_suc");
            ApplicationDelegate.isLogin = YES;
            [self drawMainView];
        };
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
        self.hidesBottomBarWhenPushed = NO;
    }
    
}
-(void)stdInitLable:(UILabel*)lab hint:(NSString*)stxt{
    lab.text=stxt;//@"已接工单";
    [lab setTextColor:[UIColor whiteColor]];
    [lab setFont:[UIFont systemFontOfSize:18]];
    [lab setTextAlignment:NSTextAlignmentCenter];
}
-(void)drawMainView{
    CGFloat topHeigh=60;
    CGFloat offsetX=10;
    CGFloat offsetY=10;
    CGFloat cellWidth=(fDeviceWidth-3*offsetX)/2;
    CGFloat cellMinHeigh=(fDeviceHeight-topHeigh-MainTabbarHeight-4*offsetY)/4;
    CGFloat imgW=60;
    CGFloat imgH=60;
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, topHeigh)];
    topView.backgroundColor=topviewcolor;
    [self.view addSubview:topView];
    UIImageView *topImg=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth/2-12, 30, 24, 12)];
    topImg.image=[UIImage imageNamed:@"login02"];
    [topView addSubview:topImg];
    
    UIView *xianImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, topHeigh-1, fDeviceWidth, 0.5)];
    xianImg.backgroundColor=topxiancolor;
    [topView addSubview:xianImg];
    
    UIView * yjgd=[[UIView alloc]initWithFrame:CGRectMake(offsetX, topHeigh+offsetY, cellWidth, cellMinHeigh*2)];
    yjgd.backgroundColor=yjgdColor;
    [self.view addSubview:yjgd];
    UIImageView *yjimg=[[UIImageView alloc]initWithFrame:CGRectMake((cellWidth-imgW)/2, (cellMinHeigh*2-imgH-30)/2, imgW, imgH)];
    yjimg.image=[UIImage imageNamed:@"FOLDER-OK"];
    [yjgd addSubview:yjimg];
    CGFloat lblH1= yjimg.frame.origin.y+yjimg.frame.size.height+3;
    UILabel *yjgdlbl=[[UILabel alloc]initWithFrame:CGRectMake(0, lblH1, cellWidth, 30)];
    [self stdInitLable:yjgdlbl hint:@"已接工单"];
    [yjgd addSubview:yjgdlbl];
    UIButton *yjbtn=[[UIButton alloc]initWithFrame:yjgd.frame];
    [self.view addSubview:yjbtn];
    [yjbtn addTarget:self action:@selector(clickyj) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * zdjd=[[UIView alloc]initWithFrame:CGRectMake(offsetX, topHeigh+offsetY*2+cellMinHeigh*2, cellWidth, cellMinHeigh)];
    zdjd.backgroundColor=zdjdColor;
    [self.view addSubview:zdjd];
    UIImageView *zdimg=[[UIImageView alloc]initWithFrame:CGRectMake((cellWidth-imgW)/2, (cellMinHeigh-imgH-30)/2, imgW, imgH)];
    zdimg.image=[UIImage imageNamed:@"USER-OK"];
    [zdjd addSubview:zdimg];
    CGFloat lblH2= zdimg.frame.origin.y+zdimg.frame.size.height+3;
    UILabel *zdlbl=[[UILabel alloc]initWithFrame:CGRectMake(0, lblH2, cellWidth, 30)];
    [self stdInitLable:zdlbl hint:@"指定接单"];
    [zdjd addSubview:zdlbl];
    UIButton *zdbtn=[[UIButton alloc]initWithFrame:zdjd.frame];
    [self.view addSubview:zdbtn];
    [zdbtn addTarget:self action:@selector(clickzd) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * kq=[[UIView alloc]initWithFrame:CGRectMake(offsetX, topHeigh+offsetY*3+cellMinHeigh*3, cellWidth, cellMinHeigh)];
    kq.backgroundColor=kqColor;
    [self.view addSubview:kq];
    UIImageView *kqimg=[[UIImageView alloc]initWithFrame:CGRectMake((cellWidth-imgW)/2, (cellMinHeigh-imgH-30)/2, imgW, imgH)];
    kqimg.image=[UIImage imageNamed:@"PIN-ZOOM-IN"];
    [kq addSubview:kqimg];
    CGFloat lblH3= kqimg.frame.origin.y+kqimg.frame.size.height+3;
    UILabel *kqlbl=[[UILabel alloc]initWithFrame:CGRectMake(0, lblH3, cellWidth, 30)];
    [self stdInitLable:kqlbl hint:@"考勤"];
    [kq addSubview:kqlbl];
    UIButton *kqbtn=[[UIButton alloc]initWithFrame:kq.frame];
    [self.view addSubview:kqbtn];
    [kqbtn addTarget:self action:@selector(clickkq) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * pd=[[UIView alloc]initWithFrame:CGRectMake(offsetX*2+cellWidth, topHeigh+offsetY, cellWidth, cellMinHeigh)];
    pd.backgroundColor=pdColor;
    [self.view addSubview:pd];
    UIImageView *pdimg=[[UIImageView alloc]initWithFrame:CGRectMake((cellWidth-imgW)/2, (cellMinHeigh-imgH-30)/2, imgW, imgH)];
    pdimg.image=[UIImage imageNamed:@"NOTEPAD-OK"];
    [pd addSubview:pdimg];
    CGFloat lblH4= pdimg.frame.origin.y+pdimg.frame.size.height+3;
    UILabel *pdlbl=[[UILabel alloc]initWithFrame:CGRectMake(0, lblH4, cellWidth, 30)];
    [self stdInitLable:pdlbl hint:@"派单"];
    [pd addSubview:pdlbl];
    UIButton *pdbtn=[[UIButton alloc]initWithFrame:pd.frame];
    [self.view addSubview:pdbtn];
    [pdbtn addTarget:self action:@selector(clickpd) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * gggd=[[UIView alloc]initWithFrame:CGRectMake(offsetX*2+cellWidth, topHeigh+offsetY*2+cellMinHeigh, cellWidth, cellMinHeigh*2)];
    gggd.backgroundColor=gggdColor;
    [self.view addSubview:gggd];
    UIImageView *ggimg=[[UIImageView alloc]initWithFrame:CGRectMake((cellWidth-imgW)/2, (cellMinHeigh*2-imgH-30)/2, imgW, imgH)];
    ggimg.image=[UIImage imageNamed:@"USERS"];
    [gggd addSubview:ggimg];
    CGFloat lblH5= ggimg.frame.origin.y+ggimg.frame.size.height+3;
    UILabel *gglbl=[[UILabel alloc]initWithFrame:CGRectMake(0, lblH5, cellWidth, 30)];
    [self stdInitLable:gglbl hint:@"公共工单"];
    [gggd addSubview:gglbl];
    UIButton *ggbtn=[[UIButton alloc]initWithFrame:gggd.frame];
    [self.view addSubview:ggbtn];
    [ggbtn addTarget:self action:@selector(clickgg) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * kshsj=[[UIView alloc]initWithFrame:CGRectMake(offsetX*2+cellWidth, topHeigh+offsetY*3+cellMinHeigh*3, cellWidth, cellMinHeigh)];
    kshsj.backgroundColor=kshsjColor;
    [self.view addSubview:kshsj];
    UIImageView *ksimg=[[UIImageView alloc]initWithFrame:CGRectMake((cellWidth-imgW)/2, (cellMinHeigh-imgH-30)/2, imgW, imgH)];
    ksimg.image=[UIImage imageNamed:@"CHART"];
    [kshsj addSubview:ksimg];
    CGFloat lblH6= ksimg.frame.origin.y+ksimg.frame.size.height+3;
    UILabel *kslbl=[[UILabel alloc]initWithFrame:CGRectMake(0, lblH6, cellWidth, 30)];
    [self stdInitLable:kslbl hint:@"可视化数据"];
    [kshsj addSubview:kslbl];
    UIButton *ksbtn=[[UIButton alloc]initWithFrame:kshsj.frame];
    [self.view addSubview:ksbtn];
    [ksbtn addTarget:self action:@selector(clickks) forControlEvents:UIControlEventTouchUpInside];
}
-(void)clickyj{//已接

}
-(void)clickzd{//主动接单
    
}
-(void)clickkq{//考勤
    
    BaseMapViewController *subViewController = [[stdMapViewController alloc] init];
    
    subViewController.title   = @"map";
    subViewController.mapView = self.mapView;
    subViewController.search  = self.search;
    subViewController.hidesBottomBarWhenPushed=YES;
    subViewController.navigationItem.hidesBackButton=YES;
    
    
    [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
}
-(void)clickpd{//派单
    
}
-(void)clickgg{//公共
    
}
-(void)clickks{//可视化
    
}

- (void)initMapView
{
    //    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
}

/* 初始化search. */
- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] init];
}



#pragma mark - Life Cycle

- (id)init
{
    if (self = [super init])
    {
       
        
        /* 初始化search. */
        [self initSearch];
        
       
    }
    
    return self;
}



//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    self.navigationController.navigationBar.barStyle    = UIBarStyleBlack;
//    self.navigationController.navigationBar.translucent = NO;
//    
//    [self.navigationController setToolbarHidden:YES animated:animated];
//}


@end
