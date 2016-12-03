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

/**
 加减代理方法

 @param mNum       数量
 @param mIndexPath 索引
 */
- (void)ZLHouseKeppingServiceCellWithNumChanged:(int)mNum andIndexPath:(NSIndexPath *)mIndexPath;

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
 设置代理
 */
@property (assign,nonatomic) id<ZLHouseKeppingServiceCellDelegate>delegate;

@property (strong,nonatomic) ZLGoodsWithCamp *mGoodsObj;


@end
