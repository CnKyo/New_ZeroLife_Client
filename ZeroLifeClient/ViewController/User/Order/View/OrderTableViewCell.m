//
//  OrderTableViewCell.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:13];
        UIColor *color = [UIColor colorWithWhite:0.3 alpha:1];
        UIView *superView = self.contentView;
        
        UIView *mLineView = [UIView new];
        mLineView.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.96 alpha:1.00];
        [superView addSubview:mLineView];
        
        self.shopView = [[OrderShopHeaderView alloc] init];
        [superView addSubview:_shopView];
//        self.shopIconImgView = [superView newUIImageViewWithImg:IMG(@"choose_on.png")];
//        self.shopNameLable = [superView newUILableWithText:@"超尔店铺" textColor:color font:font];
//        self.orderStatusLable = [superView newUILableWithText:@"待支付" textColor:COLOR(254, 102, 0) font:font textAlignment:NSTextAlignmentRight];
        
        
        self.goodsListView = [[OrderGoodsThumbListView alloc] init];
        [superView addSubview:_goodsListView];
        
        self.goodsBaoxiuView = [[BaoXiuGoodsView alloc] init];
        [superView addSubview:_goodsBaoxiuView];
        
        self.goodsPaoPaoView = [[PaoPaoGoodsView alloc] init];
        [superView addSubview:_goodsPaoPaoView];
        
        
        self.orderMoneyLable = [superView newUILableWithText:@"合计：￥30.00 (含运费￥0.00)" textColor:color font:font textAlignment:NSTextAlignmentRight];
        UIView *lineView = [superView newDefaultLineView];
        self.orderTimeLable = [superView newUILableWithText:@"创建时间：2016-10-24 10:00" textColor:color font:font];
        self.orderTimeLable.numberOfLines = 0;
        
        
        self.actionBtn1 = [OrderButton buttonWithType:UIButtonTypeCustom];
        self.actionBtn2 = [OrderButton buttonWithType:UIButtonTypeCustom];
        self.actionBtn1.titleLabel.font = font;
        self.actionBtn2.titleLabel.font = font;
        self.actionBtn1.layer.borderColor = color.CGColor;
        self.actionBtn2.layer.borderColor = color.CGColor;
        self.actionBtn1.layer.borderWidth = 1;
        self.actionBtn2.layer.borderWidth = 1;
        self.actionBtn1.layer.cornerRadius = 3;
        self.actionBtn2.layer.cornerRadius = 3;
        [self.actionBtn1 setTitle:@"取消支付" forState:UIControlStateNormal];
        [self.actionBtn2 setTitle:@"去支付" forState:UIControlStateNormal];
        [self.actionBtn1 setTitleColor:color forState:UIControlStateNormal];
        [self.actionBtn2 setTitleColor:color forState:UIControlStateNormal];
        [superView addSubview:_actionBtn1];
        [superView addSubview:_actionBtn2];
        
        [mLineView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(superView);
            make.height.equalTo(@10);
        }];
        
        [self.shopView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
            make.top.equalTo(mLineView.bottom).offset(@0);
            make.height.equalTo(40);
        }];
        
//        [self.shopIconImgView makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(superView.left).offset(padding);
//            make.centerY.equalTo(_shopNameLable.centerY);
//            make.width.height.equalTo(20);
//        }];
//        [self.shopNameLable makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_shopIconImgView.right).offset(padding/2);
//            make.top.equalTo(superView.top);
//            make.height.equalTo(40);
//        }];
//        [self.orderStatusLable makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(_shopNameLable);
//            make.right.equalTo(superView.right).offset(-padding);
//            make.width.lessThanOrEqualTo(65);
//            make.left.equalTo(_shopNameLable.right).offset(padding/2);
//        }];
        
        
        [self.goodsListView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
            make.top.equalTo(_shopView.bottom);
            make.height.equalTo(80);
        }];
        [self.goodsBaoxiuView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_goodsListView);
        }];
        [self.goodsPaoPaoView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_goodsListView);
        }];
        
        [self.orderMoneyLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.right.equalTo(superView.right).offset(-padding);
            make.top.equalTo(_goodsListView.bottom);
            make.height.equalTo(30);
        }];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
            make.top.equalTo(_orderMoneyLable.bottom);
            make.height.equalTo(OnePixNumber);
        }];
        [self.orderTimeLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.right.equalTo(_actionBtn2.left).offset(-padding);
            make.top.equalTo(lineView.bottom);
            make.height.equalTo(50);
        }];
        [self.actionBtn1 makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.right).offset(-padding);
            make.centerY.equalTo(_orderTimeLable.centerY);
            make.height.equalTo(30);
            make.width.equalTo(60);
        }];
        [self.actionBtn2 makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_actionBtn1.left).offset(-padding);
            make.top.bottom.width.equalTo(_actionBtn1);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOrderClassType:(kOrderClassType)orderClassType
{
    _orderClassType = orderClassType;
    
    switch (orderClassType) {
        case kOrderClassType_product:
        case kOrderClassType_dryclean:
            self.goodsListView.hidden = NO;
            self.goodsBaoxiuView.hidden = YES;
            self.goodsPaoPaoView.hidden = YES;
            break;
        case kOrderClassType_fix:
            self.goodsListView.hidden = YES;
            self.goodsBaoxiuView.hidden = NO;
            self.goodsPaoPaoView.hidden = YES;
            break;
        case kOrderClassType_paopao:
            self.goodsListView.hidden = YES;
            self.goodsBaoxiuView.hidden = YES;
            self.goodsPaoPaoView.hidden = NO;
            break;
        default:
            break;
    }
}

-(void)reloadUIWithItem:(OrderObject *)item
{
    
    //设置店铺信息
    self.shopView.shopNameLable.text = [NSString compIsNone:item.shop_name];
    self.shopView.orderStatusLable.text = [NSString compIsNone:item.odr_state_val];
    [self.shopView.shopIconImgView setImageWithURL:[NSURL imageurl:item.shop_logo] placeholderImage:IMG(@"order_shop_icon.png")];
    
    self.orderTimeLable.text = item.odr_add_time;
    
    
    //设置商品信息
    switch (item.odr_type) {
        case kOrderClassType_product:
        case kOrderClassType_dryclean:
            self.goodsListView.hidden = NO;
            self.goodsBaoxiuView.hidden = YES;
            self.goodsPaoPaoView.hidden = YES;
        {
            if (item.goods.count > 0) {
                OrderGoodsObject *it = [item.goods objectAtIndex:0];
                [self.goodsListView.imgView1 setImageWithURL:[NSURL imageurl:it.odrg_img] placeholderImage:ZLDefaultGoodsImg];
                self.goodsListView.imgView1.hidden = NO;
            } else
                self.goodsListView.imgView1.hidden = YES;
            
            if (item.goods.count > 1) {
                OrderGoodsObject *it = [item.goods objectAtIndex:1];
                [self.goodsListView.imgView2 setImageWithURL:[NSURL imageurl:it.odrg_img] placeholderImage:ZLDefaultGoodsImg];
                self.goodsListView.imgView2.hidden = NO;
            } else
                self.goodsListView.imgView2.hidden = YES;
            
            if (item.goods.count > 2) {
                OrderGoodsObject *it = [item.goods objectAtIndex:2];
                [self.goodsListView.imgView3 setImageWithURL:[NSURL imageurl:it.odrg_img] placeholderImage:ZLDefaultGoodsImg];
                self.goodsListView.imgView3.hidden = NO;
            } else
                self.goodsListView.imgView3.hidden = YES;
            
            self.goodsListView.countLable.text = [NSString stringWithFormat:@"共%lu件", (unsigned long)item.goods.count];
            self.orderMoneyLable.text = [NSString stringWithFormat:@"合计：￥%.2f (含运费￥%.2f)", item.odr_amount, item.odr_deliver_fee];
        }
            break;
        case kOrderClassType_fix:
            self.goodsListView.hidden = YES;
            self.goodsBaoxiuView.hidden = NO;
            self.goodsPaoPaoView.hidden = YES;
        {
            OrderGoodsObject *it = [OrderGoodsObject new];
            if (item.goods.count > 0)
                it = [item.goods objectAtIndex:0];
            
            [self.goodsBaoxiuView reloadUIWithItem:it];
            
            self.orderMoneyLable.text = [NSString stringWithFormat:@"合计：￥%.2f", item.odr_amount];
        }
            break;
        case kOrderClassType_paopao:
            self.goodsListView.hidden = YES;
            self.goodsBaoxiuView.hidden = YES;
            self.goodsPaoPaoView.hidden = NO;
        {
            OrderGoodsObject *it = [OrderGoodsObject new];
            if (item.goods.count > 0)
                it = [item.goods objectAtIndex:0];
            
            self.shopView.shopNameLable.text = [NSString compIsNone:it.odrg_pro_name];
            [self.goodsPaoPaoView reloadUIWithName:it.odrg_spec msg:item.odr_remark money:it.odrg_price imgUrl:it.odrg_img];
            
            self.orderMoneyLable.text = [NSString stringWithFormat:@"合计：￥%.2f", item.odr_amount];
        }
            break;
        default:
            break;
    }

    
    
    //设置按钮显示信息
    if (item.odr_state_next.count > 0) {
        self.actionBtn1.hidden = NO;
        NSString *stateStr = [item.odr_state_next objectAtIndex:0];
        self.actionBtn1.stateStr = stateStr;
    } else {
        self.actionBtn1.hidden = YES;
        self.actionBtn1.stateStr = @"";
    }
    
    if (item.odr_state_next.count > 1) {
        self.actionBtn2.hidden = NO;
        NSString *stateStr = [item.odr_state_next objectAtIndex:1];
        self.actionBtn2.stateStr = stateStr;
    } else {
        self.actionBtn2.hidden = YES;
        self.actionBtn2.stateStr = @"";
    }

    
}


@end
