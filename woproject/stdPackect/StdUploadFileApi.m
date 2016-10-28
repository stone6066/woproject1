//
//  StdUploadFileApi.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/8.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "StdUploadFileApi.h"
#import "AFNetworking.h"


@implementation StdUploadFileApi

-(void)stdUploadFile{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
    
}

/*
 upUrl:服务器地址
 filePath：文件全路径
 fileName：文件名
 mimeType：文件类型
 
 NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
 [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
 } error:nil];
 
 */
-(void)stdUploadFileWithProgress:(NSString*)upUrl filePath:(NSString*)fileFullpath fileName:(NSString*)fname mimeType:(NSString*)mType pragram:(NSDictionary*)pragrams{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:upUrl parameters:pragrams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (fileFullpath.length<1) {
            formData=nil;
        }
        else
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:fileFullpath] name:@"pic" fileName:fname mimeType:mType error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          [_delegate stdUploadProgress:uploadProgress.fractionCompleted];
                         
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          [_delegate stdUploadError:error];
                          //NSLog(@"Error: %@", error);
                      } else {
                          [_delegate stdUploadSucc:response responseObject:responseObject];
                          //NSLog(@"%@ %@", response, responseObject);
                      }
                  }];
    
    [uploadTask resume];
}
-(void)stdUploadTxt{
   }
@end
