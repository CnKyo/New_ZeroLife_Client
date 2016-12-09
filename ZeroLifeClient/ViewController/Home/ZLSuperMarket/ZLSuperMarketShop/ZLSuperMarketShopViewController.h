//
//  ZLSuperMarketShopViewController.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface ZLSuperMarketShopViewController : CustomVC

/**
 页面类型：1是超市2是家政
 */
@property (assign,nonatomic) ZLShopType mType;
@property (strong,nonatomic) ZLShopHomeShopObj *mShopObj;
@end
