//
//  UserComplaintHistoryTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserComplaintHistoryTVC.h"
#import "UserComplaintHistoryTableViewCell.h"
#import "UserAddressEditVC.h"

@interface UserComplaintHistoryTVC ()

@end

@implementation UserComplaintHistoryTVC

-(void)loadView
{
    [super loadView];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"反馈信息";
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
        return 70;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_UserComplaintHistoryTableViewCell";
        UserComplaintHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UserComplaintHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.backgroundColor = [UIColor whiteColor];
        }

        cell.timeLable.text = @"2016-09-10";
        cell.msgLable.text = @"投诉内容投诉内容投诉内容投诉内容投诉内容投诉内容";
        
        if (indexPath.row == 0) {
            cell.iconImgView.image = IMG(@"cell_complaint_juming.png");
            cell.nameLable.text = @"居民投诉";
        } else if (indexPath.row == 1) {
            cell.iconImgView.image = IMG(@"cell_complaint_wuguan.png");
            cell.nameLable.text = @"物管投诉";
        } else {
            cell.iconImgView.image = IMG(@"cell_complaint_gongsi.png");
            cell.nameLable.text = @"对公司投诉";
        }
        
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (self.tableArr.count > 0) {
//        UserAddressEditVC *vc = [[UserAddressEditVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}



- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [self performSelector:@selector(donwData) withObject:nil afterDelay:0.5];
}

-(void)donwData
{
    for (int i=0; i<10; i++) {
        [self.tableArr addObject:@"111"];
    }
    [self doneLoadingTableViewData];
}


@end
