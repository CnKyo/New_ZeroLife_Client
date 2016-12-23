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
        
        [SVProgressHUD showWithStatus:@"加载中"];
        [[APIClient sharedClient] ZLCommitOrder:kOrderClassType_balance_transfer andShopId:nil andGoods:nil andSendAddress:nil andArriveAddress:nil andServiceTime:nil andSendType:0 andSendPrice:nil andCoupId:nil andRemark:nil andSign:_item.sign block:^(APIObject *mBaseObj, ZLCreateOrderObj *mOrder) {
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
    
    
    //协议
    [self.xieyiBtn jk_addActionHandler:^(NSInteger tag) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转账";

    [SVProgressHUD showWithStatus:@"加载中"];
    [[APIClient sharedClient] preOrderTransferWithTag:self call:^(PreApplyObject *item, APIObject *info) {
        if (info.code==RESP_STATUS_YES && item!=nil) {
            self.item = item;
            [self reloadUIWithData];
            [SVProgressHUD showSuccessWithStatus:@"获取成功"];
        } else
            [SVProgressHUD showErrorWithStatus:info.msg];
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
