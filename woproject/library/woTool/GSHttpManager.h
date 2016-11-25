//
//  GSHttpManager.h
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/24.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^GSURLManagerSendRequestCallBack) (NSURLResponse* response, NSURL *filePath, NSError* connectionError);



@interface GSHttpManager : NSObject


/**
 *  判断网络
 */
+ (void)httpManagerGSNetworkReachabilityManage;


/**
 *  POST
 */
+ (void)httpManagerPostParameter:(NSDictionary *)param toHttpUrlStr:(NSString *)urlStr success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail;




@end



@interface GSHttpUpLoadManager : NSObject

/**
 *  UpLoadImage
 */
+ (void)httpUpLoadManagerPostParameter:(NSArray *)param toHttpUrlStr:(NSString *)urlStr useProgressHUD:(NSString *)state success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail;


@end


