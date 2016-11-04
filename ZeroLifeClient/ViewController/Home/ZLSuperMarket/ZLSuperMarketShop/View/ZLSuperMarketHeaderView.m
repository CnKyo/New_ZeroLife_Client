//
//  ZLSuperMarketHeaderView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketHeaderView.h"

@implementation ZLSuperMarketHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLSuperMarketHeaderView *)shareView{

    ZLSuperMarketHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLSuperMarketHeaderView" owner:self options:nil] objectAtIndex:0];
    
    
    
    return view;
    
}
- (IBAction)mCoupAction:(UIButton *)sender {
    
    if ([self.delegaate respondsToSelector:@selector(ZLSuperMarketCoupBtnSelected)]) {
        [self.delegaate ZLSuperMarketCoupBtnSelected];
    }
    
}

- (IBAction)mRateAction:(UIButton *)sender {
    
    if ([self.delegaate respondsToSelector:@selector(ZLSuperMarketRateBtnSelected)]) {
        [self.delegaate ZLSuperMarketRateBtnSelected];
    }
    
}

- (IBAction)mCheckMoreAction:(UIButton *)sender {
    
    if ([self.delegaate respondsToSelector:@selector(ZLSuperMarketCheckMoreBtnSelected)]) {
        [self.delegaate ZLSuperMarketCheckMoreBtnSelected];
    }
    
    
}



@end
