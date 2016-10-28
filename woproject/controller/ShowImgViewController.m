//
//  ShowImgViewController.m
//  woproject
//
//  Created by tianan-apple on 2016/10/24.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ShowImgViewController.h"
#import "UIImageView+WebCache.h"
@interface ShowImgViewController ()

@end

@implementation ShowImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self drawMainImgView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id)init:(NSString*)urlstring{
    if (self==[super init]) {
        _imgUrl=urlstring;
    }
    return self;
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    topLbl.text=@"";
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

-(void)drawMainImgView{
    UIImageView *mainImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceWidth)];
    [mainImg sd_setImageWithURL:[NSURL URLWithString:_imgUrl]];
    [self.view addSubview:mainImg];
}
@end
