//
//  ZLCustomEmptyView.m
//  ZeroLifeClient
//
//  Created by Mac on 2017/1/12.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "ZLCustomEmptyView.h"
#import "CustomDefine.h"
@implementation ZLCustomEmptyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (ZLCustomEmptyView *)initView{
    ZLCustomEmptyView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLCustomEmptyView" owner:self options:nil] objectAtIndex:0];
    
    view.mBtn.layer.masksToBounds = YES;
    view.mBtn.layer.cornerRadius = 3;
    view.mBtn.layer.borderColor = M_CO.CGColor;
    view.mBtn.layer.borderWidth = 0.5;
    
    return view;
}

- (IBAction)btn:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(wk_emptyViewDidClicked)]) {
        [_delegate wk_emptyViewDidClicked];
    }
    
}

@end
