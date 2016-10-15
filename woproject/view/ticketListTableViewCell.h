//
//  ticketListTableViewCell.h
//  woproject
//
//  Created by tianan-apple on 16/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ticketList;
@interface ticketListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *devName;
@property (weak, nonatomic) IBOutlet UILabel *ticketType;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UILabel *level;

@property (weak, nonatomic) IBOutlet UILabel *detail;
@property(nonatomic,copy)NSString* Id;

-(void)showCellView:(ticketList*)dataModel;
@end
