//
//  ZLRepairsDetailViewController.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface ZLRepairsDetailViewController : CustomVC
///子类对象
@property (strong,nonatomic) ZLFixSubExtObj *mClassObj;
///父类对象
@property (strong,nonatomic) ZLFixClassExtObj *mParentObj;

@end
