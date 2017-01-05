//
//  ZLRunningManTopView.m
//  ZeroLifeClient
//
//  Created by Mac on 2017/1/5.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "ZLRunningManTopView.h"
#import "ZLCustomBtnView.h"
#import "CustomDefine.h"

@interface ZLRunningManTopView ()<ZLCustomSegViewDelegate>

@end

@implementation ZLRunningManTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (ZLRunningManTopView *)initView:(NSArray *)mData{

    ZLRunningManTopView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLRunningManTopView" owner:self options:nil] objectAtIndex:0];
    
    for (ZLCustomBtnView *btnView in view.subviews) {
        [btnView removeFromSuperview];
    }
    
    for (int i = 0; i < mData.count; i++) {
        CGRect frame = CGRectMake(i*screen_width/4, 10, screen_width/4, 80);
        
        NSDictionary *dic = mData[i];
        
        NSString *title = [dic objectForKey:@"title"];
        NSString *imageStr = [dic objectForKey:@"img"];
        
        ZLCustomBtnView *btnView = [[ZLCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
        btnView.tag = i;
        [view addSubview:btnView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(OnTapBtnView:)];
        [btnView addGestureRecognizer:tap];
        
    }

    
    return view;
}
- (void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *mTap = (UITapGestureRecognizer *)sender;
    MLLog(@"%ld",[mTap view].tag);
    
    if ([self.delegate respondsToSelector:@selector(ZLRunningManTopViewBtnClickedWithIndex:)]) {
        [self.delegate ZLRunningManTopViewBtnClickedWithIndex:[mTap view].tag];
    }
    
}
+ (ZLRunningManTopView *)initclassViewText:(NSArray *)mText andImg:(NSArray *)mImg{    ZLRunningManTopView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLRunningManClassView" owner:self options:nil] objectAtIndex:0];

    ZLCustomSegView *mSecondSectionView = [ZLCustomSegView initViewType:ZLCustomSegViewTypeTextAndImage andTextArr:mText andImgArr:mImg];
    mSecondSectionView.delegate = view;
    mSecondSectionView.frame = CGRectMake(0, 0, DEVICE_Width, 80);
    
    [view addSubview:mSecondSectionView];
    return view;
}
#pragma mark----****----选择了哪一个代理方法
/**
 选择了哪一个
 
 @param mIndex 返回索引
 */
- (void)ZLCustomSegViewDidBtnSelectedWithIndex:(NSInteger)mIndex{

    if ([_delegate respondsToSelector:@selector(ZLRunningManClassViewBtnClickedWithIndex:)]) {
        [_delegate ZLRunningManClassViewBtnClickedWithIndex:mIndex];
    }
    
}
@end
