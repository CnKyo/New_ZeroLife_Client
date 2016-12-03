//
//  ZLShopCampainSubView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/12/1.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLShopCampainSubView.h"

@implementation ZLShopCampainSubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLShopCampainSubView *)shareView{

    ZLShopCampainSubView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLShopCampainSubView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mTitle.layer.masksToBounds = YES;
    view.mTitle.layer.cornerRadius = 3;
    
    return view;
    
}

@end
