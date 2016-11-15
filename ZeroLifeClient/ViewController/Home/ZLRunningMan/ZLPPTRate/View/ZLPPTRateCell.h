//
//  ZLPPTRateCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLPPTRateCell : UITableViewCell

#pragma mark----****----cell第一种样式

/**
 好评view
 */
@property (weak, nonatomic) IBOutlet UIView *mGoodsRateView;

/**
 中评view
 */
@property (weak, nonatomic) IBOutlet UIView *mMidRateView;

/**
 差评view
 */
@property (weak, nonatomic) IBOutlet UIView *mBadRateView;

/**
 好评数
 */
@property (assign,nonatomic) CGFloat mGoodsRate;

/**
 中评数
 */
@property (assign,nonatomic) CGFloat mMidRate;

/**
 差评数
 */
@property (assign,nonatomic) CGFloat mBadRate;

#pragma mark----****----cell第一种样式

/**
 头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeaderImg;

/**
 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;

/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;


@end
