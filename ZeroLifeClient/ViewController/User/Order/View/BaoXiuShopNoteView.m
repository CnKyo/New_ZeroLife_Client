//
//  BaoXiuShopNoteView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "BaoXiuShopNoteView.h"

@implementation BaoXiuShopNoteView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:13];
        UIView *superView = self;
        
        self.imgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.nameLable = [superView newUILableWithText:@"重庆超尔维修店竞价成功，并安排人员进行维修" textColor:[UIColor colorWithWhite:0.3 alpha:1] font:font];
        self.priceLable = [superView newUILableWithText:@"￥100" textColor:[UIColor blackColor] font:font textAlignment:NSTextAlignmentRight];
        self.nameLable.numberOfLines = 0;
        
        [self.imgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding);
            make.left.equalTo(superView.left).offset(padding);
            make.bottom.equalTo(superView.bottom).offset(-padding);
            make.width.equalTo(_imgView.height);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(superView);
            make.left.equalTo(_imgView.right).offset(padding);
        }];
        [self.priceLable makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.right).offset(-padding);
            make.top.bottom.equalTo(superView);
            make.left.equalTo(_nameLable.right).offset(padding/2);
            make.width.equalTo(70);
        }];
    }
    return self;
}


@end
