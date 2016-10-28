//
//  PropertySecurityController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "PropertySecurityController.h"
#import "DoubleSlidingContainer.h"

#import "MaxMinView.h"


@interface PropertySecurityController ()<SCChartDataSource>


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



@end

@implementation PropertySecurityController

- (void)manuallyProperties {
    [super initFrontProperties];
    _chartArr = [NSMutableArray arrayWithCapacity:0];
    _yValuesArr = [NSMutableArray arrayWithCapacity:0];
    //不允许有重复的标题
    self.titles = @[@"综合安全度",@"消防类安全度",@"安防类安全度"];
}
- (void)initUI {
    self.topTitle = @"物业安全度";
    self.dateListShow = YES;
    [self setCursor];
}

- (void)setCursor {
    DoubleSlidingContainer *doubleSlidingContainer = [[DoubleSlidingContainer alloc] init];
    [doubleSlidingContainer setFrame:CGRectMake(0, 250, fDeviceWidth, 280)];
    doubleSlidingContainer.titleArr = self.titles;
    doubleSlidingContainer.contentArr = [self creatSubViews];
    
    [self.view addSubview:doubleSlidingContainer];
     
}

- (NSMutableArray *)creatSubViews{
    NSMutableArray *pageViews = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titles.count; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 235)];
        SCChart *chartView = [[SCChart alloc] initwithSCChartDataFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width- 10, 185)
                                                            withSource:self
                                                             withStyle:SCChartLineStyle];
        chartView.backgroundColor = [UIColor clearColor];
        chartView.tag = 100 + i;
        [chartView showInView:view];
        
        
        MaxMinView *maxMinView  = [[MaxMinView alloc] init];
        [maxMinView setFrame:CGRectMake(fDeviceWidth * 0.05, 190, fDeviceWidth * 0.9, 40)];
        maxMinView.backgroundColor = RGB(230, 230, 230);
        
        [view addSubview:maxMinView];
        
        [pageViews addObject:view];
    }
    [_chartArr addObjectsFromArray:pageViews];
    
    return pageViews;
}



- (NSArray *)getXTitles:(int)num {
    return _xData.count > 0 ? _xData :nil;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)SCChart_xLableArray:(SCChart *)chart {
    return [self getXTitles:24];
}

//数值多重数组
- (NSArray *)SCChart_yValueArray:(SCChart *)chart {
    
    NSMutableArray *ary = [NSMutableArray array];
    
    if (_yValuesArr.count > 0) {
        for (NSNumber *i in _yValuesArr[chart.tag - 100]) {
            [ary addObject:[NSString stringWithFormat:@"%@", i]];
        }
    }
    
    
    return ary.count > 0 ? @[ary] : nil;
    
}

#pragma mark - @optional
//颜色数组
- (NSArray *)SCChart_ColorArray:(SCChart *)chart {
    return @[SCBlue,SCRed,SCGreen];
}

#pragma mark 折线图专享功能
//标记数值区域
- (CGRange)SCChartMarkRangeInLineChart:(SCChart *)chart {
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)SCChart:(SCChart *)chart ShowHorizonLineAtIndex:(NSInteger)index {
    return YES;
}

//判断显示最大最小值
- (BOOL)SCChart:(SCChart *)chart ShowMaxMinAtIndex:(NSInteger)index {
    return NO;
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
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forSafetyData"];
    
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
    _yValuesArr = @[result[@"generalArr"],result[@"alarmArr"],result[@"securityArr"]].mutableCopy;
    _xData = result[@"xDate"];
    for (UIView *view in _chartArr) {
        SCChart *chartView = view.subviews[0];
        [chartView strokeChart];
    }
    
    _sortInC.text = [NSString stringWithFormat:@"%@", result[@"rank"]];
    _health.text = [NSString stringWithFormat:@"%@",result[@"realHealth"]];
    _questions.text = [NSString stringWithFormat:@"%@",result[@"generalFaultCount"]];
    _healthGrade.text = [NSString stringWithFormat:@"%@",result[@"grade"]];
    [_gradeColor setImage:[UIImage imageNamed:[NSString stringWithFormat:@"nhfx_color%@",result[@"grade"]]]];
    
    _downDataArr = @[
                     @{
                         @"Max":[NSString stringWithFormat:@"%@",result[@"generalMax"]],
                         @"Min":[NSString stringWithFormat:@"%@",result[@"generalMin"]],
                         @"Avg":[NSString stringWithFormat:@"%@",result[@"generalAvg"]],
                         },
                     @{
                         @"Max":[NSString stringWithFormat:@"%@",result[@"alarmMax"]],
                         @"Min":[NSString stringWithFormat:@"%@",result[@"alarmMin"]],
                         @"Avg":[NSString stringWithFormat:@"%@",result[@"alarmAvg"]],
                         
                         },
                     @{
                         @"Max":[NSString stringWithFormat:@"%@",result[@"securityMax"]],
                         @"Min":[NSString stringWithFormat:@"%@",result[@"securityMin"]],
                         @"Avg":[NSString stringWithFormat:@"%@",result[@"securityAvg"]],
                    
                         },
                     ];
    
    for (NSInteger i = 0; i < _chartArr.count ; i ++) {
        UIView *vi = _chartArr[i];
        MaxMinView *chartView = vi.subviews[1];
        chartView.countDic = _downDataArr[i];
    }
    
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
