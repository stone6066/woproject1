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


@interface turnAndHelpViewController ()<UITextViewDelegate>

@end

@implementation turnAndHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self drawMainView];
    // Do any additional setup after loading the view.
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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


-(void)stdSetAddImgBtn:(UIButton *)btn{
    [btn addTarget:self action:@selector(myclickFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setImage:[UIImage imageNamed:@"baoxiujiahao"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self.view addSubview:btn];
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
    
    NSMutableAttributedString * lblStr=[[NSMutableAttributedString alloc]initWithString:@"转单原因*："];
    if (_ViewType==7) {
        lblStr=[[NSMutableAttributedString alloc] initWithString:@"协助原因:*"];
    }
    [lblStr addAttribute:NSForegroundColorAttributeName
                value:[UIColor blackColor]
                range:NSMakeRange(0,4)];
    [lblStr addAttribute:NSForegroundColorAttributeName
                value:[UIColor redColor]
                range:NSMakeRange(4,1)];
    
    [lblStr addAttribute:NSForegroundColorAttributeName
                value:[UIColor blackColor]
                range:NSMakeRange(5,1)];
    UILabel *hintLbl=[[UILabel alloc]initWithFrame:CGRectMake(offsetX, _operationUserBox.frame.origin.y+_operationUserBox.frame.size.height+offsetX, BoxWidth, 30)];
    [hintLbl setFont:[UIFont systemFontOfSize:12]];
    hintLbl.attributedText=lblStr;
    [self.view addSubview:hintLbl];
    
    
    if (!_memoResion) {
        _memoResion=[[UITextView alloc]initWithFrame:CGRectMake(offsetX, hintLbl.frame.origin.y+hintLbl.frame.size.height+5, BoxWidth, 120)];
        _memoResion.returnKeyType=UIReturnKeyDone;
        _memoResion.delegate=self;
        [self.view addSubview:_memoResion];
    }
    
    
    if (!_addImg1) {
        _addImg1=[[UIButton alloc]initWithFrame:CGRectMake(offsetX, _memoResion.frame.origin.y+_memoResion.frame.size.height+15, 40, 40)];
        _addImg1.tag=200;
        [self stdSetAddImgBtn:_addImg1];
    }
    
    if (!_addImg2) {
        _addImg2=[[UIButton alloc]initWithFrame:CGRectMake(offsetX+45, _memoResion.frame.origin.y+_memoResion.frame.size.height+15, 40, 40)];
        _addImg2.tag=201;
        
        [self stdSetAddImgBtn:_addImg2];
    }
    
    
    if (!_addImg3) {
        _addImg3=[[UIButton alloc]initWithFrame:CGRectMake(offsetX+45*2, _memoResion.frame.origin.y+_memoResion.frame.size.height+15, 40, 40)];
        _addImg3.tag=202;
        [self stdSetAddImgBtn:_addImg3];
        
    }
    
    if (!_doneBtn) {
        _doneBtn=[[UIButton alloc]initWithFrame:CGRectMake(offsetX, _addImg3.frame.origin.y+_addImg3.frame.size.height+15, (fDeviceWidth-offsetX*4)/2, 40)];
        _doneBtn.tag=203;
        if (_ViewType==7) {
            [_doneBtn setTitle:@"确认协助" forState:UIControlStateNormal];// 添加文字
        }
        else
            [_doneBtn setTitle:@"确认转单" forState:UIControlStateNormal];
        
        _doneBtn.backgroundColor=bluetxtcolor;
        [_doneBtn addTarget:self action:@selector(myclickFunc:) forControlEvents:UIControlEventTouchUpInside];
        
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [self.view addSubview:_doneBtn];
    }
    if (!_scanBtn) {
        _scanBtn=[[UIButton alloc]initWithFrame:CGRectMake(_doneBtn.frame.origin.x+_doneBtn.frame.size.width+2*offsetX, _addImg3.frame.origin.y+_addImg3.frame.size.height+15, (fDeviceWidth-offsetX*4)/2, 40)];
        _scanBtn.tag=204;
        if (_ViewType==7) {
            [_scanBtn setTitle:@"扫描二维码协助" forState:UIControlStateNormal];// 添加文字
        }
        else
            [_scanBtn setTitle:@"扫描二维码转单" forState:UIControlStateNormal];
        
        _scanBtn.backgroundColor=bluetxtcolor;
        [_scanBtn addTarget:self action:@selector(myclickFunc:) forControlEvents:UIControlEventTouchUpInside];
        
        _scanBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [self.view addSubview:_scanBtn];
    }


}
-(void)myclickFunc:(UIButton*)btn{


}

@end
