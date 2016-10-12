//
//  VisualizationController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "VisualizationController.h"

@interface VisualizationController () 

#pragma mark -
#pragma mark 与平台管理项目
@property (strong, nonatomic) IBOutlet UILabel *proCountLb;

@property (strong, nonatomic) IBOutlet UILabel *manageSpaceLb;

@end

@implementation VisualizationController


- (void)initUI {
    
    _proCountLb.attributedText = [MJYUtils attributeStr:[NSString stringWithFormat:@"%@", @"2个"] changePartStr:@"2" withFont:20 andColor:RGB(0, 0, 0)];
    _manageSpaceLb.attributedText = [MJYUtils attributeStr:[NSString stringWithFormat:@"%@", @"90万平方米"] changePartStr:@"90" withFont:20 andColor:RGB(0, 0, 0)];
    
}

- (IBAction)enterAllshow:(UIButton *)sender {
    
    NSLog(@"123");
    
}

- (IBAction)gongnengClick:(UIButton *)sender {
    
    NSLog(@"123%ld",sender.tag);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view from its nib.
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
