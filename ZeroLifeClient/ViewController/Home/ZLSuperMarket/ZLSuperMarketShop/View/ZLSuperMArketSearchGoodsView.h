//
//  ZLSuperMArketSearchGoodsView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
/**
 设置代理
 */
@protocol ZLSuperMarketGoodsSpecDelegate <NSObject>

@optional

/**
 关闭按钮
 */
- (void)ZLSuperMarketCloseBtnSelected;

/**
 添加按钮
 */
- (void)ZLSuperMarketAddBtnSelected:(NSIndexPath *)mIndexPath;

/**
 减按钮
 */
- (void)ZLSuperMarketSubsructBtnSelected:(NSIndexPath *)mIndexPath;

/**
 购物车按钮
 */
- (void)ZLSuperMarketShopCarBtnSelected:(NSIndexPath *)mIndexPath;

/**
 立即购买代理方法
 */
- (void)ZLSuperMarketBuyNowBtnSelected:(NSIndexPath *)mIndexPath;

@end

@interface ZLSuperMArketSearchGoodsView : UIView
#pragma mark----****---- 搜索框view
@property (weak, nonatomic) IBOutlet UITextField *mSearchTx;

+ (ZLSuperMArketSearchGoodsView *)shareView;

#pragma mark----****---- 规格view

/**
 关闭按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCloseBtn;

/**
 商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoodsImg;

/**
 商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;

/**
 商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsPrice;

/**
 商品库存
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsRep;

/**
 规格view
 */
@property (weak, nonatomic) IBOutlet UIView *mGoodsSpeScrollView;

/**
 减按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSubstructBtn;

/**
 数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mNum;

/**
 加按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddBtn;

/**
 确认购物车按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;
/**
 立即购买
 */
@property (weak, nonatomic) IBOutlet UIButton *mBuyNowBtn;

@property (strong,nonatomic) ZLGoodsWithClass *mModel;
@property (assign,nonatomic) NSIndexPath *mIndexPath;


/**
 
初始化方法
 @param mFrame         frame

 @return 返回view
 */
+ (ZLSuperMArketSearchGoodsView *)initWithSpeView:(CGRect)mFrame;

@property (strong, nonatomic) id<ZLSuperMarketGoodsSpecDelegate>delegate;

@end
