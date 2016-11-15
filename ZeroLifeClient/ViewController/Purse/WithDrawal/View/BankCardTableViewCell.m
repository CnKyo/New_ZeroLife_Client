//
//  BankCardTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "BankCardTableViewCell.h"

@implementation BankCardTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        self.backgroundColor = COLOR(246, 246, 246);
        
        float padding = 10;
        UIView *superView = self.contentView;
        
        UIView *aView = ({
            UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
            view.layer.borderColor = COLOR(230, 230, 230).CGColor;
            view.layer.masksToBounds = YES;
            view.layer.borderWidth = 1;
            view.layer.cornerRadius = 5;
            
            self.bankImgView = [view newUIImageViewWithImg:IMG(@"cell_img_touxiang_defult.png")];
            self.bankNameLable = [superView newUILableWithText:@"中国建设银行" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]];
            self.cardTypeLable = [superView newUILableWithText:@"储蓄卡" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]];
            self.cardNumberLable = [superView newUILableWithText:@"**** **** **** 3243" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]];
            
            [self.bankImgView makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.left).offset(padding);
                make.top.equalTo(view.top).offset(padding);
                make.width.height.equalTo(50);
            }];
            [self.bankNameLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_bankImgView.right).offset(padding);
                make.right.equalTo(view.right).offset(-padding);
                make.top.equalTo(_bankImgView.top);
            }];
            [self.cardTypeLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.equalTo(_bankNameLable);
                make.top.equalTo(_bankNameLable.bottom);
                make.bottom.equalTo(_bankImgView.bottom);
            }];
            [self.cardNumberLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(_bankNameLable);
                make.top.equalTo(_bankImgView.bottom);
                make.bottom.equalTo(view.bottom);
            }];
            view;
        });
        [aView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
            make.top.equalTo(superView.top).offset(padding/2);
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
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
