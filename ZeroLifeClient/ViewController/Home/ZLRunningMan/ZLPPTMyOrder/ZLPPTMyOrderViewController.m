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
#import "HMSegmentedControl.h"


@interface ZLPPTMyOrderViewController ()<UITableViewDelegate,UITableViewDataSource,ZLPPTMyOrderCellDelegate>

@end

@implementation ZLPPTMyOrderViewController
{

    HMSegmentedControl *mSegmentView;

    
    NSMutableArray *mStatusArr;
    
    NSInteger m_Index;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的跑单";

    m_Index = 0;
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLPPTMyOrderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    mStatusArr = [NSMutableArray new];
    
    NSArray *mTT = @[@"待处理",@"已完成",@"已取消"];
    
    [mStatusArr addObjectsFromArray:mTT];
    
    mSegmentView = [[HMSegmentedControl alloc] initWithSectionTitles:mTT];
    //seg.frame = CGRectMake(0, 0, DEVICE_Width, 50);
    mSegmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    mSegmentView.selectionIndicatorHeight = 2.0f;
    mSegmentView.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]};
    mSegmentView.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_NavBar};
    mSegmentView.selectionIndicatorColor = COLOR_NavBar;
    [mSegmentView addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mSegmentView];
    [mSegmentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(50);
        make.top.equalTo(self.view.top).offset(64);
    }];
    
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(mSegmentView.bottom).offset(-64);
    }];

    [self setTableViewHaveHeader];

    
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    
    m_Index = segmentedControl.selectedSegmentIndex;
    [self reloadTableViewDataSource];
    

}
- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];

    [[APIClient sharedClient] ZLGetMyPPTOrder:self.page andPageSize:10 andStatus:[self currentOrderStatus:mStatusArr[m_Index]] block:^(APIObject *mBaseObj, NSArray *mArr) {
        
        [self.tableArr removeAllObjects];
        [self ZLHideEmptyView];
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self dismiss];
            
            [self.tableArr addObjectsFromArray:mArr];
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
    return 0;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
//    UIView *mHeaderView = [UIView new];
//    mHeaderView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
//    
//    UIButton *mReleaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    mReleaseBtn.backgroundColor = [UIColor colorWithRed:1.00 green:0.68 blue:0.13 alpha:1.00];
//    mReleaseBtn.layer.cornerRadius = 4;
//    mReleaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [mReleaseBtn setTitle:@"去发布" forState:UIControlStateNormal];
//    [mReleaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [mReleaseBtn setImage:IMG(@"ZLPPTReales") forState:UIControlStateNormal];
//    [mReleaseBtn jk_setImagePosition:LXMImagePositionLeft spacing:8];
//
//    mReleaseBtn.frame = CGRectMake(15, 20, DEVICE_Width-30, 50);
//    [mReleaseBtn addTarget:self action:@selector(mGoReleaseAction:) forControlEvents:UIControlEventTouchUpInside];
//    [mHeaderView addSubview:mReleaseBtn];
//    return mHeaderView;

//    return mSegmentView;
    return nil;

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
    [cell setMOrder:self.tableArr[indexPath.row]];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLPPTOrderDetailViewController *vc = [ZLPPTOrderDetailViewController new];
    [self pushViewController:vc];
    
}

#pragma mark----****----左边的按钮的代理方法
/**
 左边的按钮的代理方法
 
 @param mIndexPath 返回索引
 */
- (void)ZLPPTMyOrderCellLeftBtnWithClicked:(NSIndexPath *)mIndexPath{

}
#pragma mark----****----右边的按钮的代理方法
/**
 右边的按钮的代理方法
 
 @param mIndexPath 返回索引
 */
- (void)ZLPPTMyOrderCellRightBtnWithClicked:(NSIndexPath *)mIndexPath{

}

- (NSString *)currentOrderStatus:(NSString *)mStatus{

    if ([mStatus isEqualToString:@"待处理"]) {
        return @"ING";
        
    }else if ([mStatus isEqualToString:@"已完成"]){
        return @"DONE";
    }else{
        return @"CANCEL";
        
    }
    
}

@end
