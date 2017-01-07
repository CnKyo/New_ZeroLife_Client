//
//  ZLRunningManCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRunningManCell.h"

@implementation ZLRunningManCell

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
    
    self.mBtn.layer.masksToBounds = YES;
    self.mBtn.layer.cornerRadius = 3;
    self.mBtn.layer.borderColor = [UIColor colorWithRed:1.00 green:0.49 blue:0.08 alpha:1.00].CGColor;
    self.mBtn.layer.borderWidth = 0.5;
}

- (IBAction)mBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLRunningManCellDelegateWithBtnClick:)]) {
        [self.delegate ZLRunningManCellDelegateWithBtnClick:self.mIndexPath];
    }
    
}


- (void)setMOrder:(ZLRunningmanHomeOrder *)mOrder{

    UIImage *mLogo = [UIImage new];
    
    if (self.mType  == ZLPPTReleaseTypeWithBuyStaff) {
        mLogo = [UIImage imageNamed:@"PPTIcon_Buy"];
        
    }else{
        mLogo = [UIImage imageNamed:@"PPTIcon_Do"];
    }
    
//    [self.mImg sd_setImageWithURL:[NSURL imageurl:nil] placeholderImage:ZLDefaultAvatorImg];
    
    self.mImg.image = mLogo;
    
    self.mName.text = mOrder.odrg_pro_name;
    self.mTime.text = [NSString stringWithFormat:@"%@分钟内完成",mOrder.odr_timing];
    self.mMoney.text = [NSString stringWithFormat:@"酬劳：¥%d",mOrder.odr_deliver_fee];
    self.mDistance.text = [NSString stringWithFormat:@"距离%@m",mOrder.distance];
    self.mSendAddress.text = [NSString stringWithFormat:@"需求内容：%@",mOrder.odrg_spec];
    self.mArriveAddress.text = mOrder.odr_deliver_address;
    
    if ([ZLUserInfo ZLCurrentUser].user_id == mOrder.user_id) {
        [self.mBtn setTitle:@"取消订单" forState:0];
        self.mBtn.hidden = YES;
    }else{
        [self.mBtn setTitle:@"立即接单" forState:0];
    }
    
    
    
}


@end
