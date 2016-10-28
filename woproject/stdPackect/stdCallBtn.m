//
//  stdCallBtn.m
//  TaoYXNew
//  呼叫号码lbl
//  Created by tianan-apple on 16/1/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "stdCallBtn.h"

@implementation stdCallBtn

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self addSubview:_titleLable];
        
        UIButton *myBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //myBtn.backgroundColor=[UIColor yellowColor];
        [self addSubview:myBtn];
        [myBtn addTarget:self action:@selector(clickMybtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)setLblText:(NSString*)mytitle{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:mytitle];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    _titleLable.attributedText = content;
    [_titleLable setTextColor:[UIColor blueColor]];
    _titleLable.font = [UIFont systemFontOfSize:13];

}
-(void)clickMybtn{
    NSString*mystring =_titleLable.text;
    if (mystring.length<1) {
        return;
    }
    NSRange range = [mystring rangeOfString:@"："];//匹配得到的下标
    if (range.location != NSNotFound) {
        mystring = [mystring substringFromIndex:range.location+1];//截取范围类的字符串
    }
    
    UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:mystring message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    [myalert show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{//取消
            
        }break;
        case 1:{//呼叫
            
                NSString * telStr=[NSString stringWithFormat:@"%@%@",@"tel://",alertView.title];
                //NSString * telStr=alertView.title;
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
            
            
        }break;
            
        default:
            break;
    }
}
@end
