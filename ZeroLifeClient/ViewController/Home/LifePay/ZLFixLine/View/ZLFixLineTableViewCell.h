//
//  ZLFixLineTableViewCell.h
//  ZeroLifeClient
//
//  Created by Mac on 2017/2/20.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
///设置代理
@protocol ZLFixLineTableViewCellDelegate <NSObject>

@optional
///选择缴费单位按钮代理方法
- (void)ZLFixLineTableViewCellUnitBtnDidClicked;
///电话号码代理方法
- (void)ZLFixLineTableViewCellPhoneTextWithEndEditing:(NSString *)mText;
///卡号代理方法
- (void)ZLFixLineTableViewCellCardTextWithEndEditing:(NSString *)mText;
///充值金额代理方法
- (void)ZLFixLineTableViewCellPriceBtnDidClicked;
///缴费类型代理方法
- (void)ZLFixLineTableViewCellTypeBtnDidClicked;
///确认充值代理方法
- (void)ZLFixLineTableViewCellCommitBtnDidClicked;

@end



@interface ZLFixLineTableViewCell : UITableViewCell<UITextFieldDelegate>
///
@property (weak, nonatomic) IBOutlet UIButton *mUnitBtn;
///
@property (weak, nonatomic) IBOutlet UITextField *mCardTx;
///
@property (weak, nonatomic) IBOutlet UITextField *mPhoneTx;
///
@property (weak, nonatomic) IBOutlet UIButton *mPriceTx;
///
@property (weak, nonatomic) IBOutlet UIButton *mTypeBtn;
///
@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;
///设置代理
@property (strong,nonatomic) id<ZLFixLineTableViewCellDelegate>delegate;

@end
