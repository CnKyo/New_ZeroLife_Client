//
//  BaoXiuChooseShopView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "BaoXiuChooseShopView.h"

@implementation BaoXiuChooseShopView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:13];
        UIView *superView = self;
        UIColor *color = COLOR_NavBar;
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = color.CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.noteLable = [superView newUILableWithText:@"已有3家服务商参与 点击选择服务商" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        
        UIImageView *jiantouView = [superView newUIImageViewWithImg:IMG(@"order_fix_choose_jiantou.png")];
        
        [self.noteLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(superView);
            make.centerX.equalTo(superView.centerX);
            make.left.greaterThanOrEqualTo(superView.left).offset(padding);
            make.right.lessThanOrEqualTo(superView.right).offset(-padding*2);
        }];
        [jiantouView makeConstraints:^(MASConstraintMaker *make) {
            //make.width.height.equalTo(10);
            make.width.equalTo(6);
            make.height.equalTo(11);
            make.left.equalTo(_noteLable.right).offset(padding);
            make.centerY.equalTo(superView.centerY);
        }];
    }
    return self;
}

-(void)reloadWithCount:(int)count chooseItem:(OrderRepairBidObject *)item
{
    if (item != nil) {
        self.noteLable.text = [NSString stringWithFormat:@"已选择 %@", item.shop_name];
    } else {
        self.noteLable.text = [NSString stringWithFormat:@"已有%i家服务商参与 点击选择服务商", count];
    }
    
}

@end
