//
//  ZLShopCarBottomView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 设置代理
 */
@protocol ZLShopCarBottomDelegate <NSObject>

@optional

/**
 全选按钮
 */
- (void)ZLShopCarBottomSelecteAllWithSelected:(BOOL)mSelected;

/**
 去结算
 */
- (void)ZLShopCarBottomGoPay;

@end

@interface ZLShopCarBottomView : UIView

/**
 全选
 */
@property (weak, nonatomic) IBOutlet UIButton *mSelecAllBtn;

/**
 去结算
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoPayBtn;

/**
 价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice;

/**
 设置代理
 */
@property (strong, nonatomic) id<ZLShopCarBottomDelegate> delegate;

/**
 初始化方法

 @return 返回view
 */
+ (ZLShopCarBottomView *)shareView;

@end
