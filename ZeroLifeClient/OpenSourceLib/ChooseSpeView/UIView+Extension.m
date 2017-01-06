//
//  UIView+Extension.m
//  HaoWeibo
//
//  Created by 张仁昊 on 16/3/9.
//  Copyright © 2016年 张仁昊. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)


- (void)setKx:(CGFloat)kx{
    
    CGRect frame = self.frame;
    frame.origin.x = kx;
    self.frame = frame;
}

- (void)setKy:(CGFloat)ky{

    
    CGRect frame = self.frame;
    frame.origin.y = ky;
    self.frame = frame;
}

-(CGFloat)kx{
    
    return self.frame.origin.x;
}

-(CGFloat)ky{
    
    return self.frame.origin.y;
}
- (void)setKcenterX:(CGFloat)kcenterX{
    
    CGPoint center = self.center;
    center.x = kcenterX;
    self.center = center;
}
- (CGFloat)kcenterX{

    
    return self.center.x;
}
- (void)setKcenterY:(CGFloat)kcenterY{
    
    CGPoint center = self.center;
    center.y = kcenterY;
    self.center = center;
}

-(CGFloat)kcenterY{
    
    return self.center.y;
}
- (void)setKwidth:(CGFloat)kwidth{
    
    CGRect frame = self.frame;
    frame.size.width = kwidth;
    self.frame = frame;
}
- (void)setKheight:(CGFloat)kheight{
    
    CGRect frame = self.frame;
    frame.size.height = kheight;
    self.frame = frame;
}
- (CGFloat)kheight{
    
    return self.frame.size.height;
}

-(CGFloat)kwidth{
    
    return self.frame.size.width;
}
- (void)setKsize:(CGSize)ksize{
    
    CGRect freme = self.frame;
    freme.size = ksize;
    self.frame = freme;
}

-(CGSize)ksize{
    
    return self.frame.size;
}
- (void)setKorigin:(CGPoint)korigin{
    
    CGRect frame = self.frame;
    frame.origin = korigin;
    self.frame = frame;
}

-(CGPoint)korigin{
    
    return self.frame.origin;
}






@end
