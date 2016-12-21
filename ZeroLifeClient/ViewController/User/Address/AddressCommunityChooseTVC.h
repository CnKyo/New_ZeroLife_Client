//
//  AddressCommunityChooseTVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/21.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "CustomVC.h"
#import <MAMapKit/MAMapKit.h>


@interface AddressCommunityChooseTVC : CustomVC
@property(nonatomic,strong) NSString *searchKey;
@property(nonatomic,assign) CLLocationCoordinate2D coo;

@property (nonatomic, copy) void (^chooseCallBack)(AddressObject* item); // 选择的地址信息

@property (nonatomic, copy) void (^scrollCallBack)(); //如果视图有滚动

@end
