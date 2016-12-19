//
//  UserCouponTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"
#import "APIObjectDefine.h"

@interface UserCouponTableView : UIView
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *typeLable; //优惠方式
@property(nonatomic,strong) UILabel *moneyLable; //优惠金额
@property(nonatomic,strong) UILabel *nameLable; //优惠发放人
@property(nonatomic,strong) UILabel *desLable;  //优惠描述
@property(nonatomic,strong) UILabel *timeLable; //截止时间
@property(nonatomic,strong) UILabel *statusLable; //使用状态
@end


@interface UserCouponTableViewCell : UITableViewCell
@property(nonatomic,strong) UserCouponTableView *view;


@property(nonatomic,strong) CouponObject *item;

@property(nonatomic,strong) ZLPreOrderCoupons *mCoup;


@end
