//
//  baoxiuInfoView.m
//  woproject
//
//  Created by tianan-apple on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "baoxiuInfoView.h"
#import "ticketInfo.h"

@implementation baoxiuInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        CGFloat viewWidth=frame.size.width;
        CGFloat viewHeight=frame.size.height;
        
        UIView *topTitleVc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 30)];
        topTitleVc.backgroundColor=bluebackcolor;
        _myViewTitle=[[UILabel alloc]initWithFrame:CGRectMake(5, 2, 100, 20)];
        _myViewTitle.text=@"报修信息";
//        [_repairTimetitle setFont:[UIFont systemFontOfSize:15]];
//        _myViewTitle.textColor=deepbluetxtcolor;
        [topTitleVc addSubview:_myViewTitle];
        [self addSubview:topTitleVc];
        
        
        CGFloat firstLbY=35;//第一个lab的y
        CGFloat fisttLbX=15;
        
        CGFloat labWidthTitle=70;//lab的宽度（标题lab）
        CGFloat secondLbX=15+70;
        CGFloat labHeigh=20;//lab的高度
        CGFloat spritePaceY=15+labHeigh;//lab之间的间隔
        CGFloat labWidth=viewWidth-25-labWidthTitle;//lab的宽度（数据lab）
        
        _repairTimetitle=[[UILabel alloc]init];
        _repairTime=[[UILabel alloc]init];
        _repairPersonTitle=[[UILabel alloc]init];
        _repairPerson=[[UILabel alloc]init];
        _projectNameTitle=[[UILabel alloc]init];
        _projectName=[[UILabel alloc]init];
        _faultDevTitle=[[UILabel alloc]init];
        _faultDev=[[UILabel alloc]init];
        _faultPosTitle=[[UILabel alloc]init];
        _faultPos=[[UILabel alloc]init];
        _priorityTitle=[[UILabel alloc]init];
        _priority=[[UILabel alloc]init];
        _faultDescTitle=[[UILabel alloc]init];
        _faultDesc=[[UILabel alloc]init];
        
        [self stdInitLab:_repairTimetitle labFrame:CGRectMake(fisttLbX, firstLbY, labWidthTitle, labHeigh)];
        _repairTimetitle.text=@"报修时间：";
        
        
        [self stdInitLab:_repairPersonTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY, labWidthTitle, labHeigh)];
        _repairPersonTitle.text=@"报修人：";
        
        [self stdInitLab:_projectNameTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY*2, labWidthTitle, labHeigh)];
        _projectNameTitle.text=@"项目名称：";
        
        [self stdInitLab:_faultDevTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY*3, labWidthTitle, labHeigh)];
        _faultDevTitle.text=@"故障设备：";
        
        [self stdInitLab:_faultPosTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY*4, labWidthTitle, labHeigh)];
        _faultPosTitle.text=@"故障位置：";
        
        [self stdInitLab:_priorityTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY*5, labWidthTitle, labHeigh)];
        _priorityTitle.text=@"优先级：";
        
        [self stdInitLab:_faultDescTitle labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY*6, labWidthTitle, labHeigh)];
        _faultDescTitle.text=@"故障描述：";
        
        
        [self stdInitLab:_repairTime labFrame:CGRectMake(secondLbX, firstLbY, labWidth, labHeigh)];
        [self stdInitLab:_repairPerson labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY, labWidth, labHeigh)];
        [self stdInitLab:_projectName labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY*2, labWidth, labHeigh)];
        [self stdInitLab:_faultDev labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY*3, labWidth, labHeigh)];
        [self stdInitLab:_faultPos labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY*4, labWidth, labHeigh)];
        [self stdInitLab:_priority labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY*5, labWidth, labHeigh)];
        [self stdInitLab:_faultDesc labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY*7, labWidth+secondLbX-fisttLbX, labHeigh*2)];
        _faultDesc.numberOfLines=0;//多行显示
        
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
    _repairTime.text=[self stdTimeToStr:modelData.createTime];
    _repairPerson.text=modelData.userName;
    _projectName.text=modelData.projectId;
    _faultDev.text=modelData.deviceName;
    _faultPos.text=modelData.faultPos;
    _priority.text=modelData.priority;
    _faultDesc.text=modelData.faultDesc;
    _repairPhone=modelData.userPhone;
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [objDateformat stringFromDate: date];
}
@end
