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
    
}

- (void)setMCampain:(ZLShopCampain *)mCampain{
    self.mContent.text = mCampain.cam_name;

}

@end
