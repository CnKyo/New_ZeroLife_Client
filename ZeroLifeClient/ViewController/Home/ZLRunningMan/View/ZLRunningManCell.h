//
//  ZLRunningManCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
#import "CustomDefine.h"
/**
 设置代理
 */
@protocol ZLRunningManCellDelegate <NSObject>

@optional

/**
 接单按钮的代理方法

 @param mIndexPath 索引
 */
- (void)ZLRunningManCellDelegateWithBtnClick:(NSIndexPath *)mIndexPath;

@end

@interface ZLRunningManCell : UITableViewCell

/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;

/**
 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;

/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;

/**
 价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;

/**
 接单按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mBtn;

/**
 距离
 */
@property (weak, nonatomic) IBOutlet UILabel *mDistance;

/**
 送出地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendAddress;

/**
 送达地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mArriveAddress;

/**
 索引
 */
@property (assign,nonatomic) NSIndexPath *mIndexPath;

/**
 设置代理
 */
@property (strong,nonatomic) id<ZLRunningManCellDelegate>delegate;

@property (strong,nonatomic) ZLRunningmanHomeOrder *mOrder;

@property (assign,nonatomic) int mType;


@end
