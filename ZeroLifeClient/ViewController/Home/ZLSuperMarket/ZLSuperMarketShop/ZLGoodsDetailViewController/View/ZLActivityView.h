//
//  ZLActivityView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol ZLActivityViewDelegate <NSObject>

@optional

/**
 关注
 */
- (void)ZLActivityViewFocusActionWithSelected:(BOOL)mSelected;

/**
 购物车
 */
- (void)ZLActivityViewShopCarAction;

/**
 加入购物车
 */
- (void)ZLActivityViewAddShopCarAction;

/**
 选好了
 */
- (void)ZLActivityViewChioseAction;

@end

@interface ZLActivityView : UIView

#pragma mark----****----活动小样式

/**
 活动标签
 */
@property (weak, nonatomic) IBOutlet UILabel *mActTitle;

/**
 活动说明
 */
@property (weak, nonatomic) IBOutlet UILabel *mActContent;

+ (ZLActivityView *)initWithActivityView;
#pragma mark----****----购物车小样式

/**
 关注
 */
@property (weak, nonatomic) IBOutlet UIButton *mFocusBtn;

/**
 购物车
 */
@property (weak, nonatomic) IBOutlet UIButton *mShopCarBtn;

/**
数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mNum;

/**
 加入购物车
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddShopCarBtn;

/**
 选好了
 */
@property (weak, nonatomic) IBOutlet UIButton *mChioseBtn;

/**
 设置代理
 */
@property (strong, nonatomic) id <ZLActivityViewDelegate>delegate;
+ (ZLActivityView *)initWithShopCarView;
@end
