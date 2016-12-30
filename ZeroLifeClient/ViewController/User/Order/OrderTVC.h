//
//  OrderTVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface OrderTVC : CustomVC
@property(nonatomic,assign) kOrderClassType classType; //订单类型
@property(nonatomic,assign) BOOL isShopOrderBool; //是否为店铺订单，no为用户订单，yes为服务者订单
@end
