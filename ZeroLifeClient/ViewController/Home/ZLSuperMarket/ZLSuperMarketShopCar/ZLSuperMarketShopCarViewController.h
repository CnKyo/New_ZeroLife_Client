//
//  ZLSuperMarketShopCarViewController.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface ZLSuperMarketShopCarViewController : CustomVC
/**
 页面类型：1是超市2是家政
 */
@property (assign,nonatomic) kOrderClassType mType;
///店铺ID
@property (assign,nonatomic)int mShopId;

///购物车数组
@property (strong,nonatomic) NSArray *mShopCarArr;
///店铺最低起送价
@property (assign,nonatomic)float mShopMinSendPrice;


@end
