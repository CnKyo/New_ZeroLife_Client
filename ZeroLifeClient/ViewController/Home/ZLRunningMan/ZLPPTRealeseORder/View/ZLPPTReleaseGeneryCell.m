//
//  ZLPPTReleaseGeneryCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTReleaseGeneryCell.h"
#import "CustomDefine.h"
#import "LTPickerView.h"

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
    
    NSArray *mTT = @[@"30分钟",@"60分钟",@"90分钟",@"2小时",@"3小时",@"4小时",@"5小时",@"8小时",@"12小时"];
    
   LTPickerView *LtpickerView = [LTPickerView new];
    LtpickerView.dataSource = mTT;//设置要显示的数据
    LtpickerView.defaultStr = mTT[0];//默认选择的数据
    [LtpickerView show];//显示
    __weak __typeof(self)weakSelf = self;
    
    //回调block
    LtpickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        MLLog(@"选择了第%d行的%@",num,str);
        NSArray *mTT2 = @[@"30",@"60",@"90",@"120",@"180",@"240",@"300",@"480",@"720"];
        
        [sender setTitle:[NSString stringWithFormat:@"%@内送达",str] forState:0];
        
        if ([_delegate respondsToSelector:@selector(ZLPPTReleaseGeneryCellWithWorkTimeBtnClicked:)]) {
            [_delegate ZLPPTReleaseGeneryCellWithWorkTimeBtnClicked:mTT2[num]];

        }
        
        
    };


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



- (void)setMPreOrder:(ZLCommitPPTPreOrder *)mPreOrder{
    
    if (mPreOrder.mArriveAddress) {
        
        NSString *mAddress = [NSString stringWithFormat:@"%@",mPreOrder.mArriveAddress.addr_address];
        
        if (mAddress.length <= 0 || [mAddress isEqualToString:@"(null)"]) {
            mAddress = @"点击选择送达地址";
        }
        
        [self.mArriveAddress setTitle:mAddress forState:0];
        
        
    }
    
}
@end
