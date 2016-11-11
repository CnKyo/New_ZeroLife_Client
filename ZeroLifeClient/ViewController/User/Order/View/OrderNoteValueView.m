//
//  OrderNoteValueView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderNoteValueView.h"

@implementation OrderNoteValueView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIView *superView = self;
        UIColor *color = [UIColor colorWithWhite:0.3 alpha:1];
        
        self.noteLable = [superView newUILableWithText:@"" textColor:color font:font];
        self.valueLable = [superView newUILableWithText:@"" textColor:color font:font];
        
        [self.noteLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left);
            make.top.bottom.equalTo(superView);
        }];
        [self.valueLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(_noteLable.right).offset(padding/2);
            make.top.bottom.equalTo(superView);
            make.right.equalTo(superView.right);
        }];
    }
    return self;
}

-(void)loadNotestr:(NSString *)note valueStr:(NSString *)value
{
    self.noteLable.text = note;
    self.valueLable.text = value;
}


@end
