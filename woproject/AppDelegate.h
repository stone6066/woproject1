//
//  AppDelegate.h
//  woproject
//
//  Created by tianan-apple on 16/10/9.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AFNetworking.h"//网络请求三方
#import "StdRootController.h"
#import "loginInfo.h"
#import "listNum.h"
//571e16ac4e21355db19ce77f
//314e49a9c6dcc64f9f7c5d07
static NSString *appKey = @"571e16ac4e21355db19ce77f";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UITabBarController* tabBarViewController;
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

/**
 *  网络请求单例
 */
@property (strong, nonatomic) AFHTTPSessionManager *httpManager;
@property (assign, nonatomic) BOOL isLogin;
@property (assign, nonatomic) BOOL isRmbPsw;//是否记住密码
@property (strong, nonatomic) loginInfo *myLoginInfo;
@property (strong, nonatomic) listNum *mylistNum;//各种工单数量，登陆成功后，取一次
@end

