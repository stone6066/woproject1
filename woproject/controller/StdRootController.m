//
//  StdRootController.m
//  StdFirstApp
//
//  Created by tianan-apple on 15/10/14.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "StdRootController.h"



@implementation StdRootController
-(void)SetUpStdRootView:(UITabBarController *)rootTab
{
    HomeViewController *homeViewController = [[HomeViewController alloc]init];
    homeViewController.view.backgroundColor = homebackcolor;
    
    RepairViewController *repairViewController = [[RepairViewController alloc]init];
    repairViewController.view.backgroundColor = [UIColor yellowColor];
    
    MyinfoViewController *myinfoViewController = [[MyinfoViewController alloc]init];
    myinfoViewController.view.backgroundColor = [UIColor redColor];
    
   
    
    UINavigationController *home = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    UINavigationController *repair = [[UINavigationController alloc] initWithRootViewController:repairViewController];
    
    UINavigationController *myinfo = [[UINavigationController alloc] initWithRootViewController:myinfoViewController];
    
    
    
    //rootTab.viewControllers = [NSArray arrayWithObjects:homeViewController, sortViewController,orderViewController,shopCarViewController,accountViewController, nil];
    rootTab.viewControllers = [NSArray arrayWithObjects:home, repair,myinfo, nil];
    
    rootTab.tabBar.frame=CGRectMake(0, fDeviceHeight-MainTabbarHeight, fDeviceWidth, MainTabbarHeight);
    
    
    for (UINavigationController *stack in rootTab.viewControllers) {
        [self setupNavigationBar:stack];
    }
   
    
    rootTab.tabBar.barStyle=UIBarStyleDefault;
    rootTab.tabBar.translucent=false;
    rootTab.tabBar.tintColor=tabTxtColor;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, MainTabbarHeight)];
    backView.backgroundColor = tabbarcolor;
    [rootTab.tabBar insertSubview:backView atIndex:0];
    rootTab.tabBar.opaque = YES;
    
    //tabbar被选中的背景颜色
    CGSize indicatorImageSize =CGSizeMake(fDeviceWidth/3, rootTab.tabBar.bounds.size.height);
    rootTab.tabBar.selectionIndicatorImage = [self drawTabBarItemBackgroundUmageWithSize:indicatorImageSize];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor whiteColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont fontWithName:@"Helvetica" size:12.0], NSFontAttributeName, nil]
                        forState:UIControlStateNormal];
}
//绘制图片
-(UIImage *)drawTabBarItemBackgroundUmageWithSize:(CGSize)size
{
    //开始图形上下文
    UIGraphicsBeginImageContext(size);
    //获得图形上下文
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(ctx,75.0/255, 100.0/255,130.0/255, 1);
    CGContextFillRect(ctx,CGRectMake(0,0, size.width, size.height));
    
    
    CGRect rect =CGRectMake(0,0, size.width, size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
    [image drawInRect:rect];
    
    UIGraphicsEndImageContext();
    
    return image;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //NSLog(@"123123");
//    int index = viewController.selectedIndex;
//    NSString *titleName = nil;
//    switch (index) {
//        case 0:
//            titleName = @"FirstView";
//            break;
//        case 1:
//            titleName = @"SecondView";
//            break;
//        case 2:
//            titleName = @"ThirdView";
//            break;
//            
//        default:
//            break;
//    }
}

- (void)setupNavigationBar:(UINavigationController *)stack{
    UIImage *barImage = [UIImage imageNamed:@"redtop.png"];
//    if(IOS7_OR_LATER)
//        [stack.navigationBar setBackgroundImage:barImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    else
//        [stack.navigationBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    
}
@end
