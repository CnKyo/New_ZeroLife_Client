//
//  ZLHomeLocationView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/1.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeLocationView.h"

@implementation ZLHomeLocationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (ZLHomeLocationView *)shareView{

    ZLHomeLocationView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLHomeLocationView" owner:self options:nil] objectAtIndex:0];
    
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 15;
    
    return view;
}
- (IBAction)mAddressAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLHomLocationViewDidSelected)]) {
        [self.delegate ZLHomLocationViewDidSelected];
    }
    
    
    
}

@end
