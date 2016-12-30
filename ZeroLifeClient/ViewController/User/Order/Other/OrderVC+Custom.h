//
//  OrderVC+Custom.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/29.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIClient.h"
#import <BlocksKit/NSObject+BKAssociatedObjects.h>

#import "OrderBaoXiuChooseShopVC.h"
#import "ZLGoPayViewController.h"
#import "OrderMainTainVC.h"
#import "SecurityPasswordVC.h"
#import "ZLRatingViewController.h"


#define USER_FIX_CHOOSE_BID_Key @"bidkey"

@interface  UIViewController (OrderVC_Custom)

//处理订单逻辑
-(void)loadAPIwithState:(NSString *)stateStr orderItem:(OrderObject *)item isShopOrderBool:(BOOL)isShopOrderBool call:( void(^)(OrderObject *itemNew))callback;

@end
