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
#import "MyRepairVC.h"

@interface RepairViewController ()
<
    RepairViewDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>

@property (nonatomic, strong) RepairView *rView;
@property (nonatomic, strong) UIAlertController *alert;
@property (nonatomic, strong) UIImagePickerController *pickerController;
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

- (void)clearUI
{
    [self.imgArray removeAllObjects];
    [self.rView clearUI];
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

#pragma mark Action
- (void)openPhotosAndCamera:(UIButton *)button
{
    if (self.imgArray.count == 3) {
        [stdPubFunc stdShowMessage:@"只允许添加三张照片"];
        return;
    }
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
    if (_rView.imgView1.hidden) {
        _rView.imgView1.image = image;
        _rView.imgView1.hidden = NO;
        if (self.imgArray.count == 1) {
            [self.imgArray removeObjectAtIndex:0];
        }
        [self.imgArray insertObject:imgData atIndex:0];
    }else{
        if (_rView.imgView2.hidden) {
            _rView.imgView2.hidden = NO;
            _rView.imgView2.image = image;
            if (self.imgArray.count == 2) {
                [self.imgArray removeObjectAtIndex:1];
            }
            [self.imgArray insertObject:imgData atIndex:1];
        }else{
            _rView.imgView3.hidden = NO;
            _rView.imgView3.image = image;
            if (self.imgArray.count == 3) {
                [self.imgArray removeObjectAtIndex:2];
            }
            [self.imgArray insertObject:imgData atIndex:2];
        }
    }
}
- (void)ConfirmRepairAction:(UIButton *)sender
{
    [self.rView.describeTextView resignFirstResponder];
    if ([_rView.PNTapLabel.text isEqualToString:@"------"]) {
        [stdPubFunc stdShowMessage:@"请选择项目名称"];
        return;
    }
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
                if (self.imgArray.count == 0) {
                    MyRepairVC *vc = [[MyRepairVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                NSString *cid = jsonDic[@"i"][@"Data"][@"id"];
                NSString *imgUrl = [NSString stringWithFormat:@"%@support/sys/forUpLoading", BaseUrl];
                imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [self.imgArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:imgUrl parameters:@{@"tid":cid,@"status":@"-1",} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                            
                            
                                NSString *name =[NSString stringWithFormat:@"image_ios_img_%ld.png",idx];
                                
                                NSString *type = @"image/jpeg";
                                
                                [formData appendPartWithFileData:self.imgArray[idx] name:@"image_stream" fileName:name mimeType:type];
                        } error:nil];

                        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                        
                        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                        
                        
                        NSURLSessionUploadTask *uploadTask;
                        uploadTask = [manager
                                      uploadTaskWithStreamedRequest:request
                                      progress:^(NSProgress * _Nonnull uploadProgress) {
                                          [SVProgressHUD showWithStatus:k_Status_Upload];

                                      }
                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                          
                                          if (error) {
                                              [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                              
                                          } else {
                                              
                                              id  dict_data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
                                              NSLog(@"%@", dict_data);
                                              if ([dict_data[@"s"] isEqualToString:@"0"]) {
                                                  [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"第%ld张图片上传成功", idx + 1]];
                                              }
                                              if (idx == self.imgArray.count - 1) {
                                                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                      MyRepairVC *vc = [[MyRepairVC alloc] init];
                                                      vc.hidesBottomBarWhenPushed = YES;
                                                      [self.navigationController pushViewController:vc animated:YES];
                                                  });

                                              }

                                          }
                                          
                                      }];
                        
                        [uploadTask resume];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearUI) name:@"dismiss" object:nil];
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

