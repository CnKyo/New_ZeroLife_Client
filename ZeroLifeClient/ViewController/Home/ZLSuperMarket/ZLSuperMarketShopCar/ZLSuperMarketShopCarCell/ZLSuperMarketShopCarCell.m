//
//  ZLSuperMarketShopCarCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketShopCarCell.h"

@implementation ZLSuperMarketShopCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mSelectedAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLShopCarSelectedBtnDidSelected:andIndexPath:)]) {
        [self.delegate ZLShopCarSelectedBtnDidSelected:sender.selected andIndexPath:self.mIndexPAth];
    }
    
    
    
}

- (IBAction)mDeleteAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLShopCarDeleteBtnDidSelectedWithIndexPath:)]) {
        [self.delegate ZLShopCarDeleteBtnDidSelectedWithIndexPath:self.mIndexPAth];
    }
    
    
}
- (IBAction)mSubstructAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLShopCarSubstructBtnDidSelectedWithIndexPath:)]) {
        [self.delegate ZLShopCarSubstructBtnDidSelectedWithIndexPath:self.mIndexPAth];
    }
    
}
- (IBAction)mAddAction:(UIButton *)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(ZLShopCarAddBtnDidSelectedWithIndexPath:)]) {
        [self.delegate ZLShopCarAddBtnDidSelectedWithIndexPath:self.mIndexPAth];
    }
    
}



@end
