//
//  UIButton+CustomLocal.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UIButton+CustomLocal.h"

@implementation UIButton (CustomLocal)

-(void)setStyleNavColor
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self jk_setBackgroundColor:COLOR_NavBar forState:UIControlStateNormal];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}

@end
