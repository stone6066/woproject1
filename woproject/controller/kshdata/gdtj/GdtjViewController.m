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

@interface GdtjViewController () 
@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic) PNCircleChart * circleChart;
@property (nonatomic) PNCircleChart * circleChart1;
@property (nonatomic) PNCircleChart * circleChart2;

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
        _backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 108, UISCREENWIDTH, UISCREENHEIGHT - 108)];
        _backScrollV.contentSize =CGSizeMake(0, 600);
        _backScrollV.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_backScrollV];
    }
    return _backScrollV;
}

#pragma mark -
#pragma mark 环图

- (PNCircleChart *)circleChart {
    if (!_circleChart) {
        
        _circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0,37.0, SCREEN_WIDTH, 140.0)
                                                          total:@10
                                                        current:@0
                                                      clockwise:YES] ;
        _circleChart.backgroundColor = [UIColor clearColor];
        
        [_circleChart setStrokeColor:[UIColor clearColor]];

        [_circleChart setStrokeColorGradientStart:[UIColor blueColor]];
//        [_circleChart strokeChart];
        
        [self.backScrollV addSubview:_circleChart];
       
    }
    return _circleChart;
}

- (PNCircleChart *)circleChart1 {
    
    if (!_circleChart1) {
        
        _circleChart1 = [[PNCircleChart alloc] initWithFrame:CGRectMake(0,22.0, SCREEN_WIDTH, 170.0)
                                                      total:@10
                                                    current:@0
                                                              clockwise:YES];
        _circleChart1.backgroundColor = [UIColor clearColor];
        [_circleChart1 setStrokeColor:[UIColor clearColor]];

        [_circleChart1 setStrokeColorGradientStart:[UIColor brownColor]];
//        [_circleChart1 strokeChart];
        
        [self.backScrollV addSubview:_circleChart1];
        
    }
    return _circleChart1;
}

- (PNCircleChart *)circleChart2 {
    if (!_circleChart2) {
        
        _circleChart2 = [[PNCircleChart alloc] initWithFrame:CGRectMake(0,7.0, SCREEN_WIDTH, 200.0)
                                                      total:@10
                                                    current:@0
                                                  clockwise:YES];
        _circleChart2.backgroundColor = [UIColor clearColor];
        
        [_circleChart2 setStrokeColor:[UIColor clearColor]];
        [_circleChart2 setStrokeColorGradientStart:[UIColor greenColor]];
//        [_circleChart2 strokeChart];
        
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
            make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH, 50));
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
            make.width.equalTo(@(UISCREENWIDTH * 0.9));
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
        //       self.barChart.yLabels = @[@-10,@0,@10];
        //        [self.barChart setYValues:@[@10000.0,@30000.0,@10000.0,@100000.0,@500000.0,@1000000.0,@1150000.0,@2150000.0]];
        [self.barChart setYLabels:@[@0, @10,@20, @30,@40,@50]];
        
        [self.barChart setStrokeColors:@[RGB(10, 10, 10),RGB(33, 44, 55),RGB(66, 77, 88),RGB(99, 199, 23),RGB(64, 20, 222),RGB(100, 21, 177)]];
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
                            @"provinceId":@"",
                            @"cityId":@"",
                            @"projectId":@"",
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
    [_circleChart updateChartByCurrent:result[@"high"] byTotal:result[@"total"]];
    [_circleChart strokeChart];

    [_circleChart1 updateChartByCurrent:result[@"middle"] byTotal:result[@"total"]];
    [_circleChart1 strokeChart];

    [_circleChart2 updateChartByCurrent:result[@"low"] byTotal:result[@"total"]];
    [_circleChart2 strokeChart];
    
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
