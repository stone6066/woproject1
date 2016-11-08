//
//  CloudPlatformManageController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "CloudPlatformManageController.h"
#import "mainBv.h"

@interface CloudPlatformManageController ()

@property (strong, nonatomic)  mainBv *mainBv;


@end

@implementation CloudPlatformManageController



- (void)initUI {
    
    self.topTitle = @"总体概览";
    self.dateListShow = NO;
    
}

- (mainBv *)mainBv {
    if (!_mainBv) {
        _mainBv = [[mainBv alloc ] initWithFrame:CGRectMake(0, 108, fDeviceWidth, fDeviceHeight - 108)];
        [self.view addSubview:_mainBv];
    }
    return _mainBv;
}
- (void)manuallyProperties {
    [super initFrontProperties];
}


- (void)setProperties {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self mainBv];
    
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
    _mainBv.dicArr = result;
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
