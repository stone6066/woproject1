//
//  turnAndHelpViewController.h
//  woproject
//
//  Created by tianan-apple on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComboxView;
@interface turnAndHelpViewController : UIViewController<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>
@property (nonatomic,copy)NSString *listId;
@property (nonatomic,assign)NSInteger ViewType;////0.派单；1.接单；2.到场；3.完成；4.核查；5.退单；6.挂起；7.协助
@property (nonatomic,strong)ComboxView *priorityBox;//优先级
@property (nonatomic,strong)ComboxView *jobNameBox;//工种
@property (nonatomic,strong)ComboxView *operationUserBox;//接单人
@property (nonatomic,strong)UITextView *memoResion;//原因
@property(nonatomic,copy)NSString *priority;
@property (nonatomic,strong)UIButton *addImg1;
@property (nonatomic,strong)UIButton *addImg2;
@property (nonatomic,strong)UIButton *addImg3;
@property (nonatomic,strong)UIButton *doneBtn;
@property (nonatomic,strong)UIButton *scanBtn;


@property (nonatomic, strong) UIAlertController *alert;
@property (nonatomic, strong) UIImagePickerController *pickerController;
@property (nonatomic, assign) NSInteger imgTag;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableDictionary *paramsDic;

-(id)init:(NSString *)listId viewType:(NSInteger)typeI priority:(NSString*)pstr;
@end
