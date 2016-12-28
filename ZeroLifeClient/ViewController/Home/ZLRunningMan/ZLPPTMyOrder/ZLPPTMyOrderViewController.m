//
//  ZLPPTMyOrderViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTMyOrderViewController.h"
#import "ZLPPTMyOrderCell.h"
#import "ZLPPTOrderDetailViewController.h"
#import "ZLPPTRealeseOrderViewController.h"


@interface ZLPPTMyOrderViewController ()<UITableViewDelegate,UITableViewDataSource,ZLPPTMyOrderCellDelegate>

@end

@implementation ZLPPTMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的发布";

    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLPPTMyOrderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    [self setTableViewHaveHeader];

    
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];

    [[APIClient sharedClient] ZLGetMyPPTOrder:self.page andPageSize:10 block:^(APIObject *mBaseObj, NSArray *mArr) {
        
        [self.tableArr removeAllObjects];
        [self ZLHideEmptyView];
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self showSuccessStatus:mBaseObj.msg];
            
            
        }else{
//            [self ZLShowEmptyView:@"暂无数据" andImage:nil andHiddenRefreshBtn:NO];
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
    return 90;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *mHeaderView = [UIView new];
    mHeaderView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    
    UIButton *mReleaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mReleaseBtn.backgroundColor = [UIColor colorWithRed:1.00 green:0.68 blue:0.13 alpha:1.00];
    mReleaseBtn.layer.cornerRadius = 4;
    mReleaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [mReleaseBtn setTitle:@"去发布" forState:UIControlStateNormal];
    [mReleaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mReleaseBtn setImage:IMG(@"ZLPPTReales") forState:UIControlStateNormal];
    [mReleaseBtn jk_setImagePosition:LXMImagePositionLeft spacing:8];

    mReleaseBtn.frame = CGRectMake(15, 20, DEVICE_Width-30, 50);
    [mReleaseBtn addTarget:self action:@selector(mGoReleaseAction:) forControlEvents:UIControlEventTouchUpInside];
    [mHeaderView addSubview:mReleaseBtn];
    return mHeaderView;
    
}
#pragma mark----****----去发布
- (void)mGoReleaseAction:(UIButton *)sender{

    ZLPPTRealeseOrderViewController *vc = [ZLPPTRealeseOrderViewController new];
    [self pushViewController:vc];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tableArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 200;
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    ZLPPTMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLPPTOrderDetailViewController *vc = [ZLPPTOrderDetailViewController new];
    [self pushViewController:vc];
    
}

#pragma mark----****----操作按钮的代理方法
/**
 按钮的代理方法
 
 @param mIndexPath 返回索引
 */
- (void)ZLPPTMyOrderCellBtnWithClicked:(NSIndexPath *)mIndexPath{

    
}

@end
