//
//  ZLSuperMarketHeaderSectionView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketHeaderSectionView.h"

@implementation ZLSuperMarketHeaderSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLSuperMarketHeaderSectionView *)shareView{

    ZLSuperMarketHeaderSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLSuperMarketHeaderSectionView" owner:self options:nil] objectAtIndex:0];
    return view;
}

@end
