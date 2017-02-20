//
//  ZLFixLineTableViewCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2017/2/20.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "ZLFixLineTableViewCell.h"

@implementation ZLFixLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)mUnit:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(ZLFixLineTableViewCellUnitBtnDidClicked)]) {
        [_delegate ZLFixLineTableViewCellUnitBtnDidClicked];
    }
    
}
- (IBAction)mPrice:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(ZLFixLineTableViewCellPriceBtnDidClicked)]) {
        [_delegate ZLFixLineTableViewCellPriceBtnDidClicked];
    }
    
    
}
- (IBAction)mType:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(ZLFixLineTableViewCellTypeBtnDidClicked)]) {
        [_delegate ZLFixLineTableViewCellTypeBtnDidClicked];

    }
}
- (IBAction)mCommit:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(ZLFixLineTableViewCellCommitBtnDidClicked)]) {
        [_delegate ZLFixLineTableViewCellCommitBtnDidClicked];
    }
    
}
- (void)layoutSubviews{

    [super layoutSubviews];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.mPhoneTx.delegate = self;
    self.mCardTx.delegate = self;
    
    self.mCommitBtn.layer.masksToBounds = YES;
    self.mCommitBtn.layer.cornerRadius = 3;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text>0) {
        if (textField == self.mPhoneTx) {
            if ([_delegate respondsToSelector:@selector(ZLFixLineTableViewCellPhoneTextWithEndEditing:)]) {
                [_delegate ZLFixLineTableViewCellPhoneTextWithEndEditing:textField.text];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(ZLFixLineTableViewCellCardTextWithEndEditing:)]) {
                [_delegate ZLFixLineTableViewCellCardTextWithEndEditing:textField.text];
            }
        }
        
    }
    

}
@end
