//
//  BaoXiuGoodsView.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "BaoXiuGoodsView.h"

@interface BaoXiuGoodsView ()
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *msgLable;
@end


@implementation BaoXiuGoodsView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR(245, 245, 245);
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIView *superView = self;
        
        self.imgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        
        
        self.nameLable = [superView newUILableWithText:@"维修冰箱" textColor:[UIColor blackColor] font:font];
        self.msgLable = [superView newUILableWithText:@"维修说明维修说明维修说明维修说明维修说明维修说明维修说明维修说明维修说明维修说明维修说明" textColor:[UIColor grayColor] font:font];
        self.nameLable.numberOfLines = 0;
        self.msgLable.numberOfLines = 0;
        
        [self.imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.top.equalTo(superView.top).offset(padding/2);
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.width.equalTo(_imgView.height);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding/2);
            make.left.equalTo(_imgView.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
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
    [self.imgView setImageWithURL:[NSURL URLWithString:item.odrg_img] placeholderImage:ZLDefaultGoodsImg];
}

@end
