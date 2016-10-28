//
//  ShowImgViewController.h
//  woproject
//
//  Created by tianan-apple on 2016/10/24.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowImgViewController : UIViewController
@property(nonatomic,copy)NSString *imgUrl;
-(id)init:(NSString*)urlstring;
@end
