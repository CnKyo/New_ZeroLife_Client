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
#import "OrderActionBtnView.h"
#import "APIObjectDefine.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <JKCategories/UIButton+JKBlock.h>


@interface OrderTableViewCell : UITableViewCell
@property(nonatomic,strong) OrderShopHeaderView *shopView; //店铺信息view

@property(nonatomic,strong) OrderGoodsThumbListView *goodsListView; //正文商品信息view
@property(nonatomic,strong) BaoXiuGoodsView *goodsBaoxiuView; //正文报修信息view
@property(nonatomic,strong) PaoPaoGoodsView *goodsPaoPaoView; //正文跑跑信息view

@property(nonatomic,strong) UILabel *orderMoneyLable;    //订单金额lable
@property(nonatomic,strong) UILabel *orderTimeLable;    //订单时间lable
@property(nonatomic,strong) OrderButton *actionBtn1;       //订单按钮1 在最右边
@property(nonatomic,strong) OrderButton *actionBtn2;   //订单按钮2

@property(nonatomic,assign) kOrderClassType orderClassType;


-(void)reloadUIWithItem:(OrderObject *)item;

@end
