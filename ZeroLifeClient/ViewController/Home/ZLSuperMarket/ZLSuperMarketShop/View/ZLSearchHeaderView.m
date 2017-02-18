//
//  ZLSearchHeaderView.m
//  ZeroLifeClient
//
//  Created by Mac on 2017/2/17.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "ZLSearchHeaderView.h"

@implementation ZLSearchHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLSearchHeaderView *)shareView{

    ZLSearchHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLSearchHeaderView" owner:self options:nil] objectAtIndex:0];
    
    view.mClearnBtn.layer.masksToBounds = YES;
    view.mClearnBtn.layer.cornerRadius = 3;
    view.mClearnBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.mClearnBtn.layer.borderWidth = 0.75;
    return view;
}
- (void)mClearnClicked:(btnClick)block{
    self.block = block;
}
- (IBAction)mClearnAction:(id)sender {
    if (self.block) {
        self.block(sender);
    }
}

@end
