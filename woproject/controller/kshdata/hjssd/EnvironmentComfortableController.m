//
//  EnvironmentComfortableController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "EnvironmentComfortableController.h"
#import "MaxMinView.h"

#import "TTLineChartView.h"
#import "TTHistoryDataObject.h"


@interface EnvironmentComfortableController ()

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
@property (strong, nonatomic) IBOutlet UILabel *healthGrade;
@property (strong, nonatomic) IBOutlet UIImageView *gradeColor;

@property (nonatomic, strong) UIScrollView *backScroll;
@property (nonatomic, strong) UILabel *titleO;





@end

@implementation EnvironmentComfortableController


- (void)manuallyProperties {
    [super initFrontProperties];
    _chartArr = [NSMutableArray arrayWithCapacity:0];
    _yValuesArr = [NSMutableArray arrayWithCapacity:0];
    //不允许有重复的标题
    self.titles = @[@"环境舒适度"];
}
- (void)initUI {
    self.topTitle = @"环境舒适度";
    self.dateListShow = YES;
    [self backScroll];
    [self titleO];
    [self setCursor];
    
}

- (UILabel *)titleO {
    if (!_titleO) {
        _titleO = [[UILabel alloc] init];
        [_titleO setFrame:CGRectMake(15, 10, 200, 40)];
        [_backScroll addSubview:_titleO];
        NSString *str = @"环境舒适度";
        _titleO.attributedText = [MJYUtils attributeStr:str changePartStr:@"环境舒适度" withFont:18 andColor:RGB(0,0,0)];
        
    }
    return _titleO;
}
- (UIScrollView *)backScroll {
    if (!_backScroll) {
        _backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 228, fDeviceWidth, fDeviceHeight -228)];
        [self.view addSubview:_backScroll];
        _backScroll.contentSize = CGSizeMake(0, 570);
    }
    return _backScroll;
}

- (void)setCursor {
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH , 280)];
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
                            @"provinceId":@"",
                            @"cityId":@"",
                            @"projectId":@"",
                            @"dateType":self.dateStr
                            };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forComfortData"];
    
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
    _yValuesArr = @[result[@"indexArr"]].mutableCopy;
    _xData = result[@"xDate"];
    for (UIView *view in _chartArr) {
        SCChart *chartView = view.subviews[0];
        [chartView strokeChart];
    }
    
    _sortInC.text = [NSString stringWithFormat:@"%@", result[@"rank"]];
    _health.text = [NSString stringWithFormat:@"%@",result[@"index"]];
    _healthGrade.text = [NSString stringWithFormat:@"%@",result[@"grade"]];
    [_gradeColor setImage:[UIImage imageNamed:[NSString stringWithFormat:@"nhfx_color%@",result[@"grade"]]]];
    
    _downDataArr = @[
                     @{
                         @"Max":[NSString stringWithFormat:@"%@",result[@"comfortMax"]],
                         @"Min":[NSString stringWithFormat:@"%@",result[@"comfortMin"]],
                         @"Avg":[NSString stringWithFormat:@"%@",result[@"comfortAvg"]],
                         },
                     ];
    
    for (NSInteger i = 0; i < _chartArr.count ; i ++) {
        UIView *vi = _chartArr[i];
        MaxMinView *chartView = vi.subviews[1];
        chartView.countDic = _downDataArr[i];
    }
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
