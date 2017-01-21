//
//  QUTagChooseView.m
//  CloudEye
//
//  Created by 瞿伦平 on 2016/10/27.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "QUTagChooseView.h"

@implementation QUTagChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)onTag: (UIButton *)btn {
    NSUInteger index =  [self.subviews indexOfObject: btn];
    self.indexChoose = index;

    if (self.didTapTagAtIndex) {
        self.didTapTagAtIndex([self.subviews indexOfObject: btn]);
    }
}

-(void)setIndexChoose:(NSUInteger)indexChoose
{
    SKTagButton *oldBtn = [self.subviews objectAtIndex:_indexChoose];
    SKTagButton *newBtn = [self.subviews objectAtIndex:indexChoose];
    
    if (oldBtn != nil)
        [oldBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    if (newBtn != nil)
        [newBtn setTitleColor:COLOR_NavBar forState:UIControlStateNormal];
    
    _indexChoose = indexChoose;
}


@end
