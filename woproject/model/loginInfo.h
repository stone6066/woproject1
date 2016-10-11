//
//  loginInfo.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "deptList.h"
#import "projectList.h"
#import "roleList.h"

@interface loginInfo : NSObject

@property(nonatomic,copy)NSString *Id;//用户id
@property(nonatomic,copy)NSString *ukey;//ukey
@property(nonatomic,copy)NSString *image;//头像
@property(nonatomic,copy)NSString *name;//用户名称
@property(nonatomic,copy)NSString *phone;//电话
@property(nonatomic,strong)NSMutableArray *deptList;//部门列表
@property(nonatomic,copy)NSString *iccId;//最近登陆纬度
@property(nonatomic,copy)NSString *idNumber;//创建时间
@property(nonatomic,copy)NSString *isInvoke;//组织机构代码
@property(nonatomic,copy)NSString *isLogin;//组织机构级别
@property(nonatomic,copy)NSString *isValid;//消息推送关键key
@property(nonatomic,copy)NSString *loginName;//头像路径
@property(nonatomic,copy)NSMutableArray *projectList;
@property(nonatomic,copy)NSMutableArray *roleList;
@property(nonatomic,copy)NSString *v;
@property(nonatomic,copy)NSString *m;
@property(nonatomic,copy)NSString *s;


- (loginInfo *)asignInfoWithDict:(NSDictionary *)dict;
@end
