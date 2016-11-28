//
//  ZLSpeSmallClassViewCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLSpeSmallClassViewCell.h"

@implementation ZLSpeSmallClassViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}
-(void)setupView{
    _mNameLabel = [UILabel new];
    _mNameLabel.font = [UIFont systemFontOfSize:12];
    _mNameLabel.numberOfLines = 0;
    _mNameLabel.textAlignment = NSTextAlignmentCenter;
    _mNameLabel.userInteractionEnabled = YES;
    _mNameLabel.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 30);
    [self.contentView addSubview:_mNameLabel];
    
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3.0f;
    [self setTintColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00]];
    self.layer.borderWidth = .5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _mNameLabel.textColor = [UIColor blackColor];
}
-(void)setName:(NSString *)name{
    _mNameLabel.text = name;
    _mNameLabel.backgroundColor = [UIColor whiteColor];
}
-(void)layoutSubviews{
    [super layoutSubviews];
}

@end
