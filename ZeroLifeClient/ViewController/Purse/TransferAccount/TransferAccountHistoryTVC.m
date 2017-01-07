//
//  TransferAccountHistoryTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "TransferAccountHistoryTVC.h"
#import "TransferAccountHistoryTableViewCell.h"

@interface TransferAccountHistoryTVC ()

@end

@implementation TransferAccountHistoryTVC

-(void)loadView
{
    [super loadView];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"转账记录";
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_TransferAccountHistoryTableViewCell";
    TransferAccountHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TransferAccountHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    WalletRecordObject *item = [self.tableArr objectAtIndex:indexPath.row];
    
    cell.nameLable.text = [NSString compIsNone:item.target_name];
    cell.timeLable.text = [NSString compIsNone:item.recw_add_time];
    switch (item.recw_record_type) {
        case kWalletRecordType_input:
            cell.moneyLable.text = [NSString stringWithFormat:@"+%.2f", item.uwal_operation_money];
            cell.statusLable.text = @"转入";
            break;
        case kWalletRecordType_output:
            cell.moneyLable.text = [NSString stringWithFormat:@"-%.2f", item.uwal_operation_money];
            cell.statusLable.text = @"转出";
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (self.tableArr.count > 0) {
//        FeePayHistoryDetailVC *vc = [[FeePayHistoryDetailVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] walletRecordListWithTag:self type:kOrderClassType_balance_transfer page:self.page call:^(int totalPage, NSArray *tableArr, APIObject *info) {
        [self reloadWithTableArr:tableArr info:info];
    }];
}


@end
