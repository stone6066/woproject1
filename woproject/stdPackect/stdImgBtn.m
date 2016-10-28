//
//  stdImgBtn.m
//  PropertyManage
//
//  Created by tianan-apple on 16/6/30.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "stdImgBtn.h"
#import "PublicDefine.h"
@implementation stdImgBtn

-(id)initWithFrame:(CGRect)frame imgName:(NSString*)imgstr lblName:(NSString*)lblstr sendId:(NSInteger)sId{
    self = [super initWithFrame:frame];
    if (self) {
        _senderId=sId;
        CGFloat viewWidth=frame.size.width;
        CGFloat viewHeight=frame.size.height;
        CGFloat imgHW=4;
        CGFloat imgW=viewWidth-imgHW*2;
        _btnImg=[[UIImageView alloc]initWithFrame:CGRectMake(imgHW, imgHW, imgW, imgW)];
        _btnImg.image=[UIImage imageNamed:imgstr];
        [self addSubview:_btnImg];
        
        _btnLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, viewWidth, viewWidth, 20)];
        _btnLbl.text=lblstr;
        [_btnLbl setFont:[UIFont systemFontOfSize:13]];
        [_btnLbl setTextColor:txtColor];
        [_btnLbl setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_btnLbl];
        
        _btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
        [_btn addTarget:self action:@selector(myClickBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn];
    
    }
    return self;
}
-(void)myClickBtn{
    [self.stdImgBtnDelegate stdImgClickDelegate:_senderId];
}

@end
