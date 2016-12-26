//
//  OrderGoodsDetailVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderAddressView.h"
#import "OrderBeizhuView.h"
#import "OrderShopHeaderView.h"
#import "OrderGoodsView.h"
#import "OrderNoteValueView.h"
#import "OrderActionBtnView.h"
#import "PaoPaoGoodsView.h"
#import "OrderBaoxiuImgVideoView.h"
#import "BaoXiuGoodsView.h"
#import "BaoXiuChooseShopView.h"
#import "BaoXiuWorkerView.h"
#import "BaoXiuShopNoteView.h"
#import "OrderHeaderStatusView.h"

#import "OrderBaoXiuChooseShopVC.h"
#import <JKCategories/UIControl+JKActionBlocks.h>

@interface OrderDetailVC ()
//@property(nonatomic,strong) OrderAddressView *addressView;
//@property(nonatomic,strong) OrderBeizhuView *beizhuView;
@end

@implementation OrderDetailVC


-(void)loadView
{
    [super loadView];
    
    
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHeaderRefreshing];
    }];
    self.scrollView.mj_header = header;
    
    [header setTitle:@"" forState:MJRefreshStateIdle];
    [header setTitle:@"" forState:MJRefreshStatePulling];
    [header setTitle:@"" forState:MJRefreshStateRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    [self.scrollView.mj_header beginRefreshing];
    //[self donwData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViews
{
    UIView *superView = self.contentView;
    UIView *lastView = nil;
    int padding = 10;
    
    OrderHeaderStatusView *statusView = [[OrderHeaderStatusView alloc] init];
    [statusView loadStatus:[NSString compIsNone:_item.odr_state_val] note:@"剩余3小时自动关闭"];
    [superView addSubview:statusView];
    [statusView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.height.equalTo(100);
        //make.height.equalTo(statusView.width).multipliedBy(0.25);
    }];
    
    
    UIView *lineView1 = [superView newDefaultLineView];
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(statusView.bottom);
        make.height.equalTo(OnePixNumber);
    }];
    
    //[NSString stringWithFormat:@"%@  %@", _item.odr_ext.odr_deliver_name, _item.odr_ext.odr_deliver_phone];
    if (_classType==kOrderClassType_product || _classType==kOrderClassType_dryclean || _classType==kOrderClassType_fix) {
        
        OrderAddressView *addressView = [[OrderAddressView alloc] initWithNote:nil name:[NSString stringWithFormat:@"%@  %@", _item.odr_deliver_name, _item.odr_deliver_phone] address:[NSString compIsNone:_item.odr_deliver_address]];
        [superView addSubview:addressView];
        [addressView updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
            make.top.equalTo(lineView1.bottom);
            //make.height.equalTo(80);
            //make.height.equalTo(_addressView.width).multipliedBy(0.3);
        }];
        lastView = addressView;
        
    } else if (_classType == kOrderClassType_paopao) {
        OrderAddressView *addressView1 = [[OrderAddressView alloc] initWithNote:@"取货地址" name:[NSString stringWithFormat:@"%@  %@", _item.odr_deliver_name, _item.odr_deliver_phone] address:[NSString compIsNone:_item.odr_deliver_address]];
        OrderAddressView *addressView2 = [[OrderAddressView alloc] initWithNote:@"送货地址" name:nil address:[NSString compIsNone:_item.odr_pick_address]];
        [superView addSubview:addressView1];
        [superView addSubview:addressView2];
        [addressView1 updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
            make.top.equalTo(lineView1.bottom);
        }];
        [addressView2 updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
            make.top.equalTo(addressView1.bottom);
        }];
        lastView = addressView2;
    }

    
    OrderBeizhuView *beizhuView = [[OrderBeizhuView alloc] init];
    beizhuView.beizhuLable.text = [NSString compIsNone:_item.odr_remark];
    [superView addSubview:beizhuView];
    [beizhuView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(lastView.bottom);
        //make.height.equalTo(80);
        //make.height.equalTo(_beizhuView.width).multipliedBy(0.3);
    }];
    lastView = beizhuView;
    
    
    if (_classType==kOrderClassType_product || _classType==kOrderClassType_dryclean) {
        UIView *shopGoodsView = ({
            UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
            
            OrderShopHeaderView *shopView = [[OrderShopHeaderView alloc] init];
            [view addSubview:shopView];
            [shopView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(view);
                make.height.equalTo(40);
            }];
            
            //加载店铺信息
            [shopView reloadUIWithShopName:_item.shop_name shopLogo:_item.shop_logo orderStatus:_item.odr_state_val];
            
            lastView = nil;
            for (int i=0; i<_item.goods.count; i++) {
                OrderGoodsView *itemView = [[OrderGoodsView alloc] init];
                [view addSubview:itemView];
                [itemView makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(view);
                    make.height.equalTo(80);
                    //make.height.equalTo(itemView.width).multipliedBy(0.35);
                    if (lastView == nil)
                        make.top.equalTo(shopView.bottom);
                    else
                        make.top.equalTo(lastView.bottom).offset(padding/2);
                    
                }];
                
                //加载商品清单数据
                OrderGoodsObject *it = [_item.goods objectAtIndex:i];
                [itemView reloadUIWithItem:it];
                
                lastView = itemView;
            }
            
            UIView *lineView111 = [view newDefaultLineView];
            [lineView111 makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(view);
                make.top.equalTo(lastView.bottom).offset(padding);
                make.height.equalTo(OnePixNumber);
            }];
            
    
            OrderNoteValueView *peisongView = [[OrderNoteValueView alloc] init];
            OrderNoteValueView *youhuiView = [[OrderNoteValueView alloc] init];
            OrderNoteValueView *couponView = [[OrderNoteValueView alloc] init];
            OrderNoteValueView *shifuView = [[OrderNoteValueView alloc] init];
            [view addSubview:peisongView];
            [view addSubview:youhuiView];
            [view addSubview:couponView];
            [view addSubview:shifuView];
            [peisongView loadNotestr:@"配送费" valueStr:[NSString stringWithFormat:@"￥%.2f", _item.odr_deliver_fee]];
            [youhuiView loadNotestr:@"活动优惠" valueStr:[NSString stringWithFormat:@"-￥%.2f", _item.odr_campagin]];
            [couponView loadNotestr:@"优惠券" valueStr:[NSString stringWithFormat:@"-￥%.2f", _item.ord_coupon_price]];
            [shifuView loadNotestr:@"实付款（含运费）" valueStr:[NSString stringWithFormat:@"￥%.2f", _item.odr_pay_price]];
            [peisongView makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.left).offset(padding);
                make.right.equalTo(view.right).offset(-padding);
                make.top.equalTo(lineView111.bottom);
                make.height.equalTo(30);
            }];
            [youhuiView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.equalTo(peisongView);
                make.top.equalTo(peisongView.bottom);
            }];
            [couponView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.equalTo(peisongView);
                make.top.equalTo(youhuiView.bottom);
            }];
            [shifuView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.equalTo(peisongView);
                make.top.equalTo(couponView.bottom);
            }];
            
            [view makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(shifuView.bottom);
            }];
            
            view;
        });
        [shopGoodsView updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(beizhuView.bottom).offset(padding);
            make.left.right.equalTo(superView);
        }];
        lastView = shopGoodsView;

    } else if (_classType == kOrderClassType_paopao) {
        UIView *shopGoodsView = ({
            UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
            
            OrderShopHeaderView *shopView = [[OrderShopHeaderView alloc] init];
            [view addSubview:shopView];
            [shopView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(view);
                make.height.equalTo(40);
            }];
            
            PaoPaoGoodsView *itemView = [[PaoPaoGoodsView alloc] init];
            [view addSubview:itemView];
            [itemView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(view);
                make.height.equalTo(80);
                make.top.equalTo(shopView.bottom);
            }];
            
            UIView *lineView111 = [view newDefaultLineView];
            [lineView111 makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(view);
                make.top.equalTo(itemView.bottom).offset(padding);
                make.height.equalTo(OnePixNumber);
            }];
            
            OrderNoteValueView *peisongView = [[OrderNoteValueView alloc] init];
            [view addSubview:peisongView];
            [peisongView loadNotestr:@"办理时间" valueStr:@"尽快办理"];
            [peisongView makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.left).offset(padding);
                make.right.equalTo(view.right).offset(-padding);
                make.top.equalTo(lineView111.bottom);
                make.height.equalTo(40);
            }];
            
            [view makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(peisongView.bottom);
            }];
            
            view;
        });
        [shopGoodsView updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(beizhuView.bottom).offset(padding);
            make.left.right.equalTo(superView);
        }];
        lastView = shopGoodsView;
        
    }else if (_classType == kOrderClassType_fix) {
        UIView *shopGoodsView = ({
            UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
            
            OrderShopHeaderView *shopView = [[OrderShopHeaderView alloc] init];
            [view addSubview:shopView];
            [shopView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(view);
                make.height.equalTo(40);
            }];
            //加载店铺信息
            [shopView reloadUIWithShopName:_item.shop_name shopLogo:_item.shop_logo orderStatus:_item.odr_state_val];
            
            BaoXiuGoodsView *itemView = [[BaoXiuGoodsView alloc] init];
            [view addSubview:itemView];
            [itemView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(view);
                make.height.equalTo(80);
                make.top.equalTo(shopView.bottom);
            }];
            //加载商品清单数据
            OrderGoodsObject *it = _item.goods.count>0 ? [_item.goods objectAtIndex:0] : nil;
            [itemView reloadUIWithItem:it];
            
            UIView *lineView111 = [view newDefaultLineView];
            [lineView111 makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(view);
                make.top.equalTo(itemView.bottom).offset(padding);
                make.height.equalTo(OnePixNumber);
            }];
            
            OrderBaoxiuImgVideoView *ivView = [[OrderBaoxiuImgVideoView alloc] init];
            [view addSubview:ivView];
            [ivView makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.left).offset(padding);
                make.right.equalTo(view.right).offset(-padding);
                make.top.equalTo(lineView111.bottom);
                make.height.equalTo(120);
            }];
            //加载报修图片数据
            [ivView reloadUIWithItem:it];
            
            [view makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(ivView.bottom);
            }];
            
            view;
        });
        [shopGoodsView updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(beizhuView.bottom).offset(padding);
            make.left.right.equalTo(superView);
        }];
        lastView = shopGoodsView;
    }

    
    
    
    
    UIView *orderView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        UIColor *color = [UIColor grayColor];
        UIFont *font = [UIFont systemFontOfSize:13];
        UIView *littleLastView = nil;
        UILabel *orderNoteLable = [view newUILableWithText:@"订单信息" textColor:color font:font];
        UILabel *orderNumLable = [view newUILableWithText:[NSString stringWithFormat:@"订单编号：%@", _item.odr_code] textColor:color font:font];
        UILabel *orderCreateTimeLable = [view newUILableWithText:[NSString stringWithFormat:@"下单时间：%@", _item.odr_add_time] textColor:color font:font];
        [orderNoteLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.equalTo(view.top);
            make.height.equalTo(30);
        }];
        [orderNumLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(orderNoteLable);
            make.top.equalTo(orderNoteLable.bottom);
        }];
        [orderCreateTimeLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(orderNoteLable);
            make.top.equalTo(orderNumLable.bottom);
        }];
        littleLastView = orderCreateTimeLable;
        
        if (_classType == kOrderClassType_dryclean || _classType == kOrderClassType_fix) {
            UILabel *orderServerTimeLable = [view newUILableWithText:@"服务时间：2016-10-13" textColor:color font:font];
            [orderServerTimeLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.equalTo(orderNoteLable);
                make.top.equalTo(orderCreateTimeLable.bottom);
            }];
            littleLastView = orderServerTimeLable;
        }
        
        
        
        if (_classType == kOrderClassType_fix) {
            UILabel *orderSMFLable = [view newUILableWithText:[NSString stringWithFormat:@"上门费：￥%.2f", _item.odr_amount] textColor:color font:font];
            [orderSMFLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.equalTo(orderNoteLable);
                make.top.equalTo(littleLastView.bottom);
            }];
            littleLastView = orderSMFLable;
        }
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(littleLastView.bottom);
        }];
        
        view;
    });
    [orderView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.bottom).offset(padding);
        make.left.right.equalTo(superView);
    }];
    lastView = orderView;
    
    
    
    if (_classType == kOrderClassType_fix) {
        if ([_item.odr_state isEqualToString:kOrderState_BIDDING]) { //竞价中
            UIView *chooseView = ({
                UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
                BaoXiuChooseShopView *itemView = [[BaoXiuChooseShopView alloc] init];
                [view addSubview:itemView];
                [itemView makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(view.top).offset(padding);
                    make.bottom.equalTo(view.bottom).offset(-padding);
                    make.left.equalTo(view.left).offset(padding*2);
                    make.right.equalTo(view.right).offset(-padding*2);
                }];
                [itemView jk_handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
                    NSLog(@"选择");
                    OrderBaoXiuChooseShopVC *vc = [[OrderBaoXiuChooseShopVC alloc] init];
                    vc.chooseCallBack = ^(NSString* shopIdStr) {
                        self.item.odr_state = kOrderState_SERPOINT;
                        [self.scrollView.mj_header beginRefreshing];
                    };
                    [self.navigationController pushViewController:vc animated:YES];
                }];
                view;
            });
            [chooseView updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(superView);
                make.top.equalTo(lastView.bottom).offset(padding);
                make.height.equalTo(60);
            }];
            lastView = chooseView;
            
        } else if ([_item.odr_state isEqualToString:kOrderState_SSERVICE]) { //商家服务中
            UIView *chooseView = ({
                UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
                UIView *lineView111 = [view newDefaultLineView];
                BaoXiuShopNoteView *itemView1 = [[BaoXiuShopNoteView alloc] init];
                BaoXiuWorkerView *itemView2 = [[BaoXiuWorkerView alloc] init];
                [view addSubview:itemView1];
                [view addSubview:itemView2];
                [itemView1 makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(view.top).offset(padding);
                    make.left.right.equalTo(view);
                    make.height.equalTo(60);
                }];
                [lineView111 makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(itemView1.bottom);
                    make.left.right.equalTo(view);
                    make.height.equalTo(OnePixNumber);
                }];
                [itemView2 makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lineView111.bottom);
                    make.left.right.equalTo(view);
                    make.height.equalTo(60);
                }];
                [view makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(itemView2.bottom);
                }];
                view;
            });
            [chooseView updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(superView);
                make.top.equalTo(lastView.bottom).offset(padding);
            }];
            lastView = chooseView;
        }

    }
    
    if (_item.odr_state_next.count > 0) {
        OrderActionBtnView *actionView = [[OrderActionBtnView alloc] init];
        [superView addSubview:actionView];
        [actionView updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView.bottom).offset(padding);
            make.left.right.equalTo(superView);
            make.height.equalTo(60);
        }];
        lastView = actionView;
        
        [actionView reloadUIWithStateArr:_item.odr_state_next]; //加载按钮显示
        
        [actionView.actionBtn1 jk_addActionHandler:^(NSInteger tag) {
            [self loadAPIwithState:actionView.actionBtn1.stateStr];
        }];
        [actionView.actionBtn2 jk_addActionHandler:^(NSInteger tag) {
            [self loadAPIwithState:actionView.actionBtn2.stateStr];
        }];
        [actionView.actionBtn3 jk_addActionHandler:^(NSInteger tag) {
            [self loadAPIwithState:actionView.actionBtn3.stateStr];
        }];
    }

    
    [self.contentView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.bottom);
    }];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:IMG(@"order_mobile.png") style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
        
    }];
    
}

-(void)loadAPIwithState:(NSString *)stateStr
{
    if (stateStr.length > 0) {
        [SVProgressHUD showWithStatus:@"操作中..."];
        [[APIClient sharedClient] orderOprateWithTag:self odr_id:_item.odr_id odr_type:_item.odr_type odr_code:_item.odr_code odr_state_next:stateStr odr_memo:nil call:^(NSString *odr_state_val, NSMutableArray *odr_state_next, APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                self.item.odr_state_next = odr_state_next;
                self.item.odr_state_val = odr_state_val;
                [self donwData];
                
                [SVProgressHUD showSuccessWithStatus:@"操作成功"];
            } else
                [SVProgressHUD showSuccessWithStatus:info.msg];
        }];
    }
}


- (void)loadHeaderRefreshing{
    [[APIClient sharedClient] orderInfoWithTag:self odr_id:_item.odr_id odr_code:_item.odr_code call:^(OrderObject *item, APIObject *info) {
        if (info.code == RESP_STATUS_YES && item!=nil) {
            self.item = item;
        }
        [self donwData];
    }];
   // [self performSelector:@selector(donwData) withObject:nil afterDelay:0.5];
}

-(void)donwData
{
    
    [self.contentView removeAllSubviews];
    
    
    [self initViews];
    [self.scrollView.mj_header endRefreshing];
}



@end
