//
//  UserPayTypeTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserPayTypeTableViewCell.h"

@implementation UserPayTypeTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIColor *color = [UIColor grayColor];
        UIView *superView = self.contentView;
        
        self.imgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.nameLable = [superView newUILableWithText:@"支付宝支付" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]];
        
        [self.imgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(22);
            make.centerY.equalTo(superView.centerY);
            make.left.equalTo(superView.left).offset(padding);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.right).offset(-padding);
            make.left.equalTo(_imgView.right).offset(padding);
            make.top.bottom.equalTo(superView);
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
