//
//  ZLCommitOrderCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLCommitOrderCell.h"

@implementation ZLCommitOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mSendTypeAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitWithSendTypeBtnSelected)]) {
        [self.delegate ZLCommitWithSendTypeBtnSelected];
    }

    
}

- (IBAction)mCoupBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitWithCoupBtnSelected)]) {
        [self.delegate ZLCommitWithCoupBtnSelected];
    }
    
}



@end
