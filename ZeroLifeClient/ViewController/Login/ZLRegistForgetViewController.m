//
//  ZLRegistForgetViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/18.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRegistForgetViewController.h"
#import "ZLLoginView.h"
#import "CustomDefine.h"
@interface ZLRegistForgetViewController ()<ZLLoginViewDelegate>

@end

@implementation ZLRegistForgetViewController
{
    ZLLoginView *mView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _mTitle;
    
    mView = [ZLLoginView initRegistView];
    mView.delegate = self;
    [self.view addSubview:mView];
    [mView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).offset(0);
        make.height.offset(200);
    }];

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
 验证码
 */
- (void)ZLLoginWithCodeAction{

}
/**
 注册
 */
- (void)ZLLoginWithRegistAction{

}
/**
 手机号码代理方法
 
 @param mText 返回text
 */
- (void)ZLPhoneTextFieldText:(NSString *)mText{
    MLLog(@"手机号：%@",mText);
}
/**
 验证码代理方法
 
 @param mText 返回text
 */
- (void)ZLCodeTextFieldText:(NSString *)mText{
    MLLog(@"验证码：%@",mText);
}
@end
