//
//  PNModel.m
//  woproject
//
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "PNModel.h"

@implementation PNModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"pnID":@"id"};
}

- (NSString *)description
{
    return [self yy_modelDescription];
}

@end
