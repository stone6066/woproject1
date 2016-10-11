//
//  stdTextField.m
//  nongcloud
//
//  Created by tianan-apple on 16/7/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "stdTextField.h"
#import "PublicDefine.h"

@implementation stdTextField

-(id)initWithFrame:(CGRect)frame titletxt:(NSString *)txt stdImg:(NSString*)img sendtag:(NSInteger)sendId{
    self = [super initWithFrame:frame];
    if (self) {
        if (!_titleLable) {
            _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            _titleLable.text=txt;
            [_titleLable setTextColor:txtColor];
            [_titleLable setFont:[UIFont systemFontOfSize:13]];
            [self addSubview:_titleLable];
        }
        if (!_iconImg) {
            _iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-30, 5, 20, 20)];
            _iconImg.image=[UIImage imageNamed:img];
            [self addSubview:_iconImg];
        }
        UIButton *myBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //myBtn.backgroundColor=[UIColor yellowColor]; "buttonClicked:"
        [self addSubview:myBtn];
        [myBtn addTarget:self action:@selector(clickMybtn:) forControlEvents:UIControlEventTouchUpInside];
        myBtn.tag=sendId;
        //_senderId=sendId;
        self.backgroundColor=MyGrayColor;
    }
    
    return self;
}
-(void)clickMybtn:(UIButton*) sender{
    [self.stdtxtDelegate TextFieldDelegate:sender];
}

-(void)setTitleLableTxt:(NSString*)txt{
    [_titleLable setText:txt];
}
-(void)setTxtId:(NSString *)txtId{
    _txtId=txtId;
}
@end
