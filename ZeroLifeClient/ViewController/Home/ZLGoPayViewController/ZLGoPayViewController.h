//
//  ZLGoPayViewController.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface ZLGoPayViewController : CustomVC

@property (strong,nonatomic) ZLCreateOrderObj *mOrder;

///店铺ID
@property (assign,nonatomic)int mShopId;

///创建支付订单类型，通过此类型判断成功后跳转返回界面
@property (assign,nonatomic) kOrderClassType mOrderType;

///支付成功返回方法
@property (nonatomic, copy) void (^paySuccessCallBack)();

@end
