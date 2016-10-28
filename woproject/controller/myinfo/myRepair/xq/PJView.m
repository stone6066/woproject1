//
//  PJView.m
//  woproject
//
//  Created by 徐洋 on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "PJView.h"

@interface PJView ()

@property (nonatomic, strong) UILabel *bgzLabel;
@property (nonatomic, strong) UIButton *shiBtn;
@property (nonatomic, strong) UILabel *fouLabel;
@property (nonatomic, strong) UIButton *fouBtn;

@property (nonatomic, strong) UILabel *wxLabel;
@property (nonatomic, strong) UIButton *hpBtn;
@property (nonatomic, strong) UILabel *zpLabel;
@property (nonatomic, strong) UIButton *zpBtn;
@property (nonatomic, strong) UILabel *cpLabel;
@property (nonatomic, strong) UIButton *cpBtn;

@property (nonatomic, strong) UILabel *pjyjLabel;
@property (nonatomic, strong) UITextView *pjTextView;
@property (nonatomic, strong) UILabel *msgLabel;

@end

@implementation PJView

- (instancetype)init
{
    if (self = [super init]) {
        [self setSubViews];
    }
    return self;
}

- (void)xfButtonAction:(UIButton *)sender
{
    if (sender == _shiBtn) {
        _shiBtn.selected = YES;
        _fouBtn.selected = NO;
    }else{
        _shiBtn.selected = NO;
        _fouBtn.selected = YES;
    }
}

- (void)wxButtonAction:(UIButton *)sender
{
    if (sender == _hpBtn) {
        _hpBtn.selected = YES;
        _zpBtn.selected = NO;
        _cpBtn.selected = NO;
    }else if (sender == _zpBtn){
        _hpBtn.selected = NO;
        _zpBtn.selected = YES;
        _cpBtn.selected = NO;
    }else{
        _hpBtn.selected = NO;
        _zpBtn.selected = NO;
        _cpBtn.selected = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

- (void)setSubViews
{
    self.backgroundColor = RGB(232, 239, 247);
    _bgzLabel = [UILabel new];
    _bgzLabel.text = @"本故障是否修复:是";
    _bgzLabel.font = k_text_font(14);
    [self addSubview:_bgzLabel];
    _shiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shiBtn setImage:[UIImage imageNamed:@"hh_pj01"] forState:UIControlStateSelected];
    [_shiBtn setImage:[UIImage imageNamed:@"hh_pj"] forState:normal];
    [_shiBtn addTarget:self action:@selector(xfButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_shiBtn];
    _fouLabel = [UILabel new];
    _fouLabel.text = @"否";
    _fouLabel.font = k_text_font(14);
    [self addSubview:_fouLabel];
    _fouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fouBtn setImage:[UIImage imageNamed:@"hh_pj01"] forState:UIControlStateSelected];
    [_fouBtn setImage:[UIImage imageNamed:@"hh_pj"] forState:normal];
    [_fouBtn addTarget:self action:@selector(xfButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_fouBtn];
    
    _wxLabel = [UILabel new];
    _wxLabel.text = @"本次维修评价:好评";
    _wxLabel.font = k_text_font(14);
    [self addSubview:_wxLabel];
    _hpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_hpBtn setImage:[UIImage imageNamed:@"hh_pj01"] forState:UIControlStateSelected];
    [_hpBtn setImage:[UIImage imageNamed:@"hh_pj"] forState:normal];
    [_hpBtn addTarget:self action:@selector(wxButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hpBtn];
    _zpLabel = [UILabel new];
    _zpLabel.text = @"中评";
    _zpLabel.font = k_text_font(14);
    [self addSubview:_zpLabel];
    _zpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_zpBtn setImage:[UIImage imageNamed:@"hh_pj01"] forState:UIControlStateSelected];
    [_zpBtn setImage:[UIImage imageNamed:@"hh_pj"] forState:normal];
    [_zpBtn addTarget:self action:@selector(wxButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_zpBtn];
    _cpLabel = [UILabel new];
    _cpLabel.text = @"差评";
    _cpLabel.font = k_text_font(14);
    [self addSubview:_cpLabel];
    _cpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cpBtn setImage:[UIImage imageNamed:@"hh_pj01"] forState:UIControlStateSelected];
    [_cpBtn setImage:[UIImage imageNamed:@"hh_pj"] forState:normal];
    [_cpBtn addTarget:self action:@selector(wxButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cpBtn];
    _pjyjLabel = [UILabel new];
    _pjyjLabel.font = k_text_font(14);
    _pjyjLabel.text = @"评价意见";
    [self addSubview:_pjyjLabel];
    _pjTextView = [UITextView new];
    _pjTextView.backgroundColor = RGB(245, 245, 245);
    [self addSubview:_pjTextView];
    _img = [UIImageView new];
    _img.image = [UIImage imageNamed:@"add"];
    [self addSubview:_img];
    _img2 = [UIImageView new];
    _img2.image = [UIImage imageNamed:@"add"];
    [self addSubview:_img2];
    _img3 = [UIImageView new];
    _img3.image = [UIImage imageNamed:@"add"];
    [self addSubview:_img3];
    _msgLabel = [UILabel new];
    _msgLabel.font = k_text_font(9);
    _msgLabel.text = @"只允许添加三张";
    [self addSubview:_msgLabel];
    _qrtjBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_qrtjBtn setTitle:@"确认提交" forState:normal];
    [_qrtjBtn setTitleColor:[UIColor whiteColor] forState:normal];
    _qrtjBtn.backgroundColor = RGB(21, 125, 250);
    [self addSubview:_qrtjBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    WS(weakSelf);
    [_bgzLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(40);
    }];
    [_shiBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(_bgzLabel);
        make.width.equalTo(_bgzLabel.mas_height);
        make.left.equalTo(_bgzLabel.mas_right);
    }];
    [_fouLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shiBtn.mas_right).offset(4);
        make.centerY.equalTo(_bgzLabel);
    }];
    [_fouBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_shiBtn);
        make.left.equalTo(_fouLabel.mas_right).offset(4);
    }];
    [_wxLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(_bgzLabel.mas_bottom).offset(20);
    }];
    [_hpBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(_wxLabel);
        make.width.equalTo(_wxLabel.mas_height);
        make.left.equalTo(_wxLabel.mas_right);
    }];
    [_zpLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_hpBtn.mas_right).offset(4);
        make.centerY.equalTo(_wxLabel);
    }];
    [_zpBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_hpBtn);
        make.left.equalTo(_zpLabel.mas_right).offset(4);
    }];
    [_cpLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_zpBtn.mas_right).offset(4);
        make.centerY.equalTo(_wxLabel);
    }];
    [_cpBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_hpBtn);
        make.left.equalTo(_cpLabel.mas_right).offset(4);
    }];
    [_pjyjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wxLabel.mas_bottom).offset(40);
        make.left.offset(20);
    }];
    [_pjTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_pjyjLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(@100);
    }];
    [_img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(_pjTextView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_img2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_img);
        make.left.equalTo(_img.mas_right).offset(10);
    }];
    [_img3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_img);
        make.left.equalTo(_img2.mas_right).offset(10);
    }];
    [_msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_img.mas_bottom).offset(2);
        make.left.equalTo(_img);
    }];
    [_qrtjBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(@40);
        make.top.equalTo(_msgLabel.mas_bottom).offset(20);
    }];
}

@end
