//
//  ZLORderReturnCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/21.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLORderReturnCell.h"
#import "CustomDefine.h"
#import "ZLOrderReturnCustomLoadImgView.h"

@interface ZLORderReturnCell ()<UITextViewDelegate,UIActionSheetDelegate>

@property (strong,nonatomic) LPActionSheet *mReasonActionSheet;

@property (strong,nonatomic) ZLOrderReturnCustomLoadImgView *mImgView;

@end

@implementation ZLORderReturnCell

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
    
    self.mNote.delegate = self;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([self.delegate respondsToSelector:@selector(ZLORderReturnCellWithNoteTx:)]) {
        [self.delegate ZLORderReturnCellWithNoteTx:textView.text];
    }
    
}

- (IBAction)nReasonAction:(UIButton *)sender {

    __weak __typeof(self)weak = self;
    
    _mReasonActionSheet  = [[LPActionSheet alloc] initWithTitle:@"为了保证服务质量，请选择以下信息" cancelButtonTitle:@"取消" destructiveButtonTitle:@"请选择原因" otherButtonTitles:self.mReasonArr handler:^(LPActionSheet *actionSheet, NSInteger index) {
        
        if (index == 0 || index == -1) {
            return ;
        }else{
            [sender setTitle:self.mReasonArr[index-1] forState:0];
            
            if ([weak.delegate respondsToSelector:@selector(ZLORderReturnCellWithReasonAction:)]) {
                [weak.delegate ZLORderReturnCellWithReasonAction:self.mReasonArr[index-1]];
            }
        }
            
        
    }];
    
    [_mReasonActionSheet show];
}


- (void)setMUpLoadImgArr:(NSArray *)mUpLoadImgArr{

    
    for (ZLOrderReturnCustomLoadImgView *vvv in self.mUpLoadImgView.subviews) {
        [vvv removeFromSuperview];
    }
    
    
    if (mUpLoadImgArr.count <= 0) {
        return;
    }
    
    CGFloat mXX = 0;
    CGFloat mWW = self.mUpLoadImgView.mwidth/3;
    
    for (int i = 0; i<mUpLoadImgArr.count; i++) {
        
        _mImgView = [ZLOrderReturnCustomLoadImgView shareView];
        
        _mImgView.frame = CGRectMake(mXX, 0, mWW, self.mUpLoadImgView.mheight);
        _mImgView.mImg = mUpLoadImgArr[i];
        [_mImgView.mDeleteBtn addTarget:self action:@selector(mDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        _mImgView.mDeleteBtn.tag = i;
        [self.mUpLoadImgView addSubview:_mImgView];
        mXX+=mWW;

    }
    
    
    
}


- (void)mDeleteAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(ZLORderReturnCellWithDeleteImageIndex:)]) {
        [self.delegate ZLORderReturnCellWithDeleteImageIndex:sender.tag];
    }
    
}

@end
