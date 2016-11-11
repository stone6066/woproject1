//
//  StringUtils.h
//  mindeye
//
//  Created by chen shaorong on 2/28/13.
//  Copyright (c) 2013 chen shaorong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface StringUtils : NSObject

// 字符串md5加密
+ (NSString *)md5HexDigest:(NSString *)input;

// 16进制颜色#e26562与UIColor互转,设置View背景颜色
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
