//
//  ZLSuperMarketShopCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
@interface ZLSuperMarketShopCell : UITableViewCell
#pragma mark----****----店铺cell样式
/**
 店铺图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mShopLogo;

/**
 店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mShopName;

/**
 距离
 */
@property (weak, nonatomic) IBOutlet UILabel *mDistance;

/**
 配送时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendTime;

/**
 销量
 */
@property (weak, nonatomic) IBOutlet UILabel *mSailsNum;
#pragma mark----****----店铺cell样式
/**
 活动类型1
 */
@property (weak, nonatomic) IBOutlet UIImageView *mActivityImage1;
#pragma mark----****----店铺cell样式
/**
 活动类型2
 */
@property (weak, nonatomic) IBOutlet UIImageView *mActivityImage2;

@property (strong,nonatomic) ZLShopHomeCampaign *mCampain;

@property (strong,nonatomic) ZLShopHomeShopObj *mShopObj;

@end
