//
//  ZLSuperMarketViewController.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface ZLSuperMarketViewController : CustomVC

///店铺类型（1超市 2报修 3干洗服务
@property (assign,nonatomic) ZLShopType mType;
@property (strong,nonatomic) NSString *mLat;
@property (strong,nonatomic) NSString *mLng;

@end
