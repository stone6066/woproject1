//
//  InfoDetailsView.m
//  woproject
//
//  Created by 关宇琼 on 2016/11/21.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "InfoDetailsView.h"
#import "DetailsCell.h"

@interface InfoDetailsView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTBV;

@end

@implementation InfoDetailsView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _listTBV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:(UITableViewStyleGrouped)];
        [self addSubview:_listTBV];
        _listTBV.delegate = self;
        _listTBV.dataSource = self;
        _listTBV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTBV.tableFooterView = [UIView new];

    }
    return self;
}
#pragma mark -
#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataDic.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellName = @"DetailsCell";
    
    DetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] firstObject];
        
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.dataDic = _dataDic[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 12;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 450;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)setDataDic:(NSArray *)dataDic {
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
    }
      [_listTBV reloadData];
}

@end
