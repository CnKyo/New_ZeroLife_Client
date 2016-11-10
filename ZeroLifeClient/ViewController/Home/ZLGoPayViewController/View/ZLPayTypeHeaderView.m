//
//  ZLPayTypeHeaderView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPayTypeHeaderView.h"

@implementation ZLPayTypeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLPayTypeHeaderView *)shareView{

    ZLPayTypeHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLPayTypeHeaderView" owner:self options:nil] objectAtIndex:0];
    return view;
    
}
@end
