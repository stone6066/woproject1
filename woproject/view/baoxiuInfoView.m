//
//  baoxiuInfoView.m
//  woproject
//
//  Created by tianan-apple on 16/10/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "baoxiuInfoView.h"
#import "ticketInfo.h"

#import "ShowImgViewController.h"
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
        
        CGFloat labWidthTitle=80;//lab的宽度（标题lab）
        CGFloat secondLbX=15+labWidthTitle;
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
        [self stdInitLab:_faultDesc labFrame:CGRectMake(fisttLbX, firstLbY+spritePaceY*7, labWidth+secondLbX-fisttLbX, labHeigh)];
        
        _faultDesc.numberOfLines=0;//多行显示
        if (!_phonebtn) {
            _phonebtn=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-60, firstLbY+spritePaceY*2, 50, 50)];
            [_phonebtn addTarget:self action:@selector(btnCallFunc:) forControlEvents:UIControlEventTouchUpInside];
            
            [_phonebtn setImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
            _phonebtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
            _phonebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self addSubview:_phonebtn];
        }
        
    }
    return self;
}

-(void)btnCallFunc:(UIButton*)btn{
    if (_repairPhone) {
        
        UIAlertView *myalert=[[UIAlertView alloc]initWithTitle:_repairPhone message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
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
            //NSString * telStr=alertView.title;
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

-(void)asignDataToLab:(ticketInfo*)modelData{
    _repairTime.text=[self stdTimeToStr:modelData.createTime];
    _repairPerson.text=modelData.userName;
    _projectName.text=modelData.projectId;
    _faultDev.text=modelData.deviceName;
    _faultPos.text=modelData.faultPos;
    _priority.text=modelData.priority;
    _faultDesc.text=modelData.faultDesc;
    [_faultDesc sizeToFit];
    _repairPhone=modelData.userPhone;
    _imgArr=modelData.imageList;
    [self setImgBtn:_imgArr];
}

-(void)setImgBtn:(NSMutableArray*)imgList{
    CGFloat firstLbY=15;//第一个lab的y
    CGFloat offsetX=45;
    NSInteger i=0;
    @try {
        for (NSString* imgUrl in imgList) {
            
            UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(firstLbY+offsetX*i, _faultDesc.frame.origin.y+_faultDesc.frame.size.height+5, 40, 40)];
            [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            
            UIButton *imgBtn=[[UIButton alloc]initWithFrame:CGRectMake(firstLbY+offsetX*i, _faultDesc.frame.origin.y+_faultDesc.frame.size.height+5, 40, 40)];
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
        [self.stdImgDelegate stdImageClickDelegate:imgUrl];
        
    } @catch (NSException *exception) {
        
    } @finally {
        NSLog(@"imagbtnClick:%@",imgUrl);
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
