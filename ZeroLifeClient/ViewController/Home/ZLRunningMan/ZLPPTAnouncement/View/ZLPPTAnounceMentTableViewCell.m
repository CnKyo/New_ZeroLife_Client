//
//  ZLPPTAnounceMentTableViewCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTAnounceMentTableViewCell.h"

@implementation ZLPPTAnounceMentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMTopObj:(ZLPPTRKLObj *)mTopObj{

    UIImage *mLevel = [UIImage new];
    
    if (mTopObj.rkl_grade>=5 && mTopObj.rkl_grade <10) {
        mLevel = [UIImage imageNamed:@"PPT_A"];
    }else if (mTopObj.rkl_grade>3 && mTopObj.rkl_grade <5){
        mLevel = [UIImage imageNamed:@"PPT_B"];
    }else{
        mLevel = [UIImage imageNamed:@"PPT_C"];
    }
    
    [self.mLevelImg setImage:mLevel];
    
    [self.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mTopObj.rkl_portrait]] placeholderImage:ZLDefaultAvatorImg];
    
    self.mName.text = mTopObj.rkl_user_name;
    
    self.mOrderNum.text = [NSString stringWithFormat:@"接单数：%d",mTopObj.rkl_order_quantity];
    self.mContent.text = [NSString stringWithFormat:@"等级:V%d",mTopObj.rkl_grade];
    self.mLevel.text = [NSString stringWithFormat:@"评分：%.1f",mTopObj.rkl_score];
    
    
    
    
}

@end
