//
//  UIButton+Border.m
//  New_Zero_Life_Service_IOS
//
//  Created by 瞿伦平 on 2017/1/10.
//  Copyright © 2017年 重庆超尔科技有限公司. All rights reserved.
//

#import "UIButton+Border.h"

@implementation UIButton (Border)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setTitleAndBorderColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

@end
