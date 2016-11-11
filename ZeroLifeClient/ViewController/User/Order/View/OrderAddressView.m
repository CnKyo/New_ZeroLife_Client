//
//  OrderAddressView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderAddressView.h"

@implementation OrderAddressView

- (id)initWithNote:(NSString *)noteStr name:(NSString *)nameStr address:(NSString *)addressStr
{
    
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR(255, 255, 255);
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:13];
        UIView *superView = self;
        UIView *lastView = nil;
        
        UIImageView *imgView = [superView newUIImageViewWithImg:IMG(@"order_address_place.png")];
//        self.addressLable = [superView newUILableWithText:addressStr textColor:[UIColor grayColor] font:font];
//        self.addressLable.numberOfLines = 0;
        self.addressLable = [superView newUITextView];
        self.addressLable.font = font;
        self.addressLable.text = addressStr;
        //self.addressLable.backgroundColor = [UIColor redColor];
        self.addressLable.editable = NO;
        self.addressLable.scrollEnabled = NO;
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.width.equalTo(15);
            make.height.equalTo(20);
            make.top.equalTo(_addressLable.top).offset(padding);
        }];
        
        
        if (noteStr.length > 0) {
            self.noteLable = [superView newUILableWithText:noteStr textColor:COLOR(170, 170, 170) font:font];
            [self.noteLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imgView.right).offset(padding);
                make.top.equalTo(superView.top);
                make.height.equalTo(30);
            }];
            lastView = _noteLable;
        }
        
        if (nameStr.length > 0) {
            self.nameLable = [superView newUILableWithText:nameStr textColor:[UIColor blackColor] font:font];
            self.nameLable.numberOfLines = 0;
            [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
                if (lastView == nil)
                    make.top.equalTo(superView.top);
                else
                    make.top.equalTo(lastView.bottom);
                
                make.height.equalTo(30);
                make.left.equalTo(imgView.right).offset(padding);
                make.right.equalTo(superView.right).offset(-padding);
            }];
            lastView = _nameLable;
        }
        
        

        [self.addressLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
            if (lastView == nil)
                make.top.equalTo(superView.top);
            else
                make.top.equalTo(lastView.bottom).offset(-padding/2);
            make.height.equalTo(50);
        }];
        
        UIImageView *lineView2 = [superView newUIImageViewWithImg:IMG(@"order_hengxian_hua.png")];
        [lineView2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
            make.top.equalTo(_addressLable.bottom).offset(padding/2);
            make.height.equalTo(2);
        }];
        
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lineView2.bottom);
        }];
    }
    return self;
}

@end
