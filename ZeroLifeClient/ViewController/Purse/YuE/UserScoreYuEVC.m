//
//  UserYuEVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserScoreYuEVC.h"
#import "UserNotIDAuthNoteView.h"
#import "UserYuEHeaderView.h"
#import "UserYuETableViewCell.h"
#import "UserIDAuthVC.h"
#import "UserRechargeMoneyVC.h"
#import <JKCategories/UIControl+JKActionBlocks.h>
#import "UserHouseEditVC.h"

@interface UserScoreYuEVC ()
@property(nonatomic,strong) UserNotIDAuthNoteView *noteView;
@property(nonatomic,strong) UserYuEHeaderView *headerView;
@end

@implementation UserScoreYuEVC

-(void)loadView
{
    [super loadView];
    int padding = 10;
    UIView *superView = self.view;
    
    UserNotIDAuthNoteView *noteView = [[UserNotIDAuthNoteView alloc] init];
    [superView addSubview:noteView];
    self.noteView = noteView;

    
    UserYuEHeaderView *headerView = [[UserYuEHeaderView alloc] init];
    [superView addSubview:headerView];
    self.headerView = headerView;
    
    [noteView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(superView).offset(@64);
        make.height.equalTo(45);
    }];
    [headerView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(noteView.bottom);
    }];
    
    UILabel *xfjlLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13]];
    [xfjlLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(padding);
        make.right.equalTo(superView.right).offset(-padding);
        make.top.equalTo(headerView.bottom);
        make.height.equalTo(40);
    }];
    UIView *lineView = [superView newDefaultLineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.bottom.equalTo(xfjlLable.bottom);
        make.height.equalTo(OnePixNumber);
    }];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(superView);
        make.top.equalTo(xfjlLable.bottom);
    }];
    
    
    
    
    
    [noteView jk_handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        UserHouseEditVC *vc = [[UserHouseEditVC alloc] init];
        vc.title = @"实名认证";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [headerView.chongZiBtn jk_addActionHandler:^(NSInteger tag) {
        if (_isScoreView == NO) {
            UserRechargeMoneyVC *vc = [[UserRechargeMoneyVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else
            [SVProgressHUD showInfoWithStatus:@"建设中..."];
    }];
    
    if (_isScoreView == YES) {
        self.title = @"我的积分";
        [headerView setScoreStyle];
        xfjlLable.text = @"兑换记录";
    } else {
        self.title = @"我的余额";
        [headerView setYuEStyle];
        xfjlLable.text = @"消费记录";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserInfoChange:) name:MyUserInfoChangedNotification object:nil];

    [self reloadUIWithData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

#pragma mark -- 监测到用户数据修改
-(void)handleUserInfoChange:(NSNotification *)note
{
    [self reloadUIWithData];
}

//重新刷新UI显示
-(void)reloadUIWithData
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    UIView *superView = self.view;
    if (user.user_is_authent == NO) {
        [self.noteView remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
            make.top.equalTo(superView).offset(DEVICE_NavBar_Height);
            make.height.equalTo(45);
        }];
        [self.headerView updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_noteView.bottom);
        }];
    } else {
        [self.headerView updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(DEVICE_NavBar_Height);
        }];
    }
    
    if (_isScoreView == YES) {
        [self.headerView loadUserScore:[NSString stringWithFormat:@"%i", user.wallet.uwal_score]];
    } else {
        [self.headerView loadYuEMoney:[NSString stringWithFormat:@"%.2f", user.wallet.uwal_balance]];
    }
}

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
    static NSString *CellIdentifier = @"Cell_UserYuETableViewCell";
    UserYuETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UserYuETableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if (_isScoreView == YES) { //如果是积分界面
        cell.msgLable.text = @"积分商场兑换";
        cell.imgView.image = IMG(@"cell_score_item.png");
        
        UserScoreRecordObject *item = [self.tableArr objectAtIndex:indexPath.row];
        
        cell.timeLable.text = [NSString compIsNone:item.recs_add_time];
        cell.msgLable.text = [NSString compIsNone:item.recs_desc];
        switch (item.recs_record_type) {
            case kWalletRecordType_input:
                cell.moneyLable.text = [NSString stringWithFormat:@"+%i", item.uwal_operation_score];
                break;
            case kWalletRecordType_output:
                cell.moneyLable.text = [NSString stringWithFormat:@"-%i", item.uwal_operation_score];
                break;
            default:
                break;
        }
        
        
    } else {
        WalletRecordObject *item = [self.tableArr objectAtIndex:indexPath.row];
        
        cell.timeLable.text = [NSString compIsNone:item.recw_add_time];
        switch (item.recw_record_type) {
            case kWalletRecordType_input:
                cell.moneyLable.text = [NSString stringWithFormat:@"+%.2f", item.uwal_operation_money];
                break;
            case kWalletRecordType_output:
                cell.moneyLable.text = [NSString stringWithFormat:@"-%.2f", item.uwal_operation_money];
                break;
            default:
                break;
        }
        
        cell.imgView.image = [UIImage imageNamed:[NSString iconImgStrOrderType:item.odr_type]];
        cell.msgLable.text = [NSString strDesWithOrderType:item.odr_type];
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableArr.count > indexPath.row && _isScoreView==NO) {
        WalletRecordObject *item = [self.tableArr objectAtIndex:indexPath.row];
        
        NSString *name = [NSString strDesWithOrderType:item.odr_type];
        NSMutableString *str = [NSMutableString new];
        [str appendFormat:@"订单编号：%@", item.odr_code];
        if (item.recw_desc.length > 0)
            [str appendFormat:@"\n时间：%@", item.recw_add_time];
        [str appendFormat:@"\n之前余额：￥%.2f", item.uwal_balance];
        
        switch (item.recw_record_type) {
            case kWalletRecordType_input:
                [str appendFormat:@"\n收入：+￥%.2f", item.uwal_operation_money];
                break;
            case kWalletRecordType_output:
                [str appendFormat:@"\n支出：-￥%.2f", item.uwal_operation_money];
                break;
            default:
                break;
        }
        
        [str appendFormat:@"\n剩余金额：￥%.2f", item.operation_money];
        if (item.recw_desc.length > 0)
            [str appendFormat:@"\n描述：%@", item.recw_desc];
        
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
    
    if (_isScoreView == YES) {
        [[APIClient sharedClient] userScoreRecordListWithTag:self page:self.page call:^(int totalPage, NSArray *tableArr, APIObject *info) {
            [self reloadWithTableArr:tableArr info:info];
        }];
    } else {
        [[APIClient sharedClient] walletRecordListWithTag:self type:0 page:self.page call:^(int totalPage, NSArray *tableArr, APIObject *info) {
            [self reloadWithTableArr:tableArr info:info];
        }];
    }
}



@end
