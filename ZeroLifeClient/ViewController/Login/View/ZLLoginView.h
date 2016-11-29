//
//  ZLLoginView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/18.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol ZLLoginViewDelegate <NSObject>

@optional

/**
 忘记密码
 */
- (void)ZLLoginWithForgetAction;

/**
 登录
 */
- (void)ZLLoginWithLoginAction;

/**
 QQ登录
 */
- (void)ZLLoginWithQQAction;

/**
 微信登录
 */
- (void)ZLLoginWithWetchatAction;

/**
 顶部左边的按钮
 */
- (void)ZLLoginWithLeftAction;

/**
 顶部右边的按钮
 */
- (void)ZLLoginWithRightAction;

/**
 验证码
 */
- (void)ZLLoginWithCodeAction;

/**
 注册
 */
- (void)ZLLoginWithRegistAction;

/**
 手机号码代理方法

 @param mText 返回text
 */
- (void)ZLPhoneTextFieldText:(NSString *)mText;

/**
 密码代理方法

 @param mText 返回text
 */
- (void)ZLPwdTextFieldText:(NSString *)mText;

/**
 验证码代理方法

 @param mText 返回text
 */
- (void)ZLCodeTextFieldText:(NSString *)mText;


@end

@interface ZLLoginView : UIView


#pragma mark----****----登录topview

/**
 topview左边的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLeftImg;

/**
 topview左边的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mLeftBtn;

/**
 topview的title
 */
@property (weak, nonatomic) IBOutlet UILabel *mTopTitle;

/**
 topview右边的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRightBtn;

/**
 初始化方法

 @return 返回view
 */
+(ZLLoginView *)initTopView;

#pragma mark----****----登录bottomview

/**
 qq登录
 */
@property (weak, nonatomic) IBOutlet UIButton *mQQBtn;

/**
 微信登录
 */
@property (weak, nonatomic) IBOutlet UIButton *mWechatBtn;

/**
 初始化方法

 @return 返回view
 */
+(ZLLoginView *)initQuikView;

#pragma mark----****----登录view

/**
 登录电话tx
 */
@property (weak, nonatomic) IBOutlet UITextField *mLoginPhoneTx;

/**
 登录密码tx
 */
@property (weak, nonatomic) IBOutlet UITextField *mLoginPwdTx;

/**
 忘记密码
 */
@property (weak, nonatomic) IBOutlet UIButton *mLoginForgetBtn;

/**
 登录
 */
@property (weak, nonatomic) IBOutlet UIButton *mLoginBtn;

/**
 初始化方法

 @return 返回view
 */
+(ZLLoginView *)initLoginView;

#pragma mark----****----注册view

/**
 注册电话tx
 */
@property (weak, nonatomic) IBOutlet UITextField *mRegistPhoneTx;

/**
 注册验证吗tx
 */
@property (weak, nonatomic) IBOutlet UITextField *mRegistCodeTx;
/**
 注册密码tx
 */
@property (weak, nonatomic) IBOutlet UITextField *mRegistPwdTx;

/**
 注册验证码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRegistCodeBtn;

/**
 注册按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mregistBtn;

/**
 初始化方法

 @return 返回view
 */
+(ZLLoginView *)initRegistView;

/**
 设置代理
 */
@property (strong,nonatomic) id<ZLLoginViewDelegate>delegate;




@end
