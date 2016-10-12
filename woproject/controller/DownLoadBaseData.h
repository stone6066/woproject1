//
//  DownLoadBaseData.h
//  woproject
//
//  Created by tianan-apple on 16/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoadBaseData : NSObject
-(void)downFaultSystem;
-(void)downforProjectList;
+(NSArray *) readBaseData:(NSString*)fileName;
@end
