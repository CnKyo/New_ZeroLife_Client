//
//  BaoXiuGoodsView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

#import "APIObjectDefine.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface BaoXiuGoodsView : UIView

-(void)reloadUIWithItem:(OrderGoodsObject *)item;

@end
