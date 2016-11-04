//
//  ZLSearchArearView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSearchArearView.h"

@implementation ZLSearchArearView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLSearchArearView *)shareView{

    ZLSearchArearView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLSearchArearView" owner:self options:nil] objectAtIndex:0];
    
    view.mSearchView.layer.masksToBounds = YES;
    view.mSearchView.layer.cornerRadius = 15;
    
    return view;
    
}
- (IBAction)mSearchAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLSearchBtnSelected)]) {
        [self.delegate ZLSearchBtnSelected];
    }
    
    
}
- (IBAction)mCloseAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLCloseBtnSelected)]) {
        [self.delegate ZLCloseBtnSelected];
    }
    
    
}
@end
