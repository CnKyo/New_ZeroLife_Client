//
//  OrderBaoXiuChooseShopVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface OrderBaoXiuChooseShopVC : CustomVC
@property (nonatomic, copy) void (^chooseCallBack)(NSString* shopIdStr);
@end
