//
//  DownLoadBaseData.m
//  woproject
//
//  Created by tianan-apple on 16/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DownLoadBaseData.h"

@implementation DownLoadBaseData
-(void)downFaultSystem{//下载故障系统
    [SVProgressHUD showWithStatus:k_Status_Load];
    
        NSDictionary *paramDict = @{
                                    @"uid":ApplicationDelegate.myLoginInfo.Id,
                                    @"ukey":ApplicationDelegate.myLoginInfo.ukey
                                    };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forFaultSyetem"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"下载系统故障返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                              NSArray *sysData=[idict objectForKey:@"Data"];
                                              NSString *carBrandModelPath = [DocumentBasePath stringByAppendingFormat:@"/%@", @"forFaultSyetem.plist"];
                                              
                                              BOOL saveResult = [sysData writeToFile:carBrandModelPath atomically:YES];
                                              if (saveResult) {
                                                  
                                                  NSLog(@"写入 %@ 数据字典成功", carBrandModelPath);
                                              }
                                              else {
                                                  
                                                  NSLog(@"写入 %@ 数据字典失败", carBrandModelPath);
                                              }
                                              
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

-(void)downforProjectList{//下载项目列表
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSDictionary *paramDict = @{
                                @"uid":ApplicationDelegate.myLoginInfo.Id,
                                @"ukey":ApplicationDelegate.myLoginInfo.ukey
                                };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forProjectList"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"下载项目返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                              NSArray *sysData=[idict objectForKey:@"Data"];
                                              NSMutableArray *writeData=[self stdProjectList:sysData];
                                              NSString *carBrandModelPath = [DocumentBasePath stringByAppendingFormat:@"/%@", @"forProjectList.plist"];
                                              
                                              BOOL saveResult = [writeData writeToFile:carBrandModelPath atomically:YES];
                                              if (saveResult) {
                                                  
                                                  NSLog(@"写入 %@ 数据字典成功", carBrandModelPath);
                                              }
                                              else {
                                                  
                                                  NSLog(@"写入 %@ 数据字典失败", carBrandModelPath);
                                              }
                                              
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


-(void)downForCity{//下载城市
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSDictionary *paramDict = @{
                                @"v":@"0",
                                };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/sys/forCity"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"下载city返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                              NSArray *sysData=[idict objectForKey:@"Data"];
                                              NSString *carBrandModelPath = [DocumentBasePath stringByAppendingFormat:@"/%@", @"forCity.plist"];
                                              
                                              BOOL saveResult = [sysData writeToFile:carBrandModelPath atomically:YES];
                                              if (saveResult) {
                                                  
                                                  NSLog(@"写入 %@ 数据字典成功", carBrandModelPath);
                                              }
                                              else {
                                                  
                                                  NSLog(@"写入 %@ 数据字典失败", carBrandModelPath);
                                              }
                                              
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

- (void)downDeviceType
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSDictionary *paramDict = @{
                                @"uid":ApplicationDelegate.myLoginInfo.Id,
                                @"ukey":ApplicationDelegate.myLoginInfo.ukey
                                };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forDeviceType"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          NSLog(@"下载项目返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                              NSArray *sysData=[idict objectForKey:@"Data"];
                                              NSMutableArray *writeData=[self stdProjectList:sysData];
                                              NSString *carBrandModelPath = [DocumentBasePath stringByAppendingFormat:@"/%@", @"forDeviceType.plist"];
                                              
                                              BOOL saveResult = [writeData writeToFile:carBrandModelPath atomically:YES];
                                              if (saveResult) {
                                                  
                                                  NSLog(@"写入 %@ 数据字典成功", carBrandModelPath);
                                              }
                                              else {
                                                  
                                                  NSLog(@"写入 %@ 数据字典失败", carBrandModelPath);
                                              }
                                              
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

-(NSMutableArray *)stdProjectList:(NSArray*)inArr{//自己重组一下数组，原数组有null，保存失败
    NSMutableArray *rtnArr=[[NSMutableArray alloc]init];
    for (NSDictionary * dict in inArr) {
        NSMutableDictionary * dictTmp=[[NSMutableDictionary alloc]init];
        
        [dictTmp setObject:[dict objectForKey:@"id"] forKey:@"id"];
        [dictTmp setObject:[dict objectForKey:@"name"]forKey:@"name"];
        [rtnArr addObject:dictTmp];
    }
    return rtnArr;
}




-(void)downforWorkType{//下载工种列表
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSDictionary *paramDict = @{
                                @"uid":ApplicationDelegate.myLoginInfo.Id,
                                @"ukey":ApplicationDelegate.myLoginInfo.ukey
                                };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forWorkType"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"下载工种返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                              NSArray *sysData=[idict objectForKey:@"Data"];
                                              NSMutableArray *writeData=[self stdProjectList:sysData];
                                              NSString *carBrandModelPath = [DocumentBasePath stringByAppendingFormat:@"/%@", @"forProjectList.plist"];
                                              
                                              BOOL saveResult = [writeData writeToFile:carBrandModelPath atomically:YES];
                                              if (saveResult) {
                                                  
                                                  NSLog(@"写入 %@ 数据字典成功", carBrandModelPath);
                                              }
                                              else {
                                                  
                                                  NSLog(@"写入 %@ 数据字典失败", carBrandModelPath);
                                              }
                                              
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

-(void)downforUserList:(NSString*)jobId{//下载工种对应的人员信息
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSDictionary *paramDict = @{
                                @"uid":ApplicationDelegate.myLoginInfo.Id,
                                @"ukey":ApplicationDelegate.myLoginInfo.ukey,
                                @"job_id":jobId
                                };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/sys/forUserList"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"下载人员信息返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                              NSArray *sysData=[idict objectForKey:@"Data"];
                                              NSMutableArray *writeData=[self stdProjectList:sysData];
                                              NSString *carBrandModelPath = [DocumentBasePath stringByAppendingFormat:@"/%@", @"forProjectList.plist"];
                                              
                                              BOOL saveResult = [writeData writeToFile:carBrandModelPath atomically:YES];
                                              if (saveResult) {
                                                  
                                                  NSLog(@"写入 %@ 数据字典成功", carBrandModelPath);
                                              }
                                              else {
                                                  
                                                  NSLog(@"写入 %@ 数据字典失败", carBrandModelPath);
                                              }
                                              
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

/**
 *  读取基础信息表
 */
+(NSArray *) readBaseData:(NSString*)fileName
{
    
    NSString *dataFilePath =[NSString stringWithFormat:@"%@/%@",DocumentBasePath,fileName];
    //@"/Provincial.plist"
    NSArray *rtnArr=[[NSArray alloc]initWithContentsOfFile:dataFilePath];
    return rtnArr;
}

+(NSDictionary *) readBaseData1:(NSString*)fileName
{
    
    NSString *dataFilePath =[NSString stringWithFormat:@"%@/%@",DocumentBasePath,fileName];
    //@"/Provincial.plist"
    NSDictionary *rtnArr=[[NSDictionary alloc]initWithContentsOfFile:dataFilePath];
    return rtnArr;
}

/*下载视频参数*/
-(void)downLoadVideoArg{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSDictionary *paramDict = @{
                                @"uid":ApplicationDelegate.myLoginInfo.Id,
                                @"ukey":ApplicationDelegate.myLoginInfo.ukey,
                                @"v":ApplicationDelegate.myLoginInfo.v
                                };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/getVideoParam"];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"下载人员信息返回：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"s"];
                                          NSString *msg=[jsonDic objectForKey:@"m"];
                                          //
                                          if ([suc isEqualToString:@"0"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              NSDictionary *idict=[jsonDic objectForKey:@"i"];
                                              NSDictionary *sysData=[idict objectForKey:@"Data"];
                                              
//                                              NSMutableArray *wArr=[[NSMutableArray alloc]init];
//                                              NSString *serverIp=[sysData objectForKey:@"serverIp"];
//                                             
//                                              NSString *portStr=[sysData objectForKey:@"serverPort"];
//                                              NSString *appId=[sysData objectForKey:@"appID"];
//                                              NSString *auth=[sysData objectForKey:@"auth"];
//                                              NSString *account=[sysData objectForKey:@"account"];
//                                              
//                                              if (!serverIp) {
//                                                  [wArr addObject:serverIp];
//                                              }
//                                              if (!portStr) {
//                                                  [wArr addObject:portStr];
//                                              }
//                                              if (!appId) {
//                                                  [wArr addObject:appId];
//                                              }
//                                              if (!auth) {
//                                                  [wArr addObject:auth];
//                                              }
//                                              if (!account) {
//                                                  [wArr addObject:account];
//                                              }
                                              NSString *carBrandModelPath = [DocumentBasePath stringByAppendingFormat:@"/%@", @"forVideo.plist"];
                                              
                                              BOOL saveResult = [sysData writeToFile:carBrandModelPath atomically:YES];
                                              if (saveResult) {
                                                  
                                                  NSLog(@"写入 %@ 数据字典成功", carBrandModelPath);
                                              }
                                              else {
                                                  
                                                  NSLog(@"写入 %@ 数据字典失败", carBrandModelPath);
                                              }
                                              
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



@end
