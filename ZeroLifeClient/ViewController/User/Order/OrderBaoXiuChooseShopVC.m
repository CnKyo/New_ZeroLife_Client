//
//  OrderBaoXiuChooseShopVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "OrderBaoXiuChooseShopVC.h"
#import "BaoXiuChooseShopTableViewCell.h"
#import "BaoXiuChooseShopNewTableViewCell.h"


#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>
#import <CoreText/CoreText.h>

@interface OrderBaoXiuChooseShopVC ()

@end

@implementation OrderBaoXiuChooseShopVC


-(void)loadView
{
    [super loadView];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择报修服务商家";
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
#pragma mark -- tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_BaoXiuChooseShopNewTableViewCell";
    BaoXiuChooseShopNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BaoXiuChooseShopNewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    OrderRepairBidObject *item = [self.tableArr objectAtIndex:indexPath.row];
    
    cell.nameLable.text = [NSString compIsNone:item.shop_name];
    cell.salesMonthLable.text = [NSString stringWithFormat:@"%i人选择", item.ext_sales_month];
    cell.ratingBarView.starNumber = [item.ext_score integerValue];
    
    NSDictionary* style2 = @{@"body" : @[[UIFont systemFontOfSize:14], [UIColor grayColor]],
                             @"u": @[[UIFont systemFontOfSize:15], COLOR_NavBar] };
    cell.priceLable.attributedText = [[NSString stringWithFormat:@"报价：<u>￥%.2f</u>", item.bid_price] attributedStringWithStyleBook:style2];
    
    
    [cell.imgView sd_setImageWithURL:[NSURL imageurl:item.shop_logo] placeholderImage:ZLDefaultShopImg];
    
    
    [cell.chooseBtn jk_addActionHandler:^(NSInteger tag) {
        if (self.chooseCallBack) {
            self.chooseCallBack(item);
            [self popViewController];
        }
        //[self performSelector:@selector(popViewController) withObject:nil afterDelay:0.2];
    }];
    
    //        //UserAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserAddressTableViewCell reuseIdentifier]];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        cell.backgroundColor = [UIColor whiteColor];
    //        cell.nameLable.text = @"张三  188****4324  户主";
    //        cell.addressLable.text = @"重庆市渝中区石油路万科中心1栋1004 重庆超尔科技有限公司";
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] orderBidListWithTag:self odr_id:_odr_id odr_code:_odr_code call:^(NSArray *tableArr, APIObject *info) {
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
