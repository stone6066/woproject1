//
//  backAndHangUpViewController.m
//  woproject
//
//  Created by tianan-apple on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//  退单和挂起界面

#import "backAndHangUpViewController.h"

@interface backAndHangUpViewController ()<UITextViewDelegate>

@end

@implementation backAndHangUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self drawMainView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id)init:(NSString *)listId viewType:(NSInteger)typeI{
    if (self==[super init]) {
        _listId=listId;
        _ViewType=typeI;
    }
    return self;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topviewcolor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, fDeviceWidth, 40)];
    topLbl.text=@"处置";
    [topLbl setFont:[UIFont systemFontOfSize:18]];
    [topLbl setTextAlignment:NSTextAlignmentCenter];
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 27, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [TopView addSubview:backimg];
    
    UILabel *hintLbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 29, 30, 20)];
    hintLbl.text=@"返回";
    [hintLbl setFont:[UIFont systemFontOfSize:14]];
    [hintLbl setTextAlignment:NSTextAlignmentCenter];
    [hintLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:hintLbl];
    
    
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    [self.view addSubview:TopView];
}
-(void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickbtnFunc:(UIButton*)btn{
    NSLog(@"clickbtnFunc:%d",btn.tag);
    NSString *upType=[NSString stringWithFormat:@"%d",_ViewType];
    switch (btn.tag) {
        case 200://添加第1个图片
            self.imgTag = btn.tag;
            [self presentViewController:self.alert animated:YES completion:nil];
            break;
        case 201://添加第2个图片
            self.imgTag = btn.tag;
            [self presentViewController:self.alert animated:YES completion:nil];
            break;
        case 202://添加第3个图片
            self.imgTag = btn.tag;
            [self presentViewController:self.alert animated:YES completion:nil];
            break;
        case 203:
            [self upLoadHangTickInofo];
            break;
        default:
            break;
    }
}
-(void)stdSetAddImgBtn:(UIButton *)btn{
    [btn addTarget:self action:@selector(clickbtnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setImage:[UIImage imageNamed:@"baoxiujiahao"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [self.view addSubview:btn];
}

-(void)drawMainView{
    CGFloat offsetX=15;
    CGFloat offsetY=TopSeachHigh+15;
    UILabel * ViewTitle=[[UILabel alloc]initWithFrame:CGRectMake(offsetX, offsetY, 100, 30)];
     NSMutableAttributedString *str= [[NSMutableAttributedString alloc] initWithString:@"挂起原因:*"];
    if (_ViewType==5) {
        str = [[NSMutableAttributedString alloc] initWithString:@"退单原因:*"];
    }
    else if(_ViewType==6)
        str = [[NSMutableAttributedString alloc] initWithString:@"挂起原因:*"];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor blackColor]
                range:NSMakeRange(0,5)];

    
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor redColor]
                range:NSMakeRange(5,1)];
    
    ViewTitle.attributedText=str;
    
    if (!_descTxt) {
        _descTxt=[[UITextView alloc]initWithFrame:CGRectMake(offsetX,offsetY+45, fDeviceWidth-offsetX*2,120)];
        [self.view addSubview:_descTxt];
        _descTxt.delegate=self;

    }
    [self.view addSubview:ViewTitle];
    [self.view addSubview:_descTxt];
    
    if (!_addImg1) {
        _addImg1=[[UIButton alloc]initWithFrame:CGRectMake(offsetX, _descTxt.frame.origin.y+_descTxt.frame.size.height+15, 40, 40)];
        _addImg1.tag=200;
        [self stdSetAddImgBtn:_addImg1];
    }
    
    if (!_addImg2) {
        _addImg2=[[UIButton alloc]initWithFrame:CGRectMake(offsetX+45, _descTxt.frame.origin.y+_descTxt.frame.size.height+15, 40, 40)];
        _addImg2.tag=201;
        
        [self stdSetAddImgBtn:_addImg2];
    }
    
    
    if (!_addImg3) {
        _addImg3=[[UIButton alloc]initWithFrame:CGRectMake(offsetX+45*2, _descTxt.frame.origin.y+_descTxt.frame.size.height+15, 40, 40)];
        _addImg3.tag=202;
        [self stdSetAddImgBtn:_addImg3];

    }
    
    if (!_doneBtn) {
        _doneBtn=[[UIButton alloc]initWithFrame:CGRectMake(offsetX, _addImg3.frame.origin.y+_addImg3.frame.size.height+15, fDeviceWidth-offsetX*2, 40)];
        _doneBtn.tag=203;
        if (_ViewType==5) {
           [_doneBtn setTitle:@"确认退单" forState:UIControlStateNormal];// 添加文字
        }
        else
           [_doneBtn setTitle:@"确认挂起" forState:UIControlStateNormal];
        
        _doneBtn.backgroundColor=bluetxtcolor;
        [_doneBtn addTarget:self action:@selector(clickbtnFunc:) forControlEvents:UIControlEventTouchUpInside];
        
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [self.view addSubview:_doneBtn];

        
    }

}



//0.派单；1.接单；2.到场；3.完成；4.核查；5.退单；6.挂起；7.协助
//-(void)upInfoRepair:(NSString*)operationType{
//    [SVProgressHUD showWithStatus:k_Status_Load];
//    
//    NSMutableDictionary * paramDict=[[NSMutableDictionary alloc]init];
//    
//    [paramDict setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"uid"];
//    [paramDict setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
//    [paramDict setObject:_listId forKey:@"tid"];
//    [paramDict setObject:operationType forKey:@"operation"];
//    [paramDict setObject:_descTxt.text forKey:@"result"];
//    
//    
//    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"support/ticket/forTicketFlow"];
//    
//    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [ApplicationDelegate.httpManager POST:urlstr
//                               parameters:paramDict
//                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
//                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                      //http请求状态
//                                      if (task.state == NSURLSessionTaskStateCompleted) {
//                                          NSError* error;
//                                          NSDictionary* jsonDic = [NSJSONSerialization
//                                                                   JSONObjectWithData:responseObject
//                                                                   options:kNilOptions
//                                                                   error:&error];
//                                          NSLog(@"上报退单返回：%@",jsonDic);
//                                          NSString *suc=[jsonDic objectForKey:@"s"];
//                                          NSString *msg=[jsonDic objectForKey:@"m"];
//                                          //
//                                          if ([suc isEqualToString:@"0"]) {
//                                              //成功
//                                              [SVProgressHUD dismiss];
//                                              [stdPubFunc stdShowMessage:msg];
//                                              [self clickleftbtn];
//                                              
//                                          } else {
//                                              //失败
//                                              [SVProgressHUD showErrorWithStatus:msg];
//                                              
//                                          }
//                                          
//                                      } else {
//                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
//                                          
//                                      }
//                                      
//                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                      //请求异常
//                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
//                                      
//                                  }];
//}



/*---抄徐阳上传图片--*/
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


- (NSMutableArray *)imgArray
{
    if (!_imgArray) {
        _imgArray = @[].mutableCopy;
    }
    return _imgArray;
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
        case 200:
            [self.addImg1 setImage:image forState:normal];
            if (self.imgArray.count == 1) {
                [self.imgArray removeObjectAtIndex:0];
            }
            [self.imgArray insertObject:imgData atIndex:0];
            self.addImg1.hidden = NO;
            break;
        case 201:
            [self.addImg2 setImage:image forState:normal];
            if (self.imgArray.count == 2) {
                [self.imgArray removeObjectAtIndex:1];
            }
            [self.imgArray insertObject:imgData atIndex:1];
            self.addImg2.hidden = NO;
            break;
        case 202:
            [self.addImg3 setImage:image forState:normal];
            if (self.imgArray.count == 3) {
                [self.imgArray removeObjectAtIndex:2];
            }
            [self.imgArray insertObject:imgData atIndex:2];
            self.addImg3.hidden = NO;
            break;
    }
}

- (NSMutableDictionary *)paramsDic
{
    if (!_paramsDic) {
        _paramsDic = [NSMutableDictionary dictionary];
    }
    return _paramsDic;
}
- (NSDictionary *)getParams
{
    [self.paramsDic setObject:ApplicationDelegate.myLoginInfo.Id forKey:@"uid"];
    [self.paramsDic setObject:ApplicationDelegate.myLoginInfo.ukey forKey:@"ukey"];
    [self.paramsDic setObject:_descTxt.text forKey:@"result"];
    [self.paramsDic setObject:_listId forKey:@"tid"];
    NSString *viewT=[NSString stringWithFormat:@"%d",_ViewType];
    [self.paramsDic setObject:viewT forKey:@"operation"];
    
    return self.paramsDic;
}
//- (void)ConfirmRepairAction:(UIButton *)sender
-(void)upLoadHangTickInofo
{
    //[self.rView.describeTextView resignFirstResponder];
    NSDictionary *params = [self getParams];
    if (_descTxt.text.length<1) {
        [stdPubFunc stdShowMessage:@"请填写原因"];
        return;
    }
    
    NSLog(@"upLoadHangTickInofo:%@", params);
    NSString *urlStr = [NSString stringWithFormat:@"%@support/ticket/forTicketFlow", BaseUrl];
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
                if (self.imgArray.count<1) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return ;
                }
                //NSString *cid = jsonDic[@"i"][@"Data"][@"id"];
                NSString *viewT=[NSString stringWithFormat:@"%d",_ViewType];
                NSString *imgUrl = [NSString stringWithFormat:@"%@support/sys/forUpLoading", BaseUrl];
                imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [self.imgArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:imgUrl parameters:@{@"tid":_listId,@"status":viewT,} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                        
                        
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
                                              NSLog(@"全部传完");
                                              [SVProgressHUD dismiss];
                                              [stdPubFunc stdShowMessage:@"上传完毕"];
                                              [self.navigationController popViewControllerAnimated:YES];
                                          }
                                          
                                      }
                                      
                                  }];
                    
                    [uploadTask resume];
                }];
                //                if (self.imgArray.count == 0) {
                //                    MyRepairVC *vc = [[MyRepairVC alloc] init];
                //                    vc.hidesBottomBarWhenPushed = YES;
                //                    [self.navigationController pushViewController:vc animated:YES];
                //                }
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

-(void)textViewDidChange:(UITextView *)textView{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum > txtViewMaxLen)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:txtViewMaxLen];
        [textView setText:s];
    }
}

@end
