//
//  ZLPPTRewardCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTRewardCell.h"

@implementation ZLPPTRewardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMObj:(ZLPPTRewardObj *)mObj{

    self.mTitle.text = mObj.des;
    self.mTime.text = mObj.odr_finished_time;
    self.mMoney.text = [NSString stringWithFormat:@"+¥%.2f元",mObj.odr_deliver_fee];
    
    
}

@end
