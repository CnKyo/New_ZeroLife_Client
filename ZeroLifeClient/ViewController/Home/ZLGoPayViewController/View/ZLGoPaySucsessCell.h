//
//  ZLGoPaySucsessCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/18.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLGoPaySucsessCell : UITableViewCell

/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLogo;

/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
/**
 金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
/**
 状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
/**
 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 订单号
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderCode;
/**
 支付方式
 */
@property (weak, nonatomic) IBOutlet UILabel *mPayType;
/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;

@end
