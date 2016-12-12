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


- (void)setMGoods:(LKDBHelperGoodsObj *)mGoods{

    
    [self.mGoodsImg sd_setImageWithURL:[NSURL URLWithString:mGoods.mGoodsImg] placeholderImage:IMG(@"ZLDefault_Green")];
    self.mGoodsName.text = mGoods.mGoodsName;
    self.mPrice.text = [NSString stringWithFormat:@"%.2f元",mGoods.mExtObj.mTotlePrice];
    self.mNum.text = [NSString stringWithFormat:@"%d",mGoods.mExtObj.mGoodsNum];
    NSString *mSpe = @"";
    
    if (mGoods.mGoodsSKU.count<= 0) {
        mSpe = mGoods.mSpe.mSpeGoodsName;
    }else{
        for (int i =0;i<mGoods.mGoodsSKU.count;i++) {
            ZLSpeObj *mSku = mGoods.mGoodsSKU[i];
            if (i==mGoods.mGoodsSKU.count-1) {
                mSpe = [mSpe stringByAppendingString:[NSString stringWithFormat:@"%@",mSku.mSpeGoodsName]];
                
            }else{
                mSpe = [mSpe stringByAppendingString:[NSString stringWithFormat:@"%@-",mSku.mSpeGoodsName]];
            }
        }

    }
    
    
    self.mGoodsContent.text = mSpe;
    
    if (mGoods.mSelected == YES) {
        [self.mSelectedImg setImage:[UIImage imageNamed:@"ZLShopCar_Selected"]];
    }else{
        [self.mSelectedImg setImage:[UIImage imageNamed:@"ZLShopCar_Normal"]];
    }

    
}

@end
