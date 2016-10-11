//
//  StdUploadFileApi.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/8.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol uploadProgressDelegate <NSObject>
@optional
- (void)stdUploadProgress:(float)progress;
-(void)stdUploadError:(NSError *)err;
-(void)stdUploadSucc:(NSURLResponse  *)Response responseObject:(id)respObject;
@end

@interface StdUploadFileApi : NSObject
@property (nonatomic, unsafe_unretained) id<uploadProgressDelegate> delegate;
-(void)stdUploadFileWithProgress:(NSString*)upUrl filePath:(NSString*)fileFullpath fileName:(NSString*)fname mimeType:(NSString*)mType pragram:(NSDictionary*)pragrams;
@end
