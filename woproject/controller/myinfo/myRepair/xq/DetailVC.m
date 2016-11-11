//
//  DetailVC.m
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DetailVC.h"
#import "DetailModel.h"
#import "DetailView.h"
#import "PJVC.h"
#import "SHVC.h"

@interface DetailVC ()
<
    DetailViewDelegate
>

@property (nonatomic, strong) DetailView *detail;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dataRequest
{
    NSDictionary *params = @{@"uid":ApplicationDelegate.myLoginInfo.Id,@"ukey":ApplicationDelegate.myLoginInfo.ukey,@"tid":self.orderId,@"v":self.v};
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forTicketInfo"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:params
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          NSLog(@"派单返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              [SVProgressHUD dismiss];
                                              

                                              DetailModel *model = [DetailModel yy_modelWithJSON:jsonDic[@"i"][@"Data"]];
                                              _detail.model = model;
                                              
                                              
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

- (void)detailViewButtonAction:(NSString *)gd
{
    switch (_type.integerValue) {
        case 0:
        {
            PJVC *vc = [[PJVC alloc] init];
            vc.gd = gd;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
        }
            break;
        case 2:
        {
            SHVC *vc = [[SHVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark UI
- (void)initUI
{
    self.topTitle = @"工单详情";
    _detail = [[DetailView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight - 64)];
    _detail.type = self.type;
    [self.view addSubview:_detail];
    _detail.delegate = self;
    switch (_type.integerValue) {
        case 0:
        {
            [_detail.detailBtn setTitle:@"评价" forState:normal];
        }
            break;
        case 1:
        {
        }
            break;
        case 2:
        {
            [_detail.detailBtn setTitle:@"审核" forState:normal];
        }
            break;
            
        default:
            break;
    }
    [self dataRequest];
}


@end
