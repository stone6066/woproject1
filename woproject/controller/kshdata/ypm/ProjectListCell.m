//
//  ProjectListCell.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ProjectListCell.h"

@interface ProjectListCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleL;

@property (strong, nonatomic) IBOutlet UILabel *count;

@property (strong, nonatomic) IBOutlet UILabel *space;

@end

@implementation ProjectListCell


- (void)setDataDic:(NSDictionary *)dataDic {
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
    }
    _titleL.text  = _dataDic[@"buildingName"];
    _count.text = [_dataDic[@"projectCount"] stringValue];
    _space.attributedText = [MJYUtils attributeStr:[NSString stringWithFormat:@"%.2f", [dataDic[@"areaCount"] floatValue] / 10000] changePartStr:[NSString stringWithFormat:@"%.2f", [dataDic[@"areaCount"] floatValue] / 10000] withFont:20 andColor:RGB(0, 0, 0)];
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
