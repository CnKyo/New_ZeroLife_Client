//
//  BaoXiuWorkerView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "BaoXiuWorkerView.h"
#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>
#import <CoreText/CoreText.h>

#import <JKCategories/UIButton+JKImagePosition.h>

@implementation BaoXiuWorkerView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:13];
        UIView *superView = self;
        
        self.workerLable = [superView newUILableWithText:@"师傅信息\n王师傅 15503241234" textColor:[UIColor colorWithWhite:0.3 alpha:1] font:font];
        //self.mobileLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:font textAlignment:NSTextAlignmentCenter];
        self.workerLable.numberOfLines = 0;
        UIView *lineView = [superView newDefaultLineView];
        
        
        self.mobileBtn = [superView newUIButton];
        self.mobileBtn.titleLabel.font = font;
        [self.mobileBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        [self.mobileBtn setTitleColor:COLOR_NavBar forState:UIControlStateNormal];
        [self.mobileBtn setImage:IMG(@"call_mobile.png") forState:UIControlStateNormal];
        [self.mobileBtn jk_setImagePosition:LXMImagePositionLeft spacing:5];
        
//        NSDictionary* style2 = @{@"body" : @[font, COLOR_NavBar],
//                                 @"thumb":IMG(@"call_mobile.png") };
        
        //self.mobileLable.attributedText = [@"<thumb> </thumb> 拨打电话" attributedStringWithStyleBook:style2];
        

        [self.workerLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(superView);
            make.left.equalTo(superView.left).offset(padding);
            make.width.equalTo(superView.width).multipliedBy(0.6);
        }];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(superView.centerY);
            make.width.equalTo(OnePixNumber);
            make.height.equalTo(superView.height).multipliedBy(0.7);
            make.left.equalTo(_workerLable.right);
        }];
        [self.mobileBtn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.right).offset(-padding);
            make.top.bottom.equalTo(superView);
            make.left.equalTo(lineView.right);
        }];
    }
    return self;
}

@end
