//
//  EquipmentHealthController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "EquipmentHealthController.h"
#import "HACursor.h"
#import "UIView+Extension.h"
#import "HATestView.h"

@interface EquipmentHealthController () <PNChartDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *pageViews;

@end

@implementation EquipmentHealthController

- (void)manuallyProperties {
    [super initFrontProperties];
    
    
}


- (void)initUI {
    self.topTitle = @"设备健康度";
    self.dateListShow = YES;
    [self lineChart];
}

- (void)lineChart {
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    //不允许有重复的标题
    self.titles = @[@"综合指数列表",@"消防指数列表",@"安防指数列表",@"照明指数列表",@"楼控指数列表"];
    
    HACursor *cursor = [[HACursor alloc]init];
    cursor.frame = CGRectMake(0, 250, self.view.width, 40);
    cursor.titles = self.titles;
    cursor.pageViews = [self createPageViews];
    //设置根滚动视图的高度
    cursor.rootScrollViewHeight = 200;
    
    //默认值是白色
    cursor.titleNormalColor = [UIColor lightGrayColor];
    //默认值是白色
    cursor.titleSelectedColor = RGB(41, 51, 63);
    //是否显示排序按钮
    cursor.showSortbutton = NO;
    //默认的最小值是5，小于默认值的话按默认值设置
    cursor.minFontSize = 11;
    //默认的最大值是25，小于默认值的话按默认值设置，大于默认值按设置的值处理
    cursor.maxFontSize = 5;
    //cursor.isGraduallyChangFont = NO;
    //在isGraduallyChangFont为NO的时候，isGraduallyChangColor不会有效果
    //cursor.isGraduallyChangColor = NO;
    [self.view addSubview:cursor];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
      // Do any additional setup after loading the view from its nib.
}

- (NSMutableArray *)createPageViews{
    NSMutableArray *pageViews = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titles.count; i++) {
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 300)];
        PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH , 180)];
        lineChart.yLabelFormat = @"%1.1f";
        lineChart.backgroundColor = [UIColor clearColor];
        [lineChart setXLabels:@[@"0", @"1", @"2",@"3", @"4",@"5", @"6",@"7", @"8",@"9", @"10",@"11", @"12",@"13", @"14",@"15", @"16",@"17", @"18",@"19", @"20",@"21", @"22",@"23", @"24",]];
//        [lineChart setXLabels:@[ @"1", @"2",@"3"]];
        lineChart.showCoordinateAxis = YES;
        
        // added an examle to show how yGridLines can be enabled
        // the color is set to clearColor so that the demo remains the same
        lineChart.yGridLinesColor = [UIColor clearColor];
        lineChart.showYGridLines = YES;
        
        //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
        //Only if you needed
        lineChart.yFixedValueMax = 100.0;
        lineChart.yFixedValueMin = 0.0;
        
        [lineChart setYLabels:@[@"0",
                                @"10",
                                @"20",
                                @"30",
                                @"40",
                                @"50",
                                @"60",
                                @"70", @"80", @"90", @"100"
                                ]
         ];
        
        // Line Chart #1
        NSArray * data01Array = @[@10.1, @20.2, @15.3, @19.1, @20.2, @30.3, @17.4];
        PNLineChartData *data01 = [PNLineChartData new];
        data01.dataTitle = @"Alpha";
        data01.color = PNFreshGreen;
        data01.alpha = 0.3f;
        data01.itemCount = data01Array.count;
        data01.inflexionPointColor = PNRed;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
//        // Line Chart #2
//        NSArray * data02Array = @[@0.0, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
//        PNLineChartData *data02 = [PNLineChartData new];
//        data02.dataTitle = @"Beta";
//        data02.color = PNTwitterColor;
//        data02.alpha = 0.5f;
//        data02.itemCount = data02Array.count;
//        data02.inflexionPointStyle = PNLineChartPointStyleCircle;
//        data02.getData = ^(NSUInteger index) {
//            CGFloat yValue = [data02Array[index] floatValue];
//            return [PNLineChartDataItem dataItemWithY:yValue];
//        };
        
        lineChart.chartData = @[data01];
        [lineChart strokeChart];
        lineChart.delegate = self;
        [view addSubview:lineChart];
        //        [pageViews addObject:lineChart];
        //    [self.view addSubview:lineChart];
        
        lineChart.legendStyle = PNLegendItemStyleStacked;
        lineChart.legendFont = [UIFont boldSystemFontOfSize:5.0f];
        lineChart.legendFontColor = [UIColor redColor];
        
        UIView *legend = [lineChart getLegendWithMaxWidth:320];
        [legend setFrame:CGRectMake(30, 340, legend.frame.size.width, legend.frame.size.width)];
        [view addSubview:legend];
        [pageViews addObject:view];
    }
    return pageViews;
}


- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex {
    NSLog(@"%ld",lineIndex);
}

- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex {
    
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
