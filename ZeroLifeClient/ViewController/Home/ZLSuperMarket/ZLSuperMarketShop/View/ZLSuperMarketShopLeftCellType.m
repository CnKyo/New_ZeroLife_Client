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


- (void)setMObj:(ZLShopLeftObj *)mObj{
    self.mContent.text = mObj.mName;
    if (mObj.mType == ZLShopLeftTypeCamp) {
        self.mLogo.image = [UIImage imageNamed:@"ZLShop_Hot"];

    }else{
        if (mObj.mImg.length<=0 || [mObj.mImg isEqualToString:@""]) {
            self.mImgW.constant = 0;
            self.mLogo.hidden = YES;
        }
        else{
            self.mImgW.constant = 30;
            self.mLogo.hidden = NO;
            [self.mLogo sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mObj.mImg]] placeholderImage:[UIImage imageNamed:@"ZLShop_Hot"]];
        }

    }
    
    if (mObj.imISelected) {
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:0.75];
        self.mBgkImg.backgroundColor = M_CO;
    }else{
        self.backgroundColor = [UIColor whiteColor];
        self.mBgkImg.backgroundColor = [UIColor whiteColor];
    }
    
   
}

@end
