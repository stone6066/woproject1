//
//  mainBv.m
//  woproject
//
//  Created by 关宇琼 on 2016/11/8.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "mainBv.h"
#import "ProjectListCell.h"


@interface mainBv ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTBV;



@end

@implementation mainBv

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor redColor];
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
    return _dicArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellName = @"ProjectListCell";
    
    ProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] firstObject];
        
    }
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.dataDic = _dicArr[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 12;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)setDicArr:(NSArray *)dicArr {
    if (_dicArr != dicArr) {
        _dicArr = dicArr;
    }
    
    [_listTBV reloadData];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
