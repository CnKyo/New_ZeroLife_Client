//
//  PaoPaoGoodsView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "PaoPaoGoodsView.h"

@interface PaoPaoGoodsView ()
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *msgLable;
@property(nonatomic,strong) UILabel *priceLable;
@end


@implementation PaoPaoGoodsView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR(245, 245, 245);
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIView *superView = self;
        
        self.imgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        
        
        self.nameLable = [superView newUILableWithText:@"帮我买一瓶脉动5块的" textColor:[UIColor blackColor] font:font];
        self.msgLable = [superView newUILableWithText:@"维修说明维修说明维修说明维修说明维修说明维修说明维修说" textColor:[UIColor grayColor] font:font];
        self.priceLable = [superView newUILableWithText:@"酬金\n\n￥3.00" textColor:[UIColor blackColor] font:font textAlignment:NSTextAlignmentCenter];
        self.nameLable.numberOfLines = 0;
        self.msgLable.numberOfLines = 0;
        self.priceLable.numberOfLines = 0;
        
        [self.imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.width.height.equalTo(50);
            make.centerY.equalTo(superView.centerY);
        }];
        [self.priceLable makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.right).offset(-padding);
            make.top.equalTo(_nameLable.top);
            make.bottom.equalTo(_msgLable.bottom);
            make.width.equalTo(50);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding/2);
            make.left.equalTo(_imgView.right).offset(padding);
            make.right.equalTo(_priceLable.left).offset(-padding/2);
            make.height.equalTo(superView.height).multipliedBy(0.3);
        }];
        [self.msgLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLable);
            make.top.equalTo(_nameLable.bottom);
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
        }];
    }
    return self;
}

-(void)reloadUIWithItem:(OrderGoodsObject *)item
{
    self.nameLable.text = [NSString compIsNone:item.odrg_pro_name];
    self.msgLable.text = [NSString compIsNone:item.odrg_spec];
    self.priceLable.text = [NSString stringWithFormat:@"酬金\n\n￥%.2f", item.odrg_price];
    [self.imgView setImageWithURL:[NSURL URLWithString:item.odrg_img] placeholderImage:ZLDefaultGoodsImg];
}


@end
