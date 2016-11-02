//
//  QRVC.m
//  woproject
//
//  Created by 徐洋 on 16/10/16.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "QRVC.h"

@interface QRVC ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *msgLabel;

@end

@implementation QRVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    style.animationImage = [UIImage imageNamed:@"qrcode_scan_light_green"];
    self.style = style;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self initUI];
}

- (void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI
{
    WS(weakSelf);
    _titleLabel = [UILabel new];
    _titleLabel.font = k_text_font(18);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"扫描二维码";
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@100);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    [self.view bringSubviewToFront:self.titleLabel];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 27, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [self.view addSubview:backimg];
    
    UILabel *hintLbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 29, 30, 20)];
    hintLbl.text=@"返回";
    [hintLbl setFont:[UIFont systemFontOfSize:14]];
    [hintLbl setTextAlignment:NSTextAlignmentCenter];
    [hintLbl setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:hintLbl];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    _msgLabel = [UILabel new];
    _msgLabel.font = k_text_font(14);
    _msgLabel.textColor = [UIColor whiteColor];
    _msgLabel.text = @"将二维码置于矩形方框内\n系统将会自动识别";
    _msgLabel.numberOfLines = 0;
    _msgLabel.textAlignment = 1;
    [self.view addSubview:_msgLabel];
    _msgLabel.frame = CGRectMake(0, fDeviceWidth + 80, fDeviceWidth, 60);
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    
    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //震动提醒
    [LBXScanWrapper systemVibrate];
    //声音提醒
    [LBXScanWrapper systemSound];
    
    
    [self showNextVCWithScanResult:scanResult];
    
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"识别失败" preferredStyle:UIAlertControllerStyleAlert];
    __weak __typeof(self) weakSelf = self;
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [weakSelf reStartDevice];
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    [self.scanObj stopScan];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"1" message:@"2" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self reStartDevice];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
