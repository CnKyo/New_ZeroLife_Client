




//
//  ZLPPTMyOrderCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTMyOrderCell.h"

@implementation ZLPPTMyOrderCell

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
    
    self.mRightBtn.layer.masksToBounds = YES;
    self.mRightBtn.layer.cornerRadius = 4;
    self.mRightBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.mRightBtn.layer.borderWidth = 0.5;
    
    
    self.mLeftBtn.layer.masksToBounds = YES;
    self.mLeftBtn.layer.cornerRadius = 4;
    self.mLeftBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.mLeftBtn.layer.borderWidth = 0.5;
    
}

- (IBAction)mBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTMyOrderCellRightBtnWithClicked:)]) {
        [self.delegate ZLPPTMyOrderCellRightBtnWithClicked:self.mIndexPath];
    }
    
    
}

- (IBAction)mLeftAction:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(ZLPPTMyOrderCellLeftBtnWithClicked:)]) {
        [_delegate ZLPPTMyOrderCellLeftBtnWithClicked:self.mIndexPath];
    }
    
}


- (void)setMOrder:(OrderObject *)mOrder{

    self.mStatus.text = mOrder.odr_state_val;

    for (OrderGoodsObject *mgoods in mOrder.goods) {
        self.mType.text = mgoods.odrg_pro_name;
        [self.mLogo sd_setImageWithURL:[NSURL imageurl:mgoods.odrg_img] placeholderImage:ZLDefaultGoodsImg];
        self.mName.text = mgoods.odrg_spec;
    }
    self.mMoney.text = [NSString stringWithFormat:@"¥%.2f",mOrder.odr_deliver_fee];
    self.mTime.text = [NSString stringWithFormat:@"下单时间：%@",mOrder.odr_add_time];
    self.mContent.text = mOrder.odr_remark;

    if (mOrder.odr_state_next.count<=0) {
        self.mLeftBtn.hidden = YES;
        self.mRightBtn.hidden = YES;

        return;
    }
    
    for (int i = 0; i<mOrder.odr_state_next.count; i++) {
    
        if (mOrder.odr_state_next.count == 2){
            
            self.mLeftBtn.hidden = NO;
            self.mRightBtn.hidden = NO;
            
            [self.mLeftBtn setTitle:[NSString strDesWithOrderState:mOrder.odr_state_next[0]] forState:0];
            [self.mRightBtn setTitle:[NSString strDesWithOrderState:mOrder.odr_state_next[1]] forState:0];
            
        }else{
            self.mLeftBtn.hidden = NO;
            self.mRightBtn.hidden = NO;
            self.mLeftBtn.hidden = YES;
            
            [self.mRightBtn setTitle:[NSString strDesWithOrderState:mOrder.odr_state_next[0]] forState:0];
        }
        
    }
    

    
}



@end
