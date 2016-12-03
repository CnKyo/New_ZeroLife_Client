//
//  ZLGoodsDetailCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"

/**
 设置代理
 */
@protocol ZLGoodsDetailDelegate <NSObject>

@optional

/**
 查看规格
 */
- (void)ZLGoodsDetailSpecAction;

@end

@interface ZLGoodsDetailCell : UITableViewCell

/**
 banerview
 */
@property (weak, nonatomic) IBOutlet UIView *mBanerView;

/**
 商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;

/**
 商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsPrice;

/**
 销量
 */
@property (weak, nonatomic) IBOutlet UILabel *mSailsNum;

/**
 配送费
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendPrice;

/**
 事件
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;

/**
 活动
 */
@property (weak, nonatomic) IBOutlet UIView *mActivityView;

/**
 规格
 */
@property (weak, nonatomic) IBOutlet UIButton *mSpecBtn;

/**
 储货地
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsAddress;

/**
 关注数
 */
@property (weak, nonatomic) IBOutlet UILabel *mFocusNum;

/**
 状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsStatus;

/**
 设置代理
 */
@property (strong, nonatomic) id <ZLGoodsDetailDelegate>delegate;

/**
 banner数据源
 */
@property (strong, nonatomic) NSMutableArray *mBanerDataSource;

/**
 活动数据源
 */
@property (strong, nonatomic) NSArray *mActivityDataSource;

@property (assign,nonatomic) CGFloat mCellH;

@property (assign,nonatomic) ZLGoodsDetail *mGoodsDetail;



@end
