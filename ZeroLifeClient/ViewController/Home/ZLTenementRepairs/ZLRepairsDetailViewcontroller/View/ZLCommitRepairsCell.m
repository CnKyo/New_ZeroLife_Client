//
//  ZLCommitRepairsCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLCommitRepairsCell.h"

@interface ZLCommitRepairsCell()<UITextFieldDelegate>

@end

@implementation ZLCommitRepairsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.mCommitBtn.layer.masksToBounds = YES;
    self.mCommitBtn.layer.cornerRadius = 3;
    
    self.mNoteTx.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mSelectedAddress:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithAddressAction)]) {
        [self.delegate ZLCommitRepairsCellWithAddressAction];
    }

}

- (IBAction)mSelectedTime:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithTimeAction:)]) {
        [self.delegate ZLCommitRepairsCellWithTimeAction:sender.titleLabel.text];

    }

}

- (IBAction)mSelectedCoup:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithCoupAction)]) {
        [self.delegate ZLCommitRepairsCellWithCoupAction];
    }
    

}

- (IBAction)mUpLoadImg:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithUpLoadImgAction)]) {
        [self.delegate ZLCommitRepairsCellWithUpLoadImgAction];
    }
    
    
}

- (IBAction)mUpLoadVideo:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithUpLoadVideoAction)]) {
        [self.delegate ZLCommitRepairsCellWithUpLoadVideoAction];
    }
    

    
}

- (IBAction)mCommit:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitRepairsCellWithCommitAction)]) {
        [self.delegate ZLCommitRepairsCellWithCommitAction];
    }
    
}

- (void)setMPreOrder:(ZLCreatePreOrder *)mPreOrder{

    if (mPreOrder.deliver_price <= 0) {
        mPreOrder.deliver_price = 0;
    }
    
    self.mEnsureMoney.text = [NSString stringWithFormat:@"¥%.2f元",mPreOrder.deliver_price];
    
    if (mPreOrder.mUpLoadImg == nil) {
        mPreOrder.mUpLoadImg = [UIImage imageNamed:@"ZLFix_UploadImg"];
    }
    if (mPreOrder.mUpLoadVideoImg == nil) {
        mPreOrder.mUpLoadVideoImg = [UIImage imageNamed:@"ZLFix_UploadVideo"];

    }
    
    [self.mUploadImgBtn setBackgroundImage:mPreOrder.mUpLoadImg forState:0];
    [self.mUpLoadVideoBtn setBackgroundImage:mPreOrder.mUpLoadVideoImg forState:0];
    
    [self.mServiceImg sd_setImageWithURL:[NSURL URLWithString:mPreOrder.goods.img_url] placeholderImage:ZLDefaultGoodsImg];
    
    self.mServiceName.text = mPreOrder.goods.pro_name;
    self.mServiceContent.text = mPreOrder.goods.pro_component;
    
    
    NSString *mConnectP = [NSString stringWithFormat:@"%@-%@",mPreOrder.mAddress.addr_name,mPreOrder.mAddress.addr_phone];
    NSString *mDetailAddress = mPreOrder.mAddress.addr_address;
    
    if (mConnectP.length <= 1 || [mConnectP isEqualToString:@"(null)-(null)"]) {
        
        mConnectP = @"点击选择收货地址";
        
    }
    if (mDetailAddress.length <= 0 || [mDetailAddress isEqualToString:@"(null)(null)(null)(null)"]) {
        mDetailAddress = @"点击选择收货地址";
    }
    
    self.mAddressName.text = mConnectP;
    self.mAddressContent.text = mDetailAddress;
    
    if (mPreOrder.mServiceTime.length <= 0) {
        mPreOrder.mServiceTime = @"选择服务时间";
    }
    [self.mTimeBtn setTitle:mPreOrder.mServiceTime forState:0];
    
    NSString *mTT = @"";
    
    if (mPreOrder.mCoupon.cup_name.length <= 0) {
        mTT = @"选择优惠卷";
    }else{
        mTT = [NSString stringWithFormat:@"优惠金额：¥%.2f元",mPreOrder.mCoupon.cup_price];
    }
    
    [self.mCoupBtn setTitle:mTT forState:0];

}


- (void)textFieldDidEndEditing:(UITextField *)textField{

    if ([_delegate respondsToSelector:@selector(ZLCommitRepairsCellWithRemark:)]) {
        [_delegate ZLCommitRepairsCellWithRemark:textField.text];
    }

}



@end
