//
//  NSObject+PickPhoto.m
//  DianJiWang
//
//  Created by 瞿伦平 on 16/10/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "NSObject+PickPhoto.h"


static const void *JKStringProperty = &JKStringProperty;


@implementation NSObject (PickPhoto)


//选择并上传图片
-(void)chooseAndUpdateImgCall:( void(^)(UIImage *img, NSString *fileUrlStr))callback
{
//    [self startChoosePhotoCall:^(UIImage *img) {
//        NSLog(@"img:%@", img);
//        [SVProgressHUD showWithStatus:@"上传中..."];
//        [[APIClient sharedClient] updateFileWithTag:self img:img call:^(NSString *fileUrlStr, APIObject *info) {
//            if (info.code == RESP_STATUS_YES) {
//                [SVProgressHUD showSuccessWithStatus:info.msg];
//                callback(img, fileUrlStr);
//            } else {
//                [SVProgressHUD showErrorWithStatus:info.msg];
//                callback(img, nil);
//            }
//        }];
//        
//    }];
}


-(void)startChoosePhotoCall:( void(^)(UIImage *img))callback
{
    UIViewController *vc = [UIViewController topViewController];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"相片选取" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            if ([self isFrontCameraAvailable]) {
            //                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            //            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.bk_didFinishPickingMediaBlock = ^(UIImagePickerController *picker, NSDictionary *info) {
                NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
                if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
                    UIImage* editedImage = [info objectForKey:UIImagePickerControllerOriginalImage]; //获取用户编辑之后的图像
                    callback(editedImage);
                }
                [picker dismissViewControllerAnimated:YES completion:^() {}];
            };
            controller.bk_didCancelBlock = ^(UIImagePickerController *picker){
                [picker dismissViewControllerAnimated:YES completion:^() {}];
            };
            [vc presentViewController:controller animated:YES completion:^(void){ }];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"从相册中选取"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.bk_didFinishPickingMediaBlock = ^(UIImagePickerController *picker, NSDictionary *info) {
                NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
                if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
                    UIImage* editedImage = [info objectForKey:UIImagePickerControllerOriginalImage]; //获取用户编辑之后的图像
                    callback(editedImage);
                }
                [picker dismissViewControllerAnimated:YES completion:^() {}];
            };
            controller.bk_didCancelBlock = ^(UIImagePickerController *picker){
                [picker dismissViewControllerAnimated:YES completion:^() {}];
            };
            [vc presentViewController:controller animated:YES completion:^(void){ }];
        }
    }]];
    [vc presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [picker dismissViewControllerAnimated:YES completion:^() {
//        
//        NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
//        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
//            UIImage* editedImage = [info objectForKey:UIImagePickerControllerOriginalImage]; //获取用户编辑之后的图像
//            //[self endLoadOriginalImage:editedImage];
//        }
//    }];
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [picker dismissViewControllerAnimated:YES completion:^(){
//    }];
//}



#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}


@end
