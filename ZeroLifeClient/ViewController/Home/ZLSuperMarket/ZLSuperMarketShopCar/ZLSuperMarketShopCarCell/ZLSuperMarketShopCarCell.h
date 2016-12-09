//

//  ZLSuperMarketShopCarCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"


@class ZLSuperMarketShopCarCell;


/**
 设置代理
 */
@protocol ZLShopCarCellDelegate <NSObject>

@optional

/**
 左边选择按钮

 @param mSelected  是否选中
 @param mIndexPath 索引
 */
- (void)ZLShopCarSelectedBtnDidSelected:(BOOL)mSelected andIndexPath:(NSIndexPath *)mIndexPath;

/**
 删除按钮

 @param mIndexPath 索引
 */
- (void)ZLShopCarDeleteBtnDidSelectedWithIndexPath:(NSIndexPath *)mIndexPath;

/**
 减按钮

 @param mIndexPath 索引
 */
- (void)ZLShopCarSubstructBtnDidSelectedWithIndexPath:(NSIndexPath *)mIndexPath;

/**
 加按钮

 @param mIndexPath 索引
 */
- (void)ZLShopCarAddBtnDidSelectedWithIndexPath:(NSIndexPath *)mIndexPath;

@end

@interface ZLSuperMarketShopCarCell : UITableViewCell

/**
 选择图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mSelectedImg;


/**
 商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoodsImg;

/**
 商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;

/**
 商品内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsContent;

/**
 价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice;

/**
 删除按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mDeleteBtn;

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
 索引
 */
@property (assign,nonatomic) NSIndexPath *mIndexPAth;

@property (strong,nonatomic) LKDBHelperGoodsObj *mGoods;

/**
 设置代理
 */
@property (strong, nonatomic) id<ZLShopCarCellDelegate>delegate;

/** 每行cell的数据 */

@end
