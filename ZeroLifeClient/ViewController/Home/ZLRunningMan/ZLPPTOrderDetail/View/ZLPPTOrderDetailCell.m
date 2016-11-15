

//
//  ZLPPTOrderDetailCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTOrderDetailCell.h"

@implementation ZLPPTOrderDetailCell

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
    
    
    self.mLeftBtn.layer.masksToBounds = YES;
    self.mLeftBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.mLeftBtn.layer.cornerRadius = 4;
    self.mLeftBtn.layer.borderWidth = 0.5;
    
    self.mRightBtn.layer.masksToBounds = YES;
    self.mRightBtn.layer.borderColor = [UIColor colorWithRed:1.00 green:0.44 blue:0.08 alpha:1.00].CGColor;
    self.mRightBtn.layer.cornerRadius = 4;
    self.mRightBtn.layer.borderWidth = 0.5;
    
}

- (IBAction)mLeftBtnAction:(UIButton *)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTOrderDetailCell:andWithLeftBtn:)]) {
        [self.delegate ZLPPTOrderDetailCell:self andWithLeftBtn:self.mIndexPath];
        
    }
    
    
}

- (IBAction)mRightBtnAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(ZLPPTOrderDetailCell:andWithRightBtn:)]) {
     [self.delegate ZLPPTOrderDetailCell:self andWithRightBtn:self.mIndexPath];
    }
    
}



@end
