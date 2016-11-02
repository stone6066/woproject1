//
//  IconVC.m
//  woproject
//
//  Created by 徐洋 on 16/10/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "IconVC.h"
#import "stdPubFunc.h"

@interface IconVC ()
<
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILongPressGestureRecognizer *lGes;
@property (nonatomic, strong) UIAlertController *alert;
@property (nonatomic, strong) UIImagePickerController *pickerController;

@end

@implementation IconVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark Action
- (void)longGesAction:(UILongPressGestureRecognizer *)ges
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *savePhoto = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self savePhotoAction];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:savePhoto];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)rightButtonAction
{
    [self presentViewController:self.alert animated:YES completion:nil];
}
- (void)savePhotoAction
{
    UIImageWriteToSavedPhotosAlbum(_iconImg.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [stdPubFunc stdShowMessage:msg];
}
////选择图片完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = info[@"UIImagePickerControllerEditedImage"];
    self.iconImg.image = image;
    [self saveImage:image];
    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
}
//保存图片
- (void)saveImage:(UIImage *)currentImage
{
    NSData *imgData = UIImageJPEGRepresentation(currentImage, 1.0f);
    UIImage *image = [[UIImage alloc] initWithData:imgData];


    NSString *imgUrl = [NSString stringWithFormat:@"%@support/sys/forUpLoading", BaseUrl];
    imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:imgUrl parameters:@{@"tid":ApplicationDelegate.myLoginInfo.Id,@"status":@"-2",} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            
            NSString *name =[NSString stringWithFormat:@"image_ios_img_touxiang.png"];
            
            NSString *type = @"image/jpeg";
            
            [formData appendPartWithFileData:imgData name:@"image_stream" fileName:name mimeType:type];
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
                                  [SVProgressHUD showSuccessWithStatus:@"头像上传成功"];
                                  ApplicationDelegate.myLoginInfo.image = dict_data[@"i"][@"Data"][@"url"];
                              }
                          }
                      }];
        
        [uploadTask resume];
}
- (void)initUI
{
    self.topTitle = @"个人头像";
    _backView = [UIView new];
    _backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_backView];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
        make.left.bottom.right.offset(0);
    }];
    _iconImg = [UIImageView new];
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:ApplicationDelegate.myLoginInfo.image] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    [_backView addSubview:_iconImg];
    [_iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(fDeviceWidth);
        make.centerY.centerX.equalTo(_backView);
    }];
    _iconImg.userInteractionEnabled = YES;
    _lGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesAction:)];
    [_iconImg addGestureRecognizer:_lGes];
    self.rightImage = [UIImage imageNamed:@"dian"];
    [self.righButon addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (UIAlertController *)alert
{
    if (!_alert) {
        _alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *savePhoto = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self savePhotoAction];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:self.pickerController animated:YES completion:nil];
        }];
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:self.pickerController animated:YES completion:nil];
        }];
        [_alert addAction:photo];
        [_alert addAction:savePhoto];
        [_alert addAction:cancel];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [_alert addAction:camera];
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
