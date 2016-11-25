//
//  tickoperateViewController.h
//  woproject
//
//  Created by tianan-apple on 2016/10/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tickoperateViewController : UIViewController
@property (nonatomic,strong)UIButton *scanBtn;//扫描二维码
@property (nonatomic,strong)UIButton *confomBtn;//到场确认
@property (nonatomic,strong)UIButton *hangupBtn;//挂起
@property (nonatomic,strong)UIButton *backOrderBtn;//退单
@property (nonatomic,strong)UIButton *assistBtn;//协助
@property (nonatomic,strong)UIButton *turnBtn;//转单
@property (nonatomic,strong)UITextView *descTxt;//维修结果
@property (nonatomic,strong)UIButton *addImg1;
@property (nonatomic,strong)UIButton *addImg2;
@property (nonatomic,strong)UIButton *addImg3;
@property (nonatomic,strong)UIButton *doneBtn;
@property (nonatomic,strong)UILabel *confTimeLbl;//到场时间
@property (nonatomic,copy)NSString *IsConfom;//是否已经到场 0未到场  1到场
@property (nonatomic,copy)NSString *OrderId;//工单id
@property (nonatomic,copy)NSString *confTime;//到场时间
@property(nonatomic,copy)NSString *priority;//优先级

@property (nonatomic, strong) UIAlertController *alert;
@property (nonatomic, strong) UIImagePickerController *pickerController;
@property (nonatomic, assign) NSInteger imgTag;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableDictionary *paramsDic;

-(id)init:(NSString *)isConf confTime:(NSString*)timeStr;
@end
