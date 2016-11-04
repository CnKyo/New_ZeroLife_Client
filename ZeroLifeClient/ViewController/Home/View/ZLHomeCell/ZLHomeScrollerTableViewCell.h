//
//  ZLHomeScrollerTableViewCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/10/21.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLCustomBtnView.h"

/**
 设置代理方法
 */
@protocol ZLHomeScrollerTableCellDelegate <NSObject>

@optional

/**
 点击的代理方法

 @param mIndex 索引
 */
- (void)ZLHomeScrollerTableViewCellDidSelectedWithIndex:(NSInteger)mIndex;

/**
 baner的代理方法

 @param mIndex 索引
 */
- (void)ZLHomeBannerDidSelectedWithIndex:(NSInteger)mIndex;

@end

@interface ZLHomeScrollerTableViewCell : UITableViewCell

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
@property (strong,nonatomic) id <ZLHomeScrollerTableCellDelegate>delegate;

@end
