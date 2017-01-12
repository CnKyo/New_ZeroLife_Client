//
//  FavoriteTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/8.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "FavoriteTVC.h"

#import "FavoriteShopTableViewCell.h"

#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>
#import <CoreText/CoreText.h>

@interface FavoriteTVC ()

@end

@implementation FavoriteTVC

-(void)loadView
{
    [super loadView];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"我的收藏";
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (tableView == self.tableView) {
            ProductFocusObject *item = [self.tableArr objectAtIndex:indexPath.row];
            
            [SVProgressHUD showWithStatus:@"删除中..."];
            [[APIClient sharedClient] productFocusDelWithTag:self foc_id:item.foc_id call:^(APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    
                    [self.tableArr removeObjectAtIndex:indexPath.row];
                    
                    if (self.tableArr.count > 0) {
                        [self.tableView beginUpdates];
                        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                    } else
                        [self.tableView reloadData];

                    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                } else
                    [SVProgressHUD showErrorWithStatus:info.msg];
            }];
            

        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_FavoriteGoodsTableViewCell";
    FavoriteGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FavoriteGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    [cell setMItem:self.tableArr[indexPath.row]];    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLGoodsWithClass *mGoods = self.tableArr[indexPath.row];
    
    mGoods.sku_id = mGoods.sku_id_def;
    ZLWebViewViewController *mWebvc = [ZLWebViewViewController new];
    
    
    mWebvc.mUrl = [NSString stringWithFormat:@"%@/wap/good/goodsdetails?pro_id=%d&sku_id=%d&shop_id=%d&user_id=%d",[[APIClient sharedClient] currentUrl],mGoods.pro_id,mGoods.sku_id,mGoods.shop_id,[ZLUserInfo ZLCurrentUser].user_id];
    mWebvc.mClsGoodsObj = mGoods;
    mWebvc.mShopObj.mShopMsg.ext_min_price = mGoods.ext_min_price;
    mWebvc.mShopId = mGoods.shop_id;
    mWebvc.mType = kOrderClassType_product;
    mWebvc.mTitle = mGoods.pro_name;
    [self pushViewController:mWebvc];

}

- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] productFocusListWithTag:self page:self.page call:^(int totalPage, NSArray *tableArr, APIObject *info) {
        [self reloadWithTableArr:tableArr info:info];
    }];
    
   // [self performSelector:@selector(donwData) withObject:nil afterDelay:0.5];
}


@end
