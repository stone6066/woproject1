//
//  GSHttpManager.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/24.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSHttpManager.h"


@interface GSHttpManager ()



@end


@implementation GSHttpManager

/**
 *  判断网络状况
 */

+ (void)httpManagerGSNetworkReachabilityManage {
   
    [gs_ReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                NSLog(@"无网络");
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                NSLog(@"无线网络");
                break;
            }
                
            default:
                NSLog(@"不明网络");
                break;
        }
        
    }];

}

/**
 *  POST
 *
 *  @param param          入参
 *  @param urlStr         请求地址
 *  @param isEGO          是否缓存
 *  @param viewController 当前的vc
 *  @param success        成功返回值
 *  @param fail           失败返回值
 */

+ (void)httpManagerPostParameter:(NSDictionary *)param toHttpUrlStr:(NSString *)urlStr success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail {
    
    [SVProgressHUD showWithStatus:k_Status_Load];
    [ApplicationDelegate.httpManager POST:urlStr parameters:param constructingBodyWithBlock:^(id  _Nonnull formData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        
        
        
        NSMutableString * strdata=[[NSMutableString alloc] initWithString:result];
        
      
        
        NSData * mdata=[strdata dataUsingEncoding:NSUTF8StringEncoding];
        
        id  dict_data = [NSJSONSerialization JSONObjectWithData:mdata options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        if (!dict_data) {
            
            dict_data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            
        }
        
        if ([dict_data[@"m"] isEqualToString:@"成功"]) {
            
            success(dict_data[@"i"][@"Data"]);
            
        }else{
            [SVProgressHUD showInfoWithStatus:dict_data[@"m"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //代理实现
        [SVProgressHUD showInfoWithStatus:error.userInfo[@"NSLocalizedDescription"]];
        
    }];

}

/**
 *  GET
 *
 *  @param param          入参
 *  @param urlStr         请求地址
 *  @param isEGO          是否缓存
 *  @param viewController 当前的vc
 *  @param success        成功返回值
 *  @param fail           失败返回值
 */

+ (void)httpManagerGetParameter:(NSDictionary *)param toHttpUrlStr:(NSString *)urlStr isEGOorNot:(BOOL)isEGO  targetViewController:(BaseViewController *)viewController andUrlFunctionName:(NSString *)urlName success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail {
    
  
}


@end



@implementation GSHttpUpLoadManager

@end



