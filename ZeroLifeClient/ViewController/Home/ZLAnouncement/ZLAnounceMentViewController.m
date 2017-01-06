//
//  ZLAnounceMentViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/22.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLAnounceMentViewController.h"
#import "ZLAnounceMentCell.h"
#import "ZLWebViewViewController.h"
#import "ZLWebVc.h"

@interface ZLAnounceMentViewController ()

@end

@implementation ZLAnounceMentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"社区公告";
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLAnounceMentCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    [self setTableViewHaveHeaderFooter];

}
- (void)reloadTableViewData{

    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];

    [[APIClient sharedClient] ZLGetHomeAnouncement:self.page block:^(int totalPage, NSArray *tableArr, APIObject *info) {
//        [self reloadWithTableArr:tableArr info:info];
        [self.tableArr removeAllObjects];
//        [self ZLHideEmptyView];
        if (info.code == RESP_STATUS_YES) {
            [self.tableArr addObjectsFromArray:tableArr];
            
            if (tableArr.count<=0) {
                [self addEmptyView:self.tableView andType:ZLEmptyViewTypeWithCommon];
                [self showSuccessStatus:@"暂无数据！"];

            }else{
                [self showSuccessStatus:info.msg];

            }
            
        }else{
        
            [self showErrorStatus:info.msg];
            [self addEmptyView:self.tableView andType:ZLEmptyViewTypeWithCommon];
        }
        [self doneLoadingTableViewData];
        [self.tableView reloadData];
    }];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 365;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    ZLAnounceMentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell setMAnouncement:self.tableArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MLLog(@"点击了第%ld个",(long)indexPath.row);
    
    ZLHomeAnouncement *mNote = self.tableArr[indexPath.row];
    
    ZLUserInfo *mUser = [ZLUserInfo ZLCurrentUser];
    if (mUser.user_id<=0) {
        
        [APIObject infoWithReLoginErrorMessage:@"请登录再试~"];

    }else{
        
        ZLWebVc *vc = [ZLWebVc new];
        vc.mUrl = [NSString stringWithFormat:@"%@/wap/wcmutNotice/findNotice?user_id=%d&not_id=%d",[[APIClient sharedClient] currentUrl],mUser.user_id,mNote.not_id];
        
        [self pushViewController:vc];
    }
    
    
}

@end
