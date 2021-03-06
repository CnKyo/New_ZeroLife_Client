//
//  ZLPPTMyOrderCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"

/**
 设置代理
 */
@protocol ZLPPTMyOrderCellDelegate <NSObject>

@optional

/**
 按钮的代理方法
 
 @param mIndexPath 返回索引
 */
- (void)ZLPPTMyOrderCellLeftBtnWithClicked:(NSIndexPath *)mIndexPath;

/**
 按钮的代理方法

 @param mIndexPath 返回索引
 */
- (void)ZLPPTMyOrderCellRightBtnWithClicked:(NSIndexPath *)mIndexPath;

@end

@interface ZLPPTMyOrderCell : UITableViewCell

/**
 类型
 */
@property (weak, nonatomic) IBOutlet UILabel *mType;

/**
 状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mStatus;

/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLogo;

/**
 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

/**
 酬金
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;

/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;


/**
 左边的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mLeftBtn;
/**
 右边的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRightBtn;

/**
 索引
 */
@property (assign, nonatomic) NSIndexPath *mIndexPath;

/**
 设置代理
 */
@property (strong, nonatomic) id<ZLPPTMyOrderCellDelegate>delegate;

@property (strong,nonatomic) OrderObject *mOrder;

@end
