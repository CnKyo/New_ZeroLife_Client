//
//  HeaderView.m
//  CityListWithIndex
//
//  Created by ljw on 16/7/19.
//  Copyright © 2016年 ljw. All rights reserved.
//

#import "HeaderView.h"

#define UIBounds [[UIScreen mainScreen] bounds]

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _titleView.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 7, self.frame.size.width-16*2, 14)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_titleView addSubview:_titleLabel];
    }
    return self;
}

- (void)setTitleString:(NSString *)titleString
{
    _titleLabel.text = titleString;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
