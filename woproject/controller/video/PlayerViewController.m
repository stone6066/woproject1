//
//  PlayerViewController.m
//  woproject
//
//  Created by tianan-apple on 2016/11/26.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "PlayerViewController.h"
#import "DeviceModel.h"
#import <qysdk/QYView.h>
#import "MindNet.h"
#import "MBProgressHUD+MJ.h"
@interface PlayerViewController ()<QYViewDelegate>
{
    DeviceModel* chanel;
    QYView* video;
    QYView* talk;
    QYView* replay;
}
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self drawMainView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    topLbl.text=_topTitle;
    [topLbl setFont:[UIFont systemFontOfSize:18]];
    [topLbl setTextAlignment:NSTextAlignmentCenter];
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 27, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [TopView addSubview:backimg];
    
    UILabel *hintLbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 29, 30, 20)];
    hintLbl.text=@"返回";
    [hintLbl setFont:[UIFont systemFontOfSize:14]];
    [hintLbl setTextAlignment:NSTextAlignmentCenter];
    [hintLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:hintLbl];
    
    
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    [self.view addSubview:TopView];
}
-(void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(id)initWithDat:(DeviceModel*) dev title:(NSString*)tStr
{
    self=[super init];
    chanel=dev;
    _topTitle=tStr;
    return  self;
}

#pragma mark -- 退出实时视频关闭房间
-(void) closeView
{
    if(video)
    {
        [video Release];
        video=nil;
    }
    
    
}
-(void)playVideo{
    
    if(![MindNet sharedManager].hasLogin)
        return;
    
    [[MindNet sharedManager] createVideoView:chanel.device_id callback:^(int32_t ret, QYView *view) {
        
        if(ret==0)
        {
            video=view;
            [video SetEventDelegate:self];
            [video startCaptureWidth:fDeviceWidth height:fDeviceHeight];
            [video SetCanvas:self.videoView];
            
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //显示到界面
                [MBProgressHUD showError:@"连接观看失败！"];
            });
        }
        
    }];
    [self addButtonListener];
}
-(void)drawTalkView{
    _talkView=[[UIView alloc]initWithFrame:CGRectMake(10,fDeviceHeight-160 , fDeviceWidth-20, 150)];
    [self.view addSubview:_talkView];
    _talkView.backgroundColor=topviewcolor;
    _talkView.hidden=YES;
    
    
    UIButton *closeTalk=[[UIButton alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
    [closeTalk setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_talkView addSubview:closeTalk];
    [closeTalk addTarget:self action:@selector(closeTalkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *openEndTalk=[[UIButton alloc]initWithFrame:CGRectMake((_talkView.frame.size.width-155)/2, 10, 155, 80)];
    [openEndTalk setImage:[UIImage imageNamed:@"talk1"] forState:UIControlStateNormal];
    [openEndTalk setImage:[UIImage imageNamed:@"talk3"] forState:UIControlStateHighlighted];
    [_talkView addSubview:openEndTalk];
    [openEndTalk addTarget:self action:@selector(startTalkBtnClick:) forControlEvents:UIControlEventTouchDown];
    [openEndTalk addTarget:self action:@selector(endTalkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * talkHint=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, _talkView.frame.size.width, 20)];
    talkHint.text=@"按住对讲，松开结束";
    [talkHint setFont:[UIFont systemFontOfSize:14]];
    [talkHint setTextAlignment:NSTextAlignmentCenter];
    [talkHint setTextColor:[UIColor whiteColor]];
    [_talkView addSubview:talkHint];

}
-(void)drawMainView{
    
    CGFloat ViewHigh=fDeviceHeight-TopSeachHigh-150-40;
    CGFloat videoWith=ViewHigh*1280/768;
    CGFloat ViewWith=fDeviceWidth-20;
    UIScrollView *videoSvc=[[UIScrollView alloc]initWithFrame:CGRectMake(10, TopSeachHigh+10, ViewWith, ViewHigh)];
    
    self.videoView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, videoWith, ViewHigh)];
    
    [videoSvc addSubview:self.videoView];
    [self.view addSubview:videoSvc];

    [videoSvc setContentSize:CGSizeMake(ViewWith*2, ViewHigh)];

    
    
    _controllView=[[UIView alloc]initWithFrame:CGRectMake(10,fDeviceHeight-160 , fDeviceWidth-20, 150)];
    [self.view addSubview:_controllView];
    _controllView.backgroundColor=topviewcolor;
    
    [self drawTalkView];
    
    CGFloat centerX=((ViewWith-30*5)/5)+20;
    CGFloat centerY=80;
    CGFloat centerW=20;
    CGFloat centerH=20;
    CGFloat fourBtnWidth=68;
    CGFloat fourBtnHigh=32;
    CGFloat offsetLen=6;
    _centerBtn=[[UIButton alloc]initWithFrame:CGRectMake(centerX, centerY, centerW, centerH)];
    [_centerBtn setImage:[UIImage imageNamed:@"reset_normal"] forState:UIControlStateNormal];
    [_centerBtn setImage:[UIImage imageNamed:@"reset_pressed"] forState:UIControlStateHighlighted];
    [_controllView addSubview:_centerBtn];
   
    _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(centerX-fourBtnHigh-offsetLen, centerY-(fourBtnWidth-centerH)/2, fourBtnHigh, fourBtnWidth)];
    [_leftBtn setImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
    [_leftBtn setImage:[UIImage imageNamed:@"left_pressed"] forState:UIControlStateHighlighted];
    [_controllView addSubview:_leftBtn];
    
    _downBtn=[[UIButton alloc]initWithFrame:CGRectMake(centerX-(fourBtnWidth-centerW)/2, centerY+centerH+offsetLen,fourBtnWidth,fourBtnHigh)];
    [_downBtn setImage:[UIImage imageNamed:@"down_normal"] forState:UIControlStateNormal];
    [_downBtn setImage:[UIImage imageNamed:@"down_pressed"] forState:UIControlStateHighlighted];
    [_controllView addSubview:_downBtn];
    
    _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(centerX+centerW+offsetLen, centerY-(fourBtnWidth-centerH)/2, fourBtnHigh, fourBtnWidth)];
    [_rightBtn setImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
    [_rightBtn setImage:[UIImage imageNamed:@"right_pressed"] forState:UIControlStateHighlighted];
    [_controllView addSubview:_rightBtn];
    
    _upBtn=[[UIButton alloc]initWithFrame:CGRectMake(centerX-(fourBtnWidth-centerW)/2, centerY-fourBtnHigh-offsetLen, fourBtnWidth,fourBtnHigh)];
    [_upBtn setImage:[UIImage imageNamed:@"up_normal"] forState:UIControlStateNormal];
    [_upBtn setImage:[UIImage imageNamed:@"up_pressed"] forState:UIControlStateHighlighted];
    [_controllView addSubview:_upBtn];
    
    CGFloat fiveBtnY=5;
    CGFloat fiveBtnW=30;
    CGFloat fiveBtnH=30;
    CGFloat btnJG=(ViewWith-30*5)/5;
    
    _talkBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnJG/2, fiveBtnY, fiveBtnW, fiveBtnH)];
    [self stdSetMyBtn:_talkBtn img:@"talkback_normal" imgSelected:@"talkback_pressed" title:@"对讲"];
    [_controllView addSubview:_talkBtn];
   
    
    _bufangBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnJG/2+btnJG+fiveBtnW, fiveBtnY, fiveBtnW, fiveBtnH)];
    [self stdSetMyBtn:_bufangBtn img:@"talkback_normal" imgSelected:@"talkback_pressed" title:@"布防"];
    [_controllView addSubview:_bufangBtn];
    
    _huazhiBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnJG/2+(btnJG+fiveBtnW)*2, fiveBtnY, fiveBtnW, fiveBtnH)];
    [self stdSetMyBtn:_huazhiBtn img:@"talkback_normal" imgSelected:@"talkback_pressed" title:@"画质"];
    [_controllView addSubview:_huazhiBtn];
    
    _fanzhuanBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnJG/2+(btnJG+fiveBtnW)*3, fiveBtnY, fiveBtnW, fiveBtnH)];
    [self stdSetMyBtn:_fanzhuanBtn img:@"talkback_normal" imgSelected:@"talkback_pressed" title:@"翻转"];
    [_controllView addSubview:_fanzhuanBtn];
    
    _huifangBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnJG/2+(btnJG+fiveBtnW)*4, fiveBtnY, fiveBtnW, fiveBtnH)];
    [self stdSetMyBtn:_huifangBtn img:@"talkback_normal" imgSelected:@"talkback_pressed" title:@"回放"];
    [_controllView addSubview:_huifangBtn];
    //_talkBtn.backgroundColor=[UIColor yellowColor];
    _talkBtn.tag=101;
    [_talkBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _bufangBtn.tag=102;
    [_bufangBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _huazhiBtn.tag=103;
    [_huazhiBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _fanzhuanBtn.tag=104;
    [_fanzhuanBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _huifangBtn.tag=105;
    [_huifangBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat firstLblY=centerY-fourBtnHigh-offsetLen;
    CGFloat lblJG=(_controllView.frame.size.height-firstLblY)/3;
    UILabel *bianbei=[[UILabel alloc]initWithFrame:CGRectMake(ViewWith/2+15, firstLblY, 40, 20)];
    bianbei.text=@"变倍";
    [bianbei setFont:[UIFont systemFontOfSize:12]];
    [bianbei setTextColor:[UIColor whiteColor]];
    [_controllView addSubview:bianbei];
    
    UILabel *guangquan=[[UILabel alloc]initWithFrame:CGRectMake(ViewWith/2+15, firstLblY+lblJG, 40, 20)];
    guangquan.text=@"光圈";
    [guangquan setFont:[UIFont systemFontOfSize:12]];
    [guangquan setTextColor:[UIColor whiteColor]];
    [_controllView addSubview:guangquan];
    
    UILabel *jiaoju=[[UILabel alloc]initWithFrame:CGRectMake(ViewWith/2+15, firstLblY+lblJG*2, 40, 20)];
    jiaoju.text=@"焦距";
    [jiaoju setFont:[UIFont systemFontOfSize:12]];
    [jiaoju setTextColor:[UIColor whiteColor]];
    [_controllView addSubview:jiaoju];
    
    CGFloat btnWidth=38;
    CGFloat offset1=30;
    CGFloat offset2=40;
    UIButton *bianbeiAdd=[[UIButton alloc]initWithFrame:CGRectMake(ViewWith/2+15+offset1, firstLblY, btnWidth, 20)];
    [bianbeiAdd setTitle:@"-" forState:UIControlStateNormal];
    bianbeiAdd.titleLabel.font = [UIFont systemFontOfSize:20];
    [_controllView addSubview:bianbeiAdd];
    //bianbeiAdd.backgroundColor=[UIColor yellowColor];
    
    UIButton *bianbeiDc=[[UIButton alloc]initWithFrame:CGRectMake(ViewWith/2+15+offset1+offset2, firstLblY, btnWidth, 20)];
    [bianbeiDc setTitle:@"+" forState:UIControlStateNormal];
    bianbeiDc.titleLabel.font = [UIFont systemFontOfSize:20];
    [_controllView addSubview:bianbeiDc];
    //bianbeiDc.backgroundColor=[UIColor yellowColor];
    
    
    UIButton *guangquanAdd=[[UIButton alloc]initWithFrame:CGRectMake(ViewWith/2+15+offset1, firstLblY+lblJG, btnWidth, 20)];
    [guangquanAdd setTitle:@"-" forState:UIControlStateNormal];
    guangquanAdd.titleLabel.font = [UIFont systemFontOfSize:20];
    [_controllView addSubview:guangquanAdd];
    
    
    UIButton *guangquanDc=[[UIButton alloc]initWithFrame:CGRectMake(ViewWith/2+15+offset1+offset2, firstLblY+lblJG, btnWidth, 20)];
    [guangquanDc setTitle:@"+" forState:UIControlStateNormal];
    guangquanDc.titleLabel.font = [UIFont systemFontOfSize:20];
    [_controllView addSubview:guangquanDc];

    
    UIButton *jiaojuAdd=[[UIButton alloc]initWithFrame:CGRectMake(ViewWith/2+15+offset1, firstLblY+lblJG*2, btnWidth, 20)];
    [jiaojuAdd setTitle:@"-" forState:UIControlStateNormal];
    jiaojuAdd.titleLabel.font = [UIFont systemFontOfSize:20];
    [_controllView addSubview:jiaojuAdd];
    
    
    UIButton *jiaojuDc=[[UIButton alloc]initWithFrame:CGRectMake(ViewWith/2+15+offset1+offset2, firstLblY+lblJG*2, btnWidth, 20)];
    [jiaojuDc setTitle:@"+" forState:UIControlStateNormal];
    jiaojuDc.titleLabel.font = [UIFont systemFontOfSize:20];
    [_controllView addSubview:jiaojuDc];
}
-(void)closeTalkBtnClick:(UIButton*)btn{
    [talk Release];
    [_talkView setHidden:YES];
}
-(void)startTalkBtnClick:(UIButton*)btn{
    [talk CtrlTalk:NO];
}

-(void)endTalkBtnClick:(UIButton*)btn{
    [talk CtrlTalk:YES];
}


-(void)topBtnClick:(UIButton*)senderBtn{
    switch (senderBtn.tag) {
        case 101://对讲
            [self stdCreatTalk];
            break;
        case 102://布防
            self.videoView.width=fDeviceWidth;
            break;
        case 103://画质
            
            break;
        case 104://翻转
            
            break;
        case 105://回放
            
            break;
        default:
            break;
    }
}
-(void)stdSetMyBtn:(UIButton*)button img:(NSString*)imgName imgSelected:(NSString*)imgNameSel title:(NSString*)tStr{
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];//给button添加image
    [button setImage:[UIImage imageNamed:imgNameSel] forState:UIControlStateHighlighted];//给button添加image
    button.imageEdgeInsets = UIEdgeInsetsMake(0,3,10,0);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    
    [button setTitle:tStr forState:UIControlStateNormal];//设置button的title
    button.titleLabel.font = [UIFont systemFontOfSize:11];//title字体大小
    button.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
    button.titleEdgeInsets = UIEdgeInsetsMake(20, -button.titleLabel.bounds.size.width-24, -3, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeView) name:UIApplicationDidEnterBackgroundNotification object:NULL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideo) name:UIApplicationDidBecomeActiveNotification object:NULL];
    
    [[MindNet sharedManager] createVideoView:chanel.device_id callback:^(int32_t ret, QYView *view) {
        
        if(ret==0)
        {
            video=view;
            [video SetEventDelegate:self];
            //[video startCaptureWidth:fDeviceWidth height:fDeviceHeight];
            [video SetCanvas:self.videoView];
            
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //显示到界面
                [MBProgressHUD showError:@"连接观看失败！"];
            });
        }
    }];
    [self addButtonListener];
}


-(void)addButtonListener
{
    UILongPressGestureRecognizer *longPress1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress1.minimumPressDuration = 0.3; //定义按的时间
    [self.leftBtn addGestureRecognizer:longPress1];
    
    UILongPressGestureRecognizer *longPress2 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress2.minimumPressDuration = 0.3; //定义按的时间
    
    [self.rightBtn addGestureRecognizer:longPress2];
    
    UILongPressGestureRecognizer *longPress3 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress3.minimumPressDuration = 0.3; //定义按的时间
    
    [self.upBtn addGestureRecognizer:longPress3];
    
    UILongPressGestureRecognizer *longPress4 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress4.minimumPressDuration = 0.3; //定义按的时间
    
    [self.downBtn addGestureRecognizer:longPress4];
}

-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        if([[gestureRecognizer view] isEqual:self.leftBtn])
        {
            [video CtrlPtz:15 action:QY_MOVE_LEFT callBack:^(int32_t ret) {
                
            }];
        }
        else if([[gestureRecognizer view] isEqual:self.rightBtn])
        {
            [video CtrlPtz:15 action:QY_MOVE_RIGHT callBack:^(int32_t ret) {
                
            }];
            
        }
        else if([[gestureRecognizer view] isEqual:self.downBtn])
        {
            [video CtrlPtz:0 action:QY_MOVE_DOWN callBack:^(int32_t ret) {
                
            }];
            
        }
        else if([[gestureRecognizer view] isEqual:self.upBtn])
        {
            [video CtrlPtz:0 action:QY_MOVE_UP callBack:^(int32_t ret) {
                
            }];
            
        }
        
        if([[gestureRecognizer view] isKindOfClass:[UIButton class]])
        {
            [(UIButton*)[gestureRecognizer view] setSelected:true];
        }
    }
    else if([gestureRecognizer state]==UIGestureRecognizerStateEnded)
    {
        
        if([[gestureRecognizer view] isKindOfClass:[UIButton class]])
        {
            [video CtrlPtz:0 action:QY_STOP callBack:^(int32_t ret) {
                
            }];
            
            [(UIButton*)[gestureRecognizer view] setSelected:false];
        }
    }
    
}


//  回放时间通知
-(void)onReplayTimeChange:(QY_TIME) time{
    
}

//  画布显示画面通知
-(void)onVideoSizeChange:(int) width height:(int) height{
    //视频界面显示成功时调用
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //显示到界面
    [MBProgressHUD showError:@"连接观看成功！"];
    //    });
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:NULL];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:NULL];
    
    
}

-(void)stdCreatTalk{
    [[MindNet sharedManager] createTalkView:chanel.device_id callback:^(int32_t ret, QYView *view) {
        if(ret==0)
        {
            talk=view;
            [talk SetEventDelegate:self];
            
        }
        
        if(talk)
        {
            [_talkView setHidden:NO];
        }
    }];

}

//布防
-(void)stdSetAlarmConfig{

}
@end
