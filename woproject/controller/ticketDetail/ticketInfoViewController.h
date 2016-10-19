//
//  ticketInfoViewController.h
//  woproject
//
//  Created by tianan-apple on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ticketInfo;
@interface ticketInfoViewController : UIViewController
@property (nonatomic,copy)NSString* myViewTitle;
@property (nonatomic,copy)NSString* ListId;
@property (nonatomic,copy)NSString* daochang;//是否到场 0未到  1已到
@property (nonatomic,copy)NSString* daochangTime;
@property (nonatomic,strong)ticketInfo *myTicketInfo;
@end
