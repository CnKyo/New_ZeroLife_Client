//
//  OrderBeizhuView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderBeizhuView.h"

@implementation OrderBeizhuView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR(255, 255, 255);
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIView *superView = self;
        
        UIImageView *imgView = [superView newUIImageViewWithImg:IMG(@"order_beizhu.png")];
        
        
        UILabel *noteLable = [superView newUILableWithText:@"备注信息" textColor:COLOR(170, 170, 170) font:font];
        self.beizhuLable = [superView newUILableWithText:@"这里是备注信息这里是备注信息这里是备注信息这里是备注信息" textColor:[UIColor grayColor] font:font];
        self.beizhuLable.numberOfLines = 0;
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.width.height.equalTo(15);
            make.top.equalTo(superView.centerY);
        }];
        [noteLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top);
            make.bottom.equalTo(imgView.top);
            make.left.equalTo(imgView.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
        }];
        [self.beizhuLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
            make.top.equalTo(imgView.top);
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
        }];
    }
    return self;
}

@end
