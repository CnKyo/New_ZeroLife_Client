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
        UIFont *font = [UIFont systemFontOfSize:13];
        UIView *superView = self;
        
        UIImageView *imgView = [superView newUIImageViewWithImg:IMG(@"order_beizhu.png")];
        
        
        UILabel *noteLable = [superView newUILableWithText:@"备注信息" textColor:COLOR(170, 170, 170) font:font];
        
        self.beizhuLable = [[TopLeftLabel alloc] init];
        self.beizhuLable.text = @"这里是备注信息这里是备注信息这里是备注信息这里是备注信息";
        self.beizhuLable.font = font;
        self.beizhuLable.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        //self.beizhuLable = [superView newUILableWithText:@"这里是备注信息这里是备注信息这里是备注信息这里是备注信息" textColor:[UIColor grayColor] font:font];
        self.beizhuLable.numberOfLines = 0;
        [superView addSubview:_beizhuLable];
        
//        [imgView makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(superView.left).offset(padding);
//            make.width.height.equalTo(15);
//            make.top.equalTo(noteLable.bottom);
//        }];
//        [noteLable makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(superView.top);
//            make.height.equalTo(30);
//            //make.bottom.equalTo(imgView.top);
//            make.left.equalTo(imgView.right).offset(padding);
//            make.right.equalTo(superView.right).offset(-padding);
//        }];
//        [self.beizhuLable makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(imgView.right).offset(padding);
//            make.right.equalTo(superView.right).offset(-padding);
//            make.top.equalTo(noteLable.bottom);
//            make.bottom.equalTo(superView.bottom).offset(-padding/2);
//        }];

        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.width.height.equalTo(15);
            make.top.equalTo(noteLable.bottom);
        }];
        [noteLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top);
            make.height.equalTo(30);
            //make.bottom.equalTo(imgView.top);
            make.left.equalTo(imgView.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
        }];
        [self.beizhuLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
            make.top.equalTo(noteLable.bottom);
            //make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.height.greaterThanOrEqualTo(40);
        }];
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_beizhuLable.bottom).offset(padding/2);
        }];
    }
    return self;
}

@end
