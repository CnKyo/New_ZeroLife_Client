//
//  OrderTableViewCell.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"
#import "OrderGoodsThumbListView.h"
#import "BaoXiuGoodsView.h"
#import "PaoPaoGoodsView.h"
#import "OrderShopHeaderView.h"

@interface OrderTableViewCell : UITableViewCell
@property(nonatomic,strong) OrderShopHeaderView *shopView;

@property(nonatomic,strong) OrderGoodsThumbListView *goodsListView;
@property(nonatomic,strong) BaoXiuGoodsView *goodsBaoxiuView;
@property(nonatomic,strong) PaoPaoGoodsView *goodsPaoPaoView;

@property(nonatomic,strong) UILabel *orderMoneyLable;
@property(nonatomic,strong) UILabel *orderTimeLable;
@property(nonatomic,strong) UIButton *actionBtn1;
@property(nonatomic,strong) UIButton *actionBtn2;

@property(nonatomic,assign) kOrderClassType orderClassType;
@end
