//
//  ZLHomeMessageViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/3.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeMessageViewController.h"
#import "ZLHomeMSGCell.h"
#import "ZLHomeMessageDetailViewController.h"
@interface ZLHomeMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZLHomeMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的消息";
    [self addRightBtn:NO andTitel:nil andImage:nil];

    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLHomeMSGCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self setTableViewHaveHeader];

}
- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [self showWithStatus:@"加载中..."];
    [[APIClient sharedClient] ZLGetHomeMsgList:^(APIObject *mBaseObj, ZLHomeMsgObj *mHomeMsg) {
        [self.tableArr removeAllObjects];
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            if (mHomeMsg.msgList.count <= 0) {
                [self showErrorStatus:@"暂无数据"];

                [self ZLShowEmptyView:@"暂无数 据" andImage:nil andHiddenRefreshBtn:NO];

            }else{
                [self showSuccessStatus:mBaseObj.msg];
                [self.tableArr addObjectsFromArray:mHomeMsg.msgList];
            }
      
            
        }else{
        
            [self ZLShowEmptyView:mBaseObj.msg andImage:nil andHiddenRefreshBtn:NO];
            [self showErrorStatus:mBaseObj.msg];
        }
        [self doneHeaderRereshing];

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
    return 70;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;

    reuseCellId = @"cell";
    
    ZLHomeMSGCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    [cell setMMessage:self.tableArr[indexPath.row]];

    return cell;
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLHomeMessageDetailViewController *mDetailVC = [ZLHomeMessageDetailViewController new];
    mDetailVC.mMessage = self.tableArr[indexPath.row];
    [self pushViewController:mDetailVC];
    

    
}

@end
