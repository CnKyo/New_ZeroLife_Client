//
//  ZLLoginView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/18.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLLoginView.h"
#import "CustomDefine.h"
@interface ZLLoginView ()<UITextFieldDelegate>

@property (strong,nonatomic)    NSString *mPhone;
@property (strong,nonatomic)    NSString *mPwd;
@property (strong,nonatomic)    NSString *mCode;


@end

@implementation ZLLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLLoginView *)initTopView{

    ZLLoginView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLLoginTopView" owner:self options:nil] objectAtIndex:0];


    
    return view;
}

+ (ZLLoginView *)initQuikView{
    
    ZLLoginView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLLoginBottomView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}

+ (ZLLoginView *)initLoginView{
    
    ZLLoginView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLLoginView" owner:self options:nil] objectAtIndex:0];
    
    view.mLoginBtn.layer.masksToBounds = YES;
    view.mLoginBtn.layer.cornerRadius = 4;
    
    view.mLoginPwdTx.delegate = view;
    view.mLoginPhoneTx.delegate = view;
    
    view.mLoginBtn.userInteractionEnabled = NO;
    

    
    return view;
}

+ (ZLLoginView *)initRegistView{
    
    ZLLoginView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLRegistView" owner:self options:nil] objectAtIndex:0];
    
    view.mregistBtn.layer.masksToBounds = YES;
    view.mregistBtn.layer.cornerRadius = 4;
    
    view.mRegistCodeBtn.layer.masksToBounds = YES;
    view.mRegistCodeBtn.layer.cornerRadius = 3;
    
    view.mRegistCodeTx.delegate = view;
    view.mRegistPhoneTx.delegate = view;
    
    view.mregistBtn.userInteractionEnabled = YES;
    
    return view;
}

- (IBAction)mForgetAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLLoginWithForgetAction)]) {
        [self.delegate ZLLoginWithForgetAction];
    }
    
}
- (IBAction)mLoginAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ZLLoginWithLoginAction)]) {
        [self.delegate ZLLoginWithLoginAction];
    }
}
- (IBAction)mQQ:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ZLLoginWithQQAction)]) {
        [self.delegate ZLLoginWithQQAction];
    }
}
- (IBAction)mWecha:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ZLLoginWithWetchatAction)]) {
        [self.delegate ZLLoginWithWetchatAction];
    }
}
- (IBAction)mLeft:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ZLLoginWithLeftAction)]) {
        [self.delegate ZLLoginWithLeftAction];
    }
}
- (IBAction)mRight:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ZLLoginWithRightAction)]) {
        [self.delegate ZLLoginWithRightAction];
    }
}

- (IBAction)mCode:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ZLLoginWithCodeAction)]) {
        [self.delegate ZLLoginWithCodeAction];
    }
}
- (IBAction)mRegist:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ZLLoginWithRegistAction)]) {
        [self.delegate ZLLoginWithRegistAction];
    }
}



-(void)textFieldDidEndEditing:(UITextField *)textField{
    

    if (textField.tag == 11) {
        _mPhone = textField.text;
        if ([self.delegate respondsToSelector:@selector(ZLPhoneTextFieldText:)]) {
            [self.delegate ZLPhoneTextFieldText:_mPhone];
        }
        
        
    }else if (textField.tag == 20) {
        _mPwd = textField.text;
        if ([self.delegate respondsToSelector:@selector(ZLPwdTextFieldText:)]) {
            [self.delegate ZLPwdTextFieldText:_mPwd];
        }
    }else{
        _mCode = textField.text;
        if ([self.delegate respondsToSelector:@selector(ZLCodeTextFieldText:)]) {
            [self.delegate ZLCodeTextFieldText:_mCode];
        }
    }
    if (_mPhone.length <= 0 || _mPwd.length <= 0) {
        self.mLoginBtn.userInteractionEnabled = NO;


        [self.mLoginBtn setBackgroundColor:[UIColor lightGrayColor]];

    }else{
        self.mLoginBtn.userInteractionEnabled = YES;
        [self.mLoginBtn setBackgroundColor:M_CO];
    }
    
    if (_mPhone.length <= 0 || _mCode.length <= 0) {
        self.mregistBtn.userInteractionEnabled = NO;
        
        
        [self.mregistBtn setBackgroundColor:[UIColor lightGrayColor]];
        
    }else{
        self.mregistBtn.userInteractionEnabled = YES;
        [self.mregistBtn setBackgroundColor:M_CO];
    }
    

    
}
///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
///密码输入长度
#define PASS_LENGHT 20
#define CODE_LENGTH 6

#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==11) {
        res= TEXT_MAXLENGTH-[new length];
        
    }else if(textField.tag == 20)
    {
        res= PASS_LENGHT-[new length];
        
    }
    else if(textField.tag == 6)
    {
        res= CODE_LENGTH-[new length];
        
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













@end
