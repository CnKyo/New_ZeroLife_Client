//
//  BaoXiuChooseShopTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "BaoXiuChooseShopTableViewCell.h"


@implementation BaoXiuChooseShopTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIColor *color = [UIColor grayColor];
        UIView *superView = self.contentView;
        
        
        self.extensionLable1 = [superView newUILableWithText:@"先行赔付" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        self.extensionLable2 = [superView newUILableWithText:@"极速响应" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        self.extensionLable3 = [superView newUILableWithText:@"售后服务" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        
        self.imgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.nameLable = [superView newUILableWithText:@"重庆超尔维修店" textColor:[UIColor blackColor] font:font];
        self.priceLable = [superView newUILableWithText:@"参与报价：￥100" textColor:[UIColor blackColor] font:font textAlignment:NSTextAlignmentRight];
        
        UIView *centerView = ({
            UIView *view = [superView newUIView];
            
            self.ratingBarView = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0, 120, 15)];
            [view addSubview:_ratingBarView];
            //self.ratingBarView.backgroundColor = [UIColor redColor];
            
            UIColor *btnColor = COLOR_BtnBar;
            self.chooseBtn = [view newUIButton];
            self.chooseBtn.titleLabel.font = font;
            self.chooseBtn.layer.borderWidth = 1;
            self.chooseBtn.layer.borderColor = btnColor.CGColor;
            self.chooseBtn.layer.masksToBounds = YES;
            self.chooseBtn.layer.cornerRadius = 5;
            [self.chooseBtn setTitle:@"选择" forState:UIControlStateNormal];
            [self.chooseBtn setTitleColor:btnColor forState:UIControlStateNormal];
            
            [self.ratingBarView makeConstraints:^(MASConstraintMaker *make) {
                make.left.centerY.equalTo(view);
                make.width.equalTo(150);
                make.height.equalTo(15);
            }];
            [self.chooseBtn makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(60);
                make.height.equalTo(25);
                make.right.centerY.equalTo(view);
                //make.left.equalTo(_ratingBarView.right).offset(padding/2);
            }];
            view;
        });
        

        
    
        [self.extensionLable1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.height.equalTo(20);
        }];
        [self.extensionLable2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_extensionLable1.right).offset(padding/2);
            make.top.bottom.width.equalTo(_extensionLable1);
        }];
        [self.extensionLable3 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_extensionLable2.right).offset(padding/2);
            make.right.equalTo(superView.right).offset(-padding);
            make.top.bottom.width.equalTo(_extensionLable1);
        }];
        
        [self.imgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding);
            make.left.equalTo(superView.left).offset(padding);
            make.bottom.equalTo(_extensionLable1.top).offset(-padding);
            make.width.equalTo(_imgView.height);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding/2);
            make.left.equalTo(_imgView.right).offset(padding);
            make.height.equalTo(30);
        }];
        [self.priceLable makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.right).offset(-padding);
            make.top.bottom.equalTo(_nameLable);
            make.left.greaterThanOrEqualTo(_nameLable.right).offset(padding/2);
        }];

        
        [centerView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLable.bottom);
            make.bottom.equalTo(_extensionLable1.top);
            make.left.equalTo(_imgView.right).offset(padding);
            make.right.equalTo(_priceLable.right).offset(-padding/2);
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
