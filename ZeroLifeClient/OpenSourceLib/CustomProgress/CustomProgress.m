
//
//  CustomProgress.m
//  WisdomPioneer
//
//  Created by 主用户 on 16/4/11.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "CustomProgress.h"

@implementation CustomProgress
@synthesize bgimg,leftimg,presentlab;
- (id)initWithFrame:(CGRect)frame andType:(int)mType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        bgimg.layer.borderColor = [UIColor clearColor].CGColor;
        bgimg.layer.borderWidth =  1;
        
        if (mType == 1) {
            bgimg.layer.cornerRadius = 8;

        }else if(mType == 2){
            bgimg.layer.cornerRadius = 4;

        }else{
            bgimg.layer.cornerRadius = 2;
        }
        [bgimg.layer setMasksToBounds:YES];

        [self addSubview:bgimg];
        leftimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
        leftimg.layer.borderColor = [UIColor clearColor].CGColor;
        leftimg.layer.borderWidth =  1;
        if (mType == 1) {
            leftimg.layer.cornerRadius = 8;
            
        }else if(mType == 2){
            leftimg.layer.cornerRadius = 4;
            
        }else{
            leftimg.layer.cornerRadius = 2;
        }

        [leftimg.layer setMasksToBounds:YES];
        [self addSubview:leftimg];
        
    }
    return self;
}
-(void)setPresent:(int)present
{
    leftimg.frame = CGRectMake(0, 0, self.frame.size.width/self.maxValue*present, self.frame.size.height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
