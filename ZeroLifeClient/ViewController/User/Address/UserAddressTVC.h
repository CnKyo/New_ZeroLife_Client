//
//  UserAddressTVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface UserAddressTVC : CustomVC
@property(nonatomic,assign) BOOL isShowHouseView; //yes房屋管理，no地址管理
@property(nonatomic,assign) BOOL isChooseAddress; //yes选择地址界面，no地址管理界面

@property(nonatomic,strong) AddressObject* oldAdrItem; //原界面传入的选择地址

@property (nonatomic, copy) void (^chooseCallBack)(AddressObject* item);
/**
 *  回调方法  返回经纬度，id
 */
@property (nonatomic,strong) void(^block)(AddressObject *mAddress);
@end
