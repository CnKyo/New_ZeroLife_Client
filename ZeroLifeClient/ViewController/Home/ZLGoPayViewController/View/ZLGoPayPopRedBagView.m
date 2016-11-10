//
//  ZLGoPayPopRedBagView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLGoPayPopRedBagView.h"
#import "ZLCustomBtnView.h"
#import "CustomDefine.h"

@implementation ZLGoPayPopRedBagView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLGoPayPopRedBagView *)initShareViewWithFrame:(CGRect)mFrame andDataSource:(NSArray *)mDataSource{

    ZLGoPayPopRedBagView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLSendRedBagView" owner:self options:nil] objectAtIndex:0];
    view.frame = mFrame;
    
    for (int i =0 ; i<mDataSource.count; i++) {
        
        CGRect frame = CGRectMake(i*screen_width/4, 40, screen_width/4, 80);

        ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:@"sss" ImageStr:nil];
        btnView.tag = i;
        [view addSubview:btnView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        [btnView addGestureRecognizer:tap];

    }
    
    return view;

}

- (void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *mTap = (UITapGestureRecognizer *)sender;
    MLLog(@"%ld",[mTap view].tag);
    
    if ([self.delegate respondsToSelector:@selector(ZLGoPayShareWithBtnClickIndex:)]) {
        [self.delegate ZLGoPayShareWithBtnClickIndex:[mTap view].tag];
    }
    
}

@end
