//
//  SingInView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/2.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "SingInView.h"

@implementation SingInView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //float padding = 10;
        UIFont *font = [UIFont boldSystemFontOfSize:20];
        UIColor *color = COLOR_NavBar;
        UIView *superView = self;
        
        self.bgImgView = [superView newUIImageView];

        self.normalStatusTextLable = [superView newUILableWithText:@"点我签到" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        self.highlightStatusTextLable = [superView newUILableWithText:@"已签到" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        self.highlightLineView = [superView newUIViewWithBgColor:color];
        self.highlightCountTextLable = [superView newUILableWithText:@"+1" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        self.normalStatusTextLable.adjustsFontSizeToFitWidth = YES;
        self.highlightStatusTextLable.adjustsFontSizeToFitWidth = YES;
        self.highlightCountTextLable.adjustsFontSizeToFitWidth = YES;
        self.normalStatusTextLable.minimumScaleFactor = 0.5;
        self.highlightStatusTextLable.minimumScaleFactor = 0.5;
        self.highlightCountTextLable.minimumScaleFactor = 0.5;
        
        
        [self.bgImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(superView);
        }];
        [self.normalStatusTextLable makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(superView.centerX);
            make.centerY.equalTo(superView.centerY);
            make.width.height.equalTo(superView.width).multipliedBy(0.5);
        }];
        
        [self.highlightLineView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(superView.centerY);
            make.left.right.equalTo(_normalStatusTextLable);
            make.height.equalTo(OnePixNumber);
        }];
        [self.highlightStatusTextLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_normalStatusTextLable.top);
            make.bottom.equalTo(_highlightLineView.top);
            make.left.right.equalTo(_highlightLineView);
        }];
        [self.highlightCountTextLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_highlightLineView.bottom);
            make.bottom.equalTo(_normalStatusTextLable.bottom);
            make.left.right.equalTo(_highlightLineView);
        }];
        self.is_singin = NO;
        [self setHighlighted:NO animated:NO];
    }
    return self;
}

- (void)setHighlighted:(BOOL)isHighlighted animated:(BOOL)animated
{
    UIColor *color = nil;
    if (isHighlighted) {
        self.bgImgView.image = IMG(@"singIn_p.png");
        color = COLOR(127, 168, 31);
        
    } else {
        self.bgImgView.image = IMG(@"singIn_n.png");
        color = COLOR(137, 186, 0);
    }
    
    self.normalStatusTextLable.textColor = color;
    self.highlightStatusTextLable.textColor = color;
    self.highlightCountTextLable.textColor = color;
}

-(void)setIs_singin:(BOOL)is_singin
{
    _is_singin = is_singin;
    
    if (is_singin) {
        self.normalStatusTextLable.hidden = YES;
        self.highlightStatusTextLable.hidden = NO;
        self.highlightLineView.hidden = NO;
        self.highlightCountTextLable.hidden = NO;
    } else {
        self.normalStatusTextLable.hidden = NO;
        self.highlightStatusTextLable.hidden = YES;
        self.highlightLineView.hidden = YES;
        self.highlightCountTextLable.hidden = YES;
    }
}

@end




@implementation SingInHeaderView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:15];
        UIView *superView = self;
        
        UIImageView *bgImgView = [superView newUIImageViewWithImg:IMG(@"qianbao_headerBG.png")];
        
        self.singView = [[SingInView alloc] init];
        [superView addSubview:_singView];
        
        [bgImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(bgImgView.width).multipliedBy(0.67);
        }];
        [self.singView makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(bgImgView.height).multipliedBy(0.6);
            make.width.equalTo(_singView.height);
            make.centerX.equalTo(bgImgView.centerX);
            make.centerY.equalTo(bgImgView.centerY);
        }];
        
        UIView *aView = ({
            UIView *view = [superView newUIView];
        
            
            UIImageView *infoImgView = [view newUIImageViewWithImg:IMG(@"singIn_note_icon.png")];
            UILabel *infoLable = [view newUILableWithText:@"每日签到" textColor:[UIColor colorWithWhite:0.3 alpha:1] font:font];
            self.noteLable = [view newUILableWithText:@"已签到15天" textColor:[UIColor blackColor] font:font textAlignment:NSTextAlignmentRight];
            [infoImgView makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.equalTo(15);
                make.centerY.equalTo(view.centerY);
                make.left.equalTo(view.left).offset(padding);
            }];
            [infoLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(infoImgView.right).offset(padding/2);
                make.top.bottom.equalTo(view);
                make.width.equalTo(80);
            }];
            [self.noteLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(infoLable.right).offset(padding);
                make.right.equalTo(view.right).offset(-padding);
                make.top.bottom.equalTo(view);
            }];
            view;
        });
        [aView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
            make.top.equalTo(bgImgView.bottom);
            make.height.equalTo(40);
        }];

        [self makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(aView.bottom);
        }];
    }
    return self;
}


-(void)loadUIWithDay:(int)day
{
    NSDictionary* style2 = @{@"body" :
                                 @[[UIFont systemFontOfSize:15], [UIColor colorWithWhite:0.3 alpha:1]],
                             @"u": @[[UIFont systemFontOfSize:15], COLOR_NavBar],
                             @"ub": @[[UIFont systemFontOfSize:20], COLOR(254, 145, 0)] };
    
    self.noteLable.attributedText = [[NSString stringWithFormat:@"已签到 <u>%i</u> 天", day] attributedStringWithStyleBook:style2];
}


@end

