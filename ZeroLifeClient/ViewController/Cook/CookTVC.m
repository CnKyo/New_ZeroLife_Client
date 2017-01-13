//
//  CookTVC.m
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CookTVC.h"
#import "APIClient.h"
#import "UIImageView+AFNetworking.h"
#import "CookDetailVC.h"
#import "ImageTextTableViewCell.h"
#import "CustomDefine.h"

@interface CookTVC ()<UITableViewDelegate,UITableViewDataSource>

@end



@implementation CookTVC

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _item.categoryInfo.name;
    
    [self addTableView];
    [self setTableViewHaveHeader];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
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

- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] cookListWithTag:self cookId:_item.categoryInfo.ctgId name:@"" pageIndex:self.page call:^(int totalpage, NSArray *tableArr, APIShareSdkObject *info) {
        if (tableArr.count > 0) {
            if (self.page == 1) {
                [self.tableArr removeAllObjects];
                self.tableArr = [tableArr mutableCopy];
            } else
                [self.tableArr addObjectsFromArray:tableArr];
            
            if (self.tableView.mj_footer != nil) {
                if (tableArr.count < TABLE_PAGE_ROW)
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                else
                    self.tableView.mj_footer.state = MJRefreshStateIdle;
            }
            
        } else {
            if (self.page > 1)
                self.page --;
            
            if (info.retCode != RETCODE_SUCCESS)
                self.errMsg = info.msg!=nil ? info.msg : @"网络错误";
            else
                self.errMsg = @"暂无数据";
        }
        
        [self doneLoadingTableViewData];
        
    }];
}




#pragma mark -- tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CookTVCTableViewCell";
    ImageTextTableViewCell *cell = (ImageTextTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[ImageTextTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    CookObject *item = [self.tableArr objectAtIndex:indexPath.row];
    cell.text1Lable.text = item.name;
    cell.text2Lable.text = item.ctgTitles;
    [cell.iconImgView setImageWithURL:[NSURL URLWithString:item.thumbnail] placeholderImage:IMG(@"DefaultImg.png")];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count > indexPath.row) {
        CookObject *item = [self.tableArr objectAtIndex:indexPath.row];
        CookDetailVC *vc = [[CookDetailVC alloc] init];
        vc.item = item;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
