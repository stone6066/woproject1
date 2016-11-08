//
//  EquipmentHealthController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "EquipmentHealthController.h"

#import "MaxMinView.h"
#import "DoubleSlidingContainer.h"
#import "TTLineChartView.h"
#import "TTHistoryDataObject.h"




@interface EquipmentHealthController () 
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, strong) NSMutableArray *yValuesArr;
@property (nonatomic, strong) NSMutableArray *chartArr;

@property (nonatomic, strong) NSArray *xData;
@property (nonatomic, strong) NSArray *downDataArr;

#pragma mark -
#pragma mark baseUI
@property (strong, nonatomic) IBOutlet UILabel *healthTitleLb;

@property (strong, nonatomic) IBOutlet UILabel *sortInC;
@property (strong, nonatomic) IBOutlet UILabel *health;
@property (strong, nonatomic) IBOutlet UILabel *questions;
@property (strong, nonatomic) IBOutlet UILabel *healthGrade;
@property (strong, nonatomic) IBOutlet UIImageView *gradeColor;


@end

@implementation EquipmentHealthController

- (void)manuallyProperties {
    [super initFrontProperties];
    _chartArr = [NSMutableArray arrayWithCapacity:0];
    _yValuesArr = [NSMutableArray arrayWithCapacity:0];
    //不允许有重复的标题
    self.titles = @[@"综合健康度",@"消防类健康度",@"安防类健康度",@"照明类健康度",@"楼控类健康度"];

}


- (void)initUI {
    self.topTitle = @"设备健康度";
    self.dateListShow = YES;
    [self setCursor];
}

- (void)setCursor {
    DoubleSlidingContainer *doubleSlidingContainer = [[DoubleSlidingContainer alloc] init];
    [doubleSlidingContainer setFrame:CGRectMake(0, 250, fDeviceWidth, 320)];
    doubleSlidingContainer.titleArr = self.titles;
    doubleSlidingContainer.contentArr = [self creatSubViews];

    [self.view addSubview:doubleSlidingContainer];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(dealwith:) name:@"lalalallalalalala" object:nil];

}
- (void)dealwith:(NSNotification *)noti {
    _healthTitleLb.text = [NSString stringWithFormat:@"%@:" ,noti.userInfo[@"content"] ];
}

- (NSMutableArray *)creatSubViews{
    NSMutableArray *pageViews = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titles.count; i++) {

        UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH , 320)];
        view.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
        TTLineChartView *lineChartView = [[TTLineChartView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 200)];
        lineChartView.showBackgroundView = YES;
        lineChartView.heightOffset = 34;
        lineChartView.widthOffset = 17.5;
        [view addSubview:lineChartView];
        lineChartView.tag = 100 + i;
        MaxMinView *maxMinView  = [[MaxMinView alloc] init];
        [maxMinView setFrame:CGRectMake(fDeviceWidth * 0.05, 230, fDeviceWidth * 0.9, 40)];
        maxMinView.backgroundColor = RGB(230, 230, 230);
        [view addSubview:maxMinView];
        
        [pageViews addObject:view];    }
    [_chartArr addObjectsFromArray:pageViews];

    return pageViews;
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
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forDeviceHealthData"];
    
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
    _yValuesArr = @[result[@"alarmArr"],result[@"automationArr"],result[@"generalArr"],result[@"lightingArr"],result[@"securityArr"]].mutableCopy;
    _xData = result[@"xDate"];
    for (int i = 0; i < 5; i++) {
        
        NSMutableArray *sourceData = [NSMutableArray array];
        
        [sourceData addObjectsFromArray:_yValuesArr[i]];
        
        NSMutableArray *historyData = [NSMutableArray array];
        for (int i = 0; i < sourceData.count; i++) {
            TTHistoryDataObject *obj = [[TTHistoryDataObject alloc] init];
            obj.displayX = [NSString stringWithFormat:@"%@", @(i)];
            obj.detailX = [NSString stringWithFormat:@"%@", sourceData[i]];
            obj.yValue = sourceData[i];
            obj.ring = i == 0 ? @0 : @((([sourceData[i] floatValue] - [sourceData[i - 1] floatValue]) / [sourceData[i - 1] floatValue]) * 100);
            [historyData addObject:obj];
        }
        
        TTLineChartView *lineChartView = [_chartArr[i] viewWithTag:100 + i];
        lineChartView.historyData = historyData;
        [lineChartView refreshUIWithElementData:sourceData];
        
        
    }

    
    _sortInC.text = [NSString stringWithFormat:@"%@", result[@"rank"]];
    _health.text = [NSString stringWithFormat:@"%@",result[@"realHealth"]];
    _questions.text = [NSString stringWithFormat:@"%@",result[@"generalFaultCount"]];
    _healthGrade.text = [NSString stringWithFormat:@"%@",result[@"grade"]];
    [_gradeColor setImage:[UIImage imageNamed:[NSString stringWithFormat:@"nhfx_color%@",result[@"grade"]]]];
    
    _downDataArr = @[
                            @{
                                @"Max":[NSString stringWithFormat:@"%@",result[@"alarmMax"]],
                                @"Min":[NSString stringWithFormat:@"%@",result[@"alarmMin"]],
                                @"Avg":[NSString stringWithFormat:@"%@",result[@"alarmAvg"]],
                                },
                            @{
                                @"Max":[NSString stringWithFormat:@"%@",result[@"automationMax"]],
                                @"Min":[NSString stringWithFormat:@"%@",result[@"automationMin"]],
                                @"Avg":[NSString stringWithFormat:@"%@",result[@"automationAvg"]],

                                },
                            @{
                                @"Max":[NSString stringWithFormat:@"%@",result[@"generalMax"]],
                                @"Min":[NSString stringWithFormat:@"%@",result[@"generalMin"]],
                                @"Avg":[NSString stringWithFormat:@"%@",result[@"generalAvg"]],

                                },
                            @{
                                @"Max":[NSString stringWithFormat:@"%@",result[@"lightingMax"]],
                                @"Min":[NSString stringWithFormat:@"%@",result[@"lightingMin"]],
                                @"Avg":[NSString stringWithFormat:@"%@",result[@"lightingAvg"]],

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
