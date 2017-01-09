//
//  DryCleanShopTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "DryCleanShopTableViewCell.h"

@implementation DryCleanShopTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        float padding = 5;
        UIFont *font = [UIFont systemFontOfSize:15];
        UIFont *font2 = [UIFont systemFontOfSize:13];
        UIColor *color = [UIColor grayColor];
        UIView *superView = self.contentView;
        
        UIImageView *iconView1 = [superView newUIImageViewWithImg:IMG(@"ganxi_shijian.png")];
        UIImageView *iconView2 = [superView newUIImageViewWithImg:IMG(@"ganxi_xiaoliang.png")];
        self.iconImgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.nameLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:font];
        self.timeLable = [superView newUILableWithText:@"" textColor:color font:font2];
        self.saleLable = [superView newUILableWithText:@"" textColor:color font:font2];
        self.distanceLable = [superView newUILableWithText:@"" textColor:color font:font2 textAlignment:NSTextAlignmentRight];
        
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
        [self.timeLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLable.bottom);
            make.left.equalTo(iconView1.right).offset(padding/2);
            make.right.equalTo(superView.right).offset(-padding);
            make.height.equalTo(20);
        }];
        [self.saleLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_timeLable.bottom);
            make.left.height.equalTo(_timeLable);
            make.bottom.equalTo(_iconImgView.bottom);
        }];
        [iconView1 makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(13);
            make.centerY.equalTo(_timeLable.centerY);
            make.left.equalTo(_nameLable.left);
        }];
        [iconView2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(iconView1);
            make.centerY.equalTo(_saleLable.centerY);
        }];
        [self.distanceLable makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_nameLable.right);
            make.top.bottom.equalTo(_saleLable);
            make.left.greaterThanOrEqualTo(_saleLable.right).offset(padding/2);
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


- (void)setMShopObj:(ZLShopHomeShopObj *)mShopObj{
    
    self.nameLable.text = mShopObj.shop_name;
    self.timeLable.text = [NSString stringWithFormat:@"%@  满%.f元起送",mShopObj.ext_max_time,mShopObj.ext_min_price];
    self.saleLable.text = [NSString stringWithFormat:@"销量：%d",mShopObj.ext_sales_month];
    self.distanceLable.text = [NSString stringWithFormat:@"%@m",mShopObj.distance];
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mShopObj.shop_logo]] placeholderImage:[UIImage imageNamed:@"ZLDefault_Shop"]];
    
}

@end
