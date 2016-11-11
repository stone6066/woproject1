//
//  QYSessionEX.h
//  qysdk
//
//  Created by 吴怡顺 on 15/10/19.
//  Copyright © 2015年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QYType.h"

@interface QYSessionEX : NSObject


-(id)initWithSession:(int) session;
-(void)QYChanelAbility:(uint64_t) ChanelNo
               callBack:(void (^)(int32_t ret,QY_DEVICE_FUN function)) callback;


-(void) GetChanelCodeStatu:(uint64_t) ChanelNo
                  callBack:(void (^)(int32_t ret)) callback;

@end
