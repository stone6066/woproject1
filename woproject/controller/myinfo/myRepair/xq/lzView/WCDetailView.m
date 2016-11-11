//
//  WCDetailView.m
//  woproject
//
//  Created by 徐洋 on 2016/10/26.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "WCDetailView.h"
#import "LZModel.h"

@interface WCDetailView ()
<
    SDPhotoBrowserDelegate
>

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
/**
 完成
 */
@property (nonatomic, strong) UILabel *wcsjLabel;
@property (nonatomic, strong) UILabel *wcsjContent;
@property (nonatomic, strong) UILabel *wcrLabel;
@property (nonatomic, strong) UILabel *wcrContent;
@property (nonatomic, strong) UILabel *wxjgLabel;
@property (nonatomic, strong) UIImageView *imgView2;
@property (nonatomic, strong) UIImageView *imgView3;

@end

@implementation WCDetailView

- (instancetype)init
{
    if (self = [super init]) {
        [self setSubViews];
    }
    return self;
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [objDateformat stringFromDate: date];
}

- (void)setModel:(LZModel *)model
{
    _model = model;
    if (model.operation.integerValue == 6) {
        _titleLabel.text = @"挂起信息";
        _wcsjLabel.text = @"挂起时间:";
        _wcrLabel.text = @"挂起人:";
        _wxjgLabel.text = @"挂起原因:";
    }
    if (model.operation.integerValue == 5) {
        _titleLabel.text = @"退单信息";
        _wcsjLabel.text = @"退单时间:";
        _wcrLabel.text = @"退单人:";
        _wxjgLabel.text = @"退单原因:";
    }
    _wcsjContent.text = [self stdTimeToStr:model.operationTime];
    _wcrContent.text = model.operationUser;
    _wxjgContent.text = model.result;
    switch (model.imageList.count) {
        case 0:
        {
            _imgView1.hidden = _imgView2.hidden = _imgView3.hidden = YES;
        }
            break;
        case 1:
        {
            _imgView2.hidden = _imgView3.hidden = YES;
            [_imgView1 sd_setImageWithURL:[NSURL URLWithString:model.imageList[0][@"url"]] placeholderImage:nil];
        }
            break;
        case 2:
        {
            _imgView3.hidden = YES;
            [_imgView1 sd_setImageWithURL:[NSURL URLWithString:model.imageList[0][@"url"]] placeholderImage:nil];
            [_imgView2 sd_setImageWithURL:[NSURL URLWithString:model.imageList[1][@"url"]] placeholderImage:nil];
        }
            break;
        case 3:
        {
            [_imgView1 sd_setImageWithURL:[NSURL URLWithString:model.imageList[0][@"url"]] placeholderImage:nil];
            [_imgView2 sd_setImageWithURL:[NSURL URLWithString:model.imageList[1][@"url"]] placeholderImage:nil];
            [_imgView3 sd_setImageWithURL:[NSURL URLWithString:model.imageList[2][@"url"]] placeholderImage:nil];
        }
            break;
    }
}

- (void)imageViewClick:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = 0;
    photoBrowser.imageCount = _model.imageList.count;
    photoBrowser.sourceImagesContainerView = self;
    [photoBrowser show];
}
- (void)imageViewTwoClick:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = 1;
    photoBrowser.imageCount = _model.imageList.count;
    photoBrowser.sourceImagesContainerView = self;
    [photoBrowser show];
}
- (void)imageViewThreeClick:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = 2;
    photoBrowser.imageCount = _model.imageList.count;
    photoBrowser.sourceImagesContainerView = self;
    [photoBrowser show];
}

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [UIImage imageNamed:@"login_icon"];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = _model.imageList[index][@"url"];
    return [NSURL URLWithString:urlStr];
}


- (void)setSubViews
{
    _titleView = [UIView new];
    _titleView.backgroundColor = RGB(230, 239, 247);
    [self addSubview:_titleView];
    _titleLabel = [UILabel new];
    _titleLabel.text = @"完成信息";
    _titleLabel.textColor = RGB(26, 71, 113);
    _titleLabel.font = k_text_font(14);
    [_titleView addSubview:_titleLabel];
    _wcsjLabel = [UILabel new];
    _wcsjLabel.text = @"完成时间:";
    _wcsjLabel.font = k_text_font(14);
    _wcsjLabel.textAlignment = 2;
    [self addSubview:_wcsjLabel];
    _wcsjContent = [UILabel new];
    _wcsjContent.font = k_text_font(14);
    [self addSubview:_wcsjContent];
    _wcrLabel = [UILabel new];
    _wcrLabel.text = @"完成人:";
    _wcrLabel.font = k_text_font(14);
    _wcrLabel.textAlignment = 2;
    [self addSubview:_wcrLabel];
    _wcrContent = [UILabel new];
    _wcrContent.font = k_text_font(14);
    [self addSubview:_wcrContent];
    _wxjgLabel = [UILabel new];
    _wxjgLabel.text = @"维修结果:";
    _wxjgLabel.font = k_text_font(14);
    _wxjgLabel.textAlignment = 2;
    [self addSubview:_wxjgLabel];
    _wxjgContent = [UILabel new];
    _wxjgContent.font = k_text_font(14);
    _wxjgContent.numberOfLines = 0;
    [self addSubview:_wxjgContent];
    _imgView1 = [UIImageView new];
    [self addSubview:_imgView1];
    _imgView2 = [UIImageView new];
    [self addSubview:_imgView2];
    _imgView3 = [UIImageView new];
    [self addSubview:_imgView3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    [_imgView1 addGestureRecognizer:tap];
    _imgView1.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTwoClick:)];
    [_imgView2 addGestureRecognizer:tap2];
    _imgView2.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewThreeClick:)];
    [_imgView3 addGestureRecognizer:tap3];
    _imgView3.userInteractionEnabled = YES;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    WS(weakSelf);
    [_titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf).offset(0);
        make.height.mas_equalTo(@40);
    }];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.equalTo(_titleView);
    }];
    [_wcsjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@70);
        make.left.offset(10);
        make.top.equalTo(_titleView.mas_bottom).offset(10);
    }];
    [_wcsjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wcsjLabel);
        make.left.equalTo(_wcsjLabel.mas_right);
    }];
    [_wcrLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_wcsjLabel);
        make.top.equalTo(_wcsjLabel.mas_bottom).offset(5);
    }];
    [_wcrContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wcrLabel);
        make.left.equalTo(_wcrLabel.mas_right);
    }];
    [_wxjgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_wcsjLabel);
        make.top.equalTo(_wcrLabel.mas_bottom).offset(5);
    }];
    [_wxjgContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.equalTo(_wxjgLabel.mas_bottom).offset(5);
        make.height.lessThanOrEqualTo(@50);
    }];
    [_imgView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(_wxjgContent.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_imgView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_imgView1);
        make.left.equalTo(_imgView1.mas_right).offset(10);
    }];
    [_imgView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_imgView1);
        make.left.equalTo(_imgView2.mas_right).offset(10);
    }];
}

@end
