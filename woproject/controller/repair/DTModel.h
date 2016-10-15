//
//  DTModel.h
//  woproject
//
//  Created by 徐洋 on 16/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicDefine.h"

@interface DTModel : NSObject<YYModel>

@property (nonatomic, copy) NSString *dtID;
@property (nonatomic, copy) NSString *name;

@end
