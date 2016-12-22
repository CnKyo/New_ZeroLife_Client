//
//  ZLRuuningManHomeHeaderSectionView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRuuningManHomeHeaderSectionView.h"

@implementation ZLRuuningManHomeHeaderSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLRuuningManHomeHeaderSectionView *)initView{
    
    ZLRuuningManHomeHeaderSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLRuuningManHomeHeaderSectionView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}
+ (ZLRuuningManHomeHeaderSectionView *)initSecondView{
    ZLRuuningManHomeHeaderSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLRuuningManHomeSecondSectionView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}

- (IBAction)mApplyAction:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(ZLRuuningManHomeHeaderSectionViewBtnClicked)]) {
        [_delegate ZLRuuningManHomeHeaderSectionViewBtnClicked];
    }
    
    
}


@end
