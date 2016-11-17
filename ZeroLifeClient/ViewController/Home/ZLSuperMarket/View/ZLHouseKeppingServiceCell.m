//
//  ZLHouseKeppingServiceCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/17.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHouseKeppingServiceCell.h"
#import "CustomDefine.h"
@implementation ZLHouseKeppingServiceCell

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
    
    for (PPNumberButton *mNumberView in self.mNumView.subviews) {
        [mNumberView removeFromSuperview];
    }
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(0, 0, 100, 30)];
    numberButton.decreaseHide = YES;
    numberButton.increaseImage = [UIImage imageNamed:@"ZLSuperMarket_Add"];
    numberButton.decreaseImage = [UIImage imageNamed:@"ZLSuperMarket_Substruct"];
    
    __weak __typeof(self)weakSelf = self;

    numberButton.numberBlock = ^(NSString *num){
        
        int mNum = [num intValue];
        
        MLLog(@"%d",mNum);
        
        if ([weakSelf.delegate respondsToSelector:@selector(ZLHouseKeppingServiceCellWithNumChanged:andIndexPath:)]) {
            [weakSelf.delegate ZLHouseKeppingServiceCellWithNumChanged:mNum andIndexPath:weakSelf.mIndexPath];
            
        }
        
        
    };
    
    [self.mNumView addSubview:numberButton];

}

@end
