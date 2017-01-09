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
    
    ProductFocusObject *item = [self.tableArr objectAtIndex:indexPath.row];
    
    //        NSDictionary* style = @{@"body" : @[[UIFont systemFontOfSize:15], COLOR(253, 160, 0)],
    //                                @"u" : @[[UIFont systemFontOfSize:13],
    //                                         [UIColor grayColor],
    //                                         @{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle|NSUnderlinePatternSolid)}]};
    //
    //        NSString *str1 = [NSString stringWithFormat:@"%@ <u>%@</u>", @"￥100.00", @"￥55.00"];
    //        cell.priceLable.attributedText = [str1 attributedStringWithStyleBook:style];
    
    cell.priceLable.text = [NSString stringWithFormat:@"￥%.2f", item.sku_price];
    cell.iconImgView.image = IMG(@"choose_on.png");
    cell.nameLable.text = [NSString compIsNone:item.pro_name];
    cell.msgLable.text = [NSString compIsNone:item.pro_spec];
    [cell.iconImgView sd_setImageWithURL:[NSURL imageurl:item.img_url] placeholderImage:ZLDefaultGoodsImg];
    
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
    
    [[APIClient sharedClient] productFocusListWithTag:self page:self.page call:^(int totalPage, NSArray *tableArr, APIObject *info) {
        [self reloadWithTableArr:tableArr info:info];
    }];
    
   // [self performSelector:@selector(donwData) withObject:nil afterDelay:0.5];
}


@end
