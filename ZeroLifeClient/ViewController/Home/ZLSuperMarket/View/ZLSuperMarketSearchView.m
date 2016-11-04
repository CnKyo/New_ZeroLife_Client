//
//  ZLSuperMarketSearchView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketSearchView.h"

@implementation ZLSuperMarketSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLSuperMarketSearchView *)shareView{

    ZLSuperMarketSearchView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLSuperMarketSearchView" owner:self options:nil] objectAtIndex:0];
    
    view.mBgkView.layer.masksToBounds = YES;
    view.mBgkView.layer.cornerRadius = 15;
    
    return view;
}

@end
