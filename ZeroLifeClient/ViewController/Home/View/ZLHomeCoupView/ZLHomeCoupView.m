//
//  ZLHomeCoupView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/2.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeCoupView.h"

@implementation ZLHomeCoupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (ZLHomeCoupView *)shareView{

    ZLHomeCoupView *view  = [[[NSBundle mainBundle] loadNibNamed:@"ZlHomeCoupView" owner:self options:0] objectAtIndex:0];
    
    
    view.mOKBtn.layer.masksToBounds = YES;
    view.mOKBtn.layer.cornerRadius = 4;
    

    return view;
    
    
}

- (IBAction)mOKBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCoupOKBtnSelected)]) {
        [self.delegate ZLCoupOKBtnSelected];
    }
    
    
}

@end
