//
//  UserComplaintHistoryTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserComplaintHistoryTableViewCell.h"

@implementation UserComplaintHistoryTableViewCell


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
        
        self.iconImgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.nameLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:font];
        self.timeLable = [superView newUILableWithText:@"" textColor:color font:font];
        self.msgLable = [superView newUILableWithText:@"" textColor:color font:font textAlignment:NSTextAlignmentRight];
        
        [self.iconImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.centerY.equalTo(superView.centerY);
            make.width.height.equalTo(30);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding/2);
            make.bottom.equalTo(superView.centerY);
            make.left.equalTo(_iconImgView.right).offset(padding);
            make.right.equalTo(_timeLable.left).offset(-padding/2);
        }];
        [self.timeLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_nameLable);
            make.right.equalTo(superView.right).offset(-padding);
            make.width.lessThanOrEqualTo(100);
        }];
        [self.msgLable makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.top.equalTo(superView.centerY);
            make.left.equalTo(_iconImgView.right).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
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
