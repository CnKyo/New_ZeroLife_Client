//
//  DryCleanShopTVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface DryCleanShopTVC : CustomVC
///店铺类型（1超市 2报修 3干洗服务
@property (assign,nonatomic) ZLShopType mType;
@property (strong,nonatomic) NSString *mLat;
@property (strong,nonatomic) NSString *mLng;

@end
