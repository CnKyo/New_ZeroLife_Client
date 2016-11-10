//
//  OrderShopHeaderView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderShopHeaderView.h"

@implementation OrderShopHeaderView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:15];
        UIColor *color = [UIColor grayColor];
        UIView *superView = self;
        
        self.shopIconImgView = [superView newUIImageViewWithImg:IMG(@"order_shop_icon.png")];
        self.shopNameLable = [superView newUILableWithText:@"超尔店铺" textColor:color font:font];
        self.orderStatusLable = [superView newUILableWithText:@"待支付" textColor:COLOR(254, 102, 0) font:font textAlignment:NSTextAlignmentRight];
        
        [self.shopIconImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.centerY.equalTo(_shopNameLable.centerY);
            make.width.height.equalTo(20);
        }];
        [self.shopNameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_shopIconImgView.right).offset(padding/2);
            make.top.bottom.equalTo(superView);
        }];
        [self.orderStatusLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(superView);
            make.right.equalTo(superView.right).offset(-padding);
            make.width.lessThanOrEqualTo(65);
            make.left.equalTo(_shopNameLable.right).offset(padding/2);
        }];
    }
    return self;
}

@end
