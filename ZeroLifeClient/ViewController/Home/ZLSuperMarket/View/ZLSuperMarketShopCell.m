//
//  ZLSuperMarketShopCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketShopCell.h"

@implementation ZLSuperMarketShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMCampain:(ZLShopHomeCampaign *)mCampain{

    [self.mActivityImage2 sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mCampain.adv_image]] placeholderImage:[UIImage imageNamed:@"ZLDefault_Activity"]];

}

- (void)setMShopObj:(ZLShopHomeShopObj *)mShopObj{

    self.mShopName.text = mShopObj.shop_name;
    self.mSendTime.text = [NSString stringWithFormat:@"%@  满%.f元起送",mShopObj.ext_max_time,mShopObj.ext_min_price];
    self.mSailsNum.text = [NSString stringWithFormat:@"销量：%d",mShopObj.ext_sales_month];
    self.mDistance.text = [NSString stringWithFormat:@"%@m",mShopObj.distance];
    [self.mShopLogo sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mShopObj.shop_logo]] placeholderImage:[UIImage imageNamed:@"ZLDefault_Green"]];
    
    
}

@end
