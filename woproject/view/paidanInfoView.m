//
//  paidanInfoView.m
//  woproject
//
//  Created by tianan-apple on 16/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "paidanInfoView.h"
#import "ticketInfo.h"
#import "ticketFlowInfo.h"

@implementation paidanInfoView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        CGFloat viewWidth=frame.size.width;
        CGFloat viewHeight=frame.size.height;
        
        UIView *topTitleVc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 30)];
        topTitleVc.backgroundColor=bluebackcolor;
        _myViewTitle=[[UILabel alloc]initWithFrame:CGRectMake(5, 2, 100, 20)];
        _myViewTitle.text=@"派单信息";
        [topTitleVc addSubview:_myViewTitle];
        [self addSubview:topTitleVc];
        
        
        
        
        CGFloat firstLbY=35;//第一个lab的y
        CGFloat fisttLbX=15;
        
        CGFloat labWidthTitle=80;//lab的宽度（标题lab）
        CGFloat secondLbX=15+70;
        CGFloat labHeigh=20;//lab的高度
        CGFloat spritePaceY=15+labHeigh;//lab之间的间隔
        CGFloat labWidth=viewWidth-25-labWidthTitle;//lab的宽度（数据lab）
        
        _operationTimeTitle=[[UILabel alloc]init];
        _operationTime=[[UILabel alloc]init];
        _operationUserTitle=[[UILabel alloc]init];
        _operationUser=[[UILabel alloc]init];
        _userIdTitle=[[UILabel alloc]init];
        _userId=[[UILabel alloc]init];
        _deptIdTitle=[[UILabel alloc]init];
        _deptId=[[UILabel alloc]init];
        _priorityTitle=[[UILabel alloc]init];
        _priority=[[UILabel alloc]init];
        
        
        [self stdInitLab:_operationTimeTitle labFrame:CGRectMake(fisttLbX, firstLbY, labWidthTitle, labHeigh)];
        _operationTimeTitle.text=@"派单时间：";
        
        
        [self stdInitLab:_operationUserTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY, labWidthTitle, labHeigh)];
        _operationUserTitle.text=@"派单人：";
        
        [self stdInitLab:_userIdTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY*2, labWidthTitle, labHeigh)];
        _userIdTitle.text=@"接单人：";
        
        [self stdInitLab:_deptIdTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY*3, labWidthTitle, labHeigh)];
        _deptIdTitle.text=@"工种：";
        
        [self stdInitLab:_priorityTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY*4, labWidthTitle, labHeigh)];
        _priorityTitle.text=@"优先级：";
        
        
        
        
        [self stdInitLab:_operationTime labFrame:CGRectMake(secondLbX, firstLbY, labWidth, labHeigh)];
        [self stdInitLab:_operationUser labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY, labWidth, labHeigh)];
        [self stdInitLab:_userId labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY*2, labWidth, labHeigh)];
        [self stdInitLab:_deptId labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY*3, labWidth, labHeigh)];
        [self stdInitLab:_priority labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY*4, labWidth, labHeigh)];
        
        
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


-(void)asignDataToLab:(ticketInfo*)modelData{
    NSArray *flowArr=modelData.ticketFlowList;
    NSString *operations;
    @try {
        if (flowArr) {
            for (ticketFlowInfo *dict in flowArr) {
                operations=dict.operation;
                if ([operations isEqualToString:@"0"]) {
                    _operationTime.text=[self stdTimeToStr:dict.operationTime];
                    _operationUser.text=dict.operationUser;
                    _userId.text=dict.userId;
                    _deptId.text=dict.deptId;
                    _priority.text=modelData.priority;
                    _operationPhone=dict.operationPhone;
                }
            }
        }
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
    [objDateformat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [objDateformat stringFromDate: date];
}

@end
