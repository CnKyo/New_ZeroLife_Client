//
//  CustomBtnView.m
//  IPos
//
//  Created by 瞿伦平 on 15/8/27.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "CustomBtnView.h"
#import "UIView+AutoSize.h"

@implementation CustomBtnView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIView *aView = ({
            UIView *view = [self newUIView];
            //view.backgroundColor = [UIColor redColor];
            
            self.imgView = [view newUIImageView];
            self.imgView.contentMode = UIViewContentModeScaleAspectFit;
            self.textLable = [view newUILableWithText:@"" textColor:[UIColor colorWithWhite:0.2 alpha:1] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter];
            self.textLable.adjustsFontSizeToFitWidth = YES;
            self.textLable.numberOfLines = 0;
            self.textLable.highlightedTextColor = [UIColor blackColor];
            [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.centerX.equalTo(view);
                make.height.equalTo(view.height).multipliedBy(0.5);
                make.width.equalTo(_imgView.mas_height);
            }];
            [self.textLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_imgView.mas_bottom);
                make.left.right.bottom.equalTo(view);
            }];
            
            view;
        });
        
        [aView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height).multipliedBy(0.95);
            make.width.equalTo(aView.mas_height);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}

+(CustomBtnView *)initWithTag:(NSInteger)tag title:(NSString *)title img:(UIImage *)img
{
    CustomBtnView *btnView = [[CustomBtnView alloc] init];
    btnView.tag = tag;
    btnView.imgView.image = img;
    btnView.textLable.text = title;
    return btnView;
}

@end
