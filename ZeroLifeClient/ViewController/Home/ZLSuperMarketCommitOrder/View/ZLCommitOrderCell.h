//
//  ZLCommitOrderCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIObjectDefine.h"
#import "IQTextView.h"

///设置代理
@protocol ZLCommitDelegate <NSObject>

@optional
///选择配送方式
- (void)ZLCommitWithSendTypeBtnSelected;
///选择优惠券
- (void)ZLCommitWithCoupBtnSelected;
///备注代理方法
- (void)ZLCommitWithNote:(NSString *)mNote;

@end

@interface ZLCommitOrderCell : UITableViewCell

#pragma mark----****----确认订单表单cell
///配送方式
@property (weak, nonatomic) IBOutlet UIButton *mSendType;
///优惠券
@property (weak, nonatomic) IBOutlet UIButton *mCoupBtn;
///备注
@property (weak, nonatomic) IBOutlet IQTextView *mNoteTx;
///价格
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
///优惠金额
@property (weak, nonatomic) IBOutlet UILabel *mCoupMoney;
///配送方式和服务时间
@property (weak, nonatomic) IBOutlet UILabel *mSendTypeOrWorkTime;




#pragma mark----****----商品cell
///商品图片
@property (weak, nonatomic) IBOutlet UIImageView *mGoodsLogo;
///商品名称
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;
///商品价格
@property (weak, nonatomic) IBOutlet UILabel *mGoodsPrice;
///设置代理
@property (strong, nonatomic) id <ZLCommitDelegate>delegate;

@property (strong,nonatomic) OrderGoodsObject *mGoodsObj;

@property (strong,nonatomic) ZLPreOrderObj *mPreOrderObj;

@end
