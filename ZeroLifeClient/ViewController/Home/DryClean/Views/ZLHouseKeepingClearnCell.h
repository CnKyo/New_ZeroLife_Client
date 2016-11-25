//
//  ZLHouseKeepingClearnCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/25.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol ZLHouseKeepingClearnCellDelegate <NSObject>

@optional

/**
 分类点击方法

 @param mIndex 返回索引
 */
- (void)ZLHouseKeepingClearnCellWithCatigryDidSelectedIndex:(NSInteger)mIndex;

@end

@interface ZLHouseKeepingClearnCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDataSource:(NSMutableArray *)mDataSource;


/**
 分类数据源
 */
@property (strong,nonatomic) NSArray *mClassArr;

/**
 设置代理
 */
@property (strong,nonatomic) id<ZLHouseKeepingClearnCellDelegate>delegate;

@end
