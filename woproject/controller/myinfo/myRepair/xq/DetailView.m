//
//  DetailView.m
//  woproject
//
//  Created by 徐洋 on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DetailView.h"
#import "DetailModel.h"
#import "LZModel.h"
#import "PDDetailView.h"
#import "JDDetailView.h"
#import "DCDetailView.h"
//完成和挂起和退单长的一样用一个view
#import "WCDetailView.h"
#import "SHDView.h"

@interface DetailView()
<
    SDPhotoBrowserDelegate
>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *stateView;//工单状态
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *dqztLabel;
@property (nonatomic, strong) UILabel *dqztContent;//当前状态
@property (nonatomic, strong) UILabel *gdbhLabel;
@property (nonatomic, strong) UIView *bxxxView;//报修信息
@property (nonatomic, strong) UILabel *bxxxLabel;
@property (nonatomic, strong) UIView *bxxxContentView;
@property (nonatomic, strong) UILabel *bxsjLabel;//报修时间
@property (nonatomic, strong) UILabel *bxsjContent;
@property (nonatomic, strong) UILabel *bxrLabel;//报修人
@property (nonatomic, strong) UILabel *bxrContent;
@property (nonatomic, strong) UILabel *xmmcLabel;//项目名称
@property (nonatomic, strong) UILabel *xmmcContent;
@property (nonatomic, strong) UILabel *gzsbLabel;//故障设备
@property (nonatomic, strong) UILabel *gzsbContent;
@property (nonatomic, strong) UILabel *gzwzLabel;//故障位置
@property (nonatomic, strong) UILabel *gzwzContent;
@property (nonatomic, strong) UILabel *yxjLabel;//优先级
@property (nonatomic, strong) UILabel *yxjContent;
@property (nonatomic, strong) UILabel *gzmsLabel;//故障描述
@property (nonatomic, strong) UILabel *gzmsContent;
@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;
@property (nonatomic, strong) UIImageView *imgView3;
@property (nonatomic, strong) UITapGestureRecognizer *tap1;
@property (nonatomic, strong) UITapGestureRecognizer *tap2;
@property (nonatomic, strong) UITapGestureRecognizer *tap3;
@property (nonatomic, strong) UIButton *bxrPhone;

@property (nonatomic, strong) UIView *tmpView;
@property (nonatomic, strong) PDDetailView *pdv;
@property (nonatomic, strong) JDDetailView *jdv;
@property (nonatomic, strong) DCDetailView *dcv;

@end

@implementation DetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
    }
    return self;
}

- (void)setModel:(DetailModel *)model
{
    _model = model;
    NSLog(@"%@", model);
    NSLog(@"流转记录:%@", model.ticketFlowList);
    if (model.imageList.count != 0) {
        [_bxxxContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            
           make.bottom.equalTo(_gzmsContent.mas_bottom).offset(55);
            
        }];
    }
    switch (model.imageList.count) {
        case 0:
        {
            _imgView1.hidden = YES;
            _imgView2.hidden = YES;
            _imgView3.hidden = YES;
        }
            break;
        case 1:
        {
            _imgView2.hidden = YES;
            _imgView3.hidden = YES;
            _imgView1.hidden = NO;
            [_imgView1 sd_setImageWithURL:[NSURL URLWithString:model.imageList[0][@"url"]] placeholderImage:[UIImage imageNamed:@"login_icon"]];
        }
            break;
        case 2:
            _imgView3.hidden = YES;
            _imgView1.hidden = _imgView2.hidden = NO;
            [_imgView1 sd_setImageWithURL:[NSURL URLWithString:model.imageList[0][@"url"]] placeholderImage:[UIImage imageNamed:@"login_icon"]];
            [_imgView2 sd_setImageWithURL:[NSURL URLWithString:model.imageList[1][@"url"]] placeholderImage:[UIImage imageNamed:@"login_icon"]];
            break;
        case 3:
            _imgView2.hidden = _imgView1.hidden = _imgView3.hidden = NO;
            [_imgView1 sd_setImageWithURL:[NSURL URLWithString:model.imageList[0][@"url"]] placeholderImage:[UIImage imageNamed:@"login_icon"]];
            [_imgView2 sd_setImageWithURL:[NSURL URLWithString:model.imageList[1][@"url"]] placeholderImage:[UIImage imageNamed:@"login_icon"]];
            [_imgView3 sd_setImageWithURL:[NSURL URLWithString:model.imageList[2][@"url"]] placeholderImage:[UIImage imageNamed:@"login_icon"]];
            break;
    }
    _dqztContent.text = model.status;
    _gdbhLabel.text = [NSString stringWithFormat:@"工单编号:%@", model.Id];
    _yxjContent.text = model.priority;
    _gzmsContent.text = model.faultDesc;
    _xmmcContent.text = model.projectId;
    _bxsjContent.text = [self stdTimeToStr:model.createTime];
    _bxrContent.text = model.userName;
    _gzsbContent.text = model.deviceName;
    _gzwzContent.text = model.faultPos;
    _tmpView = _bxxxContentView;
    [model.ticketFlowList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LZModel *lz = [LZModel yy_modelWithJSON:obj];
        switch (lz.operation.integerValue) {
            case 0:
            {
                NSLog(@"派单信息");
                [self addPDView:lz];
            }
                break;
            case 1:
            {
                NSLog(@"接单信息");
                [self addJDView:lz];
            }
                break;
            case 2:
            {
                NSLog(@"到场信息");
                [self addDCView:lz];
            }
                break;
            case 3:
            {
                NSLog(@"完成信息");
                [self addWCView:lz];
            }
                break;
            case 4:
            {
                NSLog(@"核查信息");
                [self addSHView:lz];
            }
                break;
            case 5:
            {
                NSLog(@"退单信息");
                [self addWCView:lz];
            }
                break;
            case 6:
            {
                NSLog(@"挂起信息");
                [self addWCView:lz];
            }
                break;
                
            default:
                break;
        }
        NSLog(@"第%ld次流转记录%@", idx, lz);
    }];
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

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [objDateformat stringFromDate: date];
}

- (void)imageViewClick:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = 0;
    photoBrowser.imageCount = _model.imageList.count;
    photoBrowser.sourceImagesContainerView = _bxxxContentView;
    [photoBrowser show];
}
- (void)imageViewTwoClick:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = 1;
    photoBrowser.imageCount = _model.imageList.count;
    photoBrowser.sourceImagesContainerView = _bxxxContentView;
    [photoBrowser show];
}
- (void)imageViewThreeClick:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = 2;
    photoBrowser.imageCount = _model.imageList.count;
    photoBrowser.sourceImagesContainerView = _bxxxContentView;
    [photoBrowser show];
}

- (void)addPDView:(LZModel *)model
{
    if (model.operation == nil) return;
    PDDetailView *pdv = [[PDDetailView alloc] init];
    pdv.model = model;
    pdv.yxjContent.text = _model.priority;
    [_scrollView addSubview:pdv];
    WS(weakSelf);
    [pdv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tmpView.mas_bottom).offset(10);
        make.left.width.equalTo(_bxxxContentView);
        make.bottom.equalTo(pdv.yxjLabel.mas_bottom).offset(10);
    }];
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(pdv.mas_bottom).offset(10);
    }];
    _tmpView = pdv;
}
- (void)addJDView:(LZModel *)model
{
    if (model.operation == nil) return;
    JDDetailView *jdv = [[JDDetailView alloc] init];
    jdv.model = model;
    [_scrollView addSubview:jdv];
    WS(weakSelf);
    [jdv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tmpView.mas_bottom).offset(0);
        make.left.width.equalTo(_bxxxContentView);
        make.bottom.equalTo(jdv.gzLabel.mas_bottom).offset(10);
    }];
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(jdv.mas_bottom).offset(10);
    }];
    _tmpView = jdv;
}

- (void)addDCView:(LZModel *)model
{
    if (model.operation == nil) return;
    DCDetailView *dcv = [[DCDetailView alloc] init];
    dcv.model = model;
    [_scrollView addSubview:dcv];
    WS(weakSelf);
    [dcv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tmpView.mas_bottom).offset(0);
        make.left.width.equalTo(_bxxxContentView);
        make.bottom.equalTo(dcv.dcrLabel.mas_bottom).offset(10);
    }];
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(dcv.mas_bottom).offset(10);
    }];
    _tmpView = dcv;
}
- (void)addWCView:(LZModel *)model
{
    if (model.operation == nil) return;
    WCDetailView *wcv = [[WCDetailView alloc] init];
    wcv.model = model;
    [_scrollView addSubview:wcv];
    WS(weakSelf);
    [wcv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tmpView.mas_bottom).offset(0);
        make.left.width.equalTo(_bxxxContentView);
        if (model.imageList.count == 0) {
            make.bottom.equalTo(wcv.wxjgContent.mas_bottom).offset(10);
        }else{
            make.bottom.equalTo(wcv.imgView1.mas_bottom).offset(10);
        }
    }];
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
        if (model.operation.integerValue == 3) {
            make.bottom.mas_equalTo(wcv.mas_bottom).offset(40);
        }else{
            make.bottom.mas_equalTo(wcv.mas_bottom).offset(10);
        }
    }];
    _detailBtn.hidden = model.operation.integerValue == 3?NO:YES;
    _tmpView = wcv;
}
- (void)addSHView:(LZModel *)model
{
    if (model.operation == nil) return;
    SHDView *shv = [[SHDView alloc] init];
    shv.model = model;
    [_scrollView addSubview:shv];
    WS(weakSelf);
    [shv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tmpView.mas_bottom).offset(0);
        make.left.width.equalTo(_bxxxContentView);
        make.bottom.equalTo(shv.shyjContent.mas_bottom).offset(5);
    }];
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(shv.mas_bottom).offset(0);
    }];
    _tmpView = shv;
}

- (void)pingjiaAction:(UIButton *)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(detailViewButtonAction:)]) {
        [self.delegate detailViewButtonAction:_model.Id];
    }
}

- (void)callForBxrPhone:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", _model.userPhone]]];
}

- (void)setSubViews
{
    _scrollView = [UIScrollView new];
    [self addSubview:_scrollView];
    _stateView = [UIView new];
    _stateView.backgroundColor = RGB(230, 239, 247);
    [_scrollView addSubview:_stateView];
    _stateLabel = [UILabel new];
    _stateLabel.text = @"工单状态";
    _stateLabel.font = k_text_font(14);
    _stateLabel.textColor = RGB(26, 71, 113);
    [_scrollView addSubview:_stateLabel];
    _dqztLabel = [UILabel new];
    _dqztLabel.text = @"当前状态:";
    _dqztLabel.font = k_text_font(14);
    [_scrollView addSubview:_dqztLabel];
    _dqztContent = [UILabel new];
    _dqztContent.font = k_text_font(18);
    _dqztContent.textColor = RGB(48, 137, 246);
    [_scrollView addSubview:_dqztContent];
    _gdbhLabel = [UILabel new];
    _gdbhLabel.font = k_text_font(14);
    _gdbhLabel.textAlignment = 2;
    [_scrollView addSubview:_gdbhLabel];
    _bxxxView = [UIView new];
    _bxxxView.backgroundColor = RGB(230, 239, 247);
    [_scrollView addSubview:_bxxxView];
    _bxxxLabel = [UILabel new];
    _bxxxLabel.font = k_text_font(14);
    _bxxxLabel.text = @"报修信息";
    _bxxxLabel.textColor = RGB(26, 71, 113);
    [_bxxxView addSubview:_bxxxLabel];
    _bxxxContentView = [UIView new];
    _bxxxContentView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_bxxxContentView];
    _bxsjLabel = [UILabel new];
    _bxsjLabel.font = k_text_font(14);
    _bxsjLabel.textAlignment = 2;
    _bxsjLabel.text = @"报修时间:";
    [_bxxxContentView addSubview:_bxsjLabel];
    _bxsjContent = [UILabel new];
    _bxsjContent.font = k_text_font(14);
    [_bxxxContentView addSubview:_bxsjContent];
    _bxrLabel = [UILabel new];
    _bxrLabel.font = k_text_font(14);
    _bxrLabel.textAlignment = 2;
    _bxrLabel.text = @"报修人:";
    [_bxxxContentView addSubview:_bxrLabel];
    _bxrContent = [UILabel new];
    _bxrContent.font = k_text_font(14);
    [_bxxxContentView addSubview:_bxrContent];
    _xmmcLabel = [UILabel new];
    _xmmcLabel.font = k_text_font(14);
    _xmmcLabel.textAlignment = 2;
    _xmmcLabel.text = @"项目名称:";
    [_bxxxContentView addSubview:_xmmcLabel];
    _xmmcContent = [UILabel new];
    _xmmcContent.font = k_text_font(14);
    [_bxxxContentView addSubview:_xmmcContent];
    _gzsbLabel = [UILabel new];
    _gzsbLabel.font = k_text_font(14);
    _gzsbLabel.textAlignment = 2;
    _gzsbLabel.text = @"故障设备:";
    [_bxxxContentView addSubview:_gzsbLabel];
    _gzsbContent = [UILabel new];
    _gzsbContent.font = k_text_font(14);
    [_bxxxContentView addSubview:_gzsbContent];
    _gzwzLabel = [UILabel new];
    _gzwzLabel.font = k_text_font(14);
    _gzwzLabel.textAlignment = 2;
    _gzwzLabel.text = @"故障位置:";
    [_bxxxContentView addSubview:_gzwzLabel];
    _gzwzContent = [UILabel new];
    _gzwzContent.font = k_text_font(14);
    [_bxxxContentView addSubview:_gzwzContent];
    _yxjLabel = [UILabel new];
    _yxjLabel.font = k_text_font(14);
    _yxjLabel.textAlignment = 2;
    _yxjLabel.text = @"优先级:";
    [_bxxxContentView addSubview:_yxjLabel];
    _yxjContent = [UILabel new];
    _yxjContent.font = k_text_font(14);
    [_bxxxContentView addSubview:_yxjContent];
    _gzmsLabel = [UILabel new];
    _gzmsLabel.font = k_text_font(14);
    _gzmsLabel.textAlignment = 2;
    _gzmsLabel.text = @"故障描述:";
    [_bxxxContentView addSubview:_gzmsLabel];
    _gzmsContent = [UILabel new];
    _gzmsContent.font = k_text_font(14);
    [_bxxxContentView addSubview:_gzmsContent];
    _imgView1 = [UIImageView new];
    [_bxxxContentView addSubview:_imgView1];
    _imgView2 = [UIImageView new];
    [_bxxxContentView addSubview:_imgView2];
    _imgView3 = [UIImageView new];
    [_bxxxContentView addSubview:_imgView3];
    _detailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _detailBtn.backgroundColor = RGB(21, 125, 250);
    [_detailBtn setTitleColor:[UIColor whiteColor] forState:normal];
    [_scrollView addSubview:_detailBtn];
    [_detailBtn addTarget:self action:@selector(pingjiaAction:) forControlEvents:UIControlEventTouchUpInside];
    _detailBtn.hidden = YES;
    _imgView1.hidden = _imgView2.hidden = _imgView3.hidden = YES;
    _bxrPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bxrPhone setImage:[UIImage imageNamed:@"tel"] forState:normal];
    _bxrPhone.layer.cornerRadius = 20.f;
    _bxrPhone.layer.masksToBounds = YES;
    [_bxrPhone addTarget:self action:@selector(callForBxrPhone:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_bxrPhone];
    _imgView1.userInteractionEnabled = YES;
    _imgView2.userInteractionEnabled = YES;
    _imgView3.userInteractionEnabled = YES;
    _tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    _tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTwoClick:)];
    _tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewThreeClick:)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    WS(weakSelf);
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(_bxxxContentView.mas_bottom).offset(10);
    }];
    [_stateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf).offset(0);
        make.top.equalTo(_scrollView);
        make.height.mas_equalTo(@40);
    }];
    [_stateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(_stateView);
    }];
    [_dqztLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_stateView.mas_bottom).offset(10);
    }];
    [_dqztContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dqztLabel);
        make.left.equalTo(_dqztLabel.mas_right).offset(0);
    }];
    [_gdbhLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-10);
        make.centerY.equalTo(_dqztLabel);
    }];
    [_bxxxView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dqztLabel.mas_bottom).offset(10);
        make.left.right.height.equalTo(_stateView);
    }];
    [_bxxxLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bxxxView);
        make.left.offset(10);
    }];
    [_bxxxContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.equalTo(weakSelf).offset(0);
        make.top.equalTo(_bxxxView.mas_bottom).offset(0);
        make.bottom.equalTo(_gzmsContent.mas_bottom).offset(5);
    }];
    [_bxsjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_bxxxView.mas_bottom).offset(10);
        make.width.mas_equalTo(@70);
    }];
    [_bxsjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bxsjLabel.mas_right).offset(0);
        make.top.equalTo(_bxsjLabel);
    }];
    [_bxrLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_bxsjLabel);
        make.top.equalTo(_bxsjLabel.mas_bottom).offset(5);
    }];
    [_bxrContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bxrLabel.mas_right);
        make.top.equalTo(_bxrLabel);
    }];
    [_xmmcLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_bxsjLabel);
        make.top.equalTo(_bxrLabel.mas_bottom).offset(5);
    }];
    [_xmmcContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_xmmcLabel);
        make.left.equalTo(_xmmcLabel.mas_right);
    }];
    [_gzsbLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_xmmcLabel);
        make.top.equalTo(_xmmcLabel.mas_bottom).offset(5);
    }];
    [_gzsbContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gzsbLabel);
        make.left.equalTo(_gzsbLabel.mas_right);
    }];
    [_gzwzLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_bxsjLabel);
        make.top.equalTo(_gzsbLabel.mas_bottom).offset(5);
    }];
    [_gzwzContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gzwzLabel);
        make.left.equalTo(_gzwzLabel.mas_right);
    }];
    [_yxjLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_bxsjLabel);
        make.top.equalTo(_gzwzLabel.mas_bottom).offset(5);
    }];
    [_yxjContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_yxjLabel);
        make.left.equalTo(_yxjLabel.mas_right);
    }];
    [_gzmsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_bxsjLabel);
        make.top.equalTo(_yxjLabel.mas_bottom).offset(5);
    }];
    [_gzmsContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.equalTo(weakSelf).offset(-20);
        make.height.lessThanOrEqualTo(@50);
        make.top.equalTo(_gzmsLabel.mas_bottom).offset(5);
    }];
    [_imgView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(_gzmsContent.mas_bottom).offset(5);
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
    [_bxrPhone mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.equalTo(weakSelf).offset(-20);
        make.top.equalTo(_bxxxView.mas_bottom).offset(20);
    }];
    if (_type.integerValue == 0 || _type.integerValue == 2) {
        [_detailBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf);
            make.bottom.equalTo(_scrollView);
            make.height.mas_equalTo(@40);
        }];
    }
    [_imgView1 addGestureRecognizer:_tap1];
    [_imgView2 addGestureRecognizer:_tap2];
    [_imgView3 addGestureRecognizer:_tap3];
}

@end
