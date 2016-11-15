//
//  DryCleanTimeChooseView.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanTimeChooseView.h"

@implementation DryCleanTimeChooseBtn
-(void)setItem:(TimeObject *)item
{
    if (item.time.length > 0) {
        [self setTitle:item.time forState:UIControlStateNormal];
    }
    self.enabled = item.canEdit;
    _item = item;
}
@end


@interface DryCleanTimeChooseView ()
//@property(strong,nonatomic) UIButton *chooseBtn;
@property(strong,nonatomic) NSString *chooseStr;
@end


@implementation DryCleanTimeChooseView

- (id)init
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.arr = [NSArray array];
        

    }
    return self;
}


-(void)loadUIWithTitleArr:(NSArray *)arr chooseTime:(NSString *)timeStr
{
    self.arr = arr;
    self.chooseStr = timeStr;
    
    [self reloadUIWithData];
    [self reloadBtnChooseState];
}


-(void)reloadUIWithData
{
    int row = 3;
    
    [self removeAllSubviews];
    
    UIView *lastView = nil;
    for (int i=0; i<_arr.count; i++) {
        TimeObject *item = [_arr objectAtIndex:i];
        
        DryCleanTimeChooseBtn *btn = [DryCleanTimeChooseBtn buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(chooseMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        //[self newUIButtonWithTarget:self mehotd:@selector(chooseMethod:) title:title titleColor:[UIColor grayColor]];
        btn.tag = 100 + i;
        btn.item = item;
        
        UIView *lineSView = [self newDefaultLineView]; //竖线右
        UIView *lineHView = [self newDefaultLineView]; //横线下
        //
        //
        //
        //            [lineSView makeConstraints:^(MASConstraintMaker *make) {
        //                if (lastView == nil || i % row == 0) {
        //                    make.left.equalTo(self.left);
        //                } else
        //                    make.left.equalTo(lastView.right);
        //                make.top.bottom.equalTo(btn);
        //                make.width.equalTo(OnePixNumber);
        //            }];
        //
        //            if (i < row) {
        //                UIView *lineHView1 = [self newDefaultLineView]; //横线上
        //                [lineHView1 makeConstraints:^(MASConstraintMaker *make) {
        //                    make.left.right.equalTo(btn);
        //                    make.top.equalTo(self.top);
        //                    make.height.equalTo(OnePixNumber);
        //                }];
        //
        //            } else {
        //
        //            }
        //
        if (i % row == 0) {
            UIView *lineSView1 = [self newDefaultLineView]; //竖线左
            [lineSView1 makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(btn);
                make.right.equalTo(btn.left);
                make.width.equalTo(OnePixNumber);
            }];
        }
        
        if (i < row) {
            UIView *lineHView1 = [self newDefaultLineView]; //横线上
            [lineHView1 makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(btn);
                make.bottom.equalTo(btn.top);
                make.height.equalTo(OnePixNumber);
            }];
        }
        
        [lineSView makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(btn);
            make.left.equalTo(btn.right);
            make.width.equalTo(OnePixNumber);
        }];
        
        [lineHView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(btn);
            make.top.equalTo(btn.bottom);
            make.height.equalTo(OnePixNumber);
        }];
        
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            if (i % row == 0) {
                make.left.equalTo(self.left).offset(OnePixNumber);
                if (lastView == nil) {
                    make.top.equalTo(self.top).offset(OnePixNumber);
                    make.height.equalTo(btn.mas_width).multipliedBy(0.4);
                } else
                    make.top.equalTo(lastView.bottom).offset(OnePixNumber);
            } else {
                if (i % row == row - 1)
                    make.right.equalTo(self.right).offset(-OnePixNumber);
                
                make.left.equalTo(lastView.right).offset(OnePixNumber);
                make.top.equalTo(lastView.top);
            }
            
            if (lastView != nil)
                make.width.height.equalTo(lastView);
            
        }];
        
        
        lastView = btn;
        
    }
    
    
    
    if (lastView != nil) {
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.bottom);
        }];
    }
}

-(void)chooseMethod:(UIButton *)sender
{
    NSInteger index = sender.tag - 100;
    NSLog(@"index:%li", (long)index);
    
    NSString *title = [sender titleForState:UIControlStateNormal];
    self.chooseStr = title;
    
    [self reloadBtnChooseState];
    
    if (self.chooseCallBack) {
        self.chooseCallBack(title);
    }
}

-(void)reloadBtnChooseState
{
    UIColor *colorChoose = [UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000];
    UIColor *colorNormal = [UIColor blackColor];
    UIColor *colorNoChoose = [UIColor grayColor];
    
    NSArray *arr = [self subviews];
    for (UIView *view in arr) {
        if ([view isKindOfClass:[DryCleanTimeChooseBtn class]]) {
            DryCleanTimeChooseBtn *btn = (DryCleanTimeChooseBtn *)view;
            NSString *title = [btn titleForState:UIControlStateNormal];
            if (btn.item.canEdit == YES) {
                btn.enabled = YES;
                if ([title isEqualToString:_chooseStr]) {
                    btn.layer.borderWidth = 1;
                    btn.layer.borderColor = colorChoose.CGColor;
                    btn.layer.masksToBounds = YES;
                    [btn setTitleColor:colorChoose forState:UIControlStateNormal];
                } else {
                    btn.layer.borderWidth = 0;
                    btn.layer.borderColor = colorNormal.CGColor;
                    btn.layer.masksToBounds = YES;
                    [btn setTitleColor:colorNormal forState:UIControlStateNormal];
                }
            } else {
                btn.enabled = NO;
                btn.layer.borderWidth = 0;
                btn.layer.borderColor = colorNoChoose.CGColor;
                btn.layer.masksToBounds = YES;
                [btn setTitleColor:colorNoChoose forState:UIControlStateNormal];
            }

        }
    }
}



@end
