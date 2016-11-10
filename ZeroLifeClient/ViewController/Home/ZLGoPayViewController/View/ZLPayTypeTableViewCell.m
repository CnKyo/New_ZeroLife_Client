//
//  ZLPayTypeTableViewCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPayTypeTableViewCell.h"

@implementation ZLPayTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mStatusBtnAction:(UIButton *)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(ZLGoPayStatusBtnClicked)]) {
        [self.delegate ZLGoPayStatusBtnClicked];
    }
    
    
    
}



@end
