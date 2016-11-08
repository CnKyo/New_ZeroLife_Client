//
//  ImgNameView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ImgNameView.h"

@implementation ImgNameView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imgView = [self newUIImageView];
        self.nameLable = [self newUILable];
        self.nameLable.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
