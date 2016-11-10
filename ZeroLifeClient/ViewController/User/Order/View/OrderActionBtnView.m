//
//  OrderActionBtnView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderActionBtnView.h"
#import <JKCategories/UIButton+JKBackgroundColor.h>

@implementation OrderActionBtnView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIView *superView = self;
        UIColor *color = [UIColor colorWithWhite:0.3 alpha:1];
        
        self.actionBtn1 = [superView newUIButton];
        self.actionBtn2 = [superView newUIButton];
        self.actionBtn3 = [superView newUIButton];
        self.actionBtn1.titleLabel.font = font;
        self.actionBtn2.titleLabel.font = font;
        self.actionBtn3.titleLabel.font = font;
        [self.actionBtn1 setTitle:@"取消支付" forState:UIControlStateNormal];
        [self.actionBtn2 setTitle:@"去支付" forState:UIControlStateNormal];
        [self.actionBtn3 setTitle:@"去评价" forState:UIControlStateNormal];
        [self.actionBtn1 setTitleColor:color forState:UIControlStateNormal];
        [self.actionBtn2 setTitleColor:color forState:UIControlStateNormal];
        [self.actionBtn3 setTitleColor:color forState:UIControlStateNormal];
        [self.actionBtn1 jk_setBackgroundColor:COLOR_BtnBar forState:UIControlStateNormal];
        [self.actionBtn2 jk_setBackgroundColor:COLOR_BtnBar forState:UIControlStateNormal];
        [self.actionBtn3 jk_setBackgroundColor:COLOR_BtnBar forState:UIControlStateNormal];
        
        [self.actionBtn1 makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.right).offset(-padding);
            make.top.equalTo(superView.top).offset(padding);
            make.bottom.equalTo(superView.bottom).offset(-padding);
            make.width.equalTo(_actionBtn1.height).multipliedBy(2);
        }];
        [self.actionBtn2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(_actionBtn1);
            make.right.equalTo(_actionBtn1.left).offset(-padding);
        }];
        [self.actionBtn3 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(_actionBtn1);
            make.right.equalTo(_actionBtn2.left).offset(-padding);
        }];
    }
    return self;
}


@end
