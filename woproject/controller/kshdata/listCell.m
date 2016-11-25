//
//  listCell.m
//  woproject
//
//  Created by 关宇琼 on 2016/11/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "listCell.h"

@interface listCell ()
@property (strong, nonatomic) IBOutlet UILabel *nameLb;
@property (strong, nonatomic) IBOutlet UIImageView *isChoose;

@end

@implementation listCell

- (void)setName:(NSString *)name {
    if (_name != name) {
        _name = name;
    }
    _nameLb.text = _name;
}

- (void)setCurrent:(BOOL)current {
    _isChoose.hidden = !current;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
