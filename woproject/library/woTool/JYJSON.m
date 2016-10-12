//
//  YXJSON.m
//  AUExpress
//
//  Created by majinyu on 14-7-25.
//  Copyright (c) 2014年 youdro. All rights reserved.
//


#import "JYJSON.h"

@implementation JYJSON

+ (NSString *)JSONStringWithDictionaryOrArray:(id)dictionaryOrArray
{
    if (dictionaryOrArray == nil){
        return nil;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionaryOrArray options:NSJSONWritingPrettyPrinted error:nil];
    if (data == nil)
    {
        return nil;
    }
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
    
}


+ (NSData *)JSONSDataWithDictionaryOrArray:(id)dictionaryOrArray
{
    if (dictionaryOrArray == nil)
    {
        return nil;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionaryOrArray options:NSJSONWritingPrettyPrinted error:nil];
    
    return data;
}

+ (id)dictionaryOrArrayWithJSONSString:(NSString *)jsonString
{
    if (jsonString == nil)
    {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
}


+ (id)dictionaryOrArrayWithJSONSData:(NSData *)jsonData
{
    if (jsonData == nil)
    {
        return nil;
    }
    
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
}


+(NSString *)stringWithForamtUTF8FromData:(NSData *)data
{
    
    if (data == nil)
    {
        return nil;
    }
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return str;
    
}


+(NSData *)dataWithJSONString:(NSString *)str
{
    
    if (str == nil)
    {
        return nil;
    }
    
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;
    
}

@end
