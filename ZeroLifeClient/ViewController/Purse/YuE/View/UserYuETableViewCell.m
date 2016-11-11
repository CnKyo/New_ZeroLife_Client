//
//  UserYuETableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserYuETableViewCell.h"

@implementation UserYuETableViewCell

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
        
        self.imgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.msgLable = [superView newUILableWithText:@"转账" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]];
        self.moneyLable = [superView newUILableWithText:@"-50" textColor:COLOR(254, 145, 0) font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentRight];
        self.timeLable = [superView newUILableWithText:@"2016-10-05 10:23:42" textColor:color font:[UIFont systemFontOfSize:13]];
        self.msgLable.numberOfLines = 0;
        
        [self.imgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(30);
            make.centerY.equalTo(superView.centerY);
            make.left.equalTo(superView.left).offset(padding);
        }];
        [self.moneyLable makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.right).offset(-padding);
            make.top.bottom.equalTo(superView);
            make.width.lessThanOrEqualTo(65);
        }];
        [self.msgLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imgView.right).offset(padding);
            make.right.equalTo(_moneyLable.left).offset(-padding/2);
            make.top.equalTo(superView.top).offset(padding/2);
            make.bottom.equalTo(superView.centerY);
        }];
        [self.timeLable makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.top.equalTo(superView.centerY);
            make.left.right.equalTo(_msgLable);
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
