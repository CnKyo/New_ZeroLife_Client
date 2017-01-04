//
//  OrderShopHeaderView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderShopHeaderView.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation OrderShopHeaderView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIView *superView = self;
        
        self.shopIconImgView = [superView newUIImageViewWithImg:IMG(@"order_shop_icon.png")];
        self.shopNameLable = [superView newUILableWithText:@"超尔店铺" textColor:[UIColor colorWithWhite:0.2 alpha:1] font:font];
        self.orderStatusLable = [superView newUILableWithText:@"待支付" textColor:COLOR(254, 102, 0) font:font textAlignment:NSTextAlignmentRight];
        
        [self.shopIconImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.centerY.equalTo(_shopNameLable.centerY);
            make.width.height.equalTo(15);
        }];
        [self.shopNameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_shopIconImgView.right).offset(padding/2);
            make.top.bottom.equalTo(superView);
        }];
        [self.orderStatusLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(superView);
            make.right.equalTo(superView.right).offset(-padding);
            make.width.lessThanOrEqualTo(100);
            make.left.equalTo(_shopNameLable.right).offset(padding/2);
        }];
    }
    return self;
}

-(void)reloadUIWithShopName:(NSString *)name shopLogo:(NSString *)logo orderStatus:(NSString *)state
{
    self.orderStatusLable.text = state;
    self.shopNameLable.text = [NSString compIsNone:name];
    [self.shopIconImgView sd_setImageWithURL:[NSURL imageurl:logo] placeholderImage:IMG(@"order_shop_icon.png")];
}

@end
