//
//  backOrderViewInfo.m
//  woproject
//
//  Created by tianan-apple on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "backOrderViewInfo.h"
#import "ticketInfo.h"
#import "ticketFlowInfo.h"
@implementation backOrderViewInfo

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        CGFloat viewWidth=frame.size.width;
        //CGFloat viewHeight=frame.size.height;
        
        UIView *topTitleVc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 30)];
        topTitleVc.backgroundColor=bluebackcolor;
        _myViewTitle=[[UILabel alloc]initWithFrame:CGRectMake(5, 2, 100, 20)];
        _myViewTitle.text=@"退单信息";
        [topTitleVc addSubview:_myViewTitle];
        [self addSubview:topTitleVc];
        
        
        
        
        CGFloat firstLbY=35;//第一个lab的y
        CGFloat fisttLbX=15;
        
        CGFloat labWidthTitle=80;//lab的宽度（标题lab）
        CGFloat secondLbX=15+labWidthTitle;
        CGFloat labHeigh=20;//lab的高度
        CGFloat spritePaceY=15+labHeigh;//lab之间的间隔
        CGFloat labWidth=viewWidth-25-labWidthTitle;//lab的宽度（数据lab）
        
        _operationTimeTitle=[[UILabel alloc]init];
        _operationTime=[[UILabel alloc]init];
        
        _userIdTitle=[[UILabel alloc]init];
        _userId=[[UILabel alloc]init];
        
        _hangupResonTitle=[[UILabel alloc]init];
        _hangupReson=[[UILabel alloc]init];
        
        
        [self stdInitLab:_operationTimeTitle labFrame:CGRectMake(fisttLbX, firstLbY, labWidthTitle, labHeigh)];
        _operationTimeTitle.text=@"退单时间：";
        
        [self stdInitLab:_userIdTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY, labWidthTitle, labHeigh)];
        _userIdTitle.text=@"退单人：";
        
        
        [self stdInitLab:_hangupResonTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY*2, labWidthTitle, labHeigh)];
        _hangupResonTitle.text=@"退单描述：";
        
        [self stdInitLab:_operationTime labFrame:CGRectMake(secondLbX, firstLbY, labWidth, labHeigh)];
        
        [self stdInitLab:_userId labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY, labWidth, labHeigh)];
        
        [self stdInitLab:_hangupReson labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY*2, labWidth, labHeigh)];
        _hangupReson.numberOfLines=0;//多行显示
        
        
    }
    return self;
}


-(void)stdInitLab:(UILabel*)stdLab labFrame:(CGRect)labF{
    stdLab.frame=labF;
    [stdLab setFont:[UIFont systemFontOfSize:14]];
    stdLab.textColor=graytxtcolor;
    //stdLab.backgroundColor=[UIColor yellowColor];
    [self addSubview:stdLab];
}


-(void)asignDataToLab:(ticketFlowInfo*)modelData{
    @try {
        _operationTime.text=[self stdTimeToStr:modelData.operationTime];
        _userId.text=modelData.userId;
        _hangupReson.text=modelData.result;
        _operationPhone=modelData.operationPhone;
        
    } @catch (NSException *exception) {
        NSLog(@"结构不对爆炸了");
    } @finally {
        return;
    }
}
-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [objDateformat stringFromDate: date];
}

@end
