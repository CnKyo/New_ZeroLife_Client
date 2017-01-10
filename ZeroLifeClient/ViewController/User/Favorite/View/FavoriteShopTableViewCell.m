//
//  FavoriteTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/8.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "FavoriteShopTableViewCell.h"

@implementation FavoriteShopTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        float padding = 5;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIColor *color = [UIColor grayColor];
        UIView *superView = self.contentView;
        
        self.iconImgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.nameLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:font];
        self.msgLable = [superView newUILableWithText:@"" textColor:color font:font];
        self.priceLable = [superView newUILableWithText:@"" textColor:color font:font];
        self.timeLable = [superView newUILableWithText:@"" textColor:color font:font textAlignment:NSTextAlignmentRight];
        self.goodLable = [superView newUILableWithText:@"" textColor:color font:font];
        
        [self.iconImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.top.equalTo(superView.top).offset(padding);
            make.bottom.equalTo(superView.bottom).offset(-padding);
            make.width.equalTo(_iconImgView.height);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconImgView.top);
            make.left.equalTo(_iconImgView.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
        }];
        [self.msgLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLable);
            make.top.equalTo(_nameLable.bottom);
            make.height.equalTo(_nameLable.height).multipliedBy(0.8);
        }];
        [self.priceLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLable);
            make.top.equalTo(_msgLable.bottom);
            make.height.equalTo(_msgLable.height);
        }];
        [self.goodLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.equalTo(_priceLable);
            make.top.equalTo(_priceLable.bottom);
            make.bottom.equalTo(_iconImgView.bottom);
        }];
        
        [self.timeLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(_goodLable.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
            make.top.bottom.equalTo(_goodLable);
        }];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end




@implementation FavoriteGoodsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        float padding = 5;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIColor *color = [UIColor grayColor];
        UIView *superView = self.contentView;
        
        self.iconImgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.nameLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
        self.msgLable = [superView newUILableWithText:@"" textColor:color font:font];
        self.priceLable = [superView newUILableWithText:@"" textColor:COLOR(249, 157, 45) font:[UIFont systemFontOfSize:15]];
        
        [self.iconImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.top.equalTo(superView.top).offset(padding);
            make.bottom.equalTo(superView.bottom).offset(-padding);
            make.width.equalTo(_iconImgView.height);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconImgView.top);
            make.left.equalTo(_iconImgView.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
        }];
        [self.msgLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLable);
            make.top.equalTo(_nameLable.bottom);
            make.height.equalTo(_nameLable.height).multipliedBy(1.3);
        }];
        [self.priceLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(_nameLable);
            make.top.equalTo(_msgLable.bottom);
            make.bottom.equalTo(_iconImgView.bottom);
        }];
        
    }
    return self;
}

- (void)setMItem:(ZLGoodsWithClass *)mItem{

    self.nameLable.text = mItem.pro_name;
    [self.iconImgView sd_setImageWithURL:[NSURL imageurl:mItem.img_url] placeholderImage:ZLDefaultGoodsImg];
    self.msgLable.text = [NSString stringWithFormat:@"规格：%@",mItem.pro_unit];
    
    NSString *mPrice = nil;
    if (mItem.skus.count>0) {
   
        ZLGoodsSKU *mSku = mItem.skus[0];
        mPrice = [NSString stringWithFormat:@"¥%.2f元",mSku.sku_price];
    }else{
        mPrice = @"暂无价格";
    }
    self.priceLable.text = mPrice;
    
 }
@end
