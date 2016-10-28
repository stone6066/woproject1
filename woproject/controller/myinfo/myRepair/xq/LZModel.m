//
//  LZModel.m
//  woproject
//
//  Created by 徐洋 on 2016/10/26.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "LZModel.h"

@implementation LZModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"Id":@"id"};
}

- (NSString *)description
{
    return [self yy_modelDescription];
}

@end
