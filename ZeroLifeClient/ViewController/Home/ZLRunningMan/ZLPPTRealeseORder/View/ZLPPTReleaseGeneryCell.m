//
//  ZLPPTReleaseGeneryCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTReleaseGeneryCell.h"
#import "CustomDefine.h"
@interface ZLPPTReleaseGeneryCell()<UITextFieldDelegate,UITextViewDelegate>

@end

@implementation ZLPPTReleaseGeneryCell

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
    
    
    self.mDemandTx.delegate = self;
    self.mConnectTx.delegate = self;
    self.mNoteTx.delegate = self;
    self.mProductPrice.delegate = self;
    
    
}

- (IBAction)mWorkTimeAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseGeneryCellWithWorkTimeBtnClicked)]) {
        [self.delegate ZLPPTReleaseGeneryCellWithWorkTimeBtnClicked];
    }

}

- (IBAction)mArriveTimeAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseGeneryCellWithArriveTimeBtnClicked)]) {
        [self.delegate ZLPPTReleaseGeneryCellWithArriveTimeBtnClicked];
    }
    
    
}
///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
///备注输入长度
#define PASS_LENGHT 80
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==11) {
        res= TEXT_MAXLENGTH-[new length];
        
    }else
    {
        res= PASS_LENGHT-[new length];
        
    }
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[string length]+res};
        if (rg.length>0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    /**
     *  商品价格酬劳 11是电话 80是备注
     */
    
    if(textField.tag == 1){
        
        if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseGeneryCellWithProductPrice:)]) {
            [self.delegate ZLPPTReleaseGeneryCellWithProductPrice:textField.text];
        }
        
        
        
    }else if(textField.tag == 11){
        
        if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseGeneryCellWithConnect:)]) {
            [self.delegate ZLPPTReleaseGeneryCellWithConnect:textField.text];
        }
        
        
    }
    else if(textField.tag == 80){
        
        if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseGeneryCellWithNote:)]) {
            [self.delegate ZLPPTReleaseGeneryCellWithNote:textField.text];
        }
        
    }
    
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseGeneryCellWithDemand:)]) {
        [self.delegate ZLPPTReleaseGeneryCellWithDemand:textView.text];
    }

}




@end
