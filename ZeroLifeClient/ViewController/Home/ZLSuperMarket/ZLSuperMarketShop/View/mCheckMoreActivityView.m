//
//  mCheckMoreActivityView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/2.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCheckMoreActivityView.h"

@implementation mCheckMoreActivityView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (mCheckMoreActivityView *)shareView{

    mCheckMoreActivityView *view = [[[NSBundle mainBundle] loadNibNamed:@"mCheckMoreActivityView" owner:self options:nil] objectAtIndex:0];
    return view;
}
- (IBAction)mCloseBtn:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(closeMCheckMoreActivityView)]) {
        [self.delegate closeMCheckMoreActivityView];
    }
    
    
}

@end
