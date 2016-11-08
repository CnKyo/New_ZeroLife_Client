//
//  ViewCellBackground.m
//  GoApp
//
//  Created by 瞿伦平 on 15/1/22.
//  Copyright (c) 2015年 allran.mine. All rights reserved.
//

#import "QUItemBtnView.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

@interface MDSpreadViewCellTapGestureRecognizer : UIGestureRecognizer {
    CGPoint touchDown;
}
@end

@implementation MDSpreadViewCellTapGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.state = UIGestureRecognizerStateBegan;
    touchDown = [[touches anyObject] locationInView:self.view.window];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateFailed) return;
    CGPoint newPoint = [[touches anyObject] locationInView:self.view.window];
    if (fabs(touchDown.x - newPoint.x) > 5 || fabs(touchDown.y - newPoint.y) > 5) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    self.state = UIGestureRecognizerStateChanged;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateFailed) return;
    self.state = UIGestureRecognizerStateRecognized;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateCancelled;
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    return YES;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    return NO;
}


@end



@interface QUItemBtnView ()<UIGestureRecognizerDelegate>
@property (nonatomic, assign) BOOL shouldCancelTouches;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

-(void)initTapGesture;
@end




@implementation QUItemBtnView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTapGesture];
    }
    return self;
}

-(void)initTapGesture
{
    self.highlighted = NO;
    
    MDSpreadViewCellTapGestureRecognizer *_tapGesture = [[MDSpreadViewCellTapGestureRecognizer alloc] init];
    _tapGesture.cancelsTouchesInView = NO;
    _tapGesture.delaysTouchesEnded = NO;
    _tapGesture.delegate = self;
    [_tapGesture addTarget:self action:@selector(_handleTap:)];
    [self addGestureRecognizer:_tapGesture];
}


- (void)_handleTap:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _shouldCancelTouches = NO;
        [self setHighlighted:YES animated:YES];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        if (!_shouldCancelTouches)
            if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(selectItemBtnView:)])
                [self.delegate selectItemBtnView:self];
        
        
        [self setHighlighted:NO animated:YES];
        _shouldCancelTouches = NO;
    } else if (gesture.state == UIGestureRecognizerStateCancelled ||
               gesture.state == UIGestureRecognizerStateFailed) {
        _shouldCancelTouches = YES;
        [self setHighlighted:NO animated:YES];
    }
}


- (void)setHighlighted:(BOOL)isHighlighted animated:(BOOL)animated
{
    if (_highlighted != isHighlighted)
        self.highlighted = isHighlighted;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]&&[otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
//        return NO;
//    } else
//        return YES;
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
