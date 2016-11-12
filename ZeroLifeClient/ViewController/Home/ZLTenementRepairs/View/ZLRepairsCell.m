//
//  ZLRepairsCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRepairsCell.h"

@implementation ZLRepairsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}


-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;

    self.mMainView.indexPath = self.indexPath;
    self.mMainView.dataArray = _dataArray;
}

@end
