//
//  FSModel.m
//  woproject
//
//  Created by 徐洋 on 16/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "FSModel.h"

@implementation FSModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"fsID":@"id"};
}

- (NSString *)description
{
    return [self yy_modelDescription];
}

@end
