//
//  UserPaoPaoRegisterVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserPaoPaoRegisterVC.h"
#import "UserRechargeMoneyVC.h"

@interface UserPaoPaoRegisterVC ()

@end

@implementation UserPaoPaoRegisterVC

-(void)loadView
{
    [super loadView];
    
    [self.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.payBtn jk_setBackgroundColor:COLOR_NavBar forState:UIControlStateNormal];
    self.payBtn.layer.masksToBounds = YES;
    self.payBtn.layer.cornerRadius = 5;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请跑跑腿";
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

//去充值
- (IBAction)goChongziMethod:(id)sender {
    UserRechargeMoneyVC *vc = [[UserRechargeMoneyVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


//支付
- (IBAction)payMethod:(id)sender {
    
}


//选择协议
- (IBAction)xieyiChooseMethod:(id)sender {
    
}

@end
