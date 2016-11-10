//
//  OrderGoodsView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface OrderGoodsView : UIView
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UILabel *sizeLable;
@property(nonatomic,strong) UILabel *countLable;
@end
