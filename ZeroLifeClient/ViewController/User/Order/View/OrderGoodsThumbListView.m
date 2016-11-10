//
//  OrderGoodsThumbListView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderGoodsThumbListView.h"

@interface OrderGoodsThumbListView ()
@property(nonatomic,strong) UIImageView *imgView1;
@property(nonatomic,strong) UIImageView *imgView2;
@property(nonatomic,strong) UIImageView *imgView3;
@property(nonatomic,strong) UILabel *countLable;
@end


@implementation OrderGoodsThumbListView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR(245, 245, 245);
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:15];
        UIColor *color = [UIColor grayColor];
        UIView *superView = self;
        
        self.imgView1 = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.imgView2 = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.imgView3 = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        UIImageView *imgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        
        
        self.countLable = [superView newUILableWithText:@"共3件" textColor:[UIColor blackColor] font:font textAlignment:NSTextAlignmentRight];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(15);
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
