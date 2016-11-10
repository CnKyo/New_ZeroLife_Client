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
        UIFont *font = [UIFont systemFontOfSize:14];
        UIColor *color = [UIColor grayColor];
        UIView *superView = self.contentView;
        
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
        
        
        self.actionBtn1 = [superView newUIButton];
        self.actionBtn2 = [superView newUIButton];
        self.actionBtn1.titleLabel.font = font;
        self.actionBtn2.titleLabel.font = font;
        [self.actionBtn1 setTitle:@"取消支付" forState:UIControlStateNormal];
        [self.actionBtn2 setTitle:@"去支付" forState:UIControlStateNormal];
        [self.actionBtn1 setTitleColor:color forState:UIControlStateNormal];
        [self.actionBtn2 setTitleColor:color forState:UIControlStateNormal];
        
        
        [self.shopView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(superView);
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
            make.top.equalTo(lineView.bottom);
            make.height.equalTo(40);
        }];
        [self.actionBtn2 makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.right).offset(-padding);
            make.centerY.equalTo(_orderTimeLable.centerY);
            make.height.equalTo(30);
            make.width.equalTo(60);
        }];
        [self.actionBtn1 makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_actionBtn2.left).offset(-padding);
            make.top.bottom.width.equalTo(_actionBtn2);
            make.left.equalTo(_orderTimeLable.right).offset(padding/2);
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
        case kOrderClassType_goods:
        case kOrderClassType_ganxi:
            self.goodsListView.hidden = NO;
            self.goodsBaoxiuView.hidden = YES;
            self.goodsPaoPaoView.hidden = YES;
            break;
        case kOrderClassType_baoxiu:
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

@end
