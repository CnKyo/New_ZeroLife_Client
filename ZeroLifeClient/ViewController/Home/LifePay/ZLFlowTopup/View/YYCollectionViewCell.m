//
//  YYCollectionViewCell.m
//  自定义collectionView
//
//  Created by 杨金发 on 16/9/5.
//  Copyright © 2016年 杨金发. All rights reserved.
//

#import "YYCollectionViewCell.h"

@implementation YYCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.mBgk.layer.masksToBounds = YES;
    self.mBgk.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mBgk.layer.borderWidth = 1;
    self.mBgk.layer.cornerRadius = 3;
}

- (void)setMFlow:(ZLJHFlows *)mFlow{
    self.mName.text = mFlow.p;
    self.mPrice.text = [NSString stringWithFormat:@"¥%.2f元",mFlow.inprice];
}

@end
