//
//  TransferAccountVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "TransferAccountVC.h"
#import <JKCategories/UIButton+JKImagePosition.h>
#import "TransferAccountHistoryTVC.h"
#import "ZLGoPayViewController.h"

@interface TransferAccountVC ()
@property(nonatomic,strong) PreApplyObject *item;
@end

@implementation TransferAccountVC

-(void)loadView
{
    [super loadView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"转账记录" style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
        TransferAccountHistoryTVC *vc = [[TransferAccountHistoryTVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.xieyiBtn jk_setImagePosition:LXMImagePositionLeft spacing:5];
    [self.doneBtn setStyleNavColor];
    
    
    //转帐
    [self.doneBtn jk_addActionHandler:^(NSInteger tag) {
        if (_accountField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入转账账户"];
            return ;
        }
        
        if (_moneyField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入金额"];
            return ;
        }
        
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        NSString *spec = [_item getCustomSpecWithMoney:[_moneyField.text floatValue]];
        
        NSMutableArray *mPayArr = [NSMutableArray new];
        NSMutableDictionary *mPara = [NSMutableDictionary new];
        [mPara setObject:_item.odrg_pro_name forKey:@"odrg_pro_name"];
        [mPara setObject:spec forKey:@"odrg_spec"];
        [mPara setObject:_moneyField.text forKey:@"odrg_price"];
        [mPara setObject:_accountField.text forKey:@"acc_phone"];
        [mPayArr addObject:mPara];
        
        [SVProgressHUD showWithStatus:@"加载中"];
        [[APIClient sharedClient] ZLCommitOrder:kOrderClassType_balance_transfer andShopId:nil andGoods:[Util arrToJson:mPayArr] andSendAddress:nil andArriveAddress:nil andServiceTime:nil andSendType:0 andSendPrice:nil andCoupId:nil andRemark:nil andSign:_item.sign block:^(APIObject *mBaseObj, ZLCreateOrderObj *mOrder) {
            if (mBaseObj.code == RESP_STATUS_YES) {
                ZLGoPayViewController *vc = [ZLGoPayViewController new];
                vc.mOrder = mOrder;
                vc.mOrder.sign = _item.sign;
                vc.paySuccessCallBack = ^(ZLGoPayViewController *payVC){
                    [payVC performSelector:@selector(popViewController_2) withObject:nil afterDelay:0.5];
                };
                [self.navigationController pushViewController:vc animated:YES];
                
                [self showSuccessStatus:mBaseObj.msg];
            } else
                [self showErrorStatus:mBaseObj.msg];
        }];
    }];
    
    
    //协议
    [self.xieyiBtn jk_addActionHandler:^(NSInteger tag) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转账";
    
//    self.accountField.text = @"17783708893";
//    self.moneyField.text = @"50";

    [SVProgressHUD showWithStatus:@"正在验证..."];
    [[APIClient sharedClient] preOrderTransferWithTag:self call:^(PreApplyObject *item, APIObject *info) {
        if (info.code==RESP_STATUS_YES && item!=nil) {
            self.item = item;
            [self reloadUIWithData];
            [SVProgressHUD showSuccessWithStatus:@"验证成功"];
        } else {
            [SVProgressHUD showErrorWithStatus:info.msg];
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadUIWithData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadUIWithData
{
    float uwal_balance = 0;
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    uwal_balance = user.wallet.uwal_balance;
    
    self.yuEMoneyLable.text = [NSString stringWithFormat:@"我的余额：￥%.2f", uwal_balance];

}




@end
