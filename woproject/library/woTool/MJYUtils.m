//
//  MJYUtils.m
//  MJY_Utils
//
//  Created by typc on 15/10/11.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#import "MJYUtils.h"
//#import "AddressGroupJSONModel.h"
//#import "AddressJSONModel.h"
#import "JYJSON.h"

@implementation MJYUtils




+ (CGFloat)mjy_checkSystemVersion
{
    static dispatch_once_t onceToken;
    __block float systemVersion = 0;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return systemVersion;
}

+ (NSString *)mjy_checkAPPVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    return appVersion;
}

+ (NSString*)mjy_fuckNULL:(NSObject*)obj
{
    if (obj == nil || [obj isKindOfClass:[NSNull class]])
    {
        return @"";
        
    }else if ([obj isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%@",obj];
        
    }else if(![obj isKindOfClass:[NSString class]])
    {
        return @"";
    }else if ([obj isKindOfClass:[NSString class]])
    {
        if ([(NSString *)obj isEqualToString:@"<null>"])
        {
            return @"";
            
        }else if ([(NSString *)obj isEqualToString:@"null"])
        {
            return @"";
        }else
        {
            return [NSString stringWithFormat:@"%@",obj];
        }
        
    }else
    {
        return @"";
    }
}

//单个文件的大小
+ (long long)mjy_fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath])
    {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


//遍历文件夹获得文件夹大小，返回多少M
+ (float )mjy_folderSizeAtPath:(NSString*) folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self mjy_fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

//消息推送是否开启
+ (BOOL)mjy_isAllowedNotification
{
    //iOS8 check if user allow notification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
    {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types)
        {
            return YES;
        }
    }
    return NO;
}

/**
 *  根据车牌号获取管局的信息
 *
 *  @param lsnum 车牌号
 *
 *  @return 管局的字符串信息
 */
+(NSString *)mjy_getCarorgWithLsnum:(NSString *)lsnum
{
    NSString *city;//城市
    NSString *carorg;//管局
    
    if(lsnum && lsnum.length>=1)
    {
        city = [lsnum substringToIndex:1];
        if ([@"沪" isEqualToString:city])
        {
            carorg = @"shanghai";
        }else if ([@"渝" isEqualToString:city])
        {
            carorg = @"chongqing";
        }else if ([@"渝" isEqualToString:city])
        {
            carorg = @"chongqing";
        }else if ([@"冀" isEqualToString:city])
        {
            carorg = @"hebei";
        }else if ([@"晋" isEqualToString:city])
        {
            carorg = @"shanxi";
        }else if ([@"辽" isEqualToString:city])
        {
            carorg = @"liaoning";
        }else if ([@"吉" isEqualToString:city])
        {
            carorg = @"jilin";
        }else if ([@"黑" isEqualToString:city])
        {
            carorg = @"heilongjiang";
        }else if ([@"浙" isEqualToString:city])
        {
            carorg = @"zhejiang";
        }else if ([@"皖" isEqualToString:city])
        {
            carorg = @"anhui";
        }else if ([@"鲁" isEqualToString:city])
        {
            carorg = @"shandong";
        }else if ([@"豫" isEqualToString:city])
        {
            carorg = @"henan";
        }else if ([@"鄂" isEqualToString:city])
        {
            carorg = @"hubei";
        }else if ([@"湘" isEqualToString:city])
        {
            carorg = @"hunan";
        }else if ([@"粤" isEqualToString:city])
        {
            carorg = @"guangdong";
        }else if ([@"琼" isEqualToString:city])
        {
            carorg = @"hainan";
        }else if ([@"川" isEqualToString:city])
        {
            carorg = @"sichuan";
        }else if ([@"贵" isEqualToString:city])
        {
            carorg = @"guizhou";
        }else if ([@"云" isEqualToString:city])
        {
            carorg = @"yunnan";
        }else if ([@"陕" isEqualToString:city])
        {
            carorg = @"shanxi";
        }else if ([@"甘" isEqualToString:city])
        {
            carorg = @"gansu";
        }else if ([@"青" isEqualToString:city])
        {
            carorg = @"qinghai";
        }else if ([@"内" isEqualToString:city])
        {
            carorg = @"neimenggu";
        }else if ([@"藏" isEqualToString:city])
        {
            carorg = @"xizang";
        }else if ([@"宁" isEqualToString:city])
        {
            carorg = @"ningxia";
        }else if ([@"新" isEqualToString:city])
        {
            carorg = @"xijiang";
        }
        return carorg;
    }else
    {
        return @"";
    }
}

#pragma mark 匹配账户合法性(3_16位_字母数字和下划线的组合)

//验证用户输入不能为空
+ (BOOL)mjy_checkUserInput:(NSString *)input
{
    if ([input length] == 0)
    {
        return NO;
    }
    
    int length = (int)[input stringByReplacingOccurrencesOfString:@" " withString:@""].length;
    
    if (length==0)
    {
        return NO;
    }
    
    return YES;
}

//验证用户名
+(BOOL)mjy_checkUserName:(NSString *)username
{
    if ([username length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9_]{3,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:username];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}


//验证密码
+(BOOL)mjy_checkPassWord:(NSString *)password
{
    if ([password length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"^[a-zA-Z0-9_]{6,17}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}


//验证验证码格式
+(BOOL)mjy_checkVerifyCode:(NSString *)code
{
    if ([code length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:code];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
    
}

//验证QQ
+ (BOOL)mjy_checkQQ:(NSString *)qq
{
    if ([qq length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"[0-9]{4,15}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:qq];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}

//验证手机格式
+ (BOOL)mjy_checkTel:(NSString *)tel
{
    if ([tel length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:tel];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}

//验证座机格式
+ (BOOL)mjy_checkTellandline:(NSString *)telland
{
    if ([telland length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"\\d{2,5}-\\d{7,8}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:telland];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}

//验证邮箱
+ (BOOL)mjy_checkEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *
 *
 *  @param personID 身份证号
 *
 *  @return 是否匹配
 */
+ (BOOL)mjy_checkPersonID:(NSString *)personID
{
    NSString *personIDRegex = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *personIDTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", personIDRegex];
    return [personIDTest evaluateWithObject:personID];
}



/**
 *  将tel替换为****
 *
 *  @param tel 电话号码
 *
 *  @return 替换完的tel
 */
+ (NSString *)mjy_telForStartWithTelNum:(NSString *)tel
{
    if (tel.length<11)
    {
        return @"格式错误";
    }
    
    return [tel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

/**
 *  随机数
 *
 *  @param from 开始
 *  @param to   结束
 *
 *  @return 随机数
 */
+ (NSInteger)mjy_getRandomNumberFrom:(NSInteger)from to:(NSInteger)to
{
    return (long)(from + (arc4random() % (to -from + 1)));
}



/**
 *  UUID
 *
 *  @return
 */
+ (NSString*) mjy_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}


/**
 *  读取JSON信息列表
 */
+ (NSMutableArray *) mjy_JSONAddressInfos
{
    NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"address_list.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:addressPath options:NSDataReadingUncached error:nil];
    NSDictionary *dicAddress = [JYJSON dictionaryOrArrayWithJSONSData:data];
    NSArray *arrAddress = dicAddress[@"citylist"];
    NSMutableArray *ma = [NSMutableArray array];
    for (NSDictionary *dic in arrAddress) {
        NSLog(@"%@", dic);
//        AddressGroupJSONModel *jsonInfo = [[AddressGroupJSONModel alloc] initWithDic:dic];
//        [ma addObject:jsonInfo];
    }
    return ma;
}



//--------------------------------UI
//隐藏tableView多余的分割线
+ (void)mjy_hiddleExtendCellForTableView:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

//拨打电话
+ (void)mjy_callPhone:(NSString *)phoneNumber withSuperView:(UIView *)view
{
    UIWebView *phoneWebView;
    for (UIView *subV in view.subviews){
        if ([subV isKindOfClass:[UIWebView class]]){
            phoneWebView = (UIWebView *)subV;
            break;
        }
    }
    if (!phoneWebView){
        //如果没有的话就添加一个webView
        phoneWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        [view addSubview:phoneWebView];
    }
    //否则就不用添加了,直接用已经存在的webView来加载就可以了
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    [phoneWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

//统一返回按钮
+ (void)mjy_settingBackButtonImageWithImage:(UIImage *)image
{
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

//滑动到最后一行
+ (void)mjy_scrollToFootWithTableView:(UITableView *)tableView isAnimated:(BOOL)animated
{
    NSInteger s = [tableView numberOfSections];
    if (s<1) return;
    NSInteger r = [tableView numberOfRowsInSection:s-1];
    if (r<1) return;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];
    
    [tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    
}


//等比缩放UIImage
+ (UIImage *)mjy_scaleImage:(UIImage *)image withScale:(float)scale
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scale, image.size.height * scale));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scale, image.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


+(CGFloat)mjy_heightForLabel:(UILabel *)label
                    WithText:(NSString *)text
                    fontName:(NSString *)fontName
                    fontSize:(CGFloat)fontSize
                       width:(CGFloat)width
{
    if (!text)
    {
        return 0;
    }else
    {
        if (!fontName)
        {
            //系统默认的字体
            fontName = @"Helvetica";
        }
        
        //创建字体信息
        UIFont *textFont = [UIFont fontWithName:fontName size:fontSize];
        //字体字典信息
        NSDictionary *fontDict =[NSDictionary dictionaryWithObject:textFont forKey:NSFontAttributeName];
        
        //设置label的属性
        label.numberOfLines = 0 ;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.backgroundColor = [UIColor clearColor];
        label.font = textFont;
        
        
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      attributes:fontDict
                                         context:nil];
        
        return rect.size.height+10;
        
    }
    
}



/**
 *  可变字符串定义字号颜色
 */

+ (NSMutableAttributedString *)attributeStr:(NSString *)all changePartStr:(NSString *)partStr withFont:(NSInteger)font andColor:(UIColor *)color {
    
    NSRange font_range = [all rangeOfString:partStr];
    
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:all];
    
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font] range:font_range];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:color range:font_range];
    
    return mAttStri;
}




@end
