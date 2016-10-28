//
//  MyPermissionsModel.h
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPermissionsModel : NSObject<YYModel>

@property (nonatomic, copy) NSString *roleName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSArray *projectList;

@end
