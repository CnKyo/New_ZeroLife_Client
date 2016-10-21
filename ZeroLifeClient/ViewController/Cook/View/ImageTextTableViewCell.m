//
//  ImageTextTableViewCell.m
//  StaffTraining
//
//  Created by 瞿伦平 on 16/5/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ImageTextTableViewCell.h"

@implementation ImageTextTableViewCell

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
        
        self.iconImgView = [superView newUIImageViewWithImg:IMG(@"DefaultImg.png")];
        
        self.text1Lable = [self.contentView newUILableWithText:@"" textColor:[UIColor blackColor] font:font];
        self.text2Lable = [self.contentView newUILableWithText:@"" textColor:color font:font];
        self.text1Lable.numberOfLines = 0;
        self.text2Lable.numberOfLines = 0;
        
        [self.iconImgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding);
            make.bottom.equalTo(superView.bottom).offset(-padding);
            make.left.equalTo(superView.left).offset(padding);
            make.width.equalTo(_iconImgView.mas_height);
        }];
        [self.text1Lable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconImgView.top);
            make.left.equalTo(_iconImgView.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
            make.height.equalTo(_iconImgView.mas_height).multipliedBy(0.4);
        }];
        [self.text2Lable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_text1Lable);
            make.top.equalTo(_text1Lable.bottom);
            make.bottom.equalTo(_iconImgView.bottom);
        }];
        
    }
    return self;
}

@end
