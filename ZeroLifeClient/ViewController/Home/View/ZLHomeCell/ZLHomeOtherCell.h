//
//  ZLHomeOtherCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/2.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomDefine.h"
/**
 设置代理
 */
@protocol ZLHomeOtherCellDelegate <NSObject>

@optional

/**
 点击代理方法

 @param mIndex 索引
 */
- (void)ZLHomeOtherCellFuncDidSelectedWithIndex:(NSInteger)mIndex;

@end

@interface ZLHomeOtherCell : UITableViewCell
/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImage;

/**
 设置代理
 */
@property (strong,nonatomic) id<ZLHomeOtherCellDelegate>delegate;

/**
 设置数据源
 */
@property (strong,nonatomic) NSArray *mDataSource;

@end
