//
//  ChooseView.h
//  LvjFarm
//
//  Created by 张仁昊 on 16/4/14.
//  Copyright © 2016年 _____ZXHY_____. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol  ChooseViewDeleagate <NSObject>

@optional

/**
 数量加减

 @param mNum 返回数量
 */
- (void)wk_ChooseViewWithNum:(NSInteger)mNum;

/**
 加入购物车
 */
- (void)wk_AddShopCarClick;

/**
 立即购买
 */
- (void)wk_BuyNowClick;


@end

@interface ChooseView : UIView


@property(nonatomic,strong)UIView *alphaView;
@property(nonatomic,strong)UIView *whiteView;

@property(nonatomic,strong)UIImageView *headImage;

@property(nonatomic,strong)UILabel *LB_price;
@property(nonatomic,strong)UILabel *LB_stock;
@property(nonatomic,strong)UILabel *LB_detail;
@property(nonatomic,strong)UILabel *LB_line;
@property(nonatomic,strong)UILabel *LB_showSales;


@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *stock;
@property(nonatomic,copy)NSString *detail;
@property(nonatomic,copy)NSString *showSales;

@property(nonatomic,strong)UIScrollView *mainscrollview;


@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *buyBtn;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *stockBtn;

@property(nonatomic,assign) int typeCount;

@property(nonatomic,strong)UIButton *selectBtn;


-(instancetype)initWithFrame:(CGRect)frame;

@property (strong,nonatomic) id <ChooseViewDeleagate>delegate;

@end



