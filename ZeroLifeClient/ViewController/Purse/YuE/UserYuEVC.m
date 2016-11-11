//
//  UserYuEVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserYuEVC.h"
#import "UserNotIDAuthNoteView.h"
#import "UserYuEHeaderView.h"
#import "UserYuETableViewCell.h"
#import "UserIDAuthVC.h"
#import "UserRechargeMoneyVC.h"
#import <JKCategories/UIControl+JKActionBlocks.h>

@interface UserYuEVC ()

@end

@implementation UserYuEVC

-(void)loadView
{
    [super loadView];
    int padding = 10;
    UIView *superView = self.view;
    
    UserNotIDAuthNoteView *noteView = [[UserNotIDAuthNoteView alloc] init];
    [superView addSubview:noteView];

    
    UserYuEHeaderView *headerView = [[UserYuEHeaderView alloc] init];
    [headerView loadMoney:@"100.00"];
    [superView addSubview:headerView];

    
    
    [noteView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.height.equalTo(45);
    }];
    [headerView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(noteView.bottom);
    }];
    
    UILabel *xfjlLable = [superView newUILableWithText:@"消费记录" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13]];
    [xfjlLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(padding);
        make.right.equalTo(superView.right).offset(-padding);
        make.top.equalTo(headerView.bottom);
        make.height.equalTo(40);
    }];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(superView);
        make.top.equalTo(xfjlLable.bottom);
    }];
    
    
    
    
    
    [noteView jk_handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        UserIDAuthVC *vc = [[UserIDAuthVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [headerView.chongZiBtn jk_addActionHandler:^(NSInteger tag) {
        UserRechargeMoneyVC *vc = [[UserRechargeMoneyVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的余额";
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
        return 60;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        static NSString *CellIdentifier = @"Cell_UserYuETableViewCell";
        UserYuETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UserYuETableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }

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
