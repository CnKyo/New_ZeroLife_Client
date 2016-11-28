//
//  ZLSpeHeaderView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLSpeHeaderView.h"

@implementation ZLSpeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _mNameLabel = [UILabel new];
        _mNameLabel.font = [UIFont systemFontOfSize:12];
        _mNameLabel.numberOfLines = 0;
        //        _mNameLabel.textAlignment = NSTextAlignmentCenter;
        _mNameLabel.userInteractionEnabled = YES;
        _mNameLabel.frame = CGRectMake(10, 5, self.frame.size.width - 20, 30);
        [self addSubview:_mNameLabel];
    }
    return self;
}

@end
