//
//  ZLHomeCampFuncView.m
//  ZeroLifeClient
//
//  Created by Mac on 2017/1/16.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "ZLHomeCampFuncView.h"

@implementation ZLHomeCampFuncView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLHomeCampFuncView *)initSmallView{
    
    ZLHomeCampFuncView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLHomeCampFuncView" owner:self options:nil] objectAtIndex:0];
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00].CGColor;
    view.layer.borderWidth = 0.25;
    return view;

}
+ (ZLHomeCampFuncView *)initBigView{
    ZLHomeCampFuncView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLHomeCampFuncBigView" owner:self options:nil] objectAtIndex:0];
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00].CGColor;
    view.layer.borderWidth = 0.25;
    return view;
}
+ (ZLHomeCampFuncView *)initImgRightView{
    ZLHomeCampFuncView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLHomeCampFuncImgRightView" owner:self options:nil] objectAtIndex:0];
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00].CGColor;
    view.layer.borderWidth = 0.25;
    return view;
}

- (IBAction)btnAction:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(ZLHomeCampFuncViewDidSelected:)]) {
        [_delegate ZLHomeCampFuncViewDidSelected:self.mIndex];
    }
}


@end
