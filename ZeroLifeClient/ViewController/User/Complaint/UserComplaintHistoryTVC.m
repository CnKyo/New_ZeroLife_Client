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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_UserComplaintHistoryTableViewCell";
    UserComplaintHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UserComplaintHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    ComplaintObject *item = [self.tableArr objectAtIndex:indexPath.row];
    
    cell.timeLable.text = item.cpm_add_time;
    cell.msgLable.text = item.cpm_content;
    
    switch (item.cpm_type) {
        case kComplaintType_company:
            cell.iconImgView.image = IMG(@"cell_complaint_gongsi.png");
            cell.nameLable.text = @"对公司投诉";
            break;
        case kComplaintType_community:
            cell.iconImgView.image = IMG(@"cell_complaint_wuguan.png");
            cell.nameLable.text = @"物管投诉";
            break;
        case kComplaintType_people:
            cell.iconImgView.image = IMG(@"cell_complaint_juming.png");
            cell.nameLable.text = @"居民投诉";
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
//        UserAddressEditVC *vc = [[UserAddressEditVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] complaintListWithTag:self page:self.page call:^(int totalPage, NSArray *tableArr, APIObject *info) {
        [self reloadWithTableArr:tableArr info:info];
    }];
}



@end
