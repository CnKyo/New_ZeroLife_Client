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
- (void)layoutSubviews{
    self.mStatusBtn.layer.masksToBounds = YES;
    self.mStatusBtn.layer.cornerRadius = 3;
}
- (IBAction)mStatusBtnAction:(UIButton *)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(ZLGoPayStatusBtnClicked)]) {
        [self.delegate ZLGoPayStatusBtnClicked];
    }
    
    
    
}


- (void)cellWithData:(ZLGoPayObject *)model {
    if (!model.isSelected) {
        [self.mSelectedBtn setBackgroundColor:[UIColor clearColor]];
        self.mSelectedImg.image = [UIImage imageNamed:@"ZLShopCar_Normal"];

    } else {
        [self.mSelectedBtn setBackgroundColor:[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:0.25]];
        self.mSelectedImg.image = [UIImage imageNamed:@"ZLShopCar_Selected"];
    }
    
    self.mName.text = model.mPayName;
    
    self.mLogo.image = [UIImage imageNamed:model.mImgName];
}

- (IBAction)mBtnClicked:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLSelectedBtnClicked:)]) {
        [self.delegate ZLSelectedBtnClicked:self.mIndexPath];
    }
    
}


@end
