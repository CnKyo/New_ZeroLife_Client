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
    
    cell.nameLable.text = [NSString strDesWithComplaintState:item.cpm_type];
    cell.iconImgView.image = [UIImage imageNamed:[NSString iconImgStrWithComplaintState:item.cpm_type]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count > indexPath.row) {
        ComplaintObject *item = [self.tableArr objectAtIndex:indexPath.row];
        
        NSString *name = [NSString strDesWithComplaintState:item.cpm_type];
        NSMutableString *str = [NSMutableString new];
        [str appendFormat:@"时间：%@", item.cpm_add_time];
        if (item.cmut_name.length > 0)
            [str appendFormat:@"\n社区名称：%@", item.cmut_name];
        if (item.cpm_staff.length > 0)
            [str appendFormat:@"\n被投诉者：%@", item.cpm_staff];
        if (item.cpm_content.length > 0)
            [str appendFormat:@"\n投诉内容：%@", item.cpm_content];
        [str appendFormat:@"\n处理结果：%@", item.cpm_handle_content.length>0 ? item.cpm_handle_content : @"暂无"];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:name message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) { }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
