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
#import "stdPubFunc.h"

@interface stdMapViewController ()
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, assign) BOOL isDragging;

@property (nonatomic, assign) BOOL isSearchFromDragging;
@property (nonatomic, strong) ReGeocodeAnnotation *annotation;

@property (nonatomic, assign) BOOL isFirstLocation;
@property(nonatomic,copy)NSString *longitudeStr;
@property(nonatomic,copy)NSString *latitudeStr;
@property(nonatomic,copy)NSString *locationStr;

@end

@implementation stdMapViewController


- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
     {
        MAAnnotationView *view = views[0];
        
        // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
        if ([view.annotation isKindOfClass:[MAUserLocation class]])
        {
//            MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
//            pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
//            pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
//            pre.image = [UIImage imageNamed:@"userPosition"];
//            pre.lineWidth = 3;
//            
//            
//            [self.mapView updateUserLocationRepresentation:pre];
            
            _longitudeStr=[NSString stringWithFormat:@"%f",self.mapView.userLocation.coordinate.longitude];
            _latitudeStr=[NSString stringWithFormat:@"%f",self.mapView.userLocation.coordinate.latitude];
            _locationStr=@"哈尔滨市红旗大街108号";
            
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
    [self drawBtnView];
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



-(NSString*)getDateString{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

-(NSString*)getDateTime{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}
-(void)drawBtnView{
    CGFloat VcY=fDeviceHeight*2/5+TopSeachHigh-30;
    UIView * timeVc=[[UIView alloc]initWithFrame:CGRectMake(0, VcY, fDeviceWidth, 100)];
    [self.view addSubview:timeVc];
    UILabel * dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, fDeviceWidth-10, 30)];
    
    dateLbl.text=[NSString stringWithFormat:@"%@ %@",[self getDateString],[self weekdayStringFromDate]];
    [self.view addSubview:dateLbl];
    [dateLbl setFont:[UIFont systemFontOfSize:18]];
    [dateLbl setTextColor:[UIColor blackColor]];
    
    timeVc.backgroundColor=[UIColor whiteColor];
    [timeVc addSubview:dateLbl];
    

    UILabel * timeLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, fDeviceWidth-10, 30)];
    
    timeLbl.text=[NSString stringWithFormat:@"%@ %@",@"当前时间：",[self getDateTime]];
    [self.view addSubview:timeLbl];
    [timeLbl setFont:[UIFont systemFontOfSize:18]];
    [timeLbl setTextColor:[UIColor blackColor]];
    [timeVc addSubview:timeLbl];

    CGFloat btnY=timeVc.frame.origin.y+timeVc.frame.size.height+20;
   UIButton* qiandaoBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, btnY, fDeviceWidth, 50)];
    
    [qiandaoBtn addTarget:self action:@selector(clickqiandao) forControlEvents:UIControlEventTouchUpInside];
    
    [qiandaoBtn setTitle:@"签到"forState:UIControlStateNormal];// 添加文字
    qiandaoBtn.backgroundColor=[UIColor blueColor];
    
    [self.view addSubview:qiandaoBtn];
}


-(NSDictionary *)makeUpLoadDict{
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    
    [dict setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"uid"];
    [dict setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
    [dict setObject:@"0" forKey:@"status"];//签到
    [dict setObject:_longitudeStr forKey:@"longitude"];
    
    [dict setObject:_latitudeStr forKey:@"latitude"];
    [dict setObject:_locationStr forKey:@"location"];
    [dict setObject:ApplicationDelegate.myLoginInfo.v forKey:@"v"];

    NSLog(@"dict:%@",[self dictionaryToJson:dict]);
    
    
    return dict;
    
}

-(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

-(void)clickqiandao{
    [self uploadKaoqin];
}


-(void)uploadKaoqin{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
//    NSDictionary *paramDict = @{
//                                @"id":@"hong",
//                                @"password":@"admin"
//                                };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/sys/forSignIn"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:[self makeUpLoadDict]
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          NSLog(@"签到返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功                
                                            
                                              [SVProgressHUD dismiss];
                                            NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                            NSDictionary *datadict=[idict objectForKey:@"Data"];
                                            NSString *signTime=[[datadict objectForKey:@"signTime"]stringValue];
                                            NSLog(@"signTime：%@",signTime);
                                              [self drawQiantuiVc:signTime];
                                              
                                          } else {
                                              //失败
                                              [SVProgressHUD showErrorWithStatus:msg];
                                             
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                         
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                     
                                  }];
    
}

-(void)drawQiantuiVc:(NSString*)timeStr{
    CGFloat VcY=fDeviceHeight*2/5+TopSeachHigh-30+100+10;
    
    UIView * signInVc=[[UIView alloc]initWithFrame:CGRectMake(0, VcY, fDeviceWidth, 50)];
    signInVc.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:signInVc];
    
    UILabel *signInLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, fDeviceWidth, 30)];
    signInLbl.text=[NSString stringWithFormat:@"签到：%@",[stdPubFunc stdTimeToStr:timeStr]];
    [signInLbl setFont:[UIFont systemFontOfSize:18]];
    [signInLbl setTextColor:[UIColor blackColor]];
    [signInVc addSubview:signInLbl];
}
@end
