//
//  ZLPPTMyOrderHeaderView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTMyOrderHeaderView.h"
#import <JKCategories/UIButton+JKImagePosition.h>
#import "CustomDefine.h"
@implementation ZLPPTMyOrderHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLPPTMyOrderHeaderView *)shareView{

    ZLPPTMyOrderHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLPPTMyOrderHeaderView" owner:self options:nil] objectAtIndex:0];
 
    UIButton *btn1 = [UIButton new];
    btn1.layer.cornerRadius = 5;
    btn1.titleLabel.font =  [UIFont systemFontOfSize:14];
    [btn1 setTitle:@"去发布" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:0];
    [btn1 setImage:IMG(@"ZLPPTReales") forState:UIControlStateNormal];
    [btn1 jk_setImagePosition:LXMImagePositionLeft spacing:8];
    view.mBtn = btn1;
    [view.mBtn addTarget:self action:@selector(mReleaseAction) forControlEvents:UIControlEventTouchUpInside];

    
    return view;
    
}

- (void)mReleaseAction{

    if ([self.delegate respondsToSelector:@selector(ZLPPTMyOrderHeaderViewBtnWithClicked)]) {
        [self.delegate ZLPPTMyOrderHeaderViewBtnWithClicked];
    }
    
}

@end
