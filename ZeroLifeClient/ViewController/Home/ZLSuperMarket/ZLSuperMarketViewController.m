//
//  ZLSuperMarketViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketViewController.h"
#import "ZLSupMarketCell.h"
#import "ZLSuperMarketShopCell.h"
#import "ZLSuperMarketHeaderSectionView.h"
#import "ZLSuperMarketSearchView.h"
#import "ZLSuperMarketSearchViewController.h"
#import "ZLSuperMarketShopViewController.h"
#import "ZLWebViewViewController.h"
#import "ZLWebVc.h"

@interface ZLSuperMarketViewController ()<UITableViewDelegate,UITableViewDataSource,ZLSupermarketBannerCellDelegate>

@end

@implementation ZLSuperMarketViewController
{

    //banner数据源
    NSMutableArray *mBannerArr;
    
    //活动数据源
    NSMutableArray *mCampainArr;
    //分类数据源
    NSMutableArray *mClassifyArr;
    
    ZLSuperMarketSearchView *mSearchView;
    
    BOOL isClassOrTable;
    NSInteger kIndex;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"社区店铺";
    mBannerArr = [NSMutableArray new];

    mCampainArr = [NSMutableArray new];

    mClassifyArr = [NSMutableArray new];

    
//    mSearchView = [ZLSuperMarketSearchView shareView];
//    mSearchView.frame = CGRectMake(0, 0, 200, 30);
//    self.navigationItem.titleView = mSearchView;
//    [self addRightBtn:YES andTitel:@"搜索" andImage:nil];
    kIndex = 0;
    
    [self addTableView];

    
    UINib   *nib = [UINib nibWithNibName:@"ZLSuperMarketShopCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"shopCell"];

    
    nib = [UINib nibWithNibName:@"ZLSuperMarketShopActivityCell1" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"actovotyTypeCell1"];

    
    nib = [UINib nibWithNibName:@"ZLSuperMarketShopActivityCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"actovotyTypeCell2"];

    
    [self loadData];
    
}

//- (void)loadData{

- (void)reloadTableViewDataSource{

    [super reloadTableViewDataSource];
    
    isClassOrTable = YES;
    
    
    if (kIndex<=0) {
        kIndex = 0;
    }
    
    ZLShopHomeClassify *mShopClassify = mClassifyArr[kIndex];
    [[APIClient sharedClient] ZLGetShopHomeShopList:self.mType andLat:self.mLat andLng:self.mLng andClassId:[NSString stringWithFormat:@"%d",mShopClassify.cls_id] andPage:1 block:^(APIObject *mBaseObj, ZLShopHomeShopList *mShopList) {
        [self hiddenTableEmptyView];
        
        [self.tableArr removeAllObjects];
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            [self.tableArr addObjectsFromArray:mShopList.list];
            
            if (mShopList.list.count <= 0) {
                [self addTableEmptyViewWithTitle:mBaseObj.msg andHiddenRefresh:NO];
            }
            
            
        }else{
            
            [self showErrorStatus:mBaseObj.msg];
            [self addTableEmptyViewWithTitle:mBaseObj.msg andHiddenRefresh:NO];
            
        }
        [self doneHeaderRereshing];
        
    }];
    

    
}

- (void)wk_emptyViewDidClicked{
    
//    if (isClassOrTable) {
        [self beginHeaderRereshing];
//    }else{
//        [self upDatePage:mClassifyArr[kIndex]];
    

//    }
    
    
}

- (void)loadData{
    
    [[APIClient sharedClient] ZLGetShopHomePage:self.mLat andLng:self.mLng andType:self.mType block:^(APIObject *mBaseObj, ZLShopHomePage *mShopHome) {
        
        [self.tableArr removeAllObjects];
        [mBannerArr removeAllObjects];
        [mCampainArr removeAllObjects];
        [mClassifyArr removeAllObjects];
        [self ZLHideEmptyView];
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            if (mShopHome.banner.count<=0 || mShopHome.classify.count<=0) {
                [self ZLShowEmptyView:@"暂无数据!" andImage:nil andHiddenRefreshBtn:NO];
                return ;
            }
            
            [mBannerArr addObjectsFromArray:mShopHome.banner];
            [mCampainArr addObjectsFromArray:mShopHome.campaign];
            [mClassifyArr addObjectsFromArray:mShopHome.classify];
            [self setTableViewHaveHeader];

            [self beginHeaderRereshing];
            
        }else{
            
            [self showErrorStatus:mBaseObj.msg];
            [self addTableEmptyViewWithTitle:mBaseObj.msg andHiddenRefresh:NO];
        }
        
        [self doneHeaderRereshing];
        
    }];
}
- (void)reloadTableViewData{
    [self loadData];
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
    return 3;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        return 40;
    }else{
        return 0.5;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        ZLSuperMarketHeaderSectionView *mSectionHeader = [ZLSuperMarketHeaderSectionView shareView];
        return mSectionHeader;
    }else{
        return nil;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return mBannerArr.count;
    }
    if (section == 2) {
        return self.tableArr.count;
    }else{
        return mCampainArr.count;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (mBannerArr.count<=4) {
            return 330-90;
        }else{
            return 330;
        }
        
        
    }else if (indexPath.section == 1){
  
        return 180;
    }else{
        return 80;
    }
    

    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
        if (indexPath.section == 0) {
            reuseCellId = @"cell1";
            
            ZLSupMarketCell *cell = [[ZLSupMarketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId andBannerDataSource:mBannerArr andDataSource:mClassifyArr];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delegate = self;
            
            return cell;
        }else if (indexPath.section == 1){
 
            reuseCellId = @"actovotyTypeCell2";
            
            ZLSuperMarketShopCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            [cell setMCampain:mCampainArr[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;

        }else{
            
            
            reuseCellId = @"shopCell";
            
            ZLSuperMarketShopCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            [cell setMShopObj:self.tableArr[indexPath.row]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }

    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
    
        ZLShopHomeCampaign *mCampain = mCampainArr[indexPath.row];
        
        ZLWebVc *vc = [ZLWebVc new];
        vc.mUrl = mCampain.adv_click_url;

        [self pushViewController:vc];

        
    }else{
        ZLSuperMarketShopViewController *ZLSuperMarketShopVC = [ZLSuperMarketShopViewController new];
        ZLSuperMarketShopVC.mType = kOrderClassType_product;

        ZLSuperMarketShopVC.mShopBaseObj = self.tableArr[indexPath.row];
        [self pushViewController:ZLSuperMarketShopVC];
    }
    
    
    
    
    
}
#pragma mark ----****----首页滚动分类功能代理方法
/**
 分类点击的代理方法
 
 @param mIndex 索引
 */
- (void)ZLSupermarketClassCellDidSelectedWithIndex:(NSInteger)mIndex{
    isClassOrTable = NO;
    kIndex = mIndex;

    [self beginHeaderRereshing];
}
- (void)upDatePage:(ZLShopHomeClassify *)mClassiFy{

    [[APIClient sharedClient] ZLGetShopHomeShopList:self.mType andLat:self.mLat andLng:self.mLng andClassId:[NSString stringWithFormat:@"%d",mClassiFy.cls_id] andPage:1 block:^(APIObject *mBaseObj, ZLShopHomeShopList *mShopList) {
        [self hiddenTableEmptyView];
        [self.tableArr removeAllObjects];
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            [self.tableArr addObjectsFromArray:mShopList.list];
            if (mShopList.list.count <= 0) {
                [self addTableEmptyViewWithTitle:mBaseObj.msg andHiddenRefresh:NO];
            }
        }else{
        
            [self showErrorStatus:mBaseObj.msg];
            [self addTableEmptyViewWithTitle:mBaseObj.msg andHiddenRefresh:NO];

        }
        [self.tableView reloadData];
    }];
    
}
#pragma mark ----****----banner点击方法
/**
 baner的代理方法v
 
 @param mIndex 索引
 */
- (void)ZLSupermarketBannerDidSelectedWithIndex:(NSInteger)mIndex{

}
- (void)mRightAction:(UIButton *)sender{
    ZLSuperMarketSearchViewController *mSearchVC = [ZLSuperMarketSearchViewController new];
    [self pushViewController:mSearchVC];
}
@end
