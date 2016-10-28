//
//  GdtjViewController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "GdtjViewController.h"
#import "CircleAnnotationView.h"
#import "ProgressbarSetView.h"
#import "PNChartDelegate.h"
#import "PNChart.h"

@interface GdtjViewController () <PNChartDelegate>

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic) SCCircleChart * circleChart;
@property (nonatomic) SCCircleChart * circleChart1;
@property (nonatomic) SCCircleChart * circleChart2;

@property (nonatomic, strong) UILabel *gdTilte;
@property (nonatomic, strong) UILabel *gdallCount;

@property (nonatomic, strong) CircleAnnotationView *annotationView;
@property (nonatomic, strong) ProgressbarSetView *progressbarSetView;

@property (nonatomic, strong) UILabel *eachListCount;


@property (nonatomic) PNBarChart * barChart;



@end

@implementation GdtjViewController


- (void)manuallyProperties {
    [super initFrontProperties];

}



- (void)initUI {
    self.topTitle = @"工单统计";
    self.dateListShow = YES;
    [self backScrollV];
    
    [self circleChart];
    [self circleChart1];
    [self circleChart2];
    
    [self gdTilte];
    
    [self gdallCount];

    [self annotationView];
    [self progressbarSetView];
    [self eachListCount];
    [self barChart];

}



- (UIScrollView *)backScrollV {
    if (!_backScrollV) {
        _backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 108, fDeviceWidth, fDeviceHeight - 108)];
        _backScrollV.contentSize =CGSizeMake(0, 650);
        _backScrollV.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_backScrollV];
    }
    return _backScrollV;
}

#pragma mark -
#pragma mark 环图

- (SCCircleChart *)circleChart {
    if (!_circleChart) {
        
        _circleChart = [[SCCircleChart alloc] initWithFrame:CGRectMake(0,37.0, SCREEN_WIDTH, 140.0)
                                                          total:@10
                                                        current:@0
                                                      clockwise:YES color:RGB(190, 190, 190)]  ;
        _circleChart.backgroundColor = [UIColor clearColor];
        
        [_circleChart setStrokeColor:[UIColor clearColor]];

        [_circleChart setStrokeColorGradientStart:[UIColor blueColor]];
        
        [_circleChart strokeChart];
        
        [self.backScrollV addSubview:_circleChart];
       
    }
    return _circleChart;
}

- (SCCircleChart *)circleChart1 {
    
    if (!_circleChart1) {
        
        _circleChart1 = [[SCCircleChart alloc] initWithFrame:CGRectMake(0,22.0, SCREEN_WIDTH, 170.0)
                                                      total:@10
                                                    current:@0
                                                              clockwise:YES color:RGB(210, 210  , 210)];
        _circleChart1.backgroundColor = [UIColor clearColor];
        [_circleChart1 setStrokeColor:[UIColor clearColor]];

        [_circleChart1 setStrokeColorGradientStart:[UIColor brownColor]];
        [_circleChart1 strokeChart];
        
        [self.backScrollV addSubview:_circleChart1];
        
    }
    return _circleChart1;
}

- (SCCircleChart *)circleChart2 {
    if (!_circleChart2) {
        
        _circleChart2 = [[SCCircleChart alloc] initWithFrame:CGRectMake(0,7.0, SCREEN_WIDTH, 200.0)
                                                      total:@10
                                                    current:@0
                                                  clockwise:YES color:RGB(230, 230, 230)];
        _circleChart2.backgroundColor = [UIColor clearColor];
        
        [_circleChart2 setStrokeColor:[UIColor clearColor]];
        
        [_circleChart2 setStrokeColorGradientStart:[UIColor greenColor]];
        
        [_circleChart2 strokeChart];
        
        [self.backScrollV addSubview:_circleChart2];
        
    }
    return _circleChart2;
}

- (UILabel *)gdTilte {
 
    if (!_gdTilte) {
        _gdTilte = [[UILabel alloc] init];
        [_backScrollV addSubview:_gdTilte];
        [_gdTilte mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backScrollV);
            make.top.equalTo(self.backScrollV).offset(90);
        }];
        _gdTilte.textAlignment = 1;
        _gdTilte.text = @"今日工单总数";
        _gdTilte.font = [UIFont systemFontOfSize:13.0];
        _gdTilte.textColor = RGB(80, 80, 80);
    }
    
    return _gdTilte;
}

- (UILabel *)gdallCount {
    if (!_gdallCount) {
        _gdallCount = [[UILabel alloc] init];
        [_backScrollV addSubview:_gdallCount];
        [_gdallCount mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backScrollV);
            make.top.equalTo(_gdTilte.mas_bottom).offset(8);
        }];
        _gdallCount.textAlignment = 1;
        
        _gdallCount.font = [UIFont boldSystemFontOfSize: 25.0];
        
    }
    return _gdallCount;
}

- (CircleAnnotationView *)annotationView {
    if (!_annotationView) {
        _annotationView = [[CircleAnnotationView alloc] init];
        [_backScrollV addSubview:_annotationView];
        [_annotationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_circleChart2.mas_bottom).offset(8);
            make.centerX.equalTo(_backScrollV);
            make.size.mas_equalTo(CGSizeMake(fDeviceWidth, 50));
        }];
        
        
    }
    return _annotationView;
}


- (ProgressbarSetView *)progressbarSetView {
    
    if (!_progressbarSetView) {
        _progressbarSetView = [[ProgressbarSetView alloc] init];
        [_backScrollV addSubview:_progressbarSetView];
        [_progressbarSetView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_annotationView.mas_bottom).offset(8);
            make.centerX.equalTo(_backScrollV);
            make.height.equalTo(@66);
            make.width.equalTo(@(fDeviceWidth * 0.9));
        }];
        _progressbarSetView.backgroundColor = RGB(230, 230, 230);
        

    }
    
    return _progressbarSetView;
    
}

- (UILabel *)eachListCount {
    if (!_eachListCount) {
        _eachListCount  = [[UILabel alloc] init];
        [_backScrollV addSubview:_eachListCount];
        [_eachListCount mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_progressbarSetView.mas_bottom).offset(20);
            make.left.equalTo(_backScrollV).offset(20);
        }];
        _eachListCount.text=@"各工种工单数";
        _eachListCount.font = [UIFont systemFontOfSize:15];
    }
    return _eachListCount;
}



#pragma mark - 
#pragma mark 柱图

#pragma mark -
#pragma mark 柱图
    - (PNBarChart *)barChart {
        if (!_barChart) {
            static NSNumberFormatter *barChartFormatter;
            if (!barChartFormatter){
                barChartFormatter = [[NSNumberFormatter alloc] init];
                barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
                barChartFormatter.allowsFloats = NO;
                barChartFormatter.maximumFractionDigits = 0;
            }
            
            self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(8, 400, SCREEN_WIDTH -16, 200.0)];
            //        self.barChart.showLabel = NO;
            self.barChart.backgroundColor = [UIColor clearColor];
            self.barChart.yLabelFormatter = ^(CGFloat yValue){
                return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
            };
            
            self.barChart.yChartLabelWidth = 20.0;
            self.barChart.chartMarginLeft = 30.0;
            self.barChart.chartMarginRight = 10.0;
            self.barChart.chartMarginTop = 5.0;
            self.barChart.chartMarginBottom = 10.0;
            
            
            self.barChart.labelMarginTop = 5.0;
            self.barChart.showChartBorder = YES;
            [self.barChart setXLabels:@[@"暖通",@"强电",@"弱电",@"水工",@"综合",@"其他"]];
                 
            [self.barChart setStrokeColors:@[[UIColor blueColor],[UIColor purpleColor],[UIColor greenColor],[UIColor yellowColor],[UIColor orangeColor],[UIColor cyanColor]]];
            self.barChart.isGradientShow = NO;
            self.barChart.isShowNumbers = YES;
            
            [self.barChart strokeChart];
            
            self.barChart.delegate = self;
            
            
            [self.backScrollV addSubview:self.barChart];
            
        }
        return _barChart;
    }









#pragma mark -
#pragma mark 网络请求

- (void)gsHandleData{
    
    NSDictionary *param = @{
                            @"uid":ApplicationDelegate.myLoginInfo.Id,
                            @"ukey":ApplicationDelegate.myLoginInfo.ukey,
                            @"provinceId":self.projectIdStr,
                            @"cityId":self.cityIdStr,
                            @"projectId":self.provinceIdStr,
                            @"dateType":self.dateStr
                            };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forTicketCount"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    WS(weakSelf);

    [GSHttpManager httpManagerPostParameter:param toHttpUrlStr:urlstr  success:^(id result) {
        NSLog(@"%@", result);
        
        [SVProgressHUD dismiss];
        
        [weakSelf endDealWith:result];
        
    } orFail:^(NSError *error) {
        
    }];
}
#pragma mark -
#pragma mark 数据处理 

- (void)endDealWith:(id)result {
    NSNumber *num = nil;
    if ([result[@"total"] isEqualToNumber:@0] ) {
        num = @100;
    } else {
        num = result[@"total"];
    }
    
    
    [_circleChart updateChartByCurrent:result[@"high"] byTotal:num];

    [_circleChart1 updateChartByCurrent:result[@"middle"] byTotal:num];

    [_circleChart2 updateChartByCurrent:result[@"low"] byTotal:num];
    
    _gdallCount.text = [NSString stringWithFormat:@"%@", result[@"total"]];
    
    _annotationView.countArr =@[[NSString stringWithFormat:@"%@", result[@"high"]],[NSString stringWithFormat:@"%@", result[@"middle"]], [NSString stringWithFormat:@"%@", result[@"low"]]];
    
    _progressbarSetView.countArr =@[[NSString stringWithFormat:@"%@", result[@"notRepair"]],[NSString stringWithFormat:@"%@", result[@"unFinish"]], [NSString stringWithFormat:@"%@", result[@"completed"]]];
    
    
     [_barChart updateChartData:@[result[@"hv"],result[@"se"],result[@"le"],result[@"ww"],result[@"syn"],result[@"other"]]];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
