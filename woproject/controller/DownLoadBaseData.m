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
                                          NSLog(@"下载系统故障返回：%@",jsonDic);
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

@end
