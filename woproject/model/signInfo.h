//
//  signInfo.h
//  woproject
//
//  Created by tianan-apple on 16/10/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface signInfo : NSObject
@property(nonatomic,copy)NSString *Id;//id
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *longitude;
@property(nonatomic,copy)NSString *signTime;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *v;

- (NSMutableArray *)asignInfoWithDict:(NSDictionary *)dict;
@end
