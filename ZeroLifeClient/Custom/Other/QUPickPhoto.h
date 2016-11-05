//
//  QUPickPhoto.h
//  DianJiWang
//
//  Created by 瞿伦平 on 16/10/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QUPickPhoto : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
@property(nonatomic,strong) UIViewController *vc;
@property(nonatomic,strong) UIImage *chooseImg;

@property (nonatomic, copy) void (^imgCallBack)(UIImage* img);

- (void)alertShowView;

@end
