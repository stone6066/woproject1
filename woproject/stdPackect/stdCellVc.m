//
//  stdCellVc.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/21.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "stdCellVc.h"
#import "PublicDefine.h"

@implementation stdCellVc

-(id)initWithFrame:(CGRect)frame iocnImg:(NSString*)iconImgName titleName:(NSString*)titleStr txtName:(NSString*)txtStr lookImg:(NSString*)lookStr sendid:(NSInteger)sendId{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat cellWidth=frame.size.width;
        CGFloat cellHeight=frame.size.height;
        CGFloat lblHeigh=20;
        CGFloat lblWidth=titleStr.length*22;
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(45, (cellHeight-lblHeigh)/2, lblWidth, lblHeigh)];
        
        [_titleLable setFont:[UIFont systemFontOfSize:13]];
         CGSize size = [titleStr sizeWithFont:_titleLable.font constrainedToSize:CGSizeMake(MAXFLOAT, _titleLable.frame.size.height)];

        if ([titleStr isEqualToString:@"地址："]) {//地址可以折行显示
            CGSize txtsize = [txtStr sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(cellWidth-size.width-50,10000.0f)lineBreakMode:UILineBreakModeWordWrap];
            _txtLable=[[UILabel alloc]initWithFrame:CGRectMake(45+size.width+5, (cellHeight-lblHeigh)/2, txtsize.width, txtsize.height)];
            
            _txtLable.numberOfLines = 0; // 最关键的一句
            
            _txtLable.font = [UIFont systemFontOfSize:13];
        }
        else{
            lblWidth=txtStr.length*20;
            _txtLable = [[UILabel alloc] initWithFrame:CGRectMake(45+size.width+5, (cellHeight-lblHeigh)/2, lblWidth, lblHeigh)];
            [_txtLable setFont:[UIFont systemFontOfSize:13]];
        }
      
        
        
        
        
        
        _iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(15, (cellHeight-20)/2, 20, 20)];
        _lookImg=[[UIImageView alloc]initWithFrame:CGRectMake(cellWidth-30, (cellHeight-20)/2, 12, 20)];
        
        _titleLable.text=titleStr;
        _txtLable.text=txtStr;
        _iconImg.image=[UIImage imageNamed:iconImgName];
        _lookImg.image=[UIImage imageNamed:lookStr];
        
        
        [_titleLable setTextColor:[UIColor blackColor]];
        [_txtLable setTextColor:[UIColor blackColor]];
        
        [self addSubview:_titleLable];
        [self addSubview:_txtLable];
        [self addSubview:_iconImg];
        [self addSubview:_lookImg];
        self.backgroundColor=[UIColor whiteColor];
        
        _senderId=sendId;
        UIButton *myBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
        //myBtn.backgroundColor=[UIColor yellowColor];
        [self addSubview:myBtn];
        [myBtn addTarget:self action:@selector(clickMybtn) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return self;
}

-(void)clickMybtn{
    [self.stdDelegate clickDelegate:_senderId];
    
    //NSLog(@"%@",mystring);
}

@end
