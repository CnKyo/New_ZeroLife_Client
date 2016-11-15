//
//  UserHouseEditTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserHouseEditTableViewCell.h"

@implementation UserHouseEditTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)reloadSexUI:(kUserSexType)sex
{
    if (sex == kUserSexType_man) {
        [self.sexManBtn setImage:IMG(@"shimingrenzheng_on.png") forState:UIControlStateNormal];
        [self.sexWomanBtn setImage:IMG(@"shimingrenzheng_off.png") forState:UIControlStateNormal];
    } else if (sex == kUserSexType_woman) {
        [self.sexManBtn setImage:IMG(@"shimingrenzheng_off.png") forState:UIControlStateNormal];
        [self.sexWomanBtn setImage:IMG(@"shimingrenzheng_on.png") forState:UIControlStateNormal];
    }
}

@end
