//
//  ZLLoginViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/18.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLLoginViewController.h"
#import "ZLLoginView.h"
#import "ZLRegistForgetViewController.h"
#import "otherLoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <JPUSH/JPUSHService.h>
#import <ShareSDK3/ShareSDKExtension/SSEThirdPartyLoginHelper.h> 
@interface ZLLoginViewController ()<ZLLoginViewDelegate>

@end

@implementation ZLLoginViewController
{

    ZLLoginView *mTopView;
    
    ZLLoginView *mMainView;
    
    ZLLoginView *mBottomView;
    
    ZLPlafarmtLogin *mLoginObj;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    [self initView];
//    
//    mMainView.mLoginPhoneTx.text = @"13637959618";
//    mMainView.mLoginPwdTx.text = @"123456";
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MyUserInfoChangedNotification object:nil]; //显示的时候刷新一下用户数据
}

- (void)initView{

    mLoginObj = [ZLPlafarmtLogin new];
    
    [self addLeftBtn:YES andTitel:nil andImage:IMG(@"login_close.png")];
    [self addRightBtn:YES andTitel:@"注册" andImage:nil];

    mMainView = [ZLLoginView initLoginView];
    mMainView.delegate = self;
    [self.view addSubview:mMainView];
    
    mBottomView = [ZLLoginView initQuikView];
    mBottomView.hidden = NO;
    mBottomView.delegate = self;
    [self.view addSubview:mBottomView];
    
    
    [mMainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(64);

          make.height.offset(225);
    }];
    
    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.height.offset(140);
    }];
    
    
}

-(void)mBackAction
{
    [self dismissViewController];
}

- (void)mRightAction:(UIButton *)sender{
    ZLRegistForgetViewController *vc = [ZLRegistForgetViewController new];
    vc.mTitle = @"注册";
    vc.mType = ZLRegistPwd;
    [self pushViewController:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/**
 忘记密码
 */
- (void)ZLLoginWithForgetAction{
    ZLRegistForgetViewController *vc = [ZLRegistForgetViewController new];
    vc.mTitle = @"忘记密码";
    vc.mType = ZLForgetPwd;
    [self pushViewController:vc];
}

/**
 登录
 */
- (void)ZLLoginWithLoginAction{
    
    if (mMainView.mLoginPhoneTx.text.length <=0) {
        [self showErrorStatus:@"登录账号不能为空"];
        [mMainView.mLoginPhoneTx becomeFirstResponder];
        return;
    }if (mMainView.mLoginPwdTx.text.length <= 0) {
        [self showErrorStatus:@"密码不能为空"];
        [mMainView.mLoginPwdTx becomeFirstResponder];
        return;
    }
    
//    if (![Util isMobileNumber:mMainView.mLoginPhoneTx.text]) {
//        [self showErrorStatus:@"您输入的手机号码有误！请重新输入！"];
//        [mMainView.mLoginPhoneTx becomeFirstResponder];
//
//        return;
//    }
    
    [self showWithStatus:@"登陆中..."];
    
    
    [[APIClient sharedClient] ZLLoginWithPhone:mMainView.mLoginPhoneTx.text andPwd:mMainView.mLoginPwdTx.text block:^(APIObject *mBaseObj,ZLUserInfo *mUser) {
        if ( mBaseObj.code == RESP_STATUS_YES ) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MyUserInfoChangedNotification object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:UpDateSystemCoupNotification object:nil];

            [self showSuccessStatus:@"登录成功！"];
            [self performSelector:@selector(dismissViewController) withObject:nil afterDelay:0.5];
        }else{
            [self showSuccessStatus:@"登录失败！"];
        }
    }];
    
    
}

/**
 QQ登录
 */
- (void)ZLLoginWithQQAction{
    [self loginWithType:SSDKPlatformTypeQQ];
}

/**
 微信登录
 */
- (void)ZLLoginWithWetchatAction{

    [self loginWithType:SSDKPlatformTypeWechat];

}

/**
 手机号码代理方法
 
 @param mText 返回text
 */
- (void)ZLPhoneTextFieldText:(NSString *)mText{
    MLLog(@"%@",mText);
}

/**
 密码代理方法
 
 @param mText 返回text
 */
- (void)ZLPwdTextFieldText:(NSString *)mText{
    MLLog(@"%@",mText);
}
#pragma mark----****----QQ微信登录
- (void)loginWithType:(SSDKPlatformType)type{
    [self showWithStatus:@"正在登录中..."];
    [SSEThirdPartyLoginHelper loginByPlatform:type onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        MLLog(@"三方登录返回的数据-----：%@",user);
        MLLog(@"%@",user.uid);
        if (type == SSDKPlatformTypeQQ) {
            mLoginObj.open_id = user.credential.uid;
            mLoginObj.photo = [user.rawData objectForKey:@"figureurl_qq_2"];
        }else if (type == SSDKPlatformTypeWechat){
            mLoginObj.open_id = [user.rawData objectForKey:@"openid"];
            mLoginObj.photo = [user.rawData objectForKey:@"headimgurl"];
        }
        mLoginObj.nick_name = [user.rawData objectForKey:@"nickname"];
        mLoginObj.app_v = [Util getAppVersion];
        mLoginObj.sys_v = [Util getDeviceModel];
        mLoginObj.sys_t = @"ios";
        mLoginObj.jpush = [JPUSHService registrationID];
        [self showWithStatus:@"正在登录..."];
        [[APIClient sharedClient] ZLPlaframtLogin:mLoginObj block:^(APIObject *info,ZLUserInfo *mUser) {
            if (info.code == RESP_STATUS_YES) {
                [self showSuccessStatus:info.msg];
                if (mUser.user_phone.length<=0) {
                    otherLoginViewController *vc = [[otherLoginViewController alloc] initWithNibName:@"otherLoginViewController" bundle:nil];
                    vc.mUserInfo = [ZLUserInfo new];
                    vc.mUserInfo = mUser;
                    vc.mOpenId = mLoginObj.open_id;
                    vc.block = ^(NSString *mPhone,NSString *mPwd){
                        
                        mMainView.mLoginPhoneTx.text = mPhone;
                        mMainView.mLoginPwdTx.text = mPwd;
                        [self ZLLoginWithLoginAction];
                    };
                    [self pushViewController:vc];
                }else{
                    [ZLUserInfo updateUserInfo:mUser];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:MyUserInfoChangedNotification object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:UpDateSystemCoupNotification object:nil];
                    [self showSuccessStatus:@"登录成功！"];
                    [self performSelector:@selector(dismissViewController) withObject:nil afterDelay:0.5];

                }
                
            }else{
                [self showErrorStatus:info.msg];
            }
        }];

        
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        MLLog(@"%@",error);
        [self showErrorStatus:error.description];
    }];
    
}
+(ZLLoginViewController *)startPresent:(UIViewController *)from
{
    ZLLoginViewController *vc = [[ZLLoginViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];

    [from presentViewController:navVC animated:YES completion:nil];
    return vc;
}
@end
