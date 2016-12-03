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
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"社区超市";
    mBannerArr = [NSMutableArray new];

    mCampainArr = [NSMutableArray new];

    mClassifyArr = [NSMutableArray new];

    
//    mSearchView = [ZLSuperMarketSearchView shareView];
//    mSearchView.frame = CGRectMake(0, 0, 200, 30);
//    self.navigationItem.titleView = mSearchView;
//    [self addRightBtn:YES andTitel:@"搜索" andImage:nil];

    
    [self addTableView];

    
    UINib   *nib = [UINib nibWithNibName:@"ZLSuperMarketShopCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"shopCell"];

    
    nib = [UINib nibWithNibName:@"ZLSuperMarketShopActivityCell1" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"actovotyTypeCell1"];

    
    nib = [UINib nibWithNibName:@"ZLSuperMarketShopActivityCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"actovotyTypeCell2"];

    
//    [self loadData];
    
    [self setTableViewHaveHeader];
}

//- (void)loadData{

- (void)reloadTableViewDataSource{

    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] ZLGetShopHomePage:self.mLat andLng:self.mLng andType:self.mType block:^(APIObject *mBaseObj, ZLShopHomePage *mShopHome) {
        
        [self.tableArr removeAllObjects];
        [mBannerArr removeAllObjects];
        [mCampainArr removeAllObjects];
        [mClassifyArr removeAllObjects];
        [self ZLHideEmptyView];
        if (mBaseObj.code == RESP_STATUS_YES) {
            [mBannerArr addObjectsFromArray:mShopHome.banner];
            [mCampainArr addObjectsFromArray:mShopHome.campaign];
            [mClassifyArr addObjectsFromArray:mShopHome.classify];
        }else{
        
            [self showErrorStatus:mBaseObj.msg];
            [self ZLShowEmptyView:mBaseObj.msg andImage:nil andHiddenRefreshBtn:NO];
        }
        
        [self doneHeaderRereshing];

    }];
    
    [[APIClient sharedClient] ZLGetShopHomeShopList:self.mType andLat:self.mLat andLng:self.mLng andClassId:nil andPage:1 block:^(APIObject *mBaseObj, ZLShopHomeShopList *mShopList) {
        
        [self.tableArr removeAllObjects];
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            [self.tableArr addObjectsFromArray:mShopList.list];
            
        }else{
            
            [self showErrorStatus:mBaseObj.msg];
        }
        [self doneHeaderRereshing];

    }];

}

- (void)loadData{
//- (void)reloadTableViewDataSource{

    NSString * url1 = @"http://pic.newssc.org/upload/news/20161011/1476154849151.jpg";
    NSString * url2 = @"http://img.mp.itc.cn/upload/20160328/f512a3a808c44b1ab9b18a96a04f46cc_th.jpg";
    NSString * url3 = @"http://p1.ifengimg.com/cmpp/2016/10/10/08/f2016fa9-f1ea-4da5-a0f5-ba388de46a96_size80_w550_h354.JPG";
    NSString * url4 = @"http://image.xinmin.cn/2016/10/11/6150190064053734729.jpg";
    NSString * url5 = @"http://imgtu.lishiquwen.com/20160919/63e053727778a18993545741f4028c67.jpg";
    NSString * url6 = @"http://imgtu.lishiquwen.com/20160919/590346287e6e45faf1070a07159314b7.jpg";
    NSArray *mArr = @[url1,url2,url3,url4,url5,url6];
    
    
    
    [mBannerArr addObjectsFromArray:mArr];
    
    NSDictionary *mTempDic = [NSMutableDictionary new];
    self.tableArr = [NSMutableArray new];
    for (int i = 0; i<8; i++) {
        [mTempDic setValue:[NSString stringWithFormat:@"这是第%d",i] forKey:@"title"];
        [mTempDic setValue:@"icon_homepage_default" forKey:@"image"];
        [self.tableArr addObject:mTempDic];
    }
    
    [self.tableView reloadData];
    
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
        
    }else{
        ZLSuperMarketShopViewController *ZLSuperMarketShopVC = [ZLSuperMarketShopViewController new];
        ZLSuperMarketShopVC.mShopObj = self.tableArr[indexPath.row];
        [self pushViewController:ZLSuperMarketShopVC];
    }
    
    
    
    
    
}
#pragma mark ----****----首页滚动分类功能代理方法
/**
 分类点击的代理方法
 
 @param mIndex 索引
 */
- (void)ZLSupermarketClassCellDidSelectedWithIndex:(NSInteger)mIndex{
    [self upDatePage:mClassifyArr[mIndex]];
}
- (void)upDatePage:(ZLShopHomeClassify *)mClassiFy{

    [[APIClient sharedClient] ZLGetShopHomeShopList:self.mType andLat:self.mLat andLng:self.mLng andClassId:[NSString stringWithFormat:@"%d",mClassiFy.cls_id] andPage:1 block:^(APIObject *mBaseObj, ZLShopHomeShopList *mShopList) {
        
        [self.tableArr removeAllObjects];
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            [self.tableArr addObjectsFromArray:mShopList.list];
            
        }else{
        
            [self showErrorStatus:mBaseObj.msg];
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
