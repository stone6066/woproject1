//
//  MyPermissionsCell.m
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MyPermissionsCell.h"
#import "projectList.h"

@interface MyPermissionsCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *userListLabel;
@property (nonatomic, strong) UILabel *userListContent;
@property (nonatomic, strong) UILabel *roleListLabel;
@property (nonatomic, strong) UILabel *roleListContent;
@property (nonatomic, strong) UILabel *pnameListLabel;
@property (nonatomic, strong) UILabel *pnameListContent;

@end

@implementation MyPermissionsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubbViews];
    }
    return self;
}

- (void)setModel:(MyPermissionsModel *)model
{
    _model = model;
    _userListContent.text = model.userName;
    switch (model.roleName.integerValue) {
        case 1:
            _roleListContent.text = @"经理";
            break;
        case 2:
            _roleListContent.text = @"领班";
            break;
        case 3:
            _roleListContent.text = @"调度";
            break;
        case 4:
            _roleListContent.text = @"员工";
            break;
    }
    __block NSString *project = @"";
    [model.projectList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        projectList *pr = (projectList *)obj;
        if (idx == 0) {
            project = [project stringByAppendingString:pr.name];
        }else{
            project = [project stringByAppendingString:[NSString stringWithFormat:@"\n%@", pr.name]];
        }
    }];
    _pnameListContent.text = project;
}

- (void)setSubbViews
{
    self.backgroundColor = RGB(232, 239, 247);
    _backView = [UIView new];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_backView];
    _userListLabel = [UILabel new];
    _userListLabel.text = @"用户组:";
    _userListLabel.font = k_text_font(14);
    _userListLabel.textAlignment = 2;
    [_backView addSubview:_userListLabel];
    _userListContent = [UILabel new];
    _userListContent.font = k_text_font(14);
    [_backView addSubview:_userListContent];
    _roleListLabel = [UILabel new];
    _roleListLabel.text = @"角色:";
    _roleListLabel.font = k_text_font(14);
    _roleListLabel.textAlignment = 2;
    [_backView addSubview:_roleListLabel];
    _roleListContent = [UILabel new];
    _roleListContent.font = k_text_font(14);
    [_backView addSubview:_roleListContent];
    _pnameListLabel = [UILabel new];
    _pnameListLabel.text = @"项目名称:";
    _pnameListLabel.font = k_text_font(14);
    _pnameListLabel.textAlignment = 2;
    [_backView addSubview:_pnameListLabel];
    _pnameListContent = [UILabel new];
    _pnameListContent.numberOfLines = 0;
    _pnameListContent.font = k_text_font(14);
    [_backView addSubview:_pnameListContent];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(10);
        make.bottom.offset(-5);
    }];
    [_userListLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    [_userListContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(_userListLabel);
        make.left.equalTo(_userListLabel.mas_right).offset(0);
        make.right.offset(-10);
    }];
    [_roleListLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userListLabel.mas_bottom).offset(20);
        make.left.width.height.equalTo(_userListLabel);
    }];
    [_roleListContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_userListContent);
        make.top.equalTo(_userListContent.mas_bottom).offset(20);
    }];
    [_pnameListLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_roleListLabel.mas_bottom).offset(20);
        make.left.width.height.equalTo(_userListLabel);
    }];
    [_pnameListContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pnameListLabel);
        make.left.right.equalTo(_roleListContent);
        make.bottom.offset(-10);
    }];
}

@end
