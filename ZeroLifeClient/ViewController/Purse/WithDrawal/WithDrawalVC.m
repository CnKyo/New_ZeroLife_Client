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
            
        };
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    //提交
    [self.doneBtn jk_addActionHandler:^(NSInteger tag) {
        
    }];
    
    //全部提现
    [self.allOutBtn jk_addActionHandler:^(NSInteger tag) {
        self.moneyLable.text = [NSString stringWithFormat:@"%.2f", _item.uwal_balance];
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

        if (_item.bank.id_card_val.length > 0)
            str1 = _item.bank.id_card_val;
        
        if (_item.bank.bank_card_val.length > 0)
            str2 = _item.bank.bank_card_val;
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
