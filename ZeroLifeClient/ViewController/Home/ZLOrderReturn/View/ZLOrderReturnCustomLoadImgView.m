//
//  ZLOrderReturnCustomLoadImgView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/21.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLOrderReturnCustomLoadImgView.h"
#import "CustomDefine.h"
@implementation ZLOrderReturnCustomLoadImgView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLOrderReturnCustomLoadImgView *)shareView{

    ZLOrderReturnCustomLoadImgView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLOrderReturnCustomLoadImgView" owner:self options:nil] objectAtIndex:0];
    
    view.mDeleteBtn.layer.masksToBounds = YES;
    view.mDeleteBtn.layer.cornerRadius = view.mDeleteBtn.mwidth;
    return view;
}

@end
