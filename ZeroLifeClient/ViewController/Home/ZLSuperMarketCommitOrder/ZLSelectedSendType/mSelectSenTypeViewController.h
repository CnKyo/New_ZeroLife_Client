//
//  mSelectSenTypeViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "CustomVC.h"

@interface mSelectSenTypeViewController : CustomVC


@property (nonatomic,strong) void(^block)(ZLShopSendType mSendType);

@end
