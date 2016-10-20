//
//  turnAndHelpViewController.m
//  woproject
//
//  Created by tianan-apple on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "turnAndHelpViewController.h"
#import "ComboxView.h"

#define kDropDownListTag 1000


@interface turnAndHelpViewController ()

@end

@implementation turnAndHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self drawMainView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id)init:(NSString *)listId viewType:(NSInteger)typeI{
    if (self==[super init]) {
        _listId=listId;
        _ViewType=typeI;
    }
    return self;
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

-(void)drawMainView{
    CGFloat offsetX=15;
    CGFloat offsetY=90;
    CGFloat BoxHeigh=40;
    CGFloat BoxWidth=fDeviceWidth-offsetX*2;
     _priorityBox = [[ComboxView alloc] initWithFrame:CGRectMake(offsetX, offsetY, BoxWidth, BoxHeigh) titleStr:@"优先级："];
    NSArray* arr=[[NSArray alloc]initWithObjects:@"电话",@"email",@"手机",@"aaa",@"bbb",@"ccc",@"电话",@"email",@"手机",@"aaa",@"bbb",@"ccc",@"电话",@"email",@"手机",@"aaa",@"bbb",@"ccc",nil];
    _priorityBox.tableArray = arr;
    [self.view addSubview:_priorityBox];
    
    _jobNameBox = [[ComboxView alloc] initWithFrame:CGRectMake(offsetX, offsetY+15+BoxHeigh, BoxWidth, BoxHeigh) titleStr:@"工种："];
    NSArray* arr1=[[NSArray alloc]initWithObjects:@"电话",@"email",@"手机",@"aaa",@"bbb",@"ccc",@"电话",@"email",@"手机",@"aaa",@"bbb",@"ccc",@"电话",@"email",@"手机",@"aaa",@"bbb",@"ccc",nil];
    _jobNameBox.tableArray = arr1;
    [self.view addSubview:_jobNameBox];
    
    
    _operationUserBox = [[ComboxView alloc] initWithFrame:CGRectMake(offsetX, offsetY+(15+BoxHeigh)*2, BoxWidth, BoxHeigh) titleStr:@"接单人："];
    NSArray* arr2=[[NSArray alloc]initWithObjects:@"电话",@"email",@"手机",@"aaa",@"bbb",@"ccc",@"电话",@"email",@"手机",@"aaa",@"bbb",@"ccc",@"电话",@"email",@"手机",@"aaa",@"bbb",@"ccc",nil];
    _operationUserBox.tableArray = arr2;
    [self.view addSubview:_operationUserBox];
}


@end
