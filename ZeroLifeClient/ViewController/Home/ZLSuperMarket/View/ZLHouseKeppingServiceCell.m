//
//  ZLHouseKeppingServiceCell.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/17.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHouseKeppingServiceCell.h"
#import "CustomDefine.h"

@interface ZLHouseKeppingServiceCell()<PPNumberButtonDelegate>

@end

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
    numberButton.delegate = self;
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
- (void)pp_numberButton:(__kindof UIView *)numberButton number:(NSString *)number{

}
/**
 加减按钮的代理方法
 
 @param mBtn   哪一个按钮
 @param number 数量
 */
- (void)pp_numberButtonSelected:(int)mBtn andNumber:(int)number{

    
    if ([_delegate respondsToSelector:@selector(ZLHouseKeppingServiceCellWithNumChanged:andNum:andIndexPath:)]) {
        [self.delegate ZLHouseKeppingServiceCellWithNumChanged:mBtn andNum:number andIndexPath:self.mIndexPath];
    }
    
    
    
}
- (void)setMGoodsObj:(ZLGoodsWithCamp *)mGoodsObj{
    
    [self.mImg sd_setImageWithURL:[NSURL URLWithString:mGoodsObj.img_url] placeholderImage:[UIImage imageNamed:@"ZLDefault_Img"]];
    self.mName.text = mGoodsObj.pro_name;
    self.mContent.text = [NSString stringWithFormat:@"%.1f元",mGoodsObj.sku_price];
    self.mSailsNum.text = [NSString stringWithFormat:@"月销：%d件",mGoodsObj.pro_sales_total];
    self.mContent.text = [NSString stringWithFormat:@"%@",mGoodsObj.sta_val_name];
}
@end
