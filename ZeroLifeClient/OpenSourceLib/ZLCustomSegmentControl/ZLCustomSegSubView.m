//
//  ZLCustomSegSubView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/12/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLCustomSegSubView.h"

@implementation ZLCustomSegSubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (ZLCustomSegSubView *)initView{
    
    ZLCustomSegSubView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLCustomSegSubView" owner:self options:nil] objectAtIndex:0];
    return view;
    
}
@end
