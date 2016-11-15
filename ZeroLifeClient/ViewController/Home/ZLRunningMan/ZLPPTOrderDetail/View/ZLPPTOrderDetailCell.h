//
//  ZLPPTOrderDetailCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLPPTOrderDetailCell;

@protocol ZLPPTOrderDetailCellBtnWithClicked <NSObject>

@optional

- (void)ZLPPTOrderDetailCell:(ZLPPTOrderDetailCell *)mCell andWithLeftBtn:(NSIndexPath *)mIndexPath;

- (void)ZLPPTOrderDetailCell:(ZLPPTOrderDetailCell *)mCell andWithRightBtn:(NSIndexPath *)mIndexPath;


@end

@interface ZLPPTOrderDetailCell : UITableViewCell

#pragma mark----****----第一种cell样式

@property (weak, nonatomic) IBOutlet UIImageView *mOrderStatusImg;

#pragma mark----****----第二种cell样式

@property (weak, nonatomic) IBOutlet UILabel *mOrderType;

@property (weak, nonatomic) IBOutlet UILabel *mOrderStatus;

@property (weak, nonatomic) IBOutlet UIImageView *mOrderImg;

@property (weak, nonatomic) IBOutlet UILabel *mOrderName;

@property (weak, nonatomic) IBOutlet UILabel *mOrderNote;

@property (weak, nonatomic) IBOutlet UILabel *mOrderReward;

@property (weak, nonatomic) IBOutlet UILabel *mGoodsPrice;

@property (weak, nonatomic) IBOutlet UILabel *mWorkTime;

@property (weak, nonatomic) IBOutlet UILabel *mOrderCode;

@property (weak, nonatomic) IBOutlet UILabel *mOrderCreateTime;

@property (weak, nonatomic) IBOutlet UILabel *mOrderArriveAddress;

@property (weak, nonatomic) IBOutlet UIButton *mLeftBtn;

@property (weak, nonatomic) IBOutlet UIButton *mRightBtn;

@property (assign,nonatomic) NSIndexPath *mIndexPath;

@property (strong,nonatomic) id<ZLPPTOrderDetailCellBtnWithClicked>delegate;

@end
