//
//  SelectedAddressTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/20.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "SelectedAddressTableViewCell.h"

@implementation SelectedAddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        float padding = 5;
        UIFont *font = [UIFont systemFontOfSize:15];
        UIColor *color = [UIColor grayColor];
        UIView *superView = self.contentView;
        
        UIImageView *imgView11 = [superView newUIImageViewWithImg:IMG(@"cell_address_myplace.png")];
        self.nameLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:font];
        self.addressLable = [superView newUILableWithText:@"" textColor:color font:font];
        self.nameLable.numberOfLines = 0;
        self.addressLable.numberOfLines = 0;
        
        [imgView11 makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(10);
            make.height.equalTo(15);
            make.centerY.equalTo(superView.centerY);
            make.left.equalTo(superView.left).offset(padding);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding/2);
            make.left.equalTo(imgView11.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
        }];
        [self.addressLable makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.top.equalTo(_nameLable.bottom);
            make.left.right.equalTo(_nameLable);
            make.height.equalTo(_nameLable.height);
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
