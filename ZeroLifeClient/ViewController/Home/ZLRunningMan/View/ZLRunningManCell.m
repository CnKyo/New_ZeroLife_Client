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

    [self.mImg sd_setImageWithURL:[NSURL imageurl:nil] placeholderImage:ZLDefaultAvatorImg];
    
    self.mName.text = mOrder.odrg_pro_name;
    self.mTime.text = [NSString stringWithFormat:@"%@分钟内完成",mOrder.odr_timing];
    self.mMoney.text = [NSString stringWithFormat:@"酬劳：¥%d",mOrder.odr_deliver_fee];
    self.mDistance.text = [NSString stringWithFormat:@"距离%@m",mOrder.distance];
    self.mSendAddress.text = [NSString stringWithFormat:@"需求内容：%@",mOrder.odrg_spec];
    self.mArriveAddress.text = mOrder.odr_deliver_address;
    
}


@end
