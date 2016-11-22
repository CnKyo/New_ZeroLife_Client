//
//  ZLAnounceMentCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/22.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLAnounceMentCell.h"

@implementation ZLAnounceMentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.mView.layer.masksToBounds = YES;
    self.mView.layer.cornerRadius = 5;
    self.mView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mView.layer.borderWidth = 0.5;
    
    self.mTime.layer.masksToBounds = YES;
    self.mTime.layer.cornerRadius = 3;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
