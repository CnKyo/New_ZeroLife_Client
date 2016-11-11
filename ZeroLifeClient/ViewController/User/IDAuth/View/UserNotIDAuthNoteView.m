//
//  UserNotIDAuthNoteView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserNotIDAuthNoteView.h"

@implementation UserNotIDAuthNoteView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR(253, 247, 176);
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIColor *color = COLOR(253, 150, 0);
        UIView *superView = self;
        
        UIImageView *imgView1 = [superView newUIImageViewWithImg:IMG(@"anquantishi.png")];
        UIImageView *imgView2 = [superView newUIImageViewWithImg:IMG(@"jiantou_chengshe.png")];
        
        UILabel *noteLable1 = [superView newUILableWithText:@"账户未实名认证" textColor:color font:font];
        UILabel *noteLable2 = [superView newUILableWithText:@"为资金安全，去认证" textColor:color font:font textAlignment:NSTextAlignmentCenter];

        [imgView1 makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(13);
            make.height.equalTo(15);
            make.left.equalTo(superView.left).offset(padding);
            make.centerY.equalTo(superView.centerY);
        }];
        
        [imgView2 makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(7);
            make.height.equalTo(11);
            make.centerY.equalTo(superView.centerY);
            make.right.equalTo(superView.right).offset(-padding);
        }];
        [noteLable1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView1.right).offset(padding/2);
            make.top.bottom.equalTo(superView);
        }];
        [noteLable2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(noteLable1.right).offset(padding/2);
            make.right.equalTo(imgView2.left).offset(-padding/2);
            make.top.bottom.equalTo(superView);
        }];
    }
    return self;
}

@end
