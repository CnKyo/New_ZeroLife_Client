
//
//  ZLPPTReleaseBottomView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTReleaseBottomView.h"

@implementation ZLPPTReleaseBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (ZLPPTReleaseBottomView *)shareView{
    
    ZLPPTReleaseBottomView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLPPTReleaseBottomView" owner:self options:nil] objectAtIndex:0];
    
    return view;
    
    
}

- (IBAction)mGoPayAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLPPTReleaseBottomViewWithGoPayBtnClicked)]) {
        [self.delegate ZLPPTReleaseBottomViewWithGoPayBtnClicked];
    }
    
}



@end
