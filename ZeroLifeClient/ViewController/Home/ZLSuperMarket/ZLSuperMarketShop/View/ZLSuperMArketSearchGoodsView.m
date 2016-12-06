//
//  ZLSuperMArketSearchGoodsView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMArketSearchGoodsView.h"

@implementation ZLSuperMArketSearchGoodsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (ZLSuperMArketSearchGoodsView *)shareView{

    ZLSuperMArketSearchGoodsView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLSuperMArketSearchGoodsView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}

+ (ZLSuperMArketSearchGoodsView *)initWithSpeView:(CGRect)mFrame{
    
    ZLSuperMArketSearchGoodsView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLSuperMarketGoodsSpecView" owner:self options:nil] objectAtIndex:0];

    view.mGoodsImg.layer.masksToBounds = YES;
    view.mGoodsImg.layer.cornerRadius = 6;
    view.mGoodsImg.layer.borderColor = [UIColor whiteColor].CGColor;
    view.mGoodsImg.layer.borderWidth = 3;
    view.frame = mFrame;
    

    
    
    return view;
    
    
    
    
}


- (IBAction)mCloseAvtion:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLSuperMarketCloseBtnSelected)]) {
        [self.delegate ZLSuperMarketCloseBtnSelected];
    }
    
    
}

- (IBAction)mSubstructAtion:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLSuperMarketSubsructBtnSelected)]) {
        [self.delegate ZLSuperMarketSubsructBtnSelected];
    }
    
    
}

- (IBAction)mAddAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLSuperMarketAddBtnSelected)]) {
        [self.delegate ZLSuperMarketAddBtnSelected];
    }
    
}

- (IBAction)mOKAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLSuperMarketShopCarBtnSelected)]) {
        [self.delegate ZLSuperMarketShopCarBtnSelected];
    }
    
    
}


- (IBAction)mBuyNow:(UIButton *)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(ZLSuperMarketBuyNowBtnSelected)]) {
        [self.delegate ZLSuperMarketBuyNowBtnSelected];
    }

}







@end
