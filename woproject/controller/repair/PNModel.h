//
//  PNModel.h
//  woproject
//
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicDefine.h"

@interface PNModel : NSObject<YYModel>

/**
 城市id
 */
@property (nonatomic, assign) NSInteger ciytId;
/**
 id
 */
@property (nonatomic, copy) NSString *pnID;
/**
 项目名称
 */
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger typeId;
@property (nonatomic, assign) NSInteger v;

@end
