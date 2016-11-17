//
//  ZLHouseKeepingHomeCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/17.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLCustomBtnView.h"
#import "CustomDefine.h"

/**
 设置代理
 */
@protocol ZLHouseKeepingHomeCellDelegate <NSObject>

@optional

/**
 分类点击代理方法

 @param mIndex 索引
 */
- (void)ZLHouseKeepingHomeCellWithTypeBtnClicked:(NSInteger)mIndex;
@end

@interface ZLHouseKeepingHomeCell : UITableViewCell

/**
 数据源
 */
@property (strong,nonatomic) NSArray *mDataSource;

/**
 设置代理
 */
@property (strong,nonatomic) id <ZLHouseKeepingHomeCellDelegate>delegate;


@end
