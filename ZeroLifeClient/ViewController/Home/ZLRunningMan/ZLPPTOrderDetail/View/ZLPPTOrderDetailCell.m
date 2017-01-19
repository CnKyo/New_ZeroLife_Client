

//
//  ZLPPTOrderDetailCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTOrderDetailCell.h"

@implementation ZLPPTOrderDetailCell

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
    
    
    self.mLeftBtn.layer.masksToBounds = YES;
    self.mLeftBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.mLeftBtn.layer.cornerRadius = 4;
    self.mLeftBtn.layer.borderWidth = 0.5;
    
    self.mRightBtn.layer.masksToBounds = YES;
    self.mRightBtn.layer.borderColor = [UIColor colorWithRed:1.00 green:0.44 blue:0.08 alpha:1.00].CGColor;
    self.mRightBtn.layer.cornerRadius = 4;
    self.mRightBtn.layer.borderWidth = 0.5;
    
}

- (IBAction)mLeftBtnAction:(UIButton *)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTOrderDetailCell:andWithLeftBtn:)]) {
        [self.delegate ZLPPTOrderDetailCell:self andWithLeftBtn:self.mIndexPath];
        
    }
    
    
}

- (IBAction)mRightBtnAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(ZLPPTOrderDetailCell:andWithRightBtn:)]) {
     [self.delegate ZLPPTOrderDetailCell:self andWithRightBtn:self.mIndexPath];
    }
    
}

- (void)setMOrderDetail:(OrderObject *)mOrderDetail{
    
    
    if (mOrderDetail.goods.count>0) {
        OrderGoodsObject *mGood = mOrderDetail.goods[0];

        self.mOrderName.text = mGood.odrg_pro_name;
        self.mOrderNote.text = mGood.odrg_spec;
        [self.mOrderImg sd_setImageWithURL:[NSURL imageurl:mGood.odrg_img] placeholderImage:ZLDefaultGoodsImg];
        self.mGoodsPrice.text = [NSString stringWithFormat:@"¥%.1f",mGood.odrg_price];

        
    }
    
    self.mOrderReward.text = [NSString stringWithFormat:@"¥%.1f",mOrderDetail.odr_deliver_fee];

    self.mOrderStatus.text = mOrderDetail.odr_state_val;
    
    
    int mTime = [[NSString stringWithFormat:@"%@",mOrderDetail.odr_timing] intValue];

    if (mTime<=90) {
        self.mWorkTime.text = [NSString stringWithFormat:@"%d分钟内完成",mTime];

    }else{
    
        mTime = mTime/60;
        self.mWorkTime.text = [NSString stringWithFormat:@"%d小时内完成",mTime];

    }
    
    if (mOrderDetail.odr_remark.length<=0 || [mOrderDetail.odr_remark isEqualToString:@"null"]) {
        mOrderDetail.odr_remark = @" ";
    }
    if (mOrderDetail.odr_code.length<=0 || [mOrderDetail.odr_code isEqualToString:@"null"]) {
        mOrderDetail.odr_code = @" ";
    }
    if (mOrderDetail.odr_add_time.length<=0 || [mOrderDetail.odr_add_time isEqualToString:@"null"]) {
        mOrderDetail.odr_add_time = @" ";
    }
    if (mOrderDetail.odr_deliver_address.length<=0 || [mOrderDetail.odr_deliver_address isEqualToString:@"null"]) {
        mOrderDetail.odr_deliver_address = @" ";
    }
    
    self.mRemark.text = [NSString stringWithFormat:@"订单备注：%@",mOrderDetail.odr_remark];
    self.mOrderCode.text = [NSString stringWithFormat:@"订单编号：%@",mOrderDetail.odr_code];

    self.mOrderCreateTime.text = [NSString stringWithFormat:@"创建时间：%@",mOrderDetail.odr_add_time];
    self.mOrderArriveAddress.text = [NSString stringWithFormat:@"送达地址：%@",mOrderDetail.odr_deliver_address];
 
    if ([ZLUserInfo ZLCurrentUser].user_id == mOrderDetail.user_id) {
        self.mLeftBtn.hidden = YES;
        self.mRightBtn.hidden = YES;
    }else{
        self.mLeftBtn.hidden = YES;
        [self.mRightBtn setTitle:@"立即接单" forState:0];
    }
    

    
}


@end
