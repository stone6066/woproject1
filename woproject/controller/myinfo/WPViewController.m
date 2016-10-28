//
//  WPViewController.m
//  woproject
//
//  Created by 徐洋 on 16/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "WPViewController.h"

@interface WPViewController ()

@property (nonatomic, strong) UIView *toptView;
@property (nonatomic, strong) UILabel *topLabel;
/**
 返回按钮
 */
@property (nonatomic, strong) UIImageView *backimg;
@property (nonatomic, strong) UILabel *hintLbl;
@property (nonatomic, strong) UIButton *back;

@end

@implementation WPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTopNav];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)setTopTitle:(NSString *)topTitle
{
    _topTitle = topTitle;
    _topLabel.text = topTitle;
}

- (void)setIsHiddenBackItem:(BOOL)isHiddenBackItem
{
    _isHiddenBackItem = isHiddenBackItem;
    _backimg.hidden = isHiddenBackItem;
    _hintLbl.hidden = isHiddenBackItem;
    _back.hidden = isHiddenBackItem;
}

- (void)setRightTitle:(NSString *)rightTitle
{
    _rightTitle = rightTitle;
    if (!rightTitle) return;
    _righButon.hidden = NO;
    [_righButon setTitle:rightTitle forState:normal];
}

- (void)setRightImage:(UIImage *)rightImage
{
    _rightImage = rightImage;
    _righButon.hidden = NO;
    [_righButon setImage:rightImage forState:normal];
}

- (void)setLeftImage:(UIImage *)leftImage
{
    _leftImage = leftImage;
    _leftButton.hidden = NO;
    [_leftButton setImage:leftImage forState:normal];
    self.isHiddenBackItem = YES;
}

- (void)initUI{}

- (void)loadTopNav{
    
    _toptView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    _toptView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    _topLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    _topLabel.text = _topTitle;
    [_topLabel setFont:[UIFont systemFontOfSize:18]];
    [_topLabel setTextAlignment:NSTextAlignmentCenter];
    [_topLabel setTextColor:[UIColor whiteColor]];
    
    [_toptView addSubview:_topLabel];
    _backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 27, 60, 24)];
    _backimg.image=[UIImage imageNamed:@"bar_back"];
    [_toptView addSubview:_backimg];
    
    _hintLbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 29, 30, 20)];
    _hintLbl.text=@"返回";
    [_hintLbl setFont:[UIFont systemFontOfSize:14]];
    [_hintLbl setTextAlignment:NSTextAlignmentCenter];
    [_hintLbl setTextColor:[UIColor whiteColor]];
    
    [_toptView addSubview:_hintLbl];
    [self.view addSubview:_toptView];
    
    //返回按钮
    _back = [UIButton buttonWithType:UIButtonTypeCustom];
    [_back setFrame:CGRectMake(0, 22, 70, 42)];
    [_back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [_toptView addSubview:_back];
    [self.view addSubview:_toptView];
    
    _righButon = [UIButton buttonWithType:UIButtonTypeCustom];
    _righButon.titleLabel.font = k_text_font(14);
    _righButon.hidden = YES;
    [_toptView addSubview:_righButon];
    _righButon.frame = CGRectMake(fDeviceWidth - 45, 25, 32, 32);
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.hidden = YES;
    _leftButton.frame = CGRectMake(13, 25, 32, 32);
    [_toptView addSubview:_leftButton];
}

-(void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    NSLog(@"%@ is dealloc", self.class);
}

@end
