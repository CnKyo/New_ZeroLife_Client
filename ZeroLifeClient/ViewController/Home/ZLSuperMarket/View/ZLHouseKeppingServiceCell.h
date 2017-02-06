//
//  ZLHouseKeppingServiceCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/17.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
/**
 设置代理
 */
@protocol ZLHouseKeppingServiceCellDelegate <NSObject>

@optional

- (void)ZLHouseKeppingServiceCellWithNumChanged:(int)mNum andIndexPath:(NSIndexPath *)mIndexPath;


/**
 加按钮代理方法

 @param mIndexPath 索引
 */
- (void)ZLHouseKeepingAddBtnClicked:(NSIndexPath *)mIndexPath;

/**
 减按钮代理方法

 @param mIndexPath 索引
 */
- (void)ZLHouseKeepingSubstructBtnClicked:(NSIndexPath *)mIndexPath;

/**
 加减代理方法
 @param mType       按钮类型: 1 加  2是减
 @param mNum       数量
 @param mIndexPath 索引
 */
- (void)ZLHouseKeppingServiceCellWithNumChanged:(int)mType andNum:(int)mNum andIndexPath:(NSIndexPath *)mIndexPath;

@end

@interface ZLHouseKeppingServiceCell : UITableViewCell

/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;

/**
 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;

/**
 销量
 */
@property (weak, nonatomic) IBOutlet UILabel *mSailsNum;

@property (weak, nonatomic) IBOutlet UILabel *mGoodsPrice;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

/**
 数量view
 */
@property (weak, nonatomic) IBOutlet UIView *mNumView;

/**
 索引
 */
@property (strong,nonatomic) NSIndexPath *mIndexPath;

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
 设置代理
 */
@property (assign,nonatomic) id<ZLHouseKeppingServiceCellDelegate>delegate;

@property (strong,nonatomic) ZLGoodsWithCamp *mGoodsObj;


@end
