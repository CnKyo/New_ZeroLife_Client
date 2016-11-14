//
//  ZLRunningManCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRunningManCell.h"

@implementation ZLRunningManCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLRunningManCellDelegateWithBtnClick:)]) {
        [self.delegate ZLRunningManCellDelegateWithBtnClick:self.mIndexPath];
    }
    
}



@end
