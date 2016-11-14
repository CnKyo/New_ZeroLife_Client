//
//  ZLRunningManHomeCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol ZLRunningManHomeCellDelegate <NSObject>

@optional

/**
 按钮点击代理方法

 @param mIndex 索引
 */
- (void)ZLRunningManHomeCellBtnClickedWithIndex:(NSInteger)mIndex;

@end
@interface ZLRunningManHomeCell : UITableViewCell

/**
 数据源
 */
@property (strong,nonatomic) NSArray *mDataSource;

/**
 设置代理
 */
@property (strong,nonatomic) id<ZLRunningManHomeCellDelegate>delegate;


@end
