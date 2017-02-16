//
//  ZLFlowHeaderView.m
//  ZeroLifeClient
//
//  Created by Mac on 2017/2/15.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "ZLFlowHeaderView.h"

@implementation ZLFlowHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (ZLFlowHeaderView *)shareView{
    ZLFlowHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLFlowHeaderView" owner:self options:nil] objectAtIndex:0];
    //view.mPhoneTx.layer.masksToBounds = YES;
    //view.mPhoneTx.layer.cornerRadius = 3;
    //view.mPhoneTx.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //view.mPhoneTx.layer.borderWidth = 0.75;
    view.mPhoneTx.delegate = view;
    
    
    return view;

}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    if ([_delegate respondsToSelector:@selector(ZLFlowHeaderViewPhoneTxDidEndEditing:)]) {
        [_delegate ZLFlowHeaderViewPhoneTxDidEndEditing:textField.text];
    }
    
}
///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==11) {
        res= TEXT_MAXLENGTH-[new length];
        
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


- (IBAction)mAddressBook:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(ZLFlowHeaderViewAddressBookBtnAction)]) {
        [_delegate ZLFlowHeaderViewAddressBookBtnAction];
    }
    
    
    
}

@end
