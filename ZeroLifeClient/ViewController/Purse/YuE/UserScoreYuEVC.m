//
//  UserYuEVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserScoreYuEVC.h"
#import "UserNotIDAuthNoteView.h"
#import "UserYuEHeaderView.h"
#import "UserYuETableViewCell.h"
#import "UserIDAuthVC.h"
#import "UserRechargeMoneyVC.h"
#import <JKCategories/UIControl+JKActionBlocks.h>

@interface UserScoreYuEVC ()
@property(nonatomic,strong) UserNotIDAuthNoteView *noteView;
@property(nonatomic,strong) UserYuEHeaderView *headerView;
@end

@implementation UserScoreYuEVC

-(void)loadView
{
    [super loadView];
    int padding = 10;
    UIView *superView = self.view;
    
    UserNotIDAuthNoteView *noteView = [[UserNotIDAuthNoteView alloc] init];
    [superView addSubview:noteView];
    self.noteView = noteView;

    
    UserYuEHeaderView *headerView = [[UserYuEHeaderView alloc] init];
    [superView addSubview:headerView];
    self.headerView = headerView;
    
    [noteView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(superView).offset(@64);
        make.height.equalTo(45);
    }];
    [headerView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(noteView.bottom);
    }];
    
    UILabel *xfjlLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13]];
    [xfjlLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(padding);
        make.right.equalTo(superView.right).offset(-padding);
        make.top.equalTo(headerView.bottom);
        make.height.equalTo(40);
    }];
    UIView *lineView = [superView newDefaultLineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.bottom.equalTo(xfjlLable.bottom);
        make.height.equalTo(OnePixNumber);
    }];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(superView);
        make.top.equalTo(xfjlLable.bottom);
    }];
    
    
    
    
    
    [noteView jk_handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        UserIDAuthVC *vc = [[UserIDAuthVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [headerView.chongZiBtn jk_addActionHandler:^(NSInteger tag) {
        if (_isScoreView == NO) {
            UserRechargeMoneyVC *vc = [[UserRechargeMoneyVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    if (_isScoreView == YES) {
        self.title = @"我的积分";
        [headerView setScoreStyle];
        xfjlLable.text = @"兑换记录";
    } else {
        self.title = @"我的余额";
        [headerView setYuEStyle];
        xfjlLable.text = @"消费记录";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    UIView *superView = self.view;
    if (user.user_is_authent == NO) {
        [self.noteView remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
            make.top.equalTo(superView).offset(DEVICE_NavBar_Height);
            make.height.equalTo(45);
        }];
        [self.headerView updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_noteView.bottom);
        }];
    } else {
        [self.headerView updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(DEVICE_NavBar_Height);
        }];
    }
    
    if (_isScoreView == YES) {
        [self.headerView loadUserScore:[NSString stringWithFormat:@"%i", user.wallet.uwal_score]];
    } else {
        [self.headerView loadYuEMoney:[NSString stringWithFormat:@"%.2f", user.wallet.uwal_balance]];
    }
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

#pragma mark -- tableviewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0)
        return 60;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_UserYuETableViewCell";
        UserYuETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UserYuETableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }

        if (_isScoreView == YES) {
            cell.msgLable.text = @"积分商场兑换";
            cell.imgView.image = IMG(@"cell_score_item.png");
        } else {
            WalletRecordObject *item = [self.tableArr objectAtIndex:indexPath.row];
            
            cell.timeLable.text = [NSString compIsNone:item.recw_add_time];
            switch (item.recw_record_type) {
                case kWalletRecordType_input:
                    cell.moneyLable.text = [NSString stringWithFormat:@"+%.2f", item.uwal_operation_money];
                    break;
                case kWalletRecordType_output:
                    cell.moneyLable.text = [NSString stringWithFormat:@"-%.2f", item.uwal_operation_money];
                    break;
                default:
                    break;
            }
            
            switch (item.odr_type) {
                case kOrderClassType_balance_present:
                    cell.msgLable.text = @"提现";
                    cell.imgView.image = IMG(@"purse_tixian.png");
                    break;
                case kOrderClassType_balance_recharge:
                    cell.msgLable.text = @"余额充值";
                    cell.imgView.image = IMG(@"cell_soukuan_item.png");
                    break;
                case kOrderClassType_balance_transfer:
                    cell.msgLable.text = @"转帐";
                    cell.imgView.image = IMG(@"purse_zhuanzhuang.png");
                    break;
                case kOrderClassType_balance_collection:
                    cell.msgLable.text = @"收款";
                    cell.imgView.image = IMG(@"cell_soukuan_item.png");
                    break;
                default:
                    break;
            }

            
        }
        
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (self.tableArr.count > 0) {
//        FeePayHistoryDetailVC *vc = [[FeePayHistoryDetailVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}



- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] walletRecordListWithTag:self type:0 page:self.page call:^(int totalPage, NSArray *tableArr, APIObject *info) {
        [self reloadWithTableArr:tableArr info:info];
    }];
    //[self performSelector:@selector(donwData) withObject:nil afterDelay:0.5];
}

-(void)donwData
{
    for (int i=0; i<10; i++) {
        [self.tableArr addObject:@"111"];
    }
    [self doneLoadingTableViewData];
}



@end
