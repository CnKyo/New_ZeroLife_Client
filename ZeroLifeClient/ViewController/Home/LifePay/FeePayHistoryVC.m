//
//  FeePayHistoryVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/8.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "FeePayHistoryVC.h"
#import "FeePayHistoryTableViewCell.h"
#import "UserAddressEditVC.h"
#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>
#import "FeePayHistoryDetailVC.h"

#import "UserYuETableViewCell.h"
#import "OrderDetailVC.h"


@interface FeePayHistoryVC ()

@end

@implementation FeePayHistoryVC

-(void)loadView
{
    [super loadView];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"缴费记录";
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
//    if (self.tableArr.count > 0)
//        return 60;
//    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_UserYuETableViewCell";
    UserYuETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UserYuETableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    OrderObject *item = [self.tableArr objectAtIndex:indexPath.row];
    
    cell.timeLable.text = [NSString compIsNone:item.odr_add_time];
    cell.moneyLable.text = [NSString stringWithFormat:@"-￥%.2f", item.odr_amount];
    
    cell.imgView.image = [UIImage imageNamed:[NSString iconImgStrOrderType:item.odr_type]];
    cell.msgLable.text = [NSString strDesWithOrderType:item.odr_type];
    
    cell.msgLable.text = item.odr_code.length>0 ? item.odr_code : [NSString strDesWithOrderType:item.odr_type];
    
//    static NSString *CellIdentifier = @"Cell_FeePayHistoryTableViewCell";
//    FeePayHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[FeePayHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//    }
//    
//    NSDictionary* style = @{@"body" : @[[UIFont systemFontOfSize:18], [UIColor blackColor]],
//                            @"red" : @[[UIFont systemFontOfSize:15], [UIColor redColor]]};
//    
//    NSString *str1 = [NSString stringWithFormat:@"%@ <red>%@</red>", @"物管费", @"￥55.00"];
//    cell.nameLable.attributedText = [str1 attributedStringWithStyleBook:style];
//    
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.iconImgView.image = IMG(@"choose_on.png");
//    cell.timeLable.text = @"周二\n09-10";
//    cell.companyLable.text = @"重庆超尔科技有限公司";
    return cell;
    
//    if (self.tableArr.count > 0) {
//
//    }
//    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (self.tableArr.count > indexPath.row) {
//        OrderObject *item = [self.tableArr objectAtIndex:indexPath.row];
//        
//        OrderDetailVC *vc = [[OrderDetailVC alloc] init];
//        vc.classType = _orderType;
//        vc.item = item;
//        vc.isShopOrderBool = NO;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
    if (self.tableArr.count > indexPath.row) {
        OrderObject *item = [self.tableArr objectAtIndex:indexPath.row];
        
        NSString *name = [NSString strDesWithOrderType:item.odr_type];
        NSMutableString *str = [NSMutableString new];
        [str appendFormat:@"订单编号：%@", item.odr_code];
        
        if (item.odr_add_time.length > 0)
            [str appendFormat:@"\n时间：%@", item.odr_add_time];

        NSString *meto = [NSString strMemoDesWithOrderType:item.odr_type];
        if (meto==nil ||meto.length==0)
            meto = @"对象";
        
        for (OrderGoodsObject *ai in item.goods) {
            if (ai.odrg_memo.length > 0)
                [str appendFormat:@"\n%@：%@", meto, ai.odrg_memo];
            
            [str appendFormat:@"\n金额：-￥%.2f", ai.odrg_price];
            
            if (ai.odrg_spec.length > 0)
                [str appendFormat:@"\n描述：%@", ai.odrg_spec];
        }
        
        [str appendFormat:@"\n总金额：￥%.2f", item.odr_amount];
        [str appendFormat:@"\n支付金额：￥%.2f", item.odr_pay_price];
        
        if (item.odr_state_val.length > 0)
            [str appendFormat:@"\n订单状态：%@", item.odr_state_val];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:name message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) { }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
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
    
    [[APIClient sharedClient] orderListWithTag:self odr_type:_orderType odr_status:nil page:self.page call:^(int totalPage, NSArray *tableArr, APIObject *info) {
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
