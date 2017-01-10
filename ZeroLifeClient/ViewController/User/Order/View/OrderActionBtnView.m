//
//  OrderActionBtnView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderActionBtnView.h"
#import <JKCategories/UIButton+JKBackgroundColor.h>
#import "UIButton+Border.h"
#import "APIObjectDefine.h"

@implementation OrderButton

-(void)setStateStr:(NSString *)stateStr
{
    _stateStr = stateStr;
    NSString *title = [NSString strDesWithOrderState:stateStr];

    [self setTitle:title forState:UIControlStateNormal];
    
    [self setTitleAndBorderColor:[UIColor colorWithOrderState:stateStr]];
}

@end




@implementation OrderActionBtnView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIView *superView = self;
        UIColor *color = [UIColor colorWithWhite:0.3 alpha:1];
        
        self.actionBtn1 = [OrderButton buttonWithType:UIButtonTypeCustom];
        self.actionBtn2 = [OrderButton buttonWithType:UIButtonTypeCustom];
        self.actionBtn3 = [OrderButton buttonWithType:UIButtonTypeCustom];
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
        [superView addSubview:_actionBtn1];
        [superView addSubview:_actionBtn2];
        [superView addSubview:_actionBtn3];
        
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

-(void)reloadUIWithStateArr:(NSArray *)arr
{
    //设置按钮显示信息
    if (arr.count > 0) {
        self.actionBtn1.hidden = NO;
        NSString *stateStr = [arr objectAtIndex:0];
        self.actionBtn1.stateStr = stateStr;
    } else {
        self.actionBtn1.hidden = YES;
        self.actionBtn1.stateStr = @"";
    }
    
    if (arr.count > 1) {
        self.actionBtn2.hidden = NO;
        NSString *stateStr = [arr objectAtIndex:1];
        self.actionBtn2.stateStr = stateStr;
    } else {
        self.actionBtn2.hidden = YES;
        self.actionBtn2.stateStr = @"";
    }
    
    if (arr.count > 2) {
        self.actionBtn3.hidden = NO;
        NSString *stateStr = [arr objectAtIndex:2];
        self.actionBtn3.stateStr = stateStr;
    } else {
        self.actionBtn3.hidden = YES;
        self.actionBtn3.stateStr = @"";
    }
}

@end
