//
//  backAndHangUpViewController.h
//  woproject
//
//  Created by tianan-apple on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface backAndHangUpViewController : UIViewController
@property (nonatomic,strong)UITextView *descTxt;//挂起或者退单原因
@property (nonatomic,strong)UIButton *addImg1;
@property (nonatomic,strong)UIButton *addImg2;
@property (nonatomic,strong)UIButton *addImg3;
@property (nonatomic,strong)UIButton *doneBtn;

@property (nonatomic,copy)NSString *listId;
@property (nonatomic,assign)NSInteger ViewType;////0.派单；1.接单；2.到场；3.完成；4.核查；5.退单；6.挂起；7.协助

-(id)init:(NSString *)listId viewType:(NSInteger)typeI;
@end
