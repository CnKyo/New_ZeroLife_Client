//
//  ZLSuperMarketCommitOrderViewController.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface ZLSuperMarketCommitOrderViewController : CustomVC
///购物车数据源
@property (strong,nonatomic)ZLPreOrderObj *mPreOrder;

///店铺ID
@property (assign,nonatomic)int mShopId;

@end
