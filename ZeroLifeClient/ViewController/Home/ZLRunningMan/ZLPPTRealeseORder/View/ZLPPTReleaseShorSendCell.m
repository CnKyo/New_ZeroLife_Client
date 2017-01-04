//
//  ZLPPTReleaseShorSendCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTReleaseShorSendCell.h"
#import "CustomDefine.h"
#import "LTPickerView.h"

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
        
        if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseShorSendCellWithWorkTimeBtnAction:)]) {
            [self.delegate ZLPPTReleaseShorSendCellWithWorkTimeBtnAction:mTT2[num]];
        }
        
        
    };


 
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


- (void)setMPreOrder:(ZLCommitPPTPreOrder *)mPreOrder{

    if (mPreOrder.mSendAddress) {

        NSString *mConnectP = [NSString stringWithFormat:@"%@-%@",mPreOrder.mSendAddress.addr_name,mPreOrder.mSendAddress.addr_phone];
        NSString *mAddress = [NSString stringWithFormat:@"%@",mPreOrder.mSendAddress.addr_address];
        
        if (mConnectP.length <= 1 || [mConnectP isEqualToString:@"(null)-(null)"]) {
            
            mConnectP = @"点击选择送出地址";
            self.mSendDisplay.text = mConnectP;
            
        }else{
            self.mSendNamePhone.text = mConnectP;
            self.mSendDisplay.text = nil;

        }
        if (mAddress.length <= 0 || [mAddress isEqualToString:@"(null)(null)(null)(null)"]) {
            mAddress = @"点击选择送出地址";
            self.mSendDisplay.text = mAddress;
        }else{
            self.mSendAddress.text = mAddress;
            self.mSendDisplay.text = nil;


        }
        

    }
    if (mPreOrder.mArriveAddress) {
        
        NSString *mConnectP = [NSString stringWithFormat:@"%@-%@",mPreOrder.mArriveAddress.addr_name,mPreOrder.mArriveAddress.addr_phone];
        NSString *mAddress = [NSString stringWithFormat:@"%@",mPreOrder.mArriveAddress.addr_address];
        
        if (mConnectP.length <= 1 || [mConnectP isEqualToString:@"(null)-(null)"]) {
            
            mConnectP = @"点击选择送达地址";
            self.mArriveDisplay.text = mConnectP;
        }else{
            self.mArriveNamePhone.text = mConnectP;
            self.mArriveDisplay.text = nil;
        }
        if (mAddress.length <= 0 || [mAddress isEqualToString:@"(null)(null)(null)(null)"]) {
            mAddress = @"点击选择送达地址";
            self.mArriveDisplay.text = mAddress;
        }else{
            self.mArriveAddress.text = mAddress;
            self.mArriveDisplay.text = nil;
        }

        
    }
}



@end
