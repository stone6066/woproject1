//
//  DropMenuListView.m
//  woproject
//
//  Created by 关宇琼 on 2016/11/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DropMenuListView.h"

NSString *const DropMenListViewToBaseViewControllerShowListNoti = @"extern NSString *const DropMenListViewToBaseViewControllerShowListNoti";


@interface DropMenuListView ()


@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *leftv;
@property (nonatomic, strong) UIView *middlev;
@property (nonatomic, strong) UIView *rightv;

@property (nonatomic, strong) UIImageView *leftImgev;
@property (nonatomic, strong) UIImageView *middleImgev;
@property (nonatomic, strong) UIImageView *rightImgev;

@end

@implementation DropMenuListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGB(254, 254, 254);
        
        
        [self lineView];
        [self leftv];
        [self middlev];
        [self rightv];
        
        _leftLb.text = @"请选择省";
        _middleLb.text = @"请选择市";
        _rightLb.text = @"请选择项";

    }
    return self;
}


- (UIView *)leftv {
    
    if (!_leftv) {
        
        _leftv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth / 3, 43)];
        
        _leftBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
        [_leftBt setFrame:CGRectMake(0, 0, fDeviceWidth / 3, 43)];
   
        _leftBt.tag = 1;
        self.leftLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,  fDeviceWidth / 3 *0.75, 43)];
        self.leftLb.textAlignment = 1;
        
        [_leftv addSubview:self.leftLb];
        
        _leftImgev =[[UIImageView alloc] initWithFrame:CGRectMake(fDeviceWidth / 3 *0.75, (43 - fDeviceWidth / 3 *0.1) / 2, fDeviceWidth / 3 *0.1, fDeviceWidth / 3 *0.1)];
        
        [_leftv addSubview:_leftImgev];
        
        [_leftImgev setImage:[UIImage imageNamed:@"dropmenu"]];
        
        [_leftv addSubview:_leftBt];
        
        [self addSubview:_leftv];

    }
    
    return _leftv;
}

- (UIView *)middlev {
    
    if (!_middlev) {
        _middlev = [[UIView alloc] initWithFrame:CGRectMake(fDeviceWidth / 3, 0, fDeviceWidth / 3, 43)];
        _middleBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
        
        [_middleBt setFrame:CGRectMake(0, 0, fDeviceWidth / 3, 43)];
        
        _middleBt.tag = 2;
        _middleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,  fDeviceWidth / 3 *0.75, 43)];
        _middleLb.textAlignment = 1;
        [_middlev addSubview:_middleLb];
        
        _middleImgev =[[UIImageView alloc] initWithFrame:CGRectMake(fDeviceWidth / 3 *0.75, (43 - fDeviceWidth / 3 *0.1) / 2, fDeviceWidth / 3 *0.1, fDeviceWidth / 3 *0.1)];
        [_middlev addSubview:_middleImgev];
        [_middleImgev setImage:[UIImage imageNamed:@"dropmenu"]];
        [_middlev addSubview:_middleBt];
        
        
        [self addSubview:_middlev];
    }
    
    return _middlev;
}

- (UIView *)rightv {
    
    if (!_rightv) {
        
        _rightv = [[UIView alloc] initWithFrame:CGRectMake(fDeviceWidth * 2 / 3, 0, fDeviceWidth / 3, 43)];
        
        _rightBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
        [_rightBt setFrame:CGRectMake(0, 0, fDeviceWidth / 3, 43)];
        
        _rightBt.tag = 3;
        _rightLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,  fDeviceWidth / 3 *0.75, 43)];
        _rightLb.textAlignment = 1;
        
        [_rightv addSubview:_rightLb];
        
        
        
        _rightImgev =[[UIImageView alloc] initWithFrame:CGRectMake(fDeviceWidth / 3 *0.75, (43 - fDeviceWidth / 3 *0.1) / 2, fDeviceWidth / 3 *0.1, fDeviceWidth / 3 *0.1)];
        [_rightv addSubview:_rightImgev];
        [_rightImgev setImage:[UIImage imageNamed:@"dropmenu"]];
        [_rightv addSubview:_rightBt];
        [self addSubview:_rightv];
    }
    
    return _rightv;
}




//- (void)removeshow:(NSNotification *)noti {
//    
//    NSString *lbtext = noti.userInfo[@"lbtext"];
//
//
//    UIView *v  = _titleArr[[noti.userInfo[@"choose"]  integerValue] - 1];
//    UIView *v2 = _titleArr [1];
//    UIView *v3 = _titleArr [2];
//
//    UILabel *lb2 = v2.subviews[0];
//    UILabel *lb3 = v3.subviews[0];
//
//    UILabel *lb = v.subviews[0];
//    
//    UIImageView *imgb = v.subviews[1];
//    
//    lb.textColor = [UIColor blackColor];
//    
//    if ([@2 isEqual:noti.userInfo[@"change"]]) {
//        lb2.text = @"请选择市";
//         lb3.text = @"请选择项";
//    }
//    if ([@3 isEqual:noti.userInfo[@"change"]]) {
//        lb3.text = @"请选择项";
//    }
//    
//    if (lbtext.length ==0 || [lbtext isEqualToString:@"请选择省"]) {
//        
//        lb.text = @"请选择省";
//        lb2.text = @"请选择市";
//        lb3.text = @"请选择项";
//        
//    } else {
//        
//        lb.text = lbtext;
//
//    }
//
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        
//        CGAffineTransform transform= CGAffineTransformMakeRotation(0);
//        
//        imgb.transform = transform;//旋转
//        
//    } completion:^(BOOL finished) {
//        
//        [imgb setImage:[UIImage imageNamed:@"dropmenu"]];
//        
//    }];
//    
//    _flag = NO;
//    
//}

- (UIView *)lineView {
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        
        [_lineView setFrame:CGRectMake(0, 43, fDeviceWidth, 1)];
        
        _lineView.backgroundColor = RGB(237, 237, 237);
        
        [self addSubview:_lineView];
        
        UIView *linev = [[UIView alloc] initWithFrame:CGRectMake(fDeviceWidth / 3, 10, 2, 24)];
        linev.backgroundColor  = RGB(237, 237, 237);
        
        [self addSubview: linev];
        
        UIView *linev1 = [[UIView alloc] initWithFrame:CGRectMake(fDeviceWidth * 2 / 3, 10, 2, 24)];
        
        linev1.backgroundColor  = RGB(237, 237, 237);
        
        [self addSubview: linev1];
        
        
        
    }
    return _lineView;
}

- (void)setTitleContentWithArr:(NSArray *)arr {
    
    
    
    
//    for (NSInteger i = 0 ; i < arr.count; i ++) {
//        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0 + fDeviceWidth / arr.count * i, 0, fDeviceWidth / arr.count, 43)];
//        v.tag = 100 + i;
//        [self addSubview:v];
//        UIButton *bt = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        [bt addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
//        [bt setFrame:CGRectMake(0, 0, fDeviceWidth / arr.count, 43)];
//        bt.tag = 1 + i;
//        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,  fDeviceWidth / arr.count *0.75, 43)];
//        lb.textAlignment = 1;
//        lb.text = arr[i];
//        
//        [v addSubview:lb];
//        UIImageView *imgv =[[UIImageView alloc] initWithFrame:CGRectMake(fDeviceWidth / arr.count *0.75, (43 - fDeviceWidth / arr.count *0.1) / 2, fDeviceWidth / arr.count *0.1, fDeviceWidth / arr.count *0.1)];
//        [v addSubview:imgv];
//        [imgv setImage:[UIImage imageNamed:@"dropmenu"]];
//        [v addSubview:bt];
//        
//        if (i != 2) {
//            UIView *linev = [[UIView alloc] initWithFrame:CGRectMake(fDeviceWidth / arr.count, 10, 2, 24)];
//            linev.backgroundColor  = RGB(237, 237, 237);
//            [v addSubview: linev];
//        } else {
//           
//        }
//        
//        [_titleArr addObject:v];
//    }
    
}

//- (void)buttonClick:(UIButton *)bt {
//    
//    
//    UIView *v1 = _titleArr[bt.tag - 1];
//    UILabel *lb1 = v1.subviews[0];
//
//    _tempStr = lb1.text;
//    
//    if (bt.tag == 2) {
//        UIView *v =  _titleArr[0];
//        UILabel *lb = v.subviews[0];
//        if ([lb.text isEqualToString:@"请选择省"]) {
//            [SVProgressHUD showInfoWithStatus:@"请先选择省"];
//            return;
//        }
//
//        
//    } else if (bt.tag == 3) {
//        UIView *v =  _titleArr[1];
//        UILabel *lb = v.subviews[0];
//        if ([lb.text isEqualToString:@"请选择市"]) {
//            [SVProgressHUD showInfoWithStatus:@"请先选择市"];
//            return;
//        }
//
//    }
//    
//    for (NSInteger i = 0 ; i < _titleArr.count ; i ++ ) {
//        
//        UIView *v =  _titleArr[i];
//        
//        UIButton *btin = v.subviews[2];
//        
//        UILabel *lb = v.subviews[0];
//        
//        UIImageView *imgb = v.subviews[1];
//        
//        
//        if ([bt isEqual:btin]) {
//            
//            if ([lb.textColor isEqual:[UIColor orangeColor]]) {
//                
//                lb.textColor = [UIColor blackColor];
//                
//                [UIView animateWithDuration:0.2 animations:^{
//                    
//                    CGAffineTransform transform= CGAffineTransformMakeRotation(0);
//                    
//                    imgb.transform = transform;//旋转
//                    
//                } completion:^(BOOL finished) {
//                    
//                    [imgb setImage:[UIImage imageNamed:@"dropmenu"]];
//                    
//                }];
//                
//                _flag = NO;
//                
//            } else {
//                
//                lb.textColor = [UIColor orangeColor];
//                [UIView animateWithDuration:0.2 animations:^{
//                    CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI);
//                    
//                    imgb.transform = transform;//旋转
//                } completion:^(BOOL finished) {
//                    [imgb setImage:[UIImage imageNamed:@"upmenu"]];
//                }];
//                _flag = YES;
//                
//            }
//            
//        } else {
//            
//            lb.textColor = [UIColor blackColor];
//            
//            [UIView animateWithDuration:0.2 animations:^{
//                CGAffineTransform transform= CGAffineTransformMakeRotation(0);
//                
//                imgb.transform = transform;//旋转
//            } completion:^(BOOL finished) {
//                
//                [imgb setImage:[UIImage imageNamed:@"dropmenu"]];
//                
//            }];
//            
//        }
//
//    }
// 
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    
//    [center postNotificationName:_superClassN object:nil  userInfo:@{@"choose":@(bt.tag), @"show":@(_flag), @"lbtext":_tempStr}];
//    
//    
//}

//- (void)setSuperClassN:(NSString *)superClassN {
//    if (_superClassN != superClassN) {
//        _superClassN = superClassN;
//    }
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeshow:) name:[NSString stringWithFormat:@"remove%@", _superClassN] object:nil];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
