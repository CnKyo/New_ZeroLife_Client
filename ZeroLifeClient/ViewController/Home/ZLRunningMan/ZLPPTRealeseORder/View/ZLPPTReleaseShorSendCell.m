//
//  ZLPPTReleaseShorSendCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTReleaseShorSendCell.h"

@interface ZLPPTReleaseShorSendCell()<UITextFieldDelegate>

@end

@implementation ZLPPTReleaseShorSendCell

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
    
    self.mProductNameTx.delegate = self;
    self.mNoteTx.delegate = self;
}

- (IBAction)mSendAddressAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseShorSendCellWithSendAddressAction)]) {
        [self.delegate ZLPPTReleaseShorSendCellWithSendAddressAction];
    }

}

- (IBAction)mArriveAddressAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseShorSendCellWithArriveAddressAction)]) {
        [self.delegate ZLPPTReleaseShorSendCellWithArriveAddressAction];
    }

    
}

- (IBAction)mWorkTimeAction:(UIButton *)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseShorSendCellWithWorkTimeBtnAction)]) {
        [self.delegate ZLPPTReleaseShorSendCellWithWorkTimeBtnAction];
    }

    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    /**
     *  商品价格酬劳 11是电话 80是备注
     */
    
    if(textField.tag == 1){
        
        NSString *mProduct = nil;
        
        if (textField.text.length == 0) {
            mProduct = @"";
            return;
        }else{
            mProduct = textField.text;
        }
        
        if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseShorSendCellWithProductNameTx:)]) {
            [self.delegate ZLPPTReleaseShorSendCellWithProductNameTx:mProduct];
        }
        
        
        
    }else if(textField.tag == 2){
        
        NSString *mNote = nil;
        
        if (textField.text.length == 0) {
            mNote = @"";
            return;
        }else{
            mNote = textField.text;
        }
        
        if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseShorSendCellWithNoteTx:)]) {
            [self.delegate ZLPPTReleaseShorSendCellWithNoteTx:mNote];
        }
        
        
    }

    
    
    
}




@end
