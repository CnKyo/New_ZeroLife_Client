//
//  ZLUserHeaderTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLUserHeaderTableViewCell.h"

@implementation ZLUserHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.paopaoInfoView.layer.masksToBounds = YES;
    self.paopaoRegisterView.layer.masksToBounds = YES;
    self.paopaoRegisterView.layer.cornerRadius = 15;
    self.paopaoInfoView.layer.cornerRadius = 15;
    
    self.paopaoRegisterView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
