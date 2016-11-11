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
        [_myViewTitle setFont:[UIFont systemFontOfSize:15]];
        [_myViewTitle setTextColor:deepbluetxtcolor];
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
        
        
        if (!_phonebtn) {
            _phonebtn=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-60, firstLbY+spritePaceY*2, 50, 50)];
            [_phonebtn addTarget:self action:@selector(btnCallFunc:) forControlEvents:UIControlEventTouchUpInside];
            
            [_phonebtn setImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
            _phonebtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
            _phonebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self addSubview:_phonebtn];
        }

        
        [self stdInitLab:_operationTime labFrame:CGRectMake(secondLbX, firstLbY, labWidth, labHeigh)];
        [self stdInitLab:_operationUser labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY, labWidth, labHeigh)];
        [self stdInitLab:_userId labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY*2, labWidth, labHeigh)];
        [self stdInitLab:_deptId labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY*3, labWidth, labHeigh)];
        [self stdInitLab:_priority labFrame:CGRectMake(secondLbX, firstLbY+spritePaceY*4, labWidth, labHeigh)];
        
        
    }
    return self;
}
-(void)btnCallFunc:(UIButton*)btn{
    if (_operationPhone) {
        UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:_operationPhone message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [myalert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{//取消
            
        }break;
        case 1:{//呼叫
            
            NSString * telStr=[NSString stringWithFormat:@"%@%@",@"tel://",alertView.title];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
        }break;
            
        default:
            break;
    }
}

-(void)stdInitLab:(UILabel*)stdLab labFrame:(CGRect)labF{
    stdLab.frame=labF;
    [stdLab setFont:[UIFont systemFontOfSize:14]];
    stdLab.textColor=graytxtcolor;
    //stdLab.backgroundColor=[UIColor yellowColor];
    [self addSubview:stdLab];
}

//priority 优先级
-(void)asignDataToLab:(ticketFlowInfo*)modelData priority:(NSString*)pstr{
    @try {
        _operationTime.text=[self stdTimeToStr:modelData.operationTime];
        _operationUser.text=modelData.operationUser;
        _userId.text=modelData.userId;
        _deptId.text=modelData.jobName;
        _priority.text=pstr;
        _operationPhone=modelData.operationPhone;
        _imgArr=modelData.imageList;
        [self setImgBtn:_imgArr];

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


-(void)setImgBtn:(NSMutableArray*)imgList{
    CGFloat firstLbX=15;//第一个lab的y
    CGFloat offsetX=45;
    NSInteger i=0;
    @try {
        for (NSString* imgUrl in imgList) {
            
            UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(firstLbX+offsetX*i, _priority.frame.origin.y+_priority.frame.size.height+5, 40, 40)];
            [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            
            UIButton *imgBtn=[[UIButton alloc]initWithFrame:CGRectMake(firstLbX+offsetX*i, _priority.frame.origin.y+_priority.frame.size.height+5, 40, 40)];
            imgBtn.tag=i;
            i++;
            
            [imgBtn addTarget:self action:@selector(imagbtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:imgView];
            [self addSubview:imgBtn];
        }
    } @catch (NSException *exception) {
        NSLog(@"imglist为空");
    } @finally {
        ;
    }
}
-(void)imagbtnClick:(UIButton*)btn{
    NSString *imgUrl=@"";
    @try {
        imgUrl=_imgArr[btn.tag];
        [self.stdPaidanImgDelegate stdPaidanClickDelegate:imgUrl];
        
    } @catch (NSException *exception) {
        
    } @finally {
        NSLog(@"imagbtnClick:%@",imgUrl);
    }
    
}
@end
