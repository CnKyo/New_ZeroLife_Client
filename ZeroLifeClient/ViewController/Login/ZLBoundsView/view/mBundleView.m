//
//  mBundleView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/27.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mBundleView.h"

@implementation mBundleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mBundleView *)shareView{

    mBundleView *view = [[[NSBundle mainBundle] loadNibNamed:@"mBundleView" owner:self options:nil] objectAtIndex:0];
    
    view.mBundleBtn.layer.masksToBounds = YES;
    view.mBundleBtn.layer.cornerRadius = 3;
    
    view.mPwdView.layer.masksToBounds = view.mPhoneView.layer.masksToBounds = YES;
    view.mPwdView.layer.borderColor = view.mPhoneView.layer.borderColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00].CGColor;
    view.mPwdView.layer.borderWidth = view.mPhoneView.layer.borderWidth = 0.5;
    
    
    return view;
}

@end
