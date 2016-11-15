//
//  DryCleanNoticeView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "NoticeTextView.h"

@implementation NoticeTextView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:15];
        //UIColor *color = [UIColor grayColor];
        UIView *superView = self;
        
        UIImageView *imgView = [superView newUIImageViewWithImg:IMG(@"notice.png")];
        
        self.noteLable = [[CBAutoScrollLabel alloc] init];
        self.noteLable.text = @"恭喜喜乐天玛特干洗店成功入驻超尔零生活社区。1111112222233333";
        self.noteLable.textColor = [UIColor grayColor];
        self.noteLable.labelSpacing = 35; // distance between start and end labels
        self.noteLable.pauseInterval = 3.7; // seconds of pause before scrolling starts again
        self.noteLable.scrollSpeed = 30; // pixels per second
        self.noteLable.textAlignment = NSTextAlignmentLeft; // centers text when no auto-scrolling is applied
        self.noteLable.fadeLength = 12.f; // length of the left and right edge fade, 0 to disable
        self.noteLable.font = font;
        [superView addSubview:_noteLable];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(13);
            make.centerY.equalTo(superView.centerY);
            make.left.equalTo(superView.left).offset(padding);
        }];
        [self.noteLable makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView).offset(-padding/2);
            make.left.equalTo(imgView.right).offset(padding/2);
            make.top.bottom.equalTo(superView);
        }];
    }
    return self;
}


@end
