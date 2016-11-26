//
//  ZLSelectedCityViewController.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/26.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "CustomVC.h"

@interface ZLSelectedCityViewController : CustomVC

@property (strong,nonatomic) NSString *mTitle;
///跳转类型：1是省 2是市 3是区县
@property (assign,nonatomic) int mType;


@end
