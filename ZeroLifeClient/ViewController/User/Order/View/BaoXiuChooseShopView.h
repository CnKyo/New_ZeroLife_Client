//
//  BaoXiuChooseShopView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"
#import "APIObjectDefine.h"

@interface BaoXiuChooseShopView : UIControl
@property(nonatomic,strong) UILabel *noteLable;

-(void)reloadWithCount:(int)count chooseItem:(OrderRepairBidObject *)item;

@end
