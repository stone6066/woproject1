//
//  DetailsCell.m
//  woproject
//
//  Created by 关宇琼 on 2016/11/21.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DetailsCell.h"


@interface  DetailsCell ()
@property (strong, nonatomic) IBOutlet UILabel *bulidName;
@property (strong, nonatomic) IBOutlet UILabel *responsible;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *where;

@property (strong, nonatomic) IBOutlet UILabel *under;
@property (strong, nonatomic) IBOutlet UIImageView *imgv;
@property (strong, nonatomic) IBOutlet UILabel *bulidHeight;
@property (strong, nonatomic) IBOutlet UILabel *space;
@property (strong, nonatomic) IBOutlet UILabel *over;

@property (strong, nonatomic) IBOutlet UILabel *forms;
@end

@implementation DetailsCell




- (void)setDataDic:(NSDictionary *)dataDic {
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
    }
    NSLog(@"%@vvvvvvv" , dataDic);
    
    _bulidName.text = dataDic[@"projectName"];
    [_imgv sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseUrl, dataDic[@"imagePath"]]]  placeholderImage:nil];
      _forms.text = [NSString stringWithFormat:@"建筑业态:%@", dataDic[@"buildingName"]];
    _bulidHeight.text = [NSString stringWithFormat:@"楼高:%@米", dataDic[@"height"]];
    _space.text = [NSString stringWithFormat:@"建筑面积:%@万㎡", [NSString stringWithFormat:@"%.2f", [dataDic[@"areaCount"] floatValue] / 10000] ];
    _over.text = [NSString stringWithFormat:@"地上层数:%@", dataDic[@"overground"]];
    _under.text = [NSString stringWithFormat:@"地下层数:%@", dataDic[@"underground"]];
    _responsible.text =[NSString stringWithFormat:@"负责人:%@", dataDic[@"manager"]];
    _phone.text = [NSString stringWithFormat:@"联系电话:%@", dataDic[@"telephone"]];
    _where.text = [NSString stringWithFormat:@"位置:%@", dataDic[@"location"]];


    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor redColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
