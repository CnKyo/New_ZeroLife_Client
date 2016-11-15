




//
//  ZLPPTMyOrderCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTMyOrderCell.h"

@implementation ZLPPTMyOrderCell

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
    
    self.mBtn.layer.masksToBounds = YES;
    self.mBtn.layer.cornerRadius = 4;
    self.mBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.mBtn.layer.borderWidth = 0.5;
    
}

- (IBAction)mBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTMyOrderCellBtnWithClicked:)]) {
        [self.delegate ZLPPTMyOrderCellBtnWithClicked:self.mIndexPath];
    }
    
    
}



@end
