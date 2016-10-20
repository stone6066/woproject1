//
//  GggdDetailInfoViewController.h
//  woproject
//
//  Created by tianan-apple on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ticketInfo;
@interface GggdDetailInfoViewController : UIViewController
@property (nonatomic,copy)NSString* myViewTitle;
@property (nonatomic,copy)NSString* ListId;
@property (nonatomic,strong)ticketInfo *myTicketInfo;

-(id)init:(NSString *)listId;
@end
