//
//  CloudPlatformManageController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "CloudPlatformManageController.h"
#import "mainBv.h"
#import "InfoDetailsView.h"

@interface CloudPlatformManageController (){
    BOOL infodetails;
}


@property (strong, nonatomic)  mainBv *mainBv;

@property (nonatomic, strong) InfoDetailsView *detailsV;

@end

@implementation CloudPlatformManageController



- (void)initUI {
    
    self.topTitle = @"总体概览";
    self.dateListShow = NO;
    [self mainBv];
    [self detailsV];
}

- (mainBv *)mainBv {
    if (!_mainBv) {
        _mainBv = [[mainBv alloc ] initWithFrame:CGRectMake(0, 108, fDeviceWidth, fDeviceHeight - 108)];
        [self.view addSubview:_mainBv];
        _mainBv.hidden = NO;
    }
    return _mainBv;
}

- (InfoDetailsView *)detailsV {
    
    if (!_detailsV) {
        
        _detailsV = [[InfoDetailsView alloc] initWithFrame:CGRectMake(0, 108, fDeviceWidth, fDeviceHeight - 108)];
        
        [self.view addSubview:_detailsV];
        
        _detailsV.hidden = YES;
        
    }
    
    return _detailsV;
    
}
- (void)manuallyProperties {
    [super initFrontProperties];
    infodetails = NO;

}


- (void)setProperties {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
}


- (void)gsHandleData {
    
    NSDictionary *param = @{
                            @"uid":ApplicationDelegate.myLoginInfo.Id,
                            @"ukey":ApplicationDelegate.myLoginInfo.ukey,
                            @"provinceId":self.provinceIdStr,
                            @"cityId":self.cityIdStr,
                            @"projectId":self.projectIdStr
                            };
    
    infodetails = self.projectIdStr.length > 0 ? YES : NO;
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forProjectOrDetails"];
    
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
    if (infodetails) {
        _mainBv.hidden = YES;
        _detailsV.hidden = NO;
        _detailsV.dataDic = result;
        _detailsV.backgroundColor = [UIColor redColor];
       self.topTitle = @"项目信息";
    } else {
        self.topTitle = @"总体概览";
        _mainBv.hidden = NO;
        _detailsV.hidden = YES;
        _mainBv.dicArr = result;
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
