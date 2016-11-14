//
//  PlurseValueNameControl.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "PlurseValueNameControl.h"

@implementation PlurseValueNameControl

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        float padding = 10;
        //UIFont *font = [UIFont systemFontOfSize:15];
        UIView *superView = self;
        
        self.valueLable = [superView newUILableWithText:@"" textColor:COLOR(253, 155, 21) font:[UIFont boldSystemFontOfSize:20] textAlignment:NSTextAlignmentCenter];
        self.nameLable = [superView newUILableWithText:@"" textColor:[UIColor colorWithWhite:0.3 alpha:1] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentCenter];
        self.valueLable.adjustsFontSizeToFitWidth = YES;
        self.nameLable.adjustsFontSizeToFitWidth = YES;
        [self.valueLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding/2);
            make.right.equalTo(superView.right).offset(-padding/2);
            make.top.equalTo(superView.top).offset(padding);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(_valueLable);
            make.top.equalTo(_valueLable.bottom);
            make.bottom.equalTo(superView.bottom).offset(-padding);
        }];
    }
    return self;
}

-(void)loadName:(NSString *)nameStr value:(NSString *)valueStr
{
    self.nameLable.text = nameStr;
    self.valueLable.text = valueStr;
}

@end
