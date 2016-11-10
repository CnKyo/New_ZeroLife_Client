//
//  OrderGoodsDetailVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomScrollVC.h"

@interface OrderDetailVC : CustomScrollVC
@property(nonatomic,assign) kOrderClassType classType;
@property(nonatomic,strong) OrderObject *item;
@end
