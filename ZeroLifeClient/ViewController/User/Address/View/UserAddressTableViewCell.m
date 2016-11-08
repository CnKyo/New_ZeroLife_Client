//
//  UserAddressTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserAddressTableViewCell.h"

@implementation UserAddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        float padding = 5;
        UIFont *font = [UIFont systemFontOfSize:15];
        UIColor *color = [UIColor grayColor];
        UIView *superView = self.contentView;
        
        UIImageView *imgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        
        
        self.nameLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:font];
        self.addressLable = [superView newUILableWithText:@"" textColor:color font:font];
        self.nameLable.numberOfLines = 0;
        self.addressLable.numberOfLines = 0;

        self.delBtn = [superView newUIButton];
        self.editBtn = [superView newUIButton];
        [self.delBtn setImage:IMG(@"choose_on.png") forState:UIControlStateNormal];
        [self.editBtn setImage:IMG(@"choose_on.png") forState:UIControlStateNormal];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.centerY.equalTo(superView.centerY);
            make.width.height.equalTo(30);
        }];
        [self.delBtn makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(30);
            make.centerY.equalTo(_nameLable.centerY);
            make.right.equalTo(superView.right).offset(-padding);
        }];
        [self.editBtn makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(30);
            make.centerY.equalTo(_addressLable.centerY);
            make.right.equalTo(superView.right).offset(-padding);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding/2);
            make.bottom.equalTo(superView.centerY);
            make.left.equalTo(imgView.right).offset(padding);
            make.right.equalTo(_delBtn.left).offset(-padding);
        }];
        [self.addressLable makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.top.equalTo(superView.centerY);
            make.left.equalTo(imgView.right).offset(padding);
            make.right.equalTo(_editBtn.left).offset(-padding);
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
