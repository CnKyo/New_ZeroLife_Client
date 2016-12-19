//
//  OrderGoodsThumbListView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderGoodsThumbListView.h"

@interface OrderGoodsThumbListView ()

@end


@implementation OrderGoodsThumbListView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR(245, 245, 245);
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:13];
        //UIColor *color = [UIColor grayColor];
        UIView *superView = self;
        
        self.imgView1 = [superView newUIImageViewWithImg:ZLDefaultGoodsImg];
        self.imgView2 = [superView newUIImageViewWithImg:ZLDefaultGoodsImg];
        self.imgView3 = [superView newUIImageViewWithImg:ZLDefaultGoodsImg];
        UIImageView *imgView = [superView newUIImageViewWithImg:IMG(@"jiantou_hui.png")];
        
        
        self.countLable = [superView newUILableWithText:@"共3件" textColor:[UIColor grayColor] font:font textAlignment:NSTextAlignmentRight];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(6);
            make.height.equalTo(11);
            make.centerY.equalTo(superView.centerY);
            make.right.equalTo(superView.right).offset(-padding);
        }];
        [self.countLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(superView);
            make.right.equalTo(imgView.left).offset(-padding/2);
            make.width.equalTo(70);
        }];
        [self.imgView1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.top.equalTo(superView.top).offset(padding/2);
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.width.equalTo(_imgView1.height);
        }];
        [self.imgView2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(_imgView1);
            make.left.equalTo(_imgView1.right).offset(padding);
        }];
        [self.imgView3 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(_imgView1);
            make.left.equalTo(_imgView2.right).offset(padding);
        }];
    }
    return self;
}



@end
