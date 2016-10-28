//
//  VisualizationController.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "VisualizationController.h"
#import "GdtjViewController.h"
#import "CloudPlatformManageController.h"
#import "EquipmentHealthController.h"
#import "PropertySecurityController.h"
#import "EnvironmentComfortableController.h"
#import "EnergyConsumptionController.h"




@interface VisualizationController () 

#pragma mark -
#pragma mark 与平台管理项目
@property (strong, nonatomic) IBOutlet UILabel *proCountLb;

@property (strong, nonatomic) IBOutlet UILabel *manageSpaceLb;

@end

@implementation VisualizationController

- (void)manuallyProperties {
    [super initFrontProperties];
    
    
}


- (void)initUI {
    self.topTitle = @"可视化数据";
    self.dateListShow = NO;
    _proCountLb.attributedText = [MJYUtils attributeStr:[NSString stringWithFormat:@"%@", @"2个"] changePartStr:@"2" withFont:20 andColor:RGB(0, 0, 0)];
    _manageSpaceLb.attributedText = [MJYUtils attributeStr:[NSString stringWithFormat:@"%@", @"90万平方米"] changePartStr:@"90" withFont:20 andColor:RGB(0, 0, 0)];
    
}

- (IBAction)enterAllshow:(UIButton *)sender {
    
    CloudPlatformManageController *gdtj = [[CloudPlatformManageController alloc] initWithNibName:@"CloudPlatformManageController" bundle:nil];
    gdtj.hidesBottomBarWhenPushed=YES;
    gdtj.navigationItem.hidesBackButton=YES;
    [self.navigationController pushViewController:gdtj animated:YES];
    
}

- (IBAction)gongnengClick:(UIButton *)sender {
    
    switch (sender.tag) {
            
        case 10: {
            GdtjViewController *gdtj = [[GdtjViewController alloc] initWithNibName:@"GdtjViewController" bundle:nil];
            gdtj.hidesBottomBarWhenPushed=YES;
            gdtj.navigationItem.hidesBackButton=YES;
            [self.navigationController pushViewController:gdtj animated:YES];
        }
            break;
        case 11:{
            EquipmentHealthController *gdtj = [[EquipmentHealthController alloc] initWithNibName:@"EquipmentHealthController" bundle:nil];
            gdtj.hidesBottomBarWhenPushed=YES;
            gdtj.navigationItem.hidesBackButton=YES;
            [self.navigationController pushViewController:gdtj animated:YES];
        }

            break;
        case 12: {
            PropertySecurityController *gdtj = [[PropertySecurityController alloc] initWithNibName:@"PropertySecurityController" bundle:nil];
            gdtj.hidesBottomBarWhenPushed=YES;
            gdtj.navigationItem.hidesBackButton=YES;
            [self.navigationController pushViewController:gdtj animated:YES];

        }
            
            break;
        case 13: {
            EnvironmentComfortableController *gdtj = [[EnvironmentComfortableController alloc] initWithNibName:@"EnvironmentComfortableController" bundle:nil];
            gdtj.hidesBottomBarWhenPushed=YES;
            gdtj.navigationItem.hidesBackButton=YES;
            [self.navigationController pushViewController:gdtj animated:YES];

        }
            
            break;
        case 14: {
            EnergyConsumptionController *gdtj = [[EnergyConsumptionController alloc] initWithNibName:@"EnergyConsumptionController" bundle:nil];
            gdtj.hidesBottomBarWhenPushed=YES;
            gdtj.navigationItem.hidesBackButton=YES;
            [self.navigationController pushViewController:gdtj animated:YES];
        }
            break;

    }
    
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
