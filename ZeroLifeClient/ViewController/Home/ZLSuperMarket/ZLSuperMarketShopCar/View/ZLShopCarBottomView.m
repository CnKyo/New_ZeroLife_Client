//
//  ZLShopCarBottomView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLShopCarBottomView.h"
@implementation ZLShopCarBottomView

+ (ZLShopCarBottomView *)shareView{

    ZLShopCarBottomView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLShopCarBottomView" owner:self options:nil] objectAtIndex:0];
    [view.mSelecAllBtn setButtonTitleWithImageAlignment:UIButtonTitleWithImageAlignmentRight];
    return view;
}

- (IBAction)mSelectedAll:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"---***%d",sender.selected);
    if ([self.delegate respondsToSelector:@selector(ZLShopCarBottomSelecteAllWithSelected:)]) {
        [self.delegate ZLShopCarBottomSelecteAllWithSelected:sender.selected];
    }
    
    
}

- (IBAction)mGoPay:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLShopCarBottomGoPay)]) {
        [self.delegate ZLShopCarBottomGoPay];
    }
    
    
}



@end
