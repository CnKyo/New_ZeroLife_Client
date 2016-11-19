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
#import <ShareSDK/ShareSDK.h>

@interface ZLLoginViewController ()<ZLLoginViewDelegate>

@end

@implementation ZLLoginViewController
{

    ZLLoginView *mTopView;
    
    ZLLoginView *mMainView;
    
    ZLLoginView *mBottomView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    [self initView];
}

- (void)initView{

    
    [self addRightBtn:YES andTitel:@"注册" andImage:nil];

    mMainView = [ZLLoginView initLoginView];
    mMainView.delegate = self;
    [self.view addSubview:mMainView];
    
    mBottomView = [ZLLoginView initQuikView];
    mBottomView.delegate = self;
    [self.view addSubview:mBottomView];
    
    
    [mMainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).offset(0);
          make.height.offset(225);
    }];
    
    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.height.offset(140);
    }];
    
    
}
- (void)mRightAction:(UIButton *)sender{
    ZLRegistForgetViewController *vc = [ZLRegistForgetViewController new];
    vc.mTitle = @"注册";
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
    [self pushViewController:vc];
}

/**
 登录
 */
- (void)ZLLoginWithLoginAction{

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

    [ShareSDK getUserInfo:type onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            MLLog(@"%@",user);
            MLLog(@"%@",user.uid);
        }else{
            MLLog(@"%@",error);
        }
    }];
    
}

@end
