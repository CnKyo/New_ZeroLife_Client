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

@end
