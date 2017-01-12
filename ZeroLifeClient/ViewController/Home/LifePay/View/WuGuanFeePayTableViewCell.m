//
//  WuGuanFeePayTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "WuGuanFeePayTableViewCell.h"

@implementation WuGuanFeePayTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        float padding = 5;
        //UIFont *font = [UIFont systemFontOfSize:14];
        //UIColor *color = [UIColor grayColor];
        UIView *superView = self.contentView;
        
        
        UIView *aView = ({
            UIView *view = [superView newUIView];
            view.layer.cornerRadius = 5;
            view.layer.masksToBounds = YES;
            UIColor *color = [UIColor colorWithWhite:0.3 alpha:1];
            UIFont *font = [UIFont systemFontOfSize:15];
            UILabel *titleLable = [view newUILableWithText:@"万科物管公司" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentCenter];
            titleLable.backgroundColor = COLOR(122, 176, 1);
            UIView *bg1View = [view newUIViewWithBgColor:[UIColor whiteColor]];
            UIView *bg2View = [view newUIViewWithBgColor:[UIColor whiteColor]];
            UILabel *noteLable = [view newUILableWithText:@"9月待缴费金额(元)" textColor:color font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentCenter];
            UILabel *moneyLable = [view newUILableWithText:@"￥500.00" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:25] textAlignment:NSTextAlignmentCenter];
            UIImageView *juImgView = [view newUIImageViewWithImg:IMG(@"wuguan_jiange.png")];
            UILabel *menhuLable = [view newUILableWithText:@"门户号：大坪石油路万科一栋1004" textColor:color font:font];
            UILabel *nameLable = [view newUILableWithText:@"户主姓名：杨样样" textColor:color font:font];
            UILabel *timeLable = [view newUILableWithText:@"截止日期：2016-11-20" textColor:color font:font];
            UILabel *wenxinLable = [view newUILableWithText:@"温馨提示：请随时注意查看账单，不要逾期缴费！" textColor:color font:[UIFont systemFontOfSize:14]];
            wenxinLable.adjustsFontSizeToFitWidth = YES;
            UIButton *btn = [view newUIButton];
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            [btn setTitle:@"确认支付" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn jk_setBackgroundColor:COLOR(253, 158, 6) forState:UIControlStateNormal];
            
            self.pfee_companyLable = titleLable;
            self.pfee_titleLable = noteLable;
            self.pfee_costsLable = moneyLable;
            self.pfee_nameLable = nameLable;
            self.pfee_menpaiLable = menhuLable;
            self.pfee_endtimeLable = titleLable;
            self.actionBtn = btn;
            
            [titleLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(view);
                make.height.equalTo(50);
            }];
            [noteLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.left).offset(padding);
                make.right.equalTo(view.right).offset(-padding);
                make.top.equalTo(titleLable.bottom);
                make.height.equalTo(40);
            }];
            [moneyLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(noteLable);
                make.top.equalTo(noteLable.bottom);
                make.height.equalTo(60);
            }];
            [bg1View makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(view);
                make.top.equalTo(titleLable.bottom);
                make.bottom.equalTo(moneyLable.bottom);
            }];
            
            [juImgView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(view);
                make.top.equalTo(bg1View.bottom);
                make.height.equalTo(juImgView.width).multipliedBy(0.0385);
            }];
            [menhuLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(noteLable);
                make.top.equalTo(juImgView.bottom).offset(padding);
                make.height.equalTo(30);
            }];
            [nameLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.equalTo(menhuLable);
                make.top.equalTo(menhuLable.bottom);
            }];
            [timeLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.equalTo(menhuLable);
                make.top.equalTo(nameLable.bottom);
            }];
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(menhuLable);
                make.top.equalTo(timeLable.bottom).offset(padding);
                make.height.equalTo(50);
            }];
            [wenxinLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(menhuLable);
                make.height.equalTo(40);
                make.top.equalTo(btn.bottom);
            }];
            [bg2View makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(view);
                make.top.equalTo(juImgView.bottom);
                make.bottom.equalTo(wenxinLable.bottom);
            }];
            [view makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(bg2View.bottom);
            }];
            view;
        });
        [aView updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
            make.top.equalTo(superView.top).offset(@10);
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
