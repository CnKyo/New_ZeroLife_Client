//
//  UserPaoPaoRegisterVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserPaoPaoRegisterVC.h"
#import "UserRechargeMoneyVC.h"
#import "CustomWebVC.h"
#import "ZLGoPayViewController.h"


@interface UserPaoPaoRegisterVC ()
@property(nonatomic,strong) PrePaopaoApplyObject* item;
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
    
    //链接跑跑协议
    [self.xieyiLable jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (_item.apply_url.length > 0) {
            CustomWebVC *vc = [[CustomWebVC alloc] init];
            vc.linkUrl = _item.apply_url;
            vc.title = @"跑跑腿协议";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    //支付
    [self.payBtn jk_addActionHandler:^(NSInteger tag) {
        
        NSString *spec = [_item getCustomSpecWithMoney:_item.apply_money];
        
        NSMutableArray *mPayArr = [NSMutableArray new];
        NSMutableDictionary *mPara = [NSMutableDictionary new];
        [mPara setObject:_item.odrg_pro_name forKey:@"odrg_pro_name"];
        [mPara setObject:spec forKey:@"odrg_spec"];
        [mPara setObject:[NSString stringWithFormat:@"%f", _item.apply_money] forKey:@"odrg_price"];
        [mPayArr addObject:mPara];
        
        [SVProgressHUD showWithStatus:@"正在提交..."];
        [[APIClient sharedClient] ZLCommitOrder:kOrderClassType_paopao_apply andShopId:nil andGoods:[Util arrToJson:mPayArr] andSendAddress:nil andArriveAddress:nil andServiceTime:nil andSendType:0 andSendPrice:nil andCoupId:nil andRemark:nil andSign:_item.sign block:^(APIObject *mBaseObj, ZLCreateOrderObj *mOrder) {
            if (mBaseObj.code == RESP_STATUS_YES) {
                ZLGoPayViewController *ZLGoPayVC = [ZLGoPayViewController new];
                ZLGoPayVC.mOrder = [ZLCreateOrderObj new];
                ZLGoPayVC.mOrder = mOrder;
                [self pushViewController:ZLGoPayVC];
                
                [self showSuccessStatus:mBaseObj.msg];
            } else
                
                [self showErrorStatus:mBaseObj.msg];
        }];
    }];
    
    [SVProgressHUD showWithStatus:@"加载中"];
    [[APIClient sharedClient] preOrderPaopaoApplyWithTag:self call:^(PrePaopaoApplyObject *item, APIObject *info) {
        if (info.code==RESP_STATUS_YES && item!=nil) {
            self.item = item;
            [self reloadUIWithData];
            [SVProgressHUD showSuccessWithStatus:@"获取成功"];
        } else
            [SVProgressHUD showErrorWithStatus:info.msg];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadUIWithData
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    self.moneyLable.text = [NSString stringWithFormat:@"我的余额：￥%.2f", user.wallet.uwal_balance];

    self.apply_infoLable.text = _item.apply_info;
    
    [self.payBtn setTitle:[NSString stringWithFormat:@"支付￥%.2f保证金", _item.apply_money] forState:UIControlStateNormal];
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
