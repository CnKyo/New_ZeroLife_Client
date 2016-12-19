//
//  ZLCommitOrderCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLCommitOrderCell.h"


@interface ZLCommitOrderCell()<UITextViewDelegate>

@end

@implementation ZLCommitOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.mNoteTx setPlaceholder:@"请输入您的备注信息!"];
    [self.mNoteTx setHolderToTop];

    self.mNoteTx.delegate = self;
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


- (void)setMGoodsObj:(ZLPreOrderGoods *)mGoodsObj{

    [self.mGoodsLogo sd_setImageWithURL:[NSURL URLWithString:mGoodsObj.odrg_img] placeholderImage:ZLDefaultGoodsImg];
    self.mGoodsName.text = mGoodsObj.odrg_pro_name;
    self.mGoodsPrice.text = [NSString stringWithFormat:@"¥%.2f元    数量：%d",mGoodsObj.odrg_price,mGoodsObj.odrg_number];
    
    
    
}

- (void)setMPreOrderObj:(ZLPreOrderObj *)mPreOrderObj{

    self.mPrice.text = [NSString stringWithFormat:@"¥%.2f元",mPreOrderObj.payMoney];
    self.mCoupMoney.text = [NSString stringWithFormat:@"¥%.2f元",mPreOrderObj.deliver_price];
    
    if (mPreOrderObj.mSendType == ZLShopSendTypeWithSelf) {
        [self.mSendType setTitle:@"上门自提" forState:0];
    }else{
        [self.mSendType setTitle:@"店铺配送" forState:0];
    }
    
}


@end
