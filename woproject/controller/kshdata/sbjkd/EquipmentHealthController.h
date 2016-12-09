//
//  EquipmentHealthController.h
//  woproject
//
//  Created by 关宇琼 on 2016/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "BaseViewController.h"

@interface EquipmentHealthController : BaseViewController


@property (nonatomic, copy) NSString *cityIdStr;
@property (nonatomic, copy) NSString *projectIdStr;
@property (nonatomic, copy) NSString *provinceIdStr;


@property (nonatomic, copy) NSString *prov;
@property (nonatomic, copy) NSString *cit;
@property (nonatomic, copy) NSString *proj;

@property (nonatomic, strong) NSMutableArray *classifys;

@property (nonatomic, strong) NSMutableArray *areas;

@property (nonatomic, strong) NSMutableArray *sorts;

@end
