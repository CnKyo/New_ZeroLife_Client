//
//  WuGuanFeePayVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/8.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "WuGuanFeePayVC.h"
#import "FeePayHistoryVC.h"
#import "WuGuanFeePayTableViewCell.h"
#import "ZLGoPayViewController.h"

@interface WuGuanFeePayVC ()

@end

@implementation WuGuanFeePayVC


-(void)loadView
{
    [super loadView];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"缴费记录" style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
//        FeePayHistoryVC *vc = [[FeePayHistoryVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物管费";
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
        return 370;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_WuGuanFeePayTableViewCell";
        WuGuanFeePayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[WuGuanFeePayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            //cell.backgroundColor = [UIColor redColor];
        }
        
        PropertyFeeObject *item = [self.tableArr objectAtIndex:indexPath.row];
        
        cell.pfee_companyLable.text = [NSString compIsNone:item.pfee_company];
        cell.pfee_titleLable.text = [NSString compIsNone:item.pfee_title];
        cell.pfee_costsLable.text = [NSString stringWithFormat:@"￥%.2f", item.pfee_costs];
        cell.pfee_nameLable.text = [NSString stringWithFormat:@"户主姓名：%@", [NSString compIsNone:item.pfee_name] ] ;
        cell.pfee_menpaiLable.text = [NSString stringWithFormat:@"门户号：%i-%i-%i-%i", item.pfeel_ban, item.pfee_unit, item.pfee_floor, item.pfee_number];
        cell.pfee_endtimeLable.text = [NSString stringWithFormat:@"截止日期：%@", [NSString compIsNone:item.pfee_end_time] ];
        
        [cell.actionBtn jk_addActionHandler:^(NSInteger tag) {
            [SVProgressHUD showWithStatus:@"正在验证..."];
            [[APIClient sharedClient] preOrderPropertyWithTag:self pfee_id:item.pfee_id call:^(PreApplyObject *item11, APIObject *info) {
                if (info.code==RESP_STATUS_YES && item!=nil) {

                    //[SVProgressHUD showSuccessWithStatus:@"验证成功"];
                    
                    NSString *spec = [item11 getCustomSpecWithMoney:item.pfee_costs];
                    
                    NSMutableArray *mPayArr = [NSMutableArray new];
                    NSMutableDictionary *mPara = [NSMutableDictionary new];
                    [mPara setObject:item11.odrg_pro_name forKey:@"odrg_pro_name"];
                    [mPara setObject:spec forKey:@"odrg_spec"];
                    [mPara setObject:StringWithDouble(item.pfee_costs) forKey:@"odrg_price"];
                    [mPara setInt:item.pfee_id forKey:@"pfee_id"];
                    [mPayArr addObject:mPara];
                    
                    [SVProgressHUD showWithStatus:@"生成预订单中..."];
                    [[APIClient sharedClient] ZLCommitOrder:kOrderClassType_fee_peroperty andShopId:nil andGoods:[Util arrToJson:mPayArr] andSendAddress:nil andArriveAddress:nil andServiceTime:nil andSendType:0 andSendPrice:nil andCoupId:nil andRemark:nil andSign:item11.sign block:^(APIObject *mBaseObj, ZLCreateOrderObj *mOrder) {
                        if (mBaseObj.code == RESP_STATUS_YES) {
                            ZLGoPayViewController *ZLGoPayVC = [ZLGoPayViewController new];
                            ZLGoPayVC.mOrder = [ZLCreateOrderObj new];
                            ZLGoPayVC.mOrder = mOrder;
                            ZLGoPayVC.mOrderType = kOrderClassType_fee_peroperty;
                            [self pushViewController:ZLGoPayVC];
                            
                            [self showSuccessStatus:mBaseObj.msg];
                        } else
                            [self showErrorStatus:mBaseObj.msg];
                    }];
                    
                } else
                    [SVProgressHUD showErrorWithStatus:info.msg];
            }];
        }];
        
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
    
    [[APIClient sharedClient] propertyFeeListWithTag:self call:^(NSArray *tableArr, APIObject *info) {
        [self reloadWithTableArr:tableArr info:info];
    }];
}


@end
