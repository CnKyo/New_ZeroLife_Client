//
//  ZLCommitOrderCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLCommitOrderCell.h"


@interface ZLCommitOrderCell()<UITextViewDelegate>

@end

@implementation ZLCommitOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.mNoteTx setPlaceholder:@"请输入您的备注信息!"];
    //[self.mNoteTx setHolderToTop];

    self.mNoteTx.delegate = self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mSendTypeAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitWithSendTypeBtnSelected)]) {
        [self.delegate ZLCommitWithSendTypeBtnSelected];
    }

    
}

- (IBAction)mCoupBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitWithCoupBtnSelected)]) {
        [self.delegate ZLCommitWithCoupBtnSelected];
    }
    
}


- (void)setMGoodsObj:(OrderGoodsObject *)mGoodsObj{

    [self.mGoodsLogo sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mGoodsObj.odrg_img]] placeholderImage:ZLDefaultGoodsImg];
    self.mGoodsName.text = mGoodsObj.odrg_pro_name;
    self.mGoodsPrice.text = [NSString stringWithFormat:@"¥%.2f元    数量：%d",mGoodsObj.odrg_price,mGoodsObj.odrg_number];
    
    
    
}

- (void)setMPreOrderObj:(ZLPreOrderObj *)mPreOrderObj{


    self.mPrice.text = [NSString stringWithFormat:@"¥%.2f元",mPreOrderObj.payMoney];
    self.mCoupMoney.text = [NSString stringWithFormat:@"¥%.2f元",mPreOrderObj.campaignMoney];
    
    if (mPreOrderObj.mSendType == ZLShopSendTypeWithSelf) {
        [self.mSendType setTitle:@"上门自提" forState:0];
    }else{
        [self.mSendType setTitle:@"店铺配送" forState:0];
    }
    
    NSString *mCoupT = nil;
    
    if (mPreOrderObj.coupons.count<=0) {
        mCoupT = @"暂无优惠卷可用！";
    }else{
        
        if (mPreOrderObj.mCoupon.cup_content.length>0) {
            
            
            mCoupT = mPreOrderObj.mCoupon.cup_content;
            [self.mCoupBtn setTitleColor:[UIColor redColor] forState:0];
        }else{
            mCoupT = [NSString stringWithFormat:@"共%lu张优惠卷可用！",(unsigned long)mPreOrderObj.coupons.count];
            [self.mCoupBtn setTitleColor:[UIColor lightGrayColor] forState:0];
            
        }

    }
    [self.mCoupBtn setTitle:mCoupT forState:0];
    
    NSDictionary* style = @{@"color" :[UIColor redColor],
                            @"font":[UIFont systemFontOfSize:13]};
    self.mDiscountAmount.attributedText = [[NSString stringWithFormat:@"优惠卷<font><color>（已优惠:%.2f元）</color></font>",mPreOrderObj.campaignMoney] attributedStringWithStyleBook:style];
    
}
///限制输入长度50个字符
#define TEXT_MAXLENGTH 50
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger res;
    
    res= TEXT_MAXLENGTH-[new length];
    
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[text length]+res};
        if (rg.length>0) {
            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([_delegate respondsToSelector:@selector(ZLCommitWithNote:)]) {
        [_delegate ZLCommitWithNote:textView.text];
    }
    
}

@end
