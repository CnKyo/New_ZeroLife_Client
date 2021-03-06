//
//  TransferAccountHistoryTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "TransferAccountHistoryTableViewCell.h"

@implementation TransferAccountHistoryTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        float padding = 10;
        UIView *superView = self.contentView;
        
        
        UIColor *clolr1 = [UIColor blackColor];
        UIColor *color2 = [UIColor grayColor];
        UIFont *font1 = [UIFont systemFontOfSize:14];
        UIFont *font2 = [UIFont systemFontOfSize:13];
        self.nameLable = [superView newUILableWithText:@"张三" textColor:clolr1 font:font1];
        self.timeLable = [superView newUILableWithText:@"2016-10-05 10:23:42" textColor:color2 font:font2];
        self.moneyLable = [superView newUILableWithText:@"-50" textColor:clolr1 font:font1 textAlignment:NSTextAlignmentRight];
        self.statusLable = [superView newUILableWithText:@"转账" textColor:color2 font:font2 textAlignment:NSTextAlignmentRight];
        

        
        [self.moneyLable makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.right).offset(-padding);
            make.top.equalTo(superView.top).offset(padding);
            make.width.equalTo(80);
        }];
        [self.statusLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_moneyLable.bottom);
            make.left.right.height.equalTo(_moneyLable);
            make.bottom.equalTo(superView.bottom).offset(-padding);
        }];
        
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_moneyLable);
            make.left.equalTo(superView.left).offset(padding);
            make.right.equalTo(_moneyLable.left).offset(-padding/2);
        }];
        [self.timeLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLable);
            make.top.bottom.equalTo(_statusLable);
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
