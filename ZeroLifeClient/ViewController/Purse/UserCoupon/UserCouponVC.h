//
//  UserCouponVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"
#import "APIClient.h"

@interface UserCouponVC : CustomVC
@property (nonatomic, copy) void (^chooseCallBack)(CouponObject* item);
@end