//
//  ZLPPTRewardViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTRewardViewController.h"
#import "ZLPPTRewardCell.h"
#import "ZLPPTRewardHeadView.h"


@interface ZLPPTRewardViewController ()

@end

@implementation ZLPPTRewardViewController
{

    ZLPPTRewardHeadView *mHeaderSectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的酬劳";
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLPPTRewardCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self setTableViewHaveHeaderFooter];

}
- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
 
    [[APIClient sharedClient] ZLGetPPTRewardList:[NSString stringWithFormat:@"%d",self.page] block:^(APIObject *mBaseObj, ZLPPTRewardList *mList) {

        
        [self.tableArr removeAllObjects];
        [self ZLHideEmptyView];
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self dismiss];
            
            if (mList.list.count <= 0) {
                [self ZLShowEmptyView:@"暂无数据" andImage:nil andHiddenRefreshBtn:NO];
            }else{
                [self reloadWithTableArr:mList.list info:mBaseObj];
            }
            
        }else{
            [self ZLShowEmptyView:@"暂无数据" andImage:nil andHiddenRefreshBtn:NO];
            [self showErrorStatus:mBaseObj.msg];
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 160;
   
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    mHeaderSectionView = [ZLPPTRewardHeadView shareView];
    mHeaderSectionView.mRewardMoney.text = [NSString stringWithFormat:@"¥%.2f元",self.mTotleMoney];
    return mHeaderSectionView;
 
}
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
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell"; 
    
    ZLPPTRewardCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    [cell setMObj:self.tableArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

@end
