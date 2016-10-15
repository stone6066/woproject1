//
//  RepairViewController.m
//  woproject
//
//  Created by 徐洋 on 16/10/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "RepairViewController.h"
#import "RepairView.h"
#import "stdPubFunc.h"

@interface RepairViewController ()
<
    RepairViewDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>

@property (nonatomic, strong) RepairView *rView;
@property (nonatomic, strong) UIAlertController *alert;
@property (nonatomic, strong) UIImagePickerController *pickerController;
@property (nonatomic, assign) NSInteger imgTag;
@property (nonatomic, strong) NSMutableArray *imgArray;

@end

@implementation RepairViewController

- (NSMutableArray *)imgArray
{
    if (!_imgArray) {
        _imgArray = @[].mutableCopy;
    }
    return _imgArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Color-Fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"Color-Fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"报修";
        
        self.tabBarItem.title=tittxt;
        
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    }
    return self;
}

- (void)selectedItem:(NSInteger)type
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSString *str = @"";
    switch (type) {
        case 0:
            str = @"support/ticket/forProjectList";
            break;
        case 1:
            str = @"support/ticket/forFaultSyetem";
            break;
        case 2:
            str = @"support/ticket/forDeviceType";
            break;
    }
    NSString *urlstr = [NSString stringWithFormat:@"%@%@", BaseUrl, str];
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"uid"];
    [dict setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
    [ApplicationDelegate.httpManager POST:urlstr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSError* error;
            NSDictionary* jsonDic = [NSJSONSerialization
                                     JSONObjectWithData:responseObject
                                     options:kNilOptions
                                     error:&error];
            
            NSString *suc=[jsonDic objectForKey:@"s"];
            NSString *msg=[jsonDic objectForKey:@"m"];
            //
            if ([suc isEqualToString:@"0"]) {
                //成功
                
                [SVProgressHUD dismiss];
                [stdPubFunc stdShowMessage:msg];
                NSArray *arr = jsonDic[@"i"][@"Data"];
                switch (type) {
                    case 0:
                    {
                        NSArray *array = [NSArray yy_modelArrayWithClass:[PNModel class] json:arr];
                        self.rView.dataArray = array;
                    }
                        break;
                    case 1:
                    {
                        NSArray *array = [NSArray yy_modelArrayWithClass:[FSModel class] json:arr];
                        self.rView.dataArray = array;
                    }
                        break;
                    case 2:
                    {
                        NSArray *array = [NSArray yy_modelArrayWithClass:[DTModel class] json:arr];
                        self.rView.dataArray = array;
                    }
                        break;
                }
                NSLog(@"======== %@", jsonDic);
                
            } else {
                //失败
                [SVProgressHUD showErrorWithStatus:msg];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Network];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:k_Error_Network];
    }];
}
#pragma mark Action
- (void)openPhotosAndCamera:(UIButton *)button
{
    self.imgTag = button.tag;
    [self presentViewController:self.alert animated:YES completion:nil];
}
////选择图片完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = info[@"UIImagePickerControllerEditedImage"];
    [self saveImage:image];
    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
}
//保存图片
- (void)saveImage:(UIImage *)currentImage
{
    //    NSData *imageData = UIImageJPEGRepresentation(currentImage, .2f);
    //二进制文件 需要作为图片上传
    NSData *imgData = UIImageJPEGRepresentation(currentImage, 1.0f);
    UIImage *image = [[UIImage alloc] initWithData:imgData];
    switch (self.imgTag) {
        case 191:
            [self.rView.imgBtn1 setImage:image forState:normal];
            if (self.imgArray.count == 1) {
                [self.imgArray removeObjectAtIndex:0];
            }
            [self.imgArray insertObject:imgData atIndex:0];
            self.rView.imgBtn2.hidden = NO;
            break;
        case 192:
            [self.rView.imgBtn2 setImage:image forState:normal];
            if (self.imgArray.count == 2) {
                [self.imgArray removeObjectAtIndex:1];
            }
            [self.imgArray insertObject:imgData atIndex:1];
            self.rView.imgBtn3.hidden = NO;
            break;
        case 193:
            [self.rView.imgBtn3 setImage:image forState:normal];
            if (self.imgArray.count == 3) {
                [self.imgArray removeObjectAtIndex:2];
            }
            [self.imgArray insertObject:imgData atIndex:2];
            break;
    }
}
- (void)ConfirmRepairAction:(UIButton *)sender
{
    [self.rView.describeTextView resignFirstResponder];
    NSDictionary *params = [self.rView getParams];
    if (!params[@"fault_desc"]) {
        [stdPubFunc stdShowMessage:@"请填写报修描述"];
        return;
    }
    NSLog(@"%@", params);
    NSString *urlStr = [NSString stringWithFormat:@"%@support/ticket/forRepairs", BaseUrl];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSError* error;
            NSDictionary* jsonDic = [NSJSONSerialization
                                     JSONObjectWithData:responseObject
                                     options:kNilOptions
                                     error:&error];
            
            NSString *suc=[jsonDic objectForKey:@"s"];
            NSString *msg=[jsonDic objectForKey:@"m"];
            //
            if ([suc isEqualToString:@"0"]) {
                //成功
                
                [SVProgressHUD dismiss];
                [stdPubFunc stdShowMessage:msg];
                NSLog(@"======== %@", jsonDic);
                NSString *cid = jsonDic[@"i"][@"Data"][@"id"];
                NSString *imgUrl = [NSString stringWithFormat:@"%@support/sys/forUpLoading", BaseUrl];
                imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [self.imgArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSMutableDictionary *imgParams = [NSMutableDictionary dictionary];
                    [imgParams setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"tid"];
                    [imgParams setObject:@"-1" forKey:@"status"];
                    [imgParams setObject:obj forKey:@"image_stream"];
                    [ApplicationDelegate.httpManager POST:imgUrl parameters:imgParams progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        //http请求状态
                        if (task.state == NSURLSessionTaskStateCompleted) {
                            NSError* error;
                            NSDictionary* jsonDic = [NSJSONSerialization
                                                     JSONObjectWithData:responseObject
                                                     options:kNilOptions
                                                     error:&error];
                            
                            NSString *suc=[jsonDic objectForKey:@"s"];
                            NSString *msg=[jsonDic objectForKey:@"m"];
                            //
                            if ([suc isEqualToString:@"0"]) {
                                //成功
                                
                                [SVProgressHUD dismiss];
                                [stdPubFunc stdShowMessage:@"上传图片成功"];
                                NSLog(@"======== %@", jsonDic);
                                
                            } else {
                                //失败
                                [SVProgressHUD showErrorWithStatus:msg];
                            }
                            
                        } else {
                            [SVProgressHUD showErrorWithStatus:k_Error_Network];
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [SVProgressHUD showErrorWithStatus:k_Error_Network];
                    }];
                }];
            } else {
                //失败
                [SVProgressHUD showErrorWithStatus:msg];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Network];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:k_Error_Network];
    }];
}
#pragma mark UI
- (void)initUI
{
    self.topTitle = @"报修";
    self.isHiddenBackItem = YES;
    self.rView = [[RepairView alloc] init];
    
    self.rView.frame = CGRectMake(0, 0, fDeviceWidth, fDeviceHeight - 49 - 64);
    UIScrollView *tmpView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, fDeviceWidth, fDeviceHeight - 49 - 64)];
    [tmpView addSubview:self.rView];
    tmpView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tmpView];
    self.rView.delegate = self;
    [self.rView.repairButton addTarget:self action:@selector(ConfirmRepairAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIAlertController *)alert
{
    
    if (!_alert) {
        NSString *title = @"选择";
        NSString *cancelTitel = @"取消";
        NSString *takePhotpTitle = @"拍照";
        NSString *photoAlbumTitle = @"从相册选择";
        _alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //取消
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitel style:UIAlertActionStyleCancel handler:nil];
        //打开相机
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhotpTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:self.pickerController animated:YES completion:nil];
        }];
        //打开相册
        UIAlertAction *photoAlbumAction = [UIAlertAction actionWithTitle:photoAlbumTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:self.pickerController animated:YES completion:nil];
            
        }];
        
        [_alert addAction:cancelAction];
        [_alert addAction:photoAlbumAction];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [_alert addAction:takePhotoAction];
        }
    }
    return _alert;
}

- (UIImagePickerController *)pickerController
{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.delegate = self;
        _pickerController.allowsEditing = YES;
    }
    return _pickerController;
}

@end

