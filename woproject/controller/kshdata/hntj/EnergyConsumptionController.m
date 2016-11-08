//
//  EnergyConsumptionController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "EnergyConsumptionController.h"

#import "MaxMinView.h"
#import "LoopProgressSetView.h"
#import "AnalysisView.h"


#import "TTLineChartView.h"
#import "TTHistoryDataObject.h"

@interface EnergyConsumptionController ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, strong) NSMutableArray *yValuesArr;
@property (nonatomic, strong) NSMutableArray *chartArr;

@property (nonatomic, strong) NSArray *xData;
@property (nonatomic, strong) NSArray *downDataArr;

#pragma mark -
#pragma mark baseUI

@property (strong, nonatomic) IBOutlet UILabel *sortInC;
@property (strong, nonatomic) IBOutlet UILabel *health;
@property (strong, nonatomic) IBOutlet UILabel *questions;

@property (strong, nonatomic) IBOutlet UILabel *healthGrade;
@property (strong, nonatomic) IBOutlet UIImageView *gradeColor;

@property (nonatomic, strong) UIScrollView *backScroll;

@property (nonatomic, strong) UILabel *titleO;
@property (nonatomic, strong) UILabel *titleT;

//@property (nonatomic, strong)  *semiCircleChart;
@property (nonatomic, strong) LoopProgressSetView *looprogressView;
@property (nonatomic, strong) UILabel *startL;
@property (nonatomic, strong) UILabel *endL;
@property (nonatomic, strong) AnalysisView *analysisView;


@property (nonatomic, strong) NSDictionary *tempDic;

@end

@implementation EnergyConsumptionController

- (void)manuallyProperties {
    [super initFrontProperties];
    _chartArr = [NSMutableArray arrayWithCapacity:0];
    _yValuesArr = [NSMutableArray arrayWithCapacity:0];
    //不允许有重复的标题
    self.titles = @[@"累计减排量(tCO₂e)"];
}
- (void)initUI {
    self.topTitle = @"能耗分析";
    self.dateListShow = YES;
    [self backScroll];
    [self titleO];
    
    [self titleT];
    [self setCursor];

    [self startL];
    [self endL];
    [self analysisView];
}
- (AnalysisView *)analysisView {
    
    if (!_analysisView) {
        _analysisView = [[AnalysisView alloc] initWithFrame:CGRectMake(0, 240, fDeviceWidth, 70)];
        [_backScroll addSubview:_analysisView];
    }
    
    return _analysisView;
}

- (UILabel *)titleO {
    if (!_titleO) {
        _titleO = [[UILabel alloc] init];
        [_titleO setFrame:CGRectMake(15, 0, 200, 40)];
        [_backScroll addSubview:_titleO];
        NSString *str = @"总能耗占比(kcge)";
       _titleO.attributedText = [MJYUtils attributeStr:str changePartStr:@"总能耗占比" withFont:18 andColor:RGB(0,0,0)];
        
    }
    return _titleO;
}


- (void)pieChart:(id)result {
    
    _tempDic = result;
    NSLog(@"%@", result);

    [self looprogressView];
    
//
//    NSMutableArray *data = [NSMutableArray arrayWithObjects:
//                            [[HUChartEntry alloc]initWithName:@"" value:result[@"havc"]],
//                            [[HUChartEntry alloc]initWithName:@"" value:result[@"light"]],
//                            [[HUChartEntry alloc]initWithName:@"" value:result[@"work"]],
//                            [[HUChartEntry alloc]initWithName:@"" value:result[@"other"]],
//                            
//                            nil];
//
//    
//    if (_semiCircleChart) {
//        [_semiCircleChart setData:data];
//        //    semiCircleChart.showPortionTextType = SHOW_PORTION_VALUE;
//        //    semiCircleChart.showPortionTextType = DONT_SHOW_PORTION;
//        [_semiCircleChart setTitle:[NSString stringWithFormat:@"%@kcge",result[@"totalCost"]]];
//        _semiCircleChart.showPortionTextType = DONT_SHOW_PORTION;
//
//    } else {
//        _semiCircleChart = [[HUSemiCircleChart alloc]
//                            initWithFrame:frame];
//        _semiCircleChart.backgroundColor = [UIColor clearColor];
//        
//        //colors maybe not setup, will be generated automatically
//        
//        
//        NSMutableArray *colors = [NSMutableArray arrayWithObjects:  color1, color2,
//                                  color3, color4,
//                                  nil];
//        [_semiCircleChart setColors:colors];
//        [_semiCircleChart setData:data];
//        //    semiCircleChart.showPortionTextType = SHOW_PORTION_VALUE;
//        //    semiCircleChart.showPortionTextType = DONT_SHOW_PORTION;
//        _semiCircleChart.showPortionTextType = DONT_SHOW_PORTION;
//        
//        [_backScroll addSubview:_semiCircleChart];
//    }
//    
}

- (LoopProgressSetView *)looprogressView {
    if (!_looprogressView) {
        CGRect frame = CGRectMake((fDeviceWidth - 200 ) /2, 40, 200, 200);
        _looprogressView = [[LoopProgressSetView alloc] initWithFrame:frame];
        [self.backScroll addSubview:_looprogressView];
        
        _looprogressView.titleContent =_tempDic[@"totalCost"];

        _looprogressView.contentArr =@[_tempDic[@"havc"], _tempDic[@"light"],_tempDic[@"work"], _tempDic[@"other"]] ;
    }
    return _looprogressView;
}

- (UILabel *)titleT {
    if (!_titleT) {
        _titleT = [[UILabel alloc] init];
        [_titleT setFrame:CGRectMake(15, 310, 200, 40)];
        [_backScroll addSubview:_titleT];
        NSString *str = @"累计减排量(tCO₂e)";
        _titleT.attributedText = [MJYUtils attributeStr:str changePartStr:@"累计减排量" withFont:18 andColor:RGB(0,0,0)];
        
    }
    return _titleT;
}
- (UILabel *)startL {
    if (!_startL) {
        _startL = [[UILabel alloc] init];
        [_startL setFrame:CGRectMake((fDeviceWidth - 200 ) /2 + 25, 220, 20, 20)];
        [_backScroll addSubview:_startL];
        _startL.text = @"0";
        _startL.textColor = [UIColor lightGrayColor];

    }
    return _startL;
}

- (UILabel *)endL {
    if (!_endL) {
        _endL = [[UILabel alloc] init];
        [_endL setFrame:CGRectMake((fDeviceWidth - 200 ) /2 + 150, 220, 30, 20)];
        [_backScroll addSubview:_endL];
        _endL.text = @"100";
        _endL.textColor = [UIColor lightGrayColor];
        
    }
    return _endL;
}
- (UIScrollView *)backScroll {
    if (!_backScroll) {
        _backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 228, fDeviceWidth, fDeviceHeight -228)];
        [self.view addSubview:_backScroll];
        _backScroll.contentSize = CGSizeMake(0, 620);
    }
    return _backScroll;
}



- (void)setCursor {
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 340, SCREEN_WIDTH , 280)];
    view.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
    
    TTLineChartView *lineChartView = [[TTLineChartView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 200)];
    lineChartView.showBackgroundView = YES;
    lineChartView.heightOffset = 34;
    lineChartView.widthOffset = 17.5;
    [view addSubview:lineChartView];
    
    lineChartView.tag = 100;
    
    MaxMinView *maxMinView  = [[MaxMinView alloc] init];
    [maxMinView setFrame:CGRectMake(fDeviceWidth * 0.05, 220, fDeviceWidth * 0.9, 40)];
    maxMinView.backgroundColor = RGB(230, 230, 230);
    [view addSubview:maxMinView];
    [_backScroll addSubview:view];

}








#pragma mark -
#pragma mark 网络请求

- (void)gsHandleData{
    
    NSDictionary *param = @{
                            @"uid":ApplicationDelegate.myLoginInfo.Id,
                            @"ukey":ApplicationDelegate.myLoginInfo.ukey,
                            @"provinceId":self.provinceIdStr,
                            @"cityId":self.cityIdStr,
                            @"projectId":self.projectIdStr,
                            @"dateType":self.dateStr
                            };

    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forEnergyData"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    WS(weakSelf);
    
    [GSHttpManager httpManagerPostParameter:param toHttpUrlStr:urlstr  success:^(id result) {
        //        NSLog(@"%@", result);
        
        [SVProgressHUD dismiss];
        
        [weakSelf endDealWith:result];
        
    } orFail:^(NSError *error) {
        
    }];
}
#pragma mark -
#pragma mark 数据处理

- (void)endDealWith:(id)result {
    
    if (_yValuesArr.count > 0) {
        [_yValuesArr removeAllObjects];
    }
    _yValuesArr = @[result[@"cerArr"]].mutableCopy;
    _xData = result[@"xDate"];
    for (UIView *view in _chartArr) {
        SCChart *chartView = view.subviews[0];
        [chartView strokeChart];
    }
    
    _sortInC.text = [NSString stringWithFormat:@"%@", result[@"rank"]];
    _health.text = [NSString stringWithFormat:@"%@",result[@"unitCost"]];
    _questions.text = [NSString stringWithFormat:@"%@",result[@"totalCer"]];
    _healthGrade.text = [NSString stringWithFormat:@"%@",result[@"grade"]];
    [_gradeColor setImage:[UIImage imageNamed:[NSString stringWithFormat:@"nhfx_color%@",result[@"grade"]]]];
    
    _downDataArr = @[
                     @{
                         @"Max":[NSString stringWithFormat:@"%@",result[@"maxCer"]],
                         @"Min":[NSString stringWithFormat:@"%@",result[@"minCer"]],
                         @"Avg":[NSString stringWithFormat:@"%@",result[@"avgCer"]],
                         },
                     ];
    
    for (NSInteger i = 0; i < _chartArr.count ; i ++) {
        UIView *vi = _chartArr[i];
        MaxMinView *chartView = vi.subviews[1];
        chartView.countDic = _downDataArr[i];
    }
    [self pieChart:result];
   
    [_analysisView createSingleViewWith:@[
                                                        @{@"color":RGB(45, 169, 243), @"name":@"暖通",@"zhanbi":[NSString stringWithFormat:@"%@",result[@"havcPer"]],@"count":[NSString stringWithFormat:@"%@",result[@"havc"]]},
                                                        @{@"color":RGB(78, 210, 143), @"name":@"照明",@"zhanbi":[NSString stringWithFormat:@"%@",result[@"lightPer"]],@"count":[NSString stringWithFormat:@"%@",result[@"light"]]},
                                                        @{@"color":RGB(244, 193, 65), @"name":@"办公",@"zhanbi":[NSString stringWithFormat:@"%@",result[@"workPer"]],@"count":[NSString stringWithFormat:@"%@",result[@"work"]]},
                                                        @{@"color":RGB(222, 227, 234), @"name":@"其他",@"zhanbi":[NSString stringWithFormat:@"%@",result[@"otherPer"]],@"count":[NSString stringWithFormat:@"%@",result[@"other"]]}
                                                        ]];
    NSMutableArray *sourceData = [NSMutableArray array];
    NSInteger count = 25;
    for (int i = 0; i < count; i++) {
        [sourceData addObject:_yValuesArr[0][i]];
    }
    NSMutableArray *historyData = [NSMutableArray array];
    for (int i = 0; i < sourceData.count; i++) {
        TTHistoryDataObject *obj = [[TTHistoryDataObject alloc] init];
        obj.displayX = [NSString stringWithFormat:@"%@", @(i)];
        obj.detailX = [NSString stringWithFormat:@"%@", sourceData[i]];
        obj.yValue = sourceData[i];
        obj.ring = i == 0 ? @0 : @((([sourceData[i] floatValue] - [sourceData[i - 1] floatValue]) / [sourceData[i - 1] floatValue]) * 100);
        [historyData addObject:obj];
    }
    
    TTLineChartView *lineChartView = [_backScroll viewWithTag:100];
    lineChartView.historyData = historyData;
    [lineChartView refreshUIWithElementData:sourceData];
    

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
