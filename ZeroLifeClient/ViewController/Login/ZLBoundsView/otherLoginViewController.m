//
//  otherLoginViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/27.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "otherLoginViewController.h"

#import "mBundleView.h"
#import "MZTimerLabel.h"

@interface otherLoginViewController ()<UITextFieldDelegate,MZTimerLabelDelegate>

@end

@implementation otherLoginViewController
{

    mBundleView *mView;
    
    //倒计时label
    UILabel *timer_show;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"绑定手机号";

    [self initView];
    
}

- (void)initView{

    mView = [mBundleView shareView];
    [self.view addSubview:mView];
    [mView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(@64);
        make.bottom.equalTo(self.view).offset(@0);
    }];
    
    mView.mPwdTx.delegate = mView.mPhoneTx.delegate = self;
    [mView.mVerifyBtn addTarget:self action:@selector(verifyAction:) forControlEvents:UIControlEventTouchUpInside];

    [mView.mBundleBtn addTarget:self action:@selector(bundleAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)verifyAction:(UIButton *)sender{
    if (mView.mPhoneTx.text.length <= 0 || [mView.mPhoneTx.text isEqualToString:@" "]) {
        [self showErrorStatus:@"手机号码不能为空"];
        [mView.mPhoneTx becomeFirstResponder];
        return;
        
    }
    [self showWithStatus:@"正在发送验证码..."];
    [[APIClient sharedClient] ZLGetVerigyCode:mView.mPhoneTx.text andType:3 block:^(APIObject *mBaseObj) {
        [self dismiss];
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self dismiss];
            [self timeCount];
        }else{
            
            [self showErrorStatus:mBaseObj.msg];
        }
        
    }];

}
- (void)bundleAction:(UIButton *)sender{

    if (mView.mPhoneTx.text.length <= 0 || [mView.mPhoneTx.text isEqualToString:@" "]) {
        [self showErrorStatus:@"手机号码不能为空"];
        [mView.mPhoneTx becomeFirstResponder];
        return;
    
    }
    if (![Util isMobileNumber:mView.mPhoneTx.text]) {
        [self showErrorStatus:@"请输入合法的手机号码"];
        [mView.mPhoneTx becomeFirstResponder];
        return;
    }
    if (mView.mPwdTx.text.length <= 0 || [mView.mPwdTx.text isEqualToString:@" "] ) {
        
        [self showErrorStatus:@"密码不能为空"];
        [mView.mPwdTx becomeFirstResponder];
        return;
    }
    if (self.mOpenId.length <= 0) {
        MLLog(@"openid是%@",self.mOpenId);

        [self showErrorStatus:@"用户标志码错误！"];

        return;
    }

    [[APIClient sharedClient] ZLPlaframtLogin:self.mOpenId andPhone:mView.mPhoneTx.text andPwd:mView.mPwdTx.text block:^(APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            [ZLUserInfo updateUserInfo:_mUserInfo];

            [[NSNotificationCenter defaultCenter] postNotificationName:MyUserInfoChangedNotification object:nil];

            [self showSuccessStatus:info.msg];
            self.block(mView.mPhoneTx.text,mView.mPwdTx.text);
            [self popViewController];
        }else{
            [self showErrorStatus:info.msg];
        }
    }];
    
}
- (void)timeCount{//倒计时函数
    
    [mView.mVerifyBtn setTitle:nil forState:UIControlStateNormal];//把按钮原先的名字消掉
    timer_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mView.mVerifyBtn.frame.size.width, mView.mVerifyBtn.frame.size.height)];//UILabel设置成和UIButton一样的尺寸和位置
    [mView.mVerifyBtn addSubview:timer_show];//把timer_show添加到_dynamicCode_btn按钮上
    MZTimerLabel *timer_cutDown = [[MZTimerLabel alloc] initWithLabel:timer_show andTimerType:MZTimerLabelTypeTimer];//创建MZTimerLabel类的对象timer_cutDown
    [timer_cutDown setCountDownTime:60];//倒计时时间60s
    timer_cutDown.timeFormat = @"ss秒后再试";//倒计时格式,也可以是@"HH:mm:ss SS"，时，分，秒，毫秒；想用哪个就写哪个
    timer_cutDown.timeLabel.textColor = [UIColor whiteColor];//倒计时字体颜色
    timer_cutDown.timeLabel.font = [UIFont systemFontOfSize:14];//倒计时字体大小
    timer_cutDown.timeLabel.textAlignment = NSTextAlignmentCenter;//剧中
    timer_cutDown.delegate = self;//设置代理，以便后面倒计时结束时调用代理
    mView.mVerifyBtn.userInteractionEnabled = NO;//按钮禁止点击
    [mView.mVerifyBtn setBackgroundColor:[UIColor lightGrayColor]];
    
    [timer_cutDown start];//开始计时
}
//倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [mView.mVerifyBtn setTitle:@"重新获取" forState:UIControlStateNormal];//倒计时结束后按钮名称改为"发送验证码"
    [timer_show removeFromSuperview];//移除倒计时模块
    mView.mVerifyBtn.userInteractionEnabled = YES;//按钮可以点击
    [mView.mVerifyBtn setBackgroundColor:M_CO];
    
    
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
///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
///限制验证码输入长度
#define PASS_LENGHT 6
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==11) {
        res= TEXT_MAXLENGTH-[new length];
        
        
    }else
    {
        res= PASS_LENGHT-[new length];
        
    }
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[string length]+res};
        if (rg.length>0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}


- (void)leftBtnTouched:(id)sender{

    [self dismissViewController];
}
@end
