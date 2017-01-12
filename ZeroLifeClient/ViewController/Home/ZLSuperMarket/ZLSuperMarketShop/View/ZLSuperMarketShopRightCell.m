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

- (void)layoutSubviews{

    [super layoutSubviews];
    self.mSpecBtn.layer.masksToBounds = YES;
    self.mSpecBtn.layer.cornerRadius = 8;
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

- (IBAction)mSpecBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLSuperMarketGoodsCellWithSpecBtnSelectedIndexPath:)]) {
        [self.delegate ZLSuperMarketGoodsCellWithSpecBtnSelectedIndexPath:self.mIndexPath];
    }
    
}

- (void)setMGoodsObj:(ZLGoodsWithCamp *)mGoodsObj{
    
    [self.mGoodsImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mGoodsObj.img_url]] placeholderImage:[UIImage imageNamed:@"ZLDefault_Img"]];
    self.mGoodsName.text = mGoodsObj.pro_name;
    self.mGoodsPrice.text = [NSString stringWithFormat:@"%f元",mGoodsObj.sku_price];
    self.mSailsNum.text = [NSString stringWithFormat:@"月销:%d件",mGoodsObj.pro_sales_total];
    self.mGoodsCount.text = [NSString stringWithFormat:@"库存:%d件",mGoodsObj.sku_stock];
}

- (void)setMGoods:(ZLGoodsWithClass *)mGoods{
    [self.mGoodsImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mGoods.img_url]] placeholderImage:[UIImage imageNamed:@"ZLDefault_Img"]];
    self.mGoodsName.text = mGoods.pro_name;
    self.mSailsNum.text = [NSString stringWithFormat:@"月销:%d件",mGoods.pro_sales_total];
    self.mGoodsCount.text = [NSString stringWithFormat:@"%@/%@",mGoods.pro_weight,mGoods.pro_unit];
    
    
//    NSDictionary* style = @{@"font" : [UIFont systemFontOfSize:13],
//                            @"color":[UIColor lightGrayColor]};
    
    if (mGoods.skus.count<=0) {
        self.mGoodsPrice.text = [NSString stringWithFormat:@"保质期:%@",mGoods.pro_date_life];
    }else{
    
        for (ZLGoodsSKU *mSku in mGoods.skus) {
            
            if (mGoods.sku_id == mSku.sku_id) {
           
//                self.mGoodsPrice.attributedText = [[NSString stringWithFormat:@"¥%.2f元  <color><font>%@</font></color>",mSku.sku_price,mSku.sta_val_name] attributedStringWithStyleBook:style];
                
                self.mGoodsPrice.text = [NSString stringWithFormat:@"¥%.2f元",mSku.sku_price];



            }
        }
    }
    
    
}

@end
