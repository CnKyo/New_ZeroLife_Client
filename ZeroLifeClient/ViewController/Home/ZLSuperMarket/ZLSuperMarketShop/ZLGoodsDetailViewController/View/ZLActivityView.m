//
//  ZLActivityView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLActivityView.h"

#import "CustomDefine.h"

@implementation ZLActivityView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLActivityView *)initWithShopCarView{

    ZLActivityView *view  = [[[NSBundle mainBundle] loadNibNamed:@"ZLGoodsDetailBottomView" owner:self options:nil] objectAtIndex:0];
    
    view.mNum.layer.masksToBounds = YES;
    view.mNum.layer.cornerRadius = 8;
    
    return view;
    
}

+ (ZLActivityView *)initWithActivityView{
    
    ZLActivityView *view  = [[[NSBundle mainBundle] loadNibNamed:@"ZLActivityView" owner:self options:nil] objectAtIndex:0];
    
    view.mActTitle.layer.masksToBounds = YES;
    view.mActTitle.layer.cornerRadius = 3;
    
    return view;
    
}

- (IBAction)mFocus:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLActivityViewFocusActionWithSelected:)]) {
        [self.delegate ZLActivityViewFocusActionWithSelected:sender.selected];
    }
}

- (IBAction)mShopCar:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLActivityViewShopCarAction)]) {
        [self.delegate ZLActivityViewShopCarAction];
    }
    
    
}
- (IBAction)mAddShopCar:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLActivityViewAddShopCarAction)]) {
        [self.delegate ZLActivityViewAddShopCarAction];
    }
    
    
}
- (IBAction)mChiose:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLActivityViewChioseAction)]) {
        [self.delegate ZLActivityViewChioseAction];

    }
    
}


@end
