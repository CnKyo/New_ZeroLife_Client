//
//  ZLCommitOrderHeaderView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WPHotspotLabel.h"

/**
 设置代理
 */
@protocol ZLCommitOrderDelegate <NSObject>

@optional

/**
 选择收获地址
 */
- (void)ZLCommitSelectAddress;

/**
 去支付
 */
- (void)ZLCommitGopay;

@end

@interface ZLCommitOrderHeaderView : UIView
#pragma mark----****----header样式

/**
 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

/**
 选择按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSelecteBtn;

/**
 初始化headerview

 @return 返回view
 */
+ (ZLCommitOrderHeaderView *)initWithHeder;


#pragma mark----****----bottom样式

/**
 总价
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mTotelPrice;

/**
 去支付
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoPayBtn;

/**
 初始化bottom

 @return 返回view
 */
+ (ZLCommitOrderHeaderView *)initWithBottom;

@property (strong, nonatomic) id<ZLCommitOrderDelegate>delegate;

#pragma mark----****----店铺样式

/**
 店铺logo
 */
@property (weak, nonatomic) IBOutlet UIImageView *mShopLogo;

/**
 店铺名称
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mShopName;

+ (ZLCommitOrderHeaderView *)initWithShopSection;


@end
