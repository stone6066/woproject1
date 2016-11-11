//
//  DeviceViewController.m
//  sdkDemo
//
//  Created by 吴怡顺 on 15/9/29.
//  Copyright © 2015年 吴怡顺. All rights reserved.
//
#define kNotifyDisconnection @"c" //断开
#define kNotifyReconnection @"kNotifyReconnection" //重联

#import "DeviceViewController.h"
#import "MindNet.h"
#import "DeviceModel.h"
#import <qysdk/QYType.h>
#import "LocalityTree_Level1_Cell.h"
#import "HeadView.h"
#import "StringUtils.h"
#import "VideoViewController.h"

@interface DeviceViewController ()<HeadViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* deviceArray;
    
    
}

@property(nonatomic,strong) IBOutlet UITableView* deviceTable;

@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _deviceTable.delegate=self;
    _deviceTable.dataSource=self;
    
    self.deviceTable.tableFooterView=[UIView new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ConnectNetwork) name:kNotifyReconnection object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DisConnectNetwork) name:kNotifyDisconnection object:nil];
    // Do any additional setup after loading the view from its nib.
}

-(void) ConnectNetwork
{
    if(![[MindNet sharedManager] hasLogin])
    {
        [[MindNet sharedManager] loginSession:^(int32_t ret) {
            if(ret==0)
            {
                [self DeviceList];
                [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidBecomeActiveNotification object:NULL];
            }
        }];
    }
}

//-(void) DisConnectNetwork
//{
//   [[MindNet sharedManager]Release];
//}

-(void)viewWillAppear:(BOOL)animated
{
    if(![[MindNet sharedManager] hasLogin])
    {
        [[MindNet sharedManager] loginSession:^(int32_t ret) {
            if(ret==0)
            {
                [self DeviceList];
            }
        }];
    }
}



-(void) DeviceList
{
    
    [[MindNet sharedManager] getDeviceSuccess:^(NSArray *ret) {
        deviceArray=[NSMutableArray array];
        for(int i=0; i<ret.count; i++)
        {
            QY_DEVICE_INFO deviceinfo;
            NSValue* valueObj =[ret objectAtIndex:i];
            [valueObj getValue:&deviceinfo];
            DeviceModel * device =[DeviceModel new];
            device.device_id=deviceinfo.deviceID;
            device.status=deviceinfo.status;
            device.subDeviceList=[NSMutableArray array];
            [deviceArray addObject:device];
            
            [[MindNet sharedManager]getChanelwithDevid:device
                                           withsuccess:^(NSArray *ret) {
                                               QY_CHANNEL_INFO chanel;
                                               
                                               for(NSValue* valueObj in ret)
                                               {
                                                   [valueObj getValue:&chanel];
                                                   
                                                   DeviceModel * chanleDevice =[DeviceModel new];
                                                   chanleDevice.device_id=chanel.channelID;
                                                   chanleDevice.status=chanel.status;
                                                   [device.subDeviceList addObject:chanleDevice];
                                                   
                                               }
                                               [self.deviceTable reloadData];
                                           } ];
        }
    }];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return deviceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DeviceModel *device= [deviceArray objectAtIndex:section];
    return  device.subDeviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LocalityTree_Level1_Cell *cell = [LocalityTree_Level1_Cell cellWithTableView:tableView];
    
    DeviceModel *deviceGroup = deviceArray[indexPath.section];
    DeviceModel *subdevice =deviceGroup.subDeviceList[indexPath.row];
    cell.channelLineLabel.text =deviceGroup.status&& subdevice.status?@"在线":@"离线";
    
    cell.channelNameLabel.text =[NSString stringWithFormat:@"%lld",subdevice.device_id];
    
    //    SLLog(@"显示。。。。。。  %@",subdevice.calledName);
    if(deviceGroup.status&&subdevice.status)
    {
        cell.channelLineLabel.textColor=[UIColor blackColor];
        cell.channelNameLabel.textColor=[UIColor blackColor];
        if(subdevice.localimage!=nil)
        {
            [cell.channelIcon setImage:subdevice.localimage];
            [cell.channelIcon setHighlightedImage:subdevice.localimage];
            cell.channelIcon.backgroundColor=[UIColor clearColor];
            
        }
        else
        {
            [cell.channelIcon setHighlightedImage:[UIImage imageNamed:@"passageway"]];
            [cell.channelIcon setImage:[UIImage imageNamed:@"passageway"]];
            cell.channelIcon.backgroundColor=[UIColor clearColor];
        }
    }
    else
    {
        cell.channelLineLabel.textColor=[StringUtils colorWithHexString:@"#666666"];
        cell.channelNameLabel.textColor=[StringUtils colorWithHexString:@"#666666"];
        [cell.channelIcon setHighlightedImage:[UIImage imageNamed:@"passageway"]];
        [cell.channelIcon setImage:[UIImage imageNamed:@"passageway"]];
        cell.channelIcon.backgroundColor=[UIColor clearColor];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    
    headView.delegate = self;
    headView.deviceGroup = deviceArray[section];
    
    return headView;
}
#pragma mark----实现跳转，就是缺少导航控制器
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceModel *model=[deviceArray[indexPath.section] subDeviceList][indexPath.row];
    
    if(model.status)
    {
        VideoViewController *view= [[VideoViewController alloc]initWithDat:model];
        //        view.naDelegate=self.naDelegate;
        [self.navigationController pushViewController:view animated:true];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
