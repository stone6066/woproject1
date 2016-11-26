//
//  VideoViewController.m
//  sdkDemo
//
//  Created by 吴怡顺 on 15/9/30.
//  Copyright © 2015年 吴怡顺. All rights reserved.
//

#import "VideoViewController.h"
#import "DeviceModel.h"
#import <qysdk/QYView.h>
#import "MindNet.h"
#import "MBProgressHUD+MJ.h"

@interface VideoViewController ()<QYViewDelegate>
{
    DeviceModel* chanel;
    QYView* video;
    QYView* talk;
    QYView* replay;
}
@property(nonatomic,strong) IBOutlet UIView* videoView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *upBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;


@property (weak, nonatomic) IBOutlet UIView *clondView;
@property (weak, nonatomic) IBOutlet UIView *funcView;
@property (weak, nonatomic) IBOutlet UIView *talkView;


-(IBAction)closeBtn;//关闭云台
-(IBAction)cloudControlBtn;//云台控制
-(IBAction)talkBtn;//云台控制
- (IBAction)stopClickBtn;//停止
- (IBAction)startRecordBtn;//开始录音
- (IBAction)endRecordBtn;//停止录音
- (IBAction)replayBtn;//回放



-(IBAction)back;
@end

@implementation VideoViewController

-(id)initWithDat:(DeviceModel*) dev
{
    self=[super init];
    chanel=dev;
    return  self;
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
            [video CtrlPtz:0 action:QY_MOVE_LEFT callBack:^(int32_t ret) {
                
            }];
        }
        else if([[gestureRecognizer view] isEqual:self.rightBtn])
        {
            [video CtrlPtz:0 action:QY_MOVE_RIGHT callBack:^(int32_t ret) {
                
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
// 关闭对讲
-(IBAction)closeBtn
{
    [talk Release];
    [_funcView setHidden:NO];
    [_clondView setHidden:YES];
    [_talkView setHidden:YES];

}
// 打开云台控制
-(IBAction)cloudControlBtn
{
    NSLog(@"height:%d\n width:%d\n",[video GetHeigh],[video GetWidth]);
    [_funcView setHidden:YES];
    [_clondView setHidden:NO];
}

// 创建对讲房间
-(IBAction)talkBtn
{
    [[MindNet sharedManager] createTalkView:chanel.device_id callback:^(int32_t ret, QYView *view) {
        if(ret==0)
        {
            talk=view;
            [talk SetEventDelegate:self];
            
        }
        
        if(talk)
        {
            [_funcView setHidden:YES];
            [_talkView setHidden:NO];
        }
    }];
}
//
- (IBAction)stopClickBtn
{
//    [video CtrlPtz:0 action:QY_MOVE_RIGHT];
}


// 开始对讲
- (IBAction)startRecordBtn
{
    [talk CtrlTalk:NO];

}

//  结束对讲
- (IBAction)endRecordBtn
{
    [talk CtrlTalk:YES];
}

// 回放数据测试
-(IBAction)replayBtn
{

//     QY_DAYS_INDEX days=[[MindNet sharedManager]getDayList:chanel.device_id
//                              yearData:2015
//                             monthData:10
//                            cloundData:NO];
//    replay=[[MindNet sharedManager] createReplayView:chanel.device_id
//                                          CloudStroe:NO];
//    replay.delegate=self;
//    QYTimeIndex* qyindex=[QYTimeIndex new];
//    [replay SetCanvas:self.videoView];
//    int result=[replay GetStoreFileList:&days.days[2] timeIndex:qyindex];
//    NSLog(@"%d",result);
//    QY_TIME_BUCKET2 time;
//    
//    if(qyindex->times.count<=0)
//        return;
//    
//    NSValue* value=qyindex->times[0];
//    [value getValue:&time];
//    [replay CtrlPlay:time.starttime ctrl:1];
    
}


// 返回
-(IBAction)back
{
    [video Release];
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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

-(void)playVideo{
    
    if(![MindNet sharedManager].hasLogin)
        return;
    
    [[MindNet sharedManager] createVideoView:chanel.device_id callback:^(int32_t ret, QYView *view) {
       
            if(ret==0)
            {
                video=view;
                [video SetEventDelegate:self];
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



#pragma mark -- 退出实时视频关闭房间
-(void) closeView
{
    if(video)
    {
        [video Release];
        video=nil;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:NULL];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:NULL];
    

}

@end
