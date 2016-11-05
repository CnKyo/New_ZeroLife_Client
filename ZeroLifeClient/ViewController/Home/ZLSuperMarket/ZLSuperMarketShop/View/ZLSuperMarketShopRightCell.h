//
//  ZLSuperMarketShopRightCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomDefine.h"


/**
 设置代理
 */
@protocol ZLSuperMarketGoodsCellDelegate <NSObject>

@optional


/**
 减按钮代理方法

 @param mIndexPath 索引
 */
- (void)ZLSuperMarketGoodsCellWithSubstructSelectedIndexPath:(NSIndexPath *)mIndexPath;

/**
 加按钮代理方法

 @param mIndexPath 索引
 */
- (void)ZLSuperMarketGoodsCellWithAddSelectedIndexPath:(NSIndexPath *)mIndexPath;

/**
 选择规格按钮代理方法

 @param mIndexPath 索引
 */
- (void)ZLSuperMarketGoodsCellWithSpecBtnSelectedIndexPath:(NSIndexPath *)mIndexPath;


@end

@interface ZLSuperMarketShopRightCell : UITableViewCell

/**
 商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoodsImg;

/**
 商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;

/**
 销量
 */
@property (weak, nonatomic) IBOutlet UILabel *mSailsNum;

/**
 商品价格
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mGoodsPrice;

/**
 商品库存
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mGoodsCount;

/**
 减按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSubtractBtn;

/**
 数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mNum;

/**
 加按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddBtn;

/**
 索引
 */
@property (strong,nonatomic) NSIndexPath *mIndexPath;

/**
 设置代理
 */
@property (strong,nonatomic) id <ZLSuperMarketGoodsCellDelegate>delegate;


#pragma mark----****----规格cell
@property (weak, nonatomic) IBOutlet UIButton *mSpecBtn;

@end
