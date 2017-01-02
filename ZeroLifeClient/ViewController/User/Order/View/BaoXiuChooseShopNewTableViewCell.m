//
//  BaoXiuChooseShopNewTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/30.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "BaoXiuChooseShopNewTableViewCell.h"

#import <JKCategories/UIButton+JKImagePosition.h>

@implementation BaoXiuChooseShopNewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font1 = [UIFont systemFontOfSize:15];
        UIFont *font2 = [UIFont systemFontOfSize:14];

        UIView *superView = self.contentView;

        float rateWidth = 100;
        float rateHeight = 20;
    
        self.imgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.nameLable = [superView newUILableWithText:@"重庆超尔维修店" textColor:[UIColor blackColor] font:font1];
        self.salesMonthLable = [superView newUILableWithText:@"100人选择" textColor:[UIColor grayColor] font:font2 textAlignment:NSTextAlignmentCenter];
        self.priceLable = [superView newUILableWithText:@"参与报价：￥100" textColor:[UIColor blackColor] font:font2];
        
        self.ratingBarView = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0, rateWidth, rateHeight)];
        self.ratingBarView.enable = NO;
        [superView addSubview:_ratingBarView];
        
        UIColor *btnColor = COLOR_NavBar;
        self.chooseBtn = [superView newUIButton];
        self.chooseBtn.titleLabel.font = font1;
        self.chooseBtn.layer.borderWidth = 1;
        self.chooseBtn.layer.borderColor = btnColor.CGColor;
        self.chooseBtn.layer.masksToBounds = YES;
        self.chooseBtn.layer.cornerRadius = 5;
        [self.chooseBtn setTitle:@"选择" forState:UIControlStateNormal];
        [self.chooseBtn setTitleColor:btnColor forState:UIControlStateNormal];
        

        

        

        [self.imgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding);
            make.left.equalTo(superView.left).offset(padding);
            make.bottom.equalTo(superView.bottom).offset(-padding);
            make.width.equalTo(_imgView.height);
        }];
        
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding/2);
            make.left.equalTo(_imgView.right).offset(padding);
            //make.height.equalTo(30);
        }];
        
        [self.salesMonthLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLable.right).offset(padding/2);
            make.right.equalTo(superView.right).offset(-padding);
            make.top.bottom.equalTo(_nameLable);
            make.width.equalTo(80);
        }];
        
        [self.ratingBarView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLable.left);
            make.top.equalTo(_nameLable.bottom);
            make.width.equalTo(rateWidth);
            make.height.equalTo(rateHeight);
        }];
        [self.priceLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLable);
            make.top.equalTo(_ratingBarView.bottom);
            make.bottom.equalTo(_imgView.bottom);
            make.height.equalTo(_nameLable.height);
        }];
        [self.chooseBtn makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(30);
            make.centerY.equalTo(_priceLable.top);
            make.left.right.equalTo(_salesMonthLable);
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
