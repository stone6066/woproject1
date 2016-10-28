//
//  LZModel.h
//  woproject
//
//  Created by 徐洋 on 2016/10/26.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZModel : NSObject<YYModel>

@property (nonatomic, copy) NSString *operationUser;
@property (nonatomic, copy) NSString *operationTime;
@property (nonatomic, copy) NSString *jobName;
@property (nonatomic, copy) NSString *operationPhone;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *ticketId;
@property (nonatomic, copy) NSString *deptId;
@property (nonatomic, copy) NSString *operation;
@property (nonatomic, copy) NSArray *imageList;
@property (nonatomic, copy) NSString *isValid;
@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *v;

@end
