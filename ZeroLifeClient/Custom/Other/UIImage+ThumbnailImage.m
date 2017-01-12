//
//  UIImage+ThumbnailImage.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2017/1/6.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "UIImage+ThumbnailImage.h"

@implementation UIImage (ThumbnailImage)

+(UIImage *)getThumbnailImage:(NSString *)videoURL

{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;//按正确方向对视频进行截图,关键点是将AVAssetImageGrnerator对象的appliesPreferredTrackTransform属性设置为YES。
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;  
}




/**
 *  返回指定格式图片
 *
 *  @param image       源图片
 *  @param maxFileSize 目标大小，单位为k,如 20kb
 *
 *  @return 返回图片
 */
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    NSUInteger length = 0, lengthNew = 0;
    
    CGFloat compression = 0.9f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    length = imageData.length;
    lengthNew = length;
    
    
    
    NSUInteger lengthTag = maxFileSize*1000;
    NSUInteger lengthOffset = 20*1000;
    
    //NSLog(@"Length: %lu New: %lu lengthTag: %lu  lengthOffset: %lu", length, lengthNew, lengthTag, lengthOffset);
    //
    while (lengthNew > lengthTag && (length-lengthNew)<lengthOffset) { //当源图片大于指定大小，并且两次裁切差大于20kb 时
        length = lengthNew;
        compression -= compression/2;
        imageData = UIImageJPEGRepresentation(image, compression);
        lengthNew = imageData.length;
        
        //NSLog(@"WhileLength: %lu  New:%lu  compression:%.2f", (unsigned long)length, (unsigned long)lengthNew, compression);
    }
    //NSLog(@"Length: %lu New: %lu lengthTag: %lu  lengthOffset: %lu", length, lengthNew, lengthTag, lengthOffset);
    //NSLog(@"Length: %lu", (unsigned long)imageData.length);
    return imageData;
}



+ (UIImage *)imageFromColor:(UIColor *)color {
    return [self imageFromColor:color targetSize:CGSizeMake(600, 600)];
}

+ (UIImage *)imageFromColor:(UIColor *)color targetSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
