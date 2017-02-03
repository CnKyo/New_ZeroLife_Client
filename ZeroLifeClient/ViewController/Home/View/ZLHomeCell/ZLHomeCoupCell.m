//
//  ZLHomeCoupCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/3.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeCoupCell.h"

@implementation ZLHomeCoupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMCoup:(ZLSystempCoup *)mCoup{

    self.mMoney.text = mCoup.cup_price;
    self.mContent.text = mCoup.cup_content;
    self.mTitle.text = mCoup.cup_name;
}
@end
