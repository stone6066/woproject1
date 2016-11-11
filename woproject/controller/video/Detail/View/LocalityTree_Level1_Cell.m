//
//  Locality_Level1_Cell.m
//  mindeye
//
//  Created by wholeally on 15/2/16.
//  Copyright (c) 2015年 wholeally. All rights reserved.
//

#import "LocalityTree_Level1_Cell.h"
@interface LocalityTree_Level1_Cell()


@end
@implementation LocalityTree_Level1_Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"Level1_Cell";
    LocalityTree_Level1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LocalityTree_Level1_Cell" owner:nil options:nil][0];
        
    }
    return cell;
}

@end
