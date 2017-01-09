//
//  ZLPPTOrderDetailHeaderSectionView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTOrderDetailHeaderSectionView.h"

@implementation ZLPPTOrderDetailHeaderSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (ZLPPTOrderDetailHeaderSectionView *)initFirstView{

    ZLPPTOrderDetailHeaderSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLPPTOrderDetailHeaderSectionView" owner:self options:nil] objectAtIndex:0];
    return view;
    
}

+ (ZLPPTOrderDetailHeaderSectionView *)initSecondView{
    ZLPPTOrderDetailHeaderSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLPPTOrderDetailHeaderSectionView2" owner:self options:nil] objectAtIndex:0];
    return view;
}
- (IBAction)mPhoneAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(ZLPPTOrderDetailHeaderSectionViewWithRunnerPhoneAction)]) {
        [_delegate ZLPPTOrderDetailHeaderSectionViewWithRunnerPhoneAction];
    }
    
}

@end
