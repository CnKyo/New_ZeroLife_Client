//
//  ZLSupMarketCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLCustomBtnView.h"
/**
 设置代理方法
 */
@protocol ZLSupermarketBannerCellDelegate <NSObject>

@optional

/**
 分类点击的代理方法
 
 @param mIndex 索引
 */
- (void)ZLSupermarketClassCellDidSelectedWithIndex:(NSInteger)mIndex;

/**
 baner的代理方法
 
 @param mIndex 索引
 */
- (void)ZLSupermarketBannerDidSelectedWithIndex:(NSInteger)mIndex;

@end
@interface ZLSupMarketCell : UITableViewCell
/**
 重设cell的重用方法
 
 @param style           cell类型
 @param reuseIdentifier 重用id
 @param mDataSource     数据源
 
 @return 返回cell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andBannerDataSource:(NSMutableArray *)mBannerDataSource andDataSource:(NSMutableArray *)mDataSource;

/**
 cell的代理
 */
@property (strong,nonatomic) id <ZLSupermarketBannerCellDelegate>delegate;
@end
