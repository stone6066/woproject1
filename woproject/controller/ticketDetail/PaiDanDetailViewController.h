//
//  PaiDanDetailViewController.h
//  woproject
//
//  Created by tianan-apple on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ticketInfo,ComboxView;
@interface PaiDanDetailViewController : UIViewController
@property (nonatomic,copy)NSString* myViewTitle;
@property (nonatomic,copy)NSString* ListId;
@property (nonatomic,strong)ticketInfo *myTicketInfo;
@property (nonatomic,strong)ComboxView *priorityBox;//优先级
@property (nonatomic,strong)ComboxView *jobNameBox;//工种
@property (nonatomic,strong)ComboxView *operationUserBox;//接单人
-(id)init:(NSString *)listId;
@end