//
//  ZLPPTRewardHeadView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTRewardHeadView.h"

@implementation ZLPPTRewardHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLPPTRewardHeadView *)shareView{

    ZLPPTRewardHeadView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLPPTRewardHeadView" owner:self options:nil]objectAtIndex:0];
    
    return view;

}

@end
