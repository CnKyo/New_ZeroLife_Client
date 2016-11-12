//
//  UserYuEHeaderView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserYuEHeaderView.h"
#import <JKCategories/UIButton+JKImagePosition.h>

#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>
#import <CoreText/CoreText.h>

@implementation UserYuEHeaderView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:15];
        UIColor *color = COLOR(254, 107, 0);
        UIView *superView = self;
        
        self.yuELable = [superView newUILableWithText:@"" textColor:color font:font];
        
        UILabel *noteLable = [superView newUILableWithText:@"现金余额可用于购买商品（支付时勾选即可抵扣订单金额）" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:14]];
        noteLable.numberOfLines = 0;
        self.noteELable = noteLable;
        
        UIColor *textColor = COLOR_NavBar;
        UIButton *btn1 = [superView newUIButton];
        btn1.layer.borderColor = textColor.CGColor;
        btn1.layer.borderWidth = 1;
        btn1.layer.cornerRadius = 5;
        btn1.titleLabel.font = font;
        [btn1 setTitle:@"充值" forState:UIControlStateNormal];
        [btn1 setTitleColor:textColor forState:UIControlStateNormal];
        [btn1 setImage:IMG(@"chongzi.png") forState:UIControlStateNormal];
        [btn1 jk_setImagePosition:LXMImagePositionLeft spacing:8];
        self.chongZiBtn = btn1;
        
  
        [self.yuELable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
            make.top.equalTo(superView.top).offset(padding);
            make.height.equalTo(40);
        }];
        [noteLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_yuELable);
            make.top.equalTo(_yuELable.bottom);
            make.height.equalTo(40);
        }];
        [btn1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_yuELable);
            make.top.equalTo(noteLable.bottom);
            make.height.equalTo(50);
        }];
        
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(btn1.bottom).offset(padding);
        }];
    }
    return self;
}

//设置余额样式
-(void)setYuEStyle
{
    self.noteELable.text = @"现金余额可用于购买商品（支付时勾选即可抵扣订单金额）";
    [self.chongZiBtn setTitle:@"充值" forState:UIControlStateNormal];
    [self.chongZiBtn setImage:IMG(@"chongzi.png") forState:UIControlStateNormal];
    [self loadYuEMoney:@"0.00"];
}


//设置积分样式
-(void)setScoreStyle
{
    self.noteELable.text = @"积分可用于商品兑换（兑换时抵扣积分）";
    [self.chongZiBtn setTitle:@"积分商城" forState:UIControlStateNormal];
    [self.chongZiBtn setImage:IMG(@"btn_scoreShop.png") forState:UIControlStateNormal];
    [self loadUserScore:@"0"];
}

-(void)loadYuEMoney:(NSString *)moneyStr
{
    NSDictionary* style2 = @{@"body" :
                                 @[[UIFont systemFontOfSize:15], [UIColor blackColor]],
                             @"u": @[[UIFont systemFontOfSize:15], COLOR(254, 145, 0)],
                             @"ub": @[[UIFont systemFontOfSize:20], COLOR(254, 145, 0)] };
    
    self.yuELable.attributedText = [[NSString stringWithFormat:@"现金余额 <u>￥</u><ub>%@</ub>", moneyStr] attributedStringWithStyleBook:style2];
}


-(void)loadUserScore:(NSString *)scoreStr
{
    NSDictionary* style2 = @{@"body" :
                                 @[[UIFont systemFontOfSize:15], [UIColor blackColor]],
                             @"u": @[[UIFont systemFontOfSize:15], COLOR(254, 145, 0)],
                             @"ub": @[[UIFont systemFontOfSize:20], COLOR(254, 145, 0)] };
    
    self.yuELable.attributedText = [[NSString stringWithFormat:@"我的积分 <ub>%@</ub><u>分</u>", scoreStr] attributedStringWithStyleBook:style2];
}
@end
