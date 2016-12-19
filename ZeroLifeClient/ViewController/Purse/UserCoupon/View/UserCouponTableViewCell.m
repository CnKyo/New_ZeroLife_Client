//
//  UserCouponTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserCouponTableViewCell.h"



@implementation UserCouponTableView

- (id)init{
    
    self = [super init];
    if (self) {
        // Initialization code.
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIColor *color = [UIColor grayColor];
        UIView *superView = self;
        
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
        
        self.typeLable = [superView newUILableWithText:@"满减券" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        self.typeLable.layer.masksToBounds = YES;
        self.typeLable.layer.borderWidth = 1;
        self.typeLable.layer.cornerRadius = 5;
        
        self.moneyLable = [superView newUILableWithText:@"" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        
        self.nameLable = [superView newUILableWithText:@"超尔店铺" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]];
        self.desLable = [superView newUILableWithText:@"满100减20元" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:14]];
        self.desLable.numberOfLines = 0;
        
        self.imgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
        self.statusLable = [superView newUILableWithText:@"未使用" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        self.timeLable = [superView newUILableWithText:@"2016-10-23" textColor:color font:font textAlignment:NSTextAlignmentCenter];
        
        
        
        
        [self.imgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(superView);
            make.width.equalTo(_imgView.height).multipliedBy(1.1);
        }];
        [self.statusLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imgView.left).offset(padding);
            make.right.equalTo(_imgView.right).offset(-padding/2);
            make.top.equalTo(_imgView.top);
            make.height.equalTo(_imgView.height).multipliedBy(0.6);
        }];
        [self.timeLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_statusLable);
            make.top.equalTo(_statusLable.bottom);
            make.bottom.equalTo(_imgView.bottom);
        }];
        
        
        [self.moneyLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding/2);
            make.width.equalTo(superView.height);
            make.top.equalTo(superView.centerY).offset(-padding);
            make.bottom.equalTo(superView.bottom).offset(-padding);
        }];
        
        [self.typeLable makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_moneyLable.top);
            //make.left.lessThanOrEqualTo(_moneyLable.left);
            //make.right.lessThanOrEqualTo(_moneyLable.right);
            make.centerX.equalTo(_moneyLable.centerX);
            make.height.equalTo(20);
            make.width.lessThanOrEqualTo(_moneyLable.width);
        }];
        //
        //
        //        [self.imgView makeConstraints:^(MASConstraintMaker *make) {
        //            make.width.height.equalTo(22);
        //            make.centerY.equalTo(superView.centerY);
        //            make.left.equalTo(superView.left).offset(padding);
        //        }];
        //        [self.moneyLable makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.equalTo(superView.right).offset(-padding);
        //            make.top.bottom.equalTo(superView);
        //            make.width.lessThanOrEqualTo(65);
        //        }];
        //
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_moneyLable.right).offset(padding/2);
            make.right.equalTo(_imgView.left).offset(-padding/2);
            make.top.equalTo(superView.top).offset(padding);
            make.bottom.equalTo(superView.centerY);
        }];
        [self.desLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLable);
            make.top.equalTo(superView.centerY);
            make.bottom.equalTo(superView.bottom).offset(-padding);
        }];
        
    }
    return self;
}


-(void)loadDataWithItem:(CouponObject *)item
{
    
}


@end







@implementation UserCouponTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        self.backgroundColor = [UIColor clearColor];
        
        float padding = 10;
//        UIFont *font = [UIFont systemFontOfSize:14];
//        UIColor *color = [UIColor grayColor];
        UIView *superView = self.contentView;
        
        self.view = [[UserCouponTableView alloc] init];
        [superView addSubview:_view];
        
        [self.view makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
            make.top.equalTo(superView.top).offset(padding/2);
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
        }];
        
    }
    return self;
}


-(void)loadDataWithItem:(CouponObject *)item
{
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(CouponObject *)item{
    
    
    //        UIColor *bordColor = nil;
    //        NSString *typeStr = @"";
    //        if (indexPath.row == 0) {
    //            typeStr = @"满减券";
    //            bordColor = COLOR(253, 126, 0);
    //            cell.view.imgView.image = IMG(@"user_coupon_jushe.png");
    //            cell.view.statusLable.textColor = [UIColor whiteColor];
    //            cell.view.timeLable.textColor = [UIColor whiteColor];
    //
    //
    //        } else if (indexPath.row == 1) {
    //            typeStr = @"立减券2";
    //            bordColor = COLOR(253, 87, 88);
    //            cell.view.imgView.image = IMG(@"user_coupon_red.png");
    //            cell.view.statusLable.textColor = [UIColor whiteColor];
    //            cell.view.timeLable.textColor = [UIColor whiteColor];
    //
    //        } else {
    //            typeStr = @"立减券33";
    //            bordColor = COLOR(222, 222, 222);
    //            cell.view.imgView.image = IMG(@"user_coupon_gray.png");
    //            cell.view.statusLable.textColor = COLOR(150, 150, 150);
    //            cell.view.timeLable.textColor = COLOR(150, 150, 150);
    //        }

    
    UIColor *bordColor = nil;
    NSString *typeStr = item.cup_name;
    
    bordColor = COLOR(253, 126, 0);
    self.view.imgView.image = IMG(@"user_coupon_jushe.png");
    self.view.statusLable.textColor = [UIColor whiteColor];
    self.view.timeLable.textColor = [UIColor whiteColor];
    
    
    
    NSDictionary *attrs = @{NSFontAttributeName : self.view.typeLable.font};
    CGSize size = [typeStr sizeWithAttributes:attrs];
    [self.view.typeLable updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(size.width + 10);
    }];
    
    NSDictionary* style = @{@"body" : @[[UIFont systemFontOfSize:25], bordColor],
                            @"u" : @[[UIFont systemFontOfSize:14], COLOR(253, 156, 16)]};
    
    self.view.typeLable.text = typeStr;
    self.view.layer.borderColor = bordColor.CGColor;
    self.view.typeLable.layer.borderColor = bordColor.CGColor;
    self.view.typeLable.textColor = bordColor;
    self.view.moneyLable.attributedText = [@"20 <u>元</u>" attributedStringWithStyleBook:style];
    
    self.view.nameLable.text = [NSString compIsNone:item.cup_author];
    self.view.desLable.text = [NSString compIsNone:item.cup_content];
    self.view.timeLable.text = item.cuc_overdue;

}

- (void)setMCoup:(ZLPreOrderCoupons *)mCoup{

    //        UIColor *bordColor = nil;
    //        NSString *typeStr = @"";
    //        if (indexPath.row == 0) {
    //            typeStr = @"满减券";
    //            bordColor = COLOR(253, 126, 0);
    //            cell.view.imgView.image = IMG(@"user_coupon_jushe.png");
    //            cell.view.statusLable.textColor = [UIColor whiteColor];
    //            cell.view.timeLable.textColor = [UIColor whiteColor];
    //
    //
    //        } else if (indexPath.row == 1) {
    //            typeStr = @"立减券2";
    //            bordColor = COLOR(253, 87, 88);
    //            cell.view.imgView.image = IMG(@"user_coupon_red.png");
    //            cell.view.statusLable.textColor = [UIColor whiteColor];
    //            cell.view.timeLable.textColor = [UIColor whiteColor];
    //
    //        } else {
    //            typeStr = @"立减券33";
    //            bordColor = COLOR(222, 222, 222);
    //            cell.view.imgView.image = IMG(@"user_coupon_gray.png");
    //            cell.view.statusLable.textColor = COLOR(150, 150, 150);
    //            cell.view.timeLable.textColor = COLOR(150, 150, 150);
    //        }
    
    
    UIColor *bordColor = nil;
    NSString *typeStr = mCoup.cup_name;
    
    bordColor = COLOR(253, 126, 0);
    self.view.imgView.image = IMG(@"user_coupon_jushe.png");
    self.view.statusLable.textColor = [UIColor whiteColor];
    self.view.timeLable.textColor = [UIColor whiteColor];
    
    
    
    NSDictionary *attrs = @{NSFontAttributeName : self.view.typeLable.font};
    CGSize size = [typeStr sizeWithAttributes:attrs];
    [self.view.typeLable updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(size.width + 10);
    }];
    
    NSDictionary* style = @{@"body" : @[[UIFont systemFontOfSize:25], bordColor],
                            @"u" : @[[UIFont systemFontOfSize:14], COLOR(253, 156, 16)]};
    
    self.view.typeLable.text = typeStr;
    self.view.layer.borderColor = bordColor.CGColor;
    self.view.typeLable.layer.borderColor = bordColor.CGColor;
    self.view.typeLable.textColor = bordColor;
    self.view.moneyLable.attributedText = [@"20 <u>元</u>" attributedStringWithStyleBook:style];
    
    self.view.nameLable.text = [NSString compIsNone:mCoup.cup_author];
    self.view.desLable.text = [NSString compIsNone:mCoup.cup_content];
    self.view.timeLable.text = mCoup.cuc_overdue;

}

@end
