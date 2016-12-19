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
///进入优惠卷页面类型
@property (assign,nonatomic) ZLPushCouponVCType mPushType;

@property (nonatomic, copy) void (^chooseCallBack)(CouponObject* item);


@property (nonatomic, copy) void (^block)(ZLPreOrderCoupons *mCoupon);

@property (nonatomic, strong) NSArray *mCoupArr;

@end


//调用示例
//UserCouponVC *vc = [[UserCouponVC alloc] init];
//vc.tableArr = arr;
//vc.chooseCallBack = ^(CouponObject* item) {
//    
//};
//[self.navigationController pushViewController:vc animated:YES];
