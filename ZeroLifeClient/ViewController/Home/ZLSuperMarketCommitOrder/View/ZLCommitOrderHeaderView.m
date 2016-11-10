//
//  ZLCommitOrderHeaderView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLCommitOrderHeaderView.h"

@implementation ZLCommitOrderHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLCommitOrderHeaderView *)initWithHeder{

    
    ZLCommitOrderHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLCommitOrderHeaderView" owner:self options:nil] objectAtIndex:0];
    
    
    return view;
}

+ (ZLCommitOrderHeaderView *)initWithBottom{
    
    ZLCommitOrderHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLCommitOrderBottomView" owner:self options:nil] objectAtIndex:0];
    
    
    return view;
    
}

+ (ZLCommitOrderHeaderView *)initWithShopSection{
    
    ZLCommitOrderHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLCommitShopSectionView" owner:self options:nil] objectAtIndex:0];
    
    
    return view;
    
}

- (IBAction)mSelectAddress:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCommitSelectAddress)]) {
        [self.delegate ZLCommitSelectAddress];
    }
    
    
}

- (IBAction)mGoPay:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(ZLCommitGopay)]) {
        [self.delegate ZLCommitGopay];
    }


}


@end
