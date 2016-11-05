//
//  NSObject+PickPhoto.h
//  DianJiWang
//
//  Created by 瞿伦平 on 16/10/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JKCategories/JKUIKit.h>
#import <BlocksKit/BlocksKit+UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIViewController+Additions.h"
#import "APIClient.h"
#import <SVProgressHUD/SVProgressHUD.h>


@interface NSObject (PickPhoto) <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

/**
 *  @brief  catgory runtime实现get set方法增加一个字符串属性
 */
//@property (nonatomic,strong) UIImage *jk_stringProperty;

//选取图片
-(void)startChoosePhotoCall:( void(^)(UIImage *img))callback;


//选取图片并上传返回路径
-(void)chooseAndUpdateImgCall:( void(^)(UIImage *img, NSString *fileUrlStr))callback;

@end
