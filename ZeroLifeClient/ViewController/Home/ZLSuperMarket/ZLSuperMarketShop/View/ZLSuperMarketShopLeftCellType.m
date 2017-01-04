//
//  ZLSuperMarketShopLeftCellType1.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketShopLeftCellType.h"

@implementation ZLSuperMarketShopLeftCellType

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMClassify:(ZLShopClassify *)mClassify{

    self.mContent.text = mClassify.cls_name;
    if (mClassify.cls_image.length<=0 || [mClassify.cls_image isEqualToString:@""]) {
        self.mImgW.constant = 0;
        self.mLogo.hidden = YES;
    }
    else{
        self.mImgW.constant = 30;
        self.mLogo.hidden = NO;
        [self.mLogo sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mClassify.cls_image]] placeholderImage:[UIImage imageNamed:@"ZLShop_Hot"]];
    }
    

    self.mBgkImg.hidden = !mClassify.isSelected;
    
}

- (void)setMCampain:(ZLShopCampain *)mCampain{
    
    self.mContent.text = mCampain.cam_name;
    self.mLogo.image = [UIImage imageNamed:@"ZLShop_Hot"];

    self.mBgkImg.hidden = mCampain.isSelected;
}

@end
