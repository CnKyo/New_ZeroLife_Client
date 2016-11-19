//
//  ZLRunningManCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRunningManCell.h"

@implementation ZLRunningManCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.mBtn.layer.masksToBounds = YES;
    self.mBtn.layer.cornerRadius = 3;
    self.mBtn.layer.borderColor = [UIColor colorWithRed:1.00 green:0.49 blue:0.08 alpha:1.00].CGColor;
    self.mBtn.layer.borderWidth = 0.5;
}

- (IBAction)mBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLRunningManCellDelegateWithBtnClick:)]) {
        [self.delegate ZLRunningManCellDelegateWithBtnClick:self.mIndexPath];
    }
    
}



@end