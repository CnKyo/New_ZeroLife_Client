//
//  ComplaintJumingView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ComplaintJumingView.h"

@implementation ComplaintJumingView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    self.questionTextView.placeholder = @"请输入投诉的原因";
    self.questionTextView.text = @"";
    [self.doneBtn setStyleNavColor];
}


@end
