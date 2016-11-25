//
//  ZLCommitRepairsCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLCommitRepairsCell.h"

@implementation ZLCommitRepairsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.mCommitBtn.layer.masksToBounds = YES;
    self.mCommitBtn.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mSelectedAddress:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithAddressAction)]) {
        [self.delegate ZLCommitRepairsCellWithAddressAction];
    }

}

- (IBAction)mSelectedTime:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithTimeAction)]) {
        [self.delegate ZLCommitRepairsCellWithTimeAction];

    }

}

- (IBAction)mSelectedCoup:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithCoupAction)]) {
        [self.delegate ZLCommitRepairsCellWithCoupAction];
    }
    

}

- (IBAction)mUpLoadImg:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithUpLoadImgAction)]) {
        [self.delegate ZLCommitRepairsCellWithUpLoadImgAction];
    }
    
    
}

- (IBAction)mUpLoadVideo:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithUpLoadVideoAction)]) {
        [self.delegate ZLCommitRepairsCellWithUpLoadVideoAction];
    }
    

    
}

- (IBAction)mCommit:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithCommitAction)]) {
        [self.delegate ZLCommitRepairsCellWithCommitAction];
    }
    
}

@end
