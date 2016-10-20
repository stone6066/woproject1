//
//  DropDown.h
//  UICombox
//
//  Created by Ralbatr on 14-3-17.
//  Copyright (c) 2014年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComboxView : UIView <UITableViewDelegate,UITableViewDataSource> {
    
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
    
}

@property (nonatomic,retain) UITableView *dropTableView;//下拉列表
@property (nonatomic,retain) NSArray *tableArray;//下拉列表数据
//@property (nonatomic,retain) UITextField *textField;//文本输入框
@property (nonatomic,retain) NSString *titleStr;//下拉列表标题
@property (nonatomic,strong) UIButton *viewBtn;//全覆盖
@property (nonatomic,strong) UILabel *textLbl;//显示文本
- (void)closeTableView;
-(id)initWithFrame:(CGRect)frame titleStr:(NSString*)tstr;
@end
