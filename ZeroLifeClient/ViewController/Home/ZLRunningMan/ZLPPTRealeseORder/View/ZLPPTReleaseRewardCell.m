//
//  ZLPPTRewardCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTReleaseRewardCell.h"

@interface ZLPPTReleaseRewardCell()<UITextFieldDelegate>

@property (strong,nonatomic)  NSMutableArray *mBlockArr;

@end

@implementation ZLPPTReleaseRewardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    UIColor *B_C = [UIColor blackColor];
    
    [self.mThreeBtn setTitleColor:B_C forState:UIControlStateNormal];
    [self.mThreeBtn setTitleColor:B_C forState:UIControlStateSelected];
    
    [self.mFiveBtn setTitleColor:B_C forState:UIControlStateNormal];
    [self.mFiveBtn setTitleColor:B_C forState:UIControlStateSelected];
    
    [self.mTenBtn setTitleColor:B_C forState:UIControlStateNormal];
    [self.mTenBtn setTitleColor:B_C forState:UIControlStateSelected];
    
    [self.mFifteenBtn setTitleColor:B_C forState:UIControlStateNormal];
    [self.mFifteenBtn setTitleColor:B_C forState:UIControlStateSelected];
    
    [self.mTwentyBtn setTitleColor:B_C forState:UIControlStateNormal];
    [self.mTwentyBtn setTitleColor:B_C forState:UIControlStateSelected];
        
    _mBlockArr = [NSMutableArray new];
    
    self.mCustomTx.layer.masksToBounds = YES;
    self.mCustomTx.layer.borderColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00].CGColor;
    self.mCustomTx.layer.borderWidth = 0.5;
    self.mCustomTx.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)mBtnAction:(UIButton *)sender {

    [_mBlockArr removeAllObjects];
    
    switch (sender.tag) {
        case 3:
        {
            if (sender.selected == NO) {
                self.mThreeBtn.selected = YES;
                self.mFiveBtn.selected = NO;
                self.mTenBtn.selected = NO;
                self.mFifteenBtn.selected = NO;
                self.mTwentyBtn.selected = NO;
                [_mBlockArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
            
                sender.selected = NO;
                [_mBlockArr removeAllObjects];
            }
        }
            break;
        case 5:
        {
            if (sender.selected == NO) {
                self.mThreeBtn.selected = NO;
                self.mFiveBtn.selected = YES;
                self.mTenBtn.selected = NO;
                self.mFifteenBtn.selected = NO;
                self.mTwentyBtn.selected = NO;
                [_mBlockArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                
                sender.selected = NO;
                [_mBlockArr removeAllObjects];
            }
        }
            break;
        case 10:
        {
            if (sender.selected == NO) {
                self.mThreeBtn.selected = NO;
                self.mFiveBtn.selected = NO;
                self.mTenBtn.selected = YES;
                self.mFifteenBtn.selected = NO;
                self.mTwentyBtn.selected = NO;
                [_mBlockArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                
                sender.selected = NO;
                [_mBlockArr removeAllObjects];
            }
        }
            break;
        case 15:
        {
            if (sender.selected == NO) {
                self.mThreeBtn.selected = NO;
                self.mFiveBtn.selected = NO;
                self.mTenBtn.selected = NO;
                self.mFifteenBtn.selected = YES;
                self.mTwentyBtn.selected = NO;
                [_mBlockArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                
                sender.selected = NO;
                [_mBlockArr removeAllObjects];
            }
        }
            break;
        case 20:
        {
            if (sender.selected == NO) {
                self.mThreeBtn.selected = NO;
                self.mFiveBtn.selected = NO;
                self.mTenBtn.selected = NO;
                self.mFifteenBtn.selected = NO;
                self.mTwentyBtn.selected = YES;
                [_mBlockArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                
                sender.selected = NO;
                [_mBlockArr removeAllObjects];
            }
        }
            break;
            
        default:
            break;
    }
    
    NSString *mBlockStr = nil;

    
    if (_mBlockArr!=nil) {
        mBlockStr = [NSString stringWithFormat:@"%@",_mBlockArr];
    }else{
        mBlockStr = @"";
    }
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTRewardCellWithRewardBtnDidClicked:)]) {
        [self.delegate ZLPPTRewardCellWithRewardBtnDidClicked:mBlockStr];
    }
    
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField.text.length == 0) {
        [_mBlockArr removeAllObjects];
        return;
    }else{
        [_mBlockArr addObject:textField.text];

    }

    self.mThreeBtn.selected = NO;
    self.mFiveBtn.selected = NO;
    self.mTenBtn.selected = NO;
    self.mFifteenBtn.selected = NO;
    self.mTwentyBtn.selected = NO;
    NSString *mBlockStr = nil;
    
    
    if (_mBlockArr!=nil) {
        mBlockStr = [NSString stringWithFormat:@"%@",_mBlockArr];
    }else{
        mBlockStr = @"";
        
    }
    

    if ([self.delegate respondsToSelector:@selector(ZLPPTRewardCellWithRewardCustom:)]) {
        [self.delegate ZLPPTRewardCellWithRewardCustom:mBlockStr];
    }
    
    
}



@end
