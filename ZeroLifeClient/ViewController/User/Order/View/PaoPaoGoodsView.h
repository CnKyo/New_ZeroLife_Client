//
//  PaoPaoGoodsView.h
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

@interface PaoPaoGoodsView : UIView

-(void)reloadUIWithName:(NSString *)name msg:(NSString *)msg money:(float)money imgUrl:(NSString *)imgUrl;

@end
