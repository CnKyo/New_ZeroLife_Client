//
//  UIImage+ThumbnailImage.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2017/1/6.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@interface UIImage (ThumbnailImage)

///获取网络视频的缩略图
+(UIImage *)getThumbnailImage:(NSString *)videoURL;

///获取指定文件大小的图片
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;
@end
