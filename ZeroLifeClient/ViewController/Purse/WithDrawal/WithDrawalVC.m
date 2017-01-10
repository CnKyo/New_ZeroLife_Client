//
//  WithDrawalVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "WithDrawalVC.h"
#import "BankCardTVC.h"
#import <JKCategories/UIView+JKBlockGesture.h>
#import "ZLGoPayViewController.h"

@interface WithDrawalVC ()
@property(nonatomic,strong) PrePresentApplyObject *item;
@end

@implementation WithDrawalVC


-(void)loadView
{
    [super loadView];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"我的银行卡" style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
//
//    }];
    
    self.typeSeg.sectionTitles = @[@"T+0", @"T+1"];
    self.typeSeg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.typeSeg.selectionIndicatorHeight = 2.0f;
    self.typeSeg.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor]};
    self.typeSeg.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_NavBar};
    self.typeSeg.selectionIndicatorColor = COLOR_NavBar;
    [self.typeSeg addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.doneBtn setStyleNavColor];
    
    //银行卡
    [self.bankView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        BankCardTVC *vc = [[BankCardTVC alloc] init];
        vc.chooseCallBack = ^(BankCardObject* item) {
            self.item.bank = item;
            [self reloadUIWithData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    //提交
    [self.doneBtn jk_addActionHandler:^(NSInteger tag) {
        
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
        [mPara setInt:_item.bank.bank_id forKey:@"bank_id"];
        [mPayArr addObject:mPara];
        
        [SVProgressHUD showWithStatus:@"加载中"];
        [[APIClient sharedClient] ZLCommitOrder:kOrderClassType_balance_present andShopId:nil andGoods:[Util arrToJson:mPayArr] andSendAddress:nil andArriveAddress:nil andServiceTime:nil andSendType:0 andSendPrice:nil andCoupId:nil andRemark:nil andSign:_item.sign block:^(APIObject *mBaseObj, ZLCreateOrderObj *mOrder) {
            if (mBaseObj.code == RESP_STATUS_YES) {
                ZLGoPayViewController *vc = [ZLGoPayViewController new];
                vc.mOrder = mOrder;
                vc.mOrder.sign = _item.sign;
                vc.paySuccessCallBack = ^(ZLGoPayViewController *payVC){
                    [payVC performSelector:@selector(popViewController_2) withObject:nil afterDelay:0.2];
                };
                [self pushViewController:vc];
                
                
                [self showSuccessStatus:mBaseObj.msg];
            } else
                [self showErrorStatus:mBaseObj.msg];
        }];
    }];
    
    //全部提现
    [self.allOutBtn jk_addActionHandler:^(NSInteger tag) {
        self.moneyField.text = [NSString stringWithFormat:@"%.2f", _item.uwal_balance];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    
    [SVProgressHUD showWithStatus:@"加载中"];
    [[APIClient sharedClient] preOrderPresentWithTag:self call:^(PrePresentApplyObject *item, APIObject *info) {
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
    NSString *str1 = @"选择银行卡";
    NSString *str2 = @"先绑定银行卡";
    if (_item != nil) {
        
        uwal_balance = _item.uwal_balance;

        if (_item.bank != nil) {
            if (_item.bank.bank_name.length > 0)
                str1 = _item.bank.bank_name;
            else
                str1 = @"未知银行";
            
            if (_item.bank.bank_card_val.length > 0)
                str2 = _item.bank.bank_card_val;
            else
                str2 = @"未知卡号";
        }

    } else {
        ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
        uwal_balance = user.wallet.uwal_balance;
    }
    
    self.totalMoneyLable.text = [NSString stringWithFormat:@"可提现余额：￥%.2f", uwal_balance];
    self.bankNameLable.text = str1;
    self.bankNumberLable.text = str2;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    //[self loadWithSeg:segmentedControl.selectedSegmentIndex];
}


@end
