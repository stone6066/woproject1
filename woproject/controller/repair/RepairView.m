//
//  RepairView.m
//  woproject
//
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "RepairView.h"
#import "PublicDefine.h"
#import "stdPubFunc.h"
#import "DownLoadBaseData.h"

@interface RepairView ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    SDPhotoBrowserDelegate
>

/**
 项目名称
 */
@property (nonatomic, strong) UIView *PNView;
@property (nonatomic, strong) UILabel *PNLabel;
@property (nonatomic, strong) UITapGestureRecognizer *PNTap;
@property (nonatomic, assign) BOOL isPN;
/**
 故障系统
 */
@property (nonatomic, strong) UIView *FSView;
@property (nonatomic, strong) UILabel *FSLabel;
@property (nonatomic, strong) UITapGestureRecognizer *FSTap;
@property (nonatomic, strong) UILabel *FSTapLabel;
@property (nonatomic, assign) BOOL isFS;
/**
 设备类型
 */
@property (nonatomic, strong) UIView *DTView;
@property (nonatomic, strong) UILabel *DTLabel;
@property (nonatomic, strong) UITapGestureRecognizer *DTTap;
@property (nonatomic, strong) UILabel *DTTapLabel;
@property (nonatomic, assign) BOOL isDT;
/**
 优先级
 */
@property (nonatomic, strong) UIView *PView;
@property (nonatomic, strong) UILabel *PLabel;
@property (nonatomic, strong) UITapGestureRecognizer *PTap;
@property (nonatomic, strong) UILabel *PTapLabel;
@property (nonatomic, assign) BOOL isP;
/**
 报修描述
 */
@property (nonatomic, strong) UILabel *describeLabel;

@property (nonatomic, strong) UITableView *tableView;

/**
 0- 项目名称 1-故障系统 2-设备类型 3-优先级
 */
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSMutableDictionary *paramsDic;
@property (nonatomic, strong) UILabel *msgLabel;


@property (nonatomic, strong) UITapGestureRecognizer *tap1;
@property (nonatomic, strong) UITapGestureRecognizer *tap2;
@property (nonatomic, strong) UITapGestureRecognizer *tap3;
@property (nonatomic, strong) UIImageView *dimg1;
@property (nonatomic, strong) UIImageView *dimg2;
@property (nonatomic, strong) UIImageView *dimg3;
@property (nonatomic, strong) UIImageView *dimg4;

@end

@implementation RepairView

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.layer.borderWidth = .5f;
        _tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
         [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, -45, 0, 0)];
    }
    return _tableView;
}

- (NSMutableDictionary *)paramsDic
{
    if (!_paramsDic) {
        _paramsDic = [NSMutableDictionary dictionary];
    }
    return _paramsDic;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setSubViews];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if (self.dataArray.count == 0) {
        [stdPubFunc stdShowMessage:@"无"];
        switch (self.type) {
            case 0:
                _isPN = NO;
                break;
            case 1:
                _isFS = NO;
                break;
            case 2:
                _isDT = NO;
                break;
            case 3:
                _isP = NO;
                break;
        }
        return;
    }
    [self addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        switch (self.type) {
            case 0:
                make.top.equalTo(_PNView.mas_bottom).offset(0);
                break;
            case 1:
                make.top.equalTo(_FSView.mas_bottom).offset(0);
                break;
            case 2:
                make.top.equalTo(_DTView.mas_bottom).offset(0);
                break;
            case 3:
                make.top.equalTo(_PView.mas_bottom).offset(0);
                break;
        }
        make.left.right.equalTo(_PNView);
        make.height.mas_equalTo((self.dataArray.count>3?3:self.dataArray.count) * 44);
    }];
    [self.tableView reloadData];
}
- (NSDictionary *)getParams
{
    [self.paramsDic setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"uid"];
    [self.paramsDic setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
    return self.paramsDic;
}
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    if (index == 0) {
        return _imgView1.image;
    }else if (index == 1){
        return _imgView2.image;
    }else{
        return _imgView3.image;
    }
}
- (void)imageViewClick:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = 0;
    photoBrowser.imageCount = [self imageListCount];
    photoBrowser.sourceImagesContainerView = self;
    [photoBrowser show];
}
- (void)imageViewTwoClick:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = 1;
    photoBrowser.imageCount = [self imageListCount];
    photoBrowser.sourceImagesContainerView = self;
    [photoBrowser show];
}
- (void)imageViewThreeClick:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = 2;
    photoBrowser.imageCount = [self imageListCount];
    photoBrowser.sourceImagesContainerView = self;
    [photoBrowser show];
}

- (NSInteger)imageListCount
{
    NSInteger count = 0;
    if (_imgView1.hidden == NO) count = 1;
    if (_imgView2.hidden == NO) count = 2;
    if (_imgView3.hidden == NO) count = 3;
    return count;
}

#pragma mark Action
- (void)PNAction:(UIButton *)sender
{
    self.type = 0;
    if (_isPN) {
        [self.tableView removeFromSuperview];
    }else{
        NSArray *array = [DownLoadBaseData readBaseData:@"forProjectList.plist"];
        self.dataArray = [NSArray yy_modelArrayWithClass:[PNModel class] json:array];
    }
    _isPN = !_isPN;
}
- (void)FSAction:(UITapGestureRecognizer *)sender
{
//    if ([_PNTapLabel.text isEqualToString:@"------"]) {
//        [stdPubFunc stdShowMessage:@"请选择项目名称"];
//        return;
//    }
    self.type = 1;
    if (_isFS) {
        [self.tableView removeFromSuperview];
    }else{
        NSArray *array = [DownLoadBaseData readBaseData:@"forFaultSyetem.plist"];
        self.dataArray = [NSArray yy_modelArrayWithClass:[FSModel class] json:array];
    }
    _isFS = !_isFS;
}
- (void)DTAction:(UITapGestureRecognizer *)sender
{
//    if ([_FSTapLabel.text isEqualToString:@"------"]) {
//        [stdPubFunc stdShowMessage:@"请选择故障系统"];
//        return;
//    }
    self.type = 2;
    if (_isDT) {
        [self.tableView removeFromSuperview];
    }else{
        NSArray *array = [DownLoadBaseData readBaseData:@"forDeviceType.plist"];
        self.dataArray = [NSArray yy_modelArrayWithClass:[DTModel class] json:array];    }
    _isDT = !_isDT;
}
- (void)PAction:(UITapGestureRecognizer *)sender
{
    self.type = 3;
    if (_isP) {
        [self.tableView removeFromSuperview];
    }else{
        self.dataArray = @[@"低",@"中",@"高"];
    }
    _isP = !_isP;
}

- (void)imageButtonAction:(UIButton *)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(openPhotosAndCamera:)]) {
        [self.delegate openPhotosAndCamera:sender];
    }
}
- (void)clearUI
{
    _PNTapLabel.text = @"------";
    _FSTapLabel.text = @"------";
    _DTTapLabel.text = @"------";
    _PTapLabel.text = @"低";
    _describeTextView.text = @"";
    [_imgBtn1 setImage:[UIImage imageNamed:@"add"] forState:normal];
    _imgView1.hidden = _imgView2.hidden = _imgView3.hidden = YES;
    [self.paramsDic removeAllObjects];
    [self.paramsDic setObject:@"3" forKey:@"priority"];
    [self repairButtonIsReady];
}
- (void)repairButtonIsReady
{
//    if (![_PNTapLabel.text isEqualToString:@"------"] && _describeTextView.text.length != 0) {
        _repairButton.enabled = YES;
        _repairButton.backgroundColor = RGB(21, 125, 251);
//    }else{
//        _repairButton.enabled = NO;
//        _repairButton.backgroundColor = [UIColor lightGrayColor];
//    }
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    id model = self.dataArray[indexPath.row];
    if ([model isKindOfClass:[PNModel class]]) {
        PNModel *pn = model;
        cell.textLabel.text = pn.name;
    }else if ([model isKindOfClass:[FSModel class]]){
        FSModel *fs = model;
        cell.textLabel.text = fs.name;
    }else if ([model isKindOfClass:[DTModel class]]){
        DTModel *dt = model;
        cell.textLabel.text = dt.name;
    }else{
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment = 1;
    return cell;
}
#pragma mark UITabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView removeFromSuperview];

    switch (self.type) {
        case 0:
        {
            PNModel *pn = self.dataArray[indexPath.row];
            _PNTapLabel.text = pn.name;
            _isPN = NO;
            [self.paramsDic setObject:pn.pnID forKey:@"project_id"];
            [self repairButtonIsReady];
        }
            break;
        case 1:
        {
            FSModel *fs = self.dataArray[indexPath.row];
            _FSTapLabel.text = fs.name;
            _isFS = NO;
            [self.paramsDic setObject:fs.fsID forKey:@"system_id"];
        }
            break;
        case 2:
        {
            DTModel *dt = self.dataArray[indexPath.row];
            _DTTapLabel.text = dt.name;
            _isDT = NO;
            [self.paramsDic setObject:dt.dtID forKey:@"device_id"];
        }
            break;
        case 3:
        {
            _PTapLabel.text = self.dataArray[indexPath.row];
            _isP = NO;
            if ([_PTapLabel.text isEqualToString:@"低"]) {
                [self.paramsDic setObject:@"3" forKey:@"priority"];

            }else if ([_PTapLabel.text isEqualToString:@"中"]){
                [self.paramsDic setObject:@"2" forKey:@"priority"];

            }else{
                [self.paramsDic setObject:@"1" forKey:@"priority"];
            }
        }
            break;
    }
}
#pragma mark TextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGFloat space = fDeviceHeight - _describeTextView.frame.origin.y - _describeTextView.frame.size.height - 64;
    if(space < 282){
        [UIView animateWithDuration:.333f animations:^{
            self.frame = CGRectMake(0, self.frame.origin.y - (282 - space), fDeviceWidth, self.frame.size.height);
        }];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    CGFloat space = fDeviceHeight - _describeTextView.frame.origin.y - _describeTextView.frame.size.height - 64;
    if (space < 282) {
        [UIView animateWithDuration:.333f animations:^{
            self.frame = CGRectMake(0, self.frame.origin.y + (282 - space), fDeviceWidth, self.frame.size.height);
        }];
    }
    if (textView.text.length > 0) [self.paramsDic setObject:textView.text forKey:@"fault_desc"];
    [self repairButtonIsReady];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSMutableString *t = [self.describeTextView.text mutableCopy];
    [t replaceCharactersInRange:range withString:text];
    return t.length <= 100;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_describeTextView resignFirstResponder];
}
#pragma mark UI
- (void)setSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    _PNView = [UIView new];
    _PNView.backgroundColor = [UIColor whiteColor];
    _PNView.layer.borderWidth = .5;
    _PNView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_PNView];
    _PNLabel = [UILabel new];
    _PNLabel.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"项目名称: *"];
    [str addAttribute: NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(6, 1)];
    _PNLabel.attributedText = str;
    [_PNView addSubview:_PNLabel];
    _PNTapLabel = [UILabel new];
    _PNTapLabel.font = [UIFont systemFontOfSize:14];
    _PNTapLabel.text = @"------";
    _PNTapLabel.userInteractionEnabled = YES;
    _PNTapLabel.textAlignment = 0;
    [_PNView addSubview:_PNTapLabel];
    _PNTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PNAction:)];

    _FSView = [UIView new];
    _FSView.backgroundColor = [UIColor whiteColor];
    _FSView.layer.borderWidth = .5;
    _FSView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_FSView];
    _FSLabel = [UILabel new];
    _FSLabel.font = [UIFont systemFontOfSize:14];
    _FSLabel.text = @"故障系统:";
    [_FSView addSubview:_FSLabel];
    _FSTapLabel = [UILabel new];
    _FSTapLabel.font = [UIFont systemFontOfSize:14];
    _FSTapLabel.text = @"------";
    _FSTapLabel.userInteractionEnabled = YES;
    _FSTapLabel.textAlignment = 0;
    [_FSView addSubview:_FSTapLabel];
    _FSTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(FSAction:)];
    
    _DTView = [UIView new];
    _DTView.backgroundColor = [UIColor whiteColor];
    _DTView.layer.borderWidth = .5;
    _DTView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_DTView];
    _DTLabel = [UILabel new];
    _DTLabel.font = [UIFont systemFontOfSize:14];
    _DTLabel.text = @"设备类型:";
    [_DTView addSubview:_DTLabel];
    _DTTapLabel = [UILabel new];
    _DTTapLabel.font = [UIFont systemFontOfSize:14];
    _DTTapLabel.text = @"------";
    _DTTapLabel.userInteractionEnabled = YES;
    _DTTapLabel.textAlignment = 0;
    [_DTView addSubview:_DTTapLabel];
    _DTTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DTAction:)];
    
    _PView = [UIView new];
    _PView.backgroundColor = [UIColor whiteColor];
    _PView.layer.borderWidth = .5;
    _PView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_PView];
    _PLabel = [UILabel new];
    _PLabel.font = [UIFont systemFontOfSize:14];
    _PLabel.text = @"优先级:";
    [_PView addSubview:_PLabel];
    _PTapLabel = [UILabel new];
    _PTapLabel.font = [UIFont systemFontOfSize:14];
    _PTapLabel.text = @"低";
    _PTapLabel.userInteractionEnabled = YES;
    _PTapLabel.textAlignment = 0;
    [self.paramsDic setObject:@"3" forKey:@"priority"];
    [_PView addSubview:_PTapLabel];
    _PTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PAction:)];
    
    _describeLabel = [UILabel new];
    _describeLabel.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"报修描述:*"];
    [str1 addAttribute: NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(5, 1)];
    _describeLabel.attributedText = str1;
    [self addSubview:_describeLabel];
    _describeTextView = [UITextView new];
    _describeTextView.layer.borderWidth = .5;
    _describeTextView.delegate = self;
    _describeTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_describeTextView];
    
    _imgBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imgBtn1 setImage:[UIImage imageNamed:@"add"] forState:normal];
    [self addSubview:_imgBtn1];
    [_imgBtn1 addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _msgLabel = [UILabel new];
    _msgLabel.text = @"只允许添加三张";
    _msgLabel.font = k_text_font(8);
    [self addSubview:_msgLabel];
    _repairButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_repairButton setTitleColor:[UIColor whiteColor] forState:normal];
    [_repairButton setTitle:@"确认报修" forState:normal];
    _repairButton.backgroundColor = RGB(21, 125, 251);
    [self addSubview:_repairButton];
    
    _imgView1 = [UIImageView new];
    [self addSubview:_imgView1];
    _imgView2 = [UIImageView new];
    [self addSubview:_imgView2];
    _imgView3 = [UIImageView new];
    [self addSubview:_imgView3];
    _imgView1.hidden = _imgView3.hidden = _imgView2.hidden = YES;
    _tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    _tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTwoClick:)];
    _tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewThreeClick:)];
    _dimg1 = [UIImageView new];
    _dimg1.image = [UIImage imageNamed:@"downArrow"];
    [self addSubview:_dimg1];
    _dimg2 = [UIImageView new];
    _dimg2.image = [UIImage imageNamed:@"downArrow"];
    [self addSubview:_dimg2];
    _dimg3 = [UIImageView new];
    _dimg3.image = [UIImage imageNamed:@"downArrow"];
    [self addSubview:_dimg3];
    _dimg4 = [UIImageView new];
    _dimg4.image = [UIImage imageNamed:@"downArrow"];
    [self addSubview:_dimg4];
}
#pragma mark frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_PNView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(@40);
    }];
    [_PNLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(@80);
    }];
    [_PNTapLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.left.equalTo(_PNLabel.mas_right).offset(10);
    }];
    [_PNTapLabel addGestureRecognizer:_PNTap];
    [_FSView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_PNView);
        make.top.equalTo(_PNView.mas_bottom).offset(10);
    }];
    [_FSLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_PNLabel);
        make.top.bottom.offset(0);
    }];
    [_FSTapLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.left.equalTo(_PNTapLabel);
    }];
    [_FSTapLabel addGestureRecognizer:_FSTap];
    [_DTView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_PNView);
        make.top.equalTo(_FSView.mas_bottom).offset(10);
    }];
    [_DTLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.with.equalTo(_PNLabel);
        make.top.bottom.offset(0);
    }];
    [_DTTapLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.left.equalTo(_PNTapLabel);
    }];
    [_DTTapLabel addGestureRecognizer:_DTTap];
    [_PView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_PNView);
        make.top.equalTo(_DTView.mas_bottom).offset(10);
    }];
    [_PLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.with.equalTo(_PNLabel);
        make.top.bottom.offset(0);
    }];
    [_PTapLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.left.equalTo(_PNTapLabel);
    }];
    [_PTapLabel addGestureRecognizer:_PTap];
    [_describeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(_PView.mas_bottom).offset(10);
        make.height.mas_equalTo(@25);
    }];
    [_describeTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_describeLabel.mas_bottom).offset(0);
        make.right.offset(-10);
        make.height.mas_equalTo(@90);
    }];
    [_imgBtn1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_describeTextView.mas_bottom).offset(10);
        make.left.offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_imgView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(_imgBtn1);
        make.top.equalTo(_imgBtn1);
        make.left.equalTo(_imgBtn1.mas_right).offset(10);
    }];
    [_imgView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(_imgBtn1);
        make.top.equalTo(_imgBtn1);
        make.left.equalTo(_imgView1.mas_right).offset(10);
    }];
    [_imgView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(_imgBtn1);
        make.top.equalTo(_imgBtn1);
        make.left.equalTo(_imgView2.mas_right).offset(10);
    }];
    _imgView1.userInteractionEnabled = _imgView2.userInteractionEnabled = _imgView3.userInteractionEnabled = YES;
    [_imgView1 addGestureRecognizer:_tap1];
    [_imgView2 addGestureRecognizer:_tap2];
    [_imgView3 addGestureRecognizer:_tap3];
    [_msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgBtn1.mas_bottom).offset(5);
        make.left.equalTo(_imgBtn1);
    }];
    [_msgLabel sizeToFit];
    [_repairButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_msgLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(@40);
    }];
    [_dimg1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 10));
        make.centerY.equalTo(_PNTapLabel);
        make.right.offset(-30);
    }];
    [_dimg2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 10));
        make.centerY.equalTo(_FSTapLabel);
        make.right.offset(-30);
    }];
    [_dimg3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 10));
        make.centerY.equalTo(_DTTapLabel);
        make.right.offset(-30);
    }];
    [_dimg4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 10));
        make.centerY.equalTo(_PTapLabel);
        make.right.offset(-30);
    }];
}

@end
