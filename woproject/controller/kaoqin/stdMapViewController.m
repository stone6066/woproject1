//
//  stdMapViewController.m
//  woproject
//
//  Created by tianan-apple on 16/10/10.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "stdMapViewController.h"
#import "ReGeocodeAnnotation.h"
#import "PublicDefine.h"

@interface stdMapViewController ()
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, assign) BOOL isDragging;

@property (nonatomic, assign) BOOL isSearchFromDragging;
@property (nonatomic, strong) ReGeocodeAnnotation *annotation;

@property (nonatomic, assign) BOOL isFirstLocation;

@end

@implementation stdMapViewController

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
     {
        MAAnnotationView *view = views[0];
        
        // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
        if ([view.annotation isKindOfClass:[MAUserLocation class]])
        {
            MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
            pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
            pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
            pre.image = [UIImage imageNamed:@"userPosition"];
            pre.lineWidth = 3;
            //        pre.lineDashPattern = @[@6, @3];
            
            [self.mapView updateUserLocationRepresentation:pre];
            
            view.calloutOffset = CGPointMake(0, 0);
            view.canShowCallout = NO;
            self.userLocationAnnotationView = view;
            
        }

    }
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation && self.userLocationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
            NSLog(@"经纬度：%f,%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
            if (_isFirstLocation){
            _isFirstLocation=NO;
            [self searchReGeocodeWithCoordinate:userLocation.coordinate];
            }
        }];
    }
    
}

- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}
#pragma mark - AMapSearchDelegate

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil && _isSearchFromDragging == NO)
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        ReGeocodeAnnotation *reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate
                                                                                         reGeocode:response.regeocode];
        
        [self.mapView addAnnotation:reGeocodeAnnotation];
        [self.mapView selectAnnotation:reGeocodeAnnotation animated:YES];
    }
    else /* from drag search, update address */
    {
        [self.annotation setAMapReGeocode:response.regeocode];
        [self.mapView selectAnnotation:self.annotation animated:YES];
    }
}

#pragma mark - Override

- (void)returnAction
{
    [super returnAction];
    
    self.mapView.userTrackingMode = MAUserTrackingModeNone;
}

#pragma mark - Life Cycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [self.mapView setZoomLevel:16.1 animated:YES];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    _isFirstLocation=YES;
}


-(NSString*)weekdayStringFromDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    NSDate *indate=[dateFormatter dateFromString:dateString];
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:indate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}



+(NSString*)getDateString{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

-(void)drawBtnView{
    CGFloat VcY=self.mapView.frame.origin.y+self.mapView.frame.size.height+10;
    UIView * timeVc=[[UIView alloc]initWithFrame:CGRectMake(0, VcY, fDeviceWidth, 150)];
    [self.view addSubview:timeVc];
    UILabel * dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, fDeviceWidth-10, 30)];
    dateLbl.text=[self weekdayStringFromDate];
    [self.view addSubview:dateLbl];
    [dateLbl setFont:[UIFont systemFontOfSize:18]];
    [dateLbl setTextAlignment:NSTextAlignmentCenter];
    [dateLbl setTextColor:[UIColor blackColor]];
    
    

    

}
@end
