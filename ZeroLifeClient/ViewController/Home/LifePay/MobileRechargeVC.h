//
//  MobileRechargeVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface MobileRechargeMoneyView : UIView
@property(nonatomic, strong) NSArray *arr;
@property(strong,nonatomic) NSString *chooseStr;

@property (nonatomic, copy) void (^chooseCallBack)(NSString* moneyStr);

- (id)initWithTitleArr:(NSArray *)arr;
@end


@interface MobileRechargeVC : CustomVC

@end
