//
//  OrderGoodsView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderGoodsView.h"

@implementation OrderGoodsView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR(245, 245, 245);
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIView *superView = self;
        
        self.imgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        
        
        self.nameLable = [superView newUILableWithText:@"康师傅方便面" textColor:[UIColor colorWithWhite:0.3 alpha:1] font:font];
        self.sizeLable = [superView newUILableWithText:@"规格：120g" textColor:[UIColor colorWithWhite:0.3 alpha:1] font:font];
        self.priceLable = [superView newUILableWithText:@"￥3.50" textColor:[UIColor blackColor] font:font textAlignment:NSTextAlignmentRight];
        self.countLable = [superView newUILableWithText:@"x 1" textColor:[UIColor grayColor] font:font textAlignment:NSTextAlignmentRight];
        self.nameLable.numberOfLines = 0;
        self.sizeLable.numberOfLines = 0;
        
        [self.imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.top.equalTo(superView.top).offset(padding);
            make.bottom.equalTo(superView.bottom).offset(-padding);
            make.width.equalTo(_imgView.height);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding/2);
            make.left.equalTo(_imgView.right).offset(padding);
            //
            make.height.equalTo(superView.height).multipliedBy(0.3);
        }];
        [self.sizeLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLable);
            make.top.equalTo(_nameLable.bottom);
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
        }];
        [self.priceLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_nameLable);
            make.right.equalTo(superView.right).offset(-padding);
            make.width.equalTo(50);
            make.left.equalTo(_nameLable.right).offset(padding/2);
        }];
        [self.countLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_priceLable);
            make.top.bottom.equalTo(_sizeLable);
        }];
    }
    return self;
}


@end
