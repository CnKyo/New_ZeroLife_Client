//
//  UserAddressTVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface UserAddressTVC : CustomVC

@property(nonatomic,assign) BOOL isChooseAddress; //yes选择地址界面，no地址管理界面
@property (nonatomic, copy) void (^chooseCallBack)(UserAddressObject* item);

@end
