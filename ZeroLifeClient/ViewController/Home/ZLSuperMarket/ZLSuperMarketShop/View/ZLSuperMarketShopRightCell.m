//
//  ZLSuperMarketShopRightCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketShopRightCell.h"

@implementation ZLSuperMarketShopRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)mSubstructAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLSuperMarketGoodsCellWithSubstructSelectedIndexPath:)]) {
        [self.delegate ZLSuperMarketGoodsCellWithSubstructSelectedIndexPath:self.mIndexPath];

    }
    
    
}

- (IBAction)mAddAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLSuperMarketGoodsCellWithAddSelectedIndexPath:)]) {
        [self.delegate ZLSuperMarketGoodsCellWithAddSelectedIndexPath:self.mIndexPath];

    }
    
}


@end
