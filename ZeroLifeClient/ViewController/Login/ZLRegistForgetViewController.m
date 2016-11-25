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
#import "MZTimerLabel.h"
#import "otherLoginViewController.h"
@interface ZLRegistForgetViewController ()<ZLLoginViewDelegate,MZTimerLabelDelegate>

@end

@implementation ZLRegistForgetViewController
{
    ZLLoginView *mView;
    //倒计时label
    UILabel *timer_show;

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
    [self timeCount];
}
/**
 注册
 */
- (void)ZLLoginWithRegistAction{
    otherLoginViewController *ooo = [[otherLoginViewController alloc] initWithNibName:@"otherLoginViewController" bundle:nil];

    [self pushViewController:ooo];

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

- (void)timeCount{//倒计时函数
    
    [mView.mRegistCodeBtn setTitle:nil forState:UIControlStateNormal];//把按钮原先的名字消掉
    timer_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mView.mRegistCodeBtn.frame.size.width, mView.mRegistCodeBtn.frame.size.height)];//UILabel设置成和UIButton一样的尺寸和位置
    [mView.mRegistCodeBtn addSubview:timer_show];//把timer_show添加到_dynamicCode_btn按钮上
    MZTimerLabel *timer_cutDown = [[MZTimerLabel alloc] initWithLabel:timer_show andTimerType:MZTimerLabelTypeTimer];//创建MZTimerLabel类的对象timer_cutDown
    [timer_cutDown setCountDownTime:60];//倒计时时间60s
    timer_cutDown.timeFormat = @"ss秒后再试";//倒计时格式,也可以是@"HH:mm:ss SS"，时，分，秒，毫秒；想用哪个就写哪个
    timer_cutDown.timeLabel.textColor = [UIColor whiteColor];//倒计时字体颜色
    timer_cutDown.timeLabel.font = [UIFont systemFontOfSize:14];//倒计时字体大小
    timer_cutDown.timeLabel.textAlignment = NSTextAlignmentCenter;//剧中
    timer_cutDown.delegate = self;//设置代理，以便后面倒计时结束时调用代理
    mView.mRegistCodeBtn.userInteractionEnabled = NO;//按钮禁止点击
    [mView.mRegistCodeBtn setBackgroundColor:[UIColor lightGrayColor]];

    [timer_cutDown start];//开始计时
}
//倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [mView.mRegistCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];//倒计时结束后按钮名称改为"发送验证码"
    [timer_show removeFromSuperview];//移除倒计时模块
    mView.mRegistCodeBtn.userInteractionEnabled = YES;//按钮可以点击
    [mView.mRegistCodeBtn setBackgroundColor:M_CO];

    
}


@end
