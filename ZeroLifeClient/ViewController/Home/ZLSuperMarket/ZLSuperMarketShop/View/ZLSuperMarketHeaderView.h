//
//  ZLSuperMarketHeaderView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol ZLSuperMarketShopDelegate <NSObject>

@optional

/**
 优惠券按钮方法
 */
- (void)ZLSuperMarketCoupBtnSelected;

/**
 查看评价按钮
 */
- (void)ZLSuperMarketRateBtnSelected;

/**
 查看更多活动按钮
 */
- (void)ZLSuperMarketCheckMoreBtnSelected;

@end

@interface ZLSuperMarketHeaderView : UIView

/**
 背景图
 */
@property (weak, nonatomic) IBOutlet UIImageView *mBgkImg;

/**
 店铺logo
 */
@property (weak, nonatomic) IBOutlet UIImageView *mShopLogo;

/**
 评价view
 */
@property (weak, nonatomic) IBOutlet UIView *mRateView;

/**
 店铺内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
///店铺子内容
@property (weak, nonatomic) IBOutlet UILabel *mSubContent;


/**
 优惠券按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCoupBtn;

/**
 评价按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRateBtn;

/**
 活动view
 */
@property (weak, nonatomic) IBOutlet UIView *mActivityView;

/**
 查看更多按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCheckMoreBtn;

/**
 设置代理
 */
@property (strong, nonatomic) id<ZLSuperMarketShopDelegate>delegaate;

+ (ZLSuperMarketHeaderView *)shareView;

@end
