//
//  ZLPayTypeTableViewCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
///设置代理
@protocol ZLGoPayCellDelegate <NSObject>

@optional
///状态按钮点击事件
- (void)ZLGoPayStatusBtnClicked;

@end

@interface ZLPayTypeTableViewCell : UITableViewCell
#pragma mark----****----支付cell
///图片
@property (weak, nonatomic) IBOutlet UIImageView *mLogo;
///支付名称
@property (weak, nonatomic) IBOutlet UILabel *mName;
///选择图片
@property (weak, nonatomic) IBOutlet UIImageView *mSelectedImg;

#pragma mark----****----支付成功或失败的cell
///状态图片
@property (weak, nonatomic) IBOutlet UIImageView *mStatusImg;
///状态
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
///支付价格
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
///状态按钮
@property (weak, nonatomic) IBOutlet UIButton *mStatusBtn;
///设置代理
@property (strong, nonatomic) id<ZLGoPayCellDelegate>delegate;

@end
