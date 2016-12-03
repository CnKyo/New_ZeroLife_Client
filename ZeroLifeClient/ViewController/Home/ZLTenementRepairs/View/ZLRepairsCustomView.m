//
//  ZLRepairsCustomView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRepairsCustomView.h"
#import "CustomDefine.h"
@implementation ZLRepairsCustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLRepairsCustomView *)initWithFixLogo:(NSString *)mLogoStr andFixName:(NSString *)mFixName andFixContent:(NSString *)mFixContent andTag:(NSInteger)mTag{

    
    ZLRepairsCustomView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLRepairsCustomView" owner:self options:nil] objectAtIndex:0];
    
    [view.mFixLogo sd_setImageWithURL:[NSURL URLWithString:mLogoStr] placeholderImage:[UIImage imageNamed:@"ZLDefault_Green"]];
    view.mFixName.text = mFixName;
    view.mFixContent.text = mFixContent;
    view.mClickBtn.tag = mTag;
    [view.mClickBtn addTarget:self action:@selector(mClickAction:) forControlEvents:UIControlEventTouchUpInside];
    return view;
    
}

+ (ZLRepairsCustomView *)initView{
    ZLRepairsCustomView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLRepairsCustomView" owner:self options:nil] objectAtIndex:0];

    return view;
}

- (void)mClickAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(ZLRepairsCustomViewWithBtnClicked:)]) {
        [self.delegate ZLRepairsCustomViewWithBtnClicked:sender.tag];
    }
    
    

}
- (IBAction)mClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ZLRepairsCustomViewWithBtnClicked:)]) {
        [self.delegate ZLRepairsCustomViewWithBtnClicked:sender.tag];
    }
}


@end
