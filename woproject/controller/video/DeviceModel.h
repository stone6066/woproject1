//
//  DeviceModel.h
//  sdkDemo
//
//  Created by 吴怡顺 on 15/9/29.
//  Copyright © 2015年 吴怡顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface DeviceModel : NSObject

@property(nonatomic,assign)long long device_id;
@property(nonatomic,assign)BOOL status;
@property (nonatomic, assign, getter = isOpened) BOOL opened;
@property(nonatomic,strong)NSMutableArray* subDeviceList;
//区域
@property(nonatomic,strong) UIImage* localimage;

@end
