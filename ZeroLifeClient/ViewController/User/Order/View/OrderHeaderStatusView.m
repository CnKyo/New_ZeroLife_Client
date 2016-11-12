//
//  OrderHeaderStatusView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderHeaderStatusView.h"

#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>
#import <CoreText/CoreText.h>

@implementation OrderHeaderStatusView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR_NavBar;
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:13];
        UIView *superView = self;
        
        UIImageView *imgView = [superView newUIImageViewWithImg:IMG(@"order_img_status.png")];
        self.msgLable = [superView newUILableWithText:@"等待支付" textColor:[UIColor colorWithWhite:0.3 alpha:1] font:font];
        self.msgLable.numberOfLines = 0;
        //self.noteLable = [superView newUILableWithText:@"剩余3小时自动关闭" textColor:[UIColor blackColor] font:font textAlignment:NSTextAlignmentRight];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(104);
            make.height.equalTo(74);
            make.right.equalTo(superView.right).offset(-padding);
            make.centerY.equalTo(superView.centerY);
        }];
        [self.msgLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(superView);
            make.left.equalTo(superView.left).offset(padding*2);
            make.right.equalTo(imgView.left).offset(-padding/2);
        }];
    }
    return self;
}

-(void)loadStatus:(NSString *)statusStr note:(NSString *)noteStr
{
    NSDictionary* style2 = @{@"body" :
                                 @[[UIFont systemFontOfSize:15], [UIColor whiteColor]],
                             @"u": @[[UIFont systemFontOfSize:13]]};
    
    NSMutableString *str = [NSMutableString new];
    
    if (statusStr.length > 0) {
        [str appendString:statusStr];
    }
    
    if (noteStr.length > 0) {
        [str appendFormat:@"<u>\n\n%@</u>", noteStr];
    }
    self.msgLable.attributedText = [str attributedStringWithStyleBook:style2];

}

@end
