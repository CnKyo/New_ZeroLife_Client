//
//  mBundleView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/27.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mBundleView : UIView

#pragma mark----绑定view
/**
 *  手机号view
 */
@property (weak, nonatomic) IBOutlet UIView *mPhoneView;
/**
 *  秘密view
 */
@property (weak, nonatomic) IBOutlet UIView *mPwdView;
/**
 *  电话输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *mPhoneTx;
/**
 *  密码输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *mPwdTx;
/**
 *  绑定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mBundleBtn;
/**
 *  初始化方法
 *
 *  @return fanhuiview
 */
+ (mBundleView *)shareView;

@end
