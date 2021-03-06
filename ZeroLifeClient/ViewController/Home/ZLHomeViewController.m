//
//  ZLHomeViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeViewController.h"
#import "AppDelegate.h"
#import "MTA.h"
#import "MTAConfig.h"
#import "ScrollModelVC.h"
#import "CurentLocation.h"
#import "ZLHomeLocationView.h"
#import "ZLHomeScrollerTableViewCell.h"
#import "ZLHomeOtherCell.h"
#import "ZLSelectArearViewController.h"
#import "ZLHomeMessageViewController.h"
#import "ZLHomeCoupView.h"
#import "ZLHomeCoupCell.h"
#import "ZLSuperMarketViewController.h"
#import "DryCleanShopTVC.h"
#import "LifePayVC.h"
#import "ZLTenementRepairsViewController.h"
#import "ZLRunningManViewController.h"
#import "BianMingVC.h"
#import "ZLLoginViewController.h"
#import "ZLWebViewViewController.h"
#import "ZLOrderReturnViewController.h"
#import "ZLAnounceMentViewController.h"
#import "ZLRatingViewController.h"
#import <HcdGuideView.h>
#import <JWLaunchAd/JWLaunchAd.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <UINavigationBar+Awesome.h>
#import "ZLWebVc.h"
#import "GuideView.h"
#import "ZLNeighbourhoodViewController.h"
#import "GPSValidLocationPicker.h"
#import "GPSLocationPicker.h"
#import "ZLSuperMarketShopViewController.h"
#import "OnlyLocationManager.h"

#import "ZLFixLineViewController.h"
#define NAVBAR_CHANGE_POINT 30
@interface ZLHomeViewController ()<UITableViewDelegate,UITableViewDataSource,ZLHomeScrollerTableCellDelegate,ZLHomeLocationViewDelegate,ZLCoupViewDelegate,AMapLocationManagerDelegate,MMApBlockCoordinate,ZLHomeOtherCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation ZLHomeViewController
{
    //banner数据源
    NSMutableArray *mBannerArr;
    //功能分类数据源
    NSMutableArray *mFunctionArr;
    //地址选择view
    ZLHomeLocationView *mLocationView;
    //优惠券弹框
    ZLHomeCoupView *mCoupView;
    //优惠券数据源
    NSMutableArray *mCoupArr;
    
    CommunityObject *mCommunityObj;
    
    ///活动广告数据源
    NSMutableArray *mAdvDataSourceArr;
    ///平台公告数据源
    NSMutableArray *mComDataSourceArr;

    AMapLocationManager *mLocation;
    ///系统优惠卷数据源
    NSMutableArray *mSystemCoupList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";

    [self appInit];
    mCommunityObj = [CommunityObject new];
    NSNotificationCenter *mNotify = [NSNotificationCenter defaultCenter];
    [mNotify addObserver:self selector:@selector(webAction:) name:@"ZLAdView" object:nil];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(10, -60) forBarMetrics:UIBarMetricsDefault];

    
    mBannerArr = [NSMutableArray new];
    mFunctionArr = [NSMutableArray new];
    mCoupArr = [NSMutableArray new];
    
    mAdvDataSourceArr = [NSMutableArray new];
    mComDataSourceArr = [NSMutableArray new];
    mSystemCoupList = [NSMutableArray new];

    self.mTableView.dataSource = self;
    self.mTableView.delegate = self;
    self.mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.mTableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:0.65];
    [self initLeftAndRightBarButton];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLHomeOtherCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"cell2"];

    
    [self initCoupView];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    [self TableViewHaveHeader];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserInfoNeedChange:) name:MyUserNeedUpdateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserInfoChange:) name:MyUserInfoChangedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCoup:) name:UpDateSystemCoupNotification object:nil];

    if ([ZLUserInfo ZLCurrentUser] != nil) {
        [self performSelector:@selector(startLoadUserInfo) withObject:nil afterDelay:1.0]; //更新用户数据
    }
}

-(void)startLoadUserInfo
{
    [self handleUserInfoNeedChange:nil];
}

#pragma mark----****----用户需要更新数据
-(void)handleUserInfoNeedChange:(NSNotification *)note
{
    [[APIClient sharedClient] userInfoWithTag:self call:^(ZLUserInfo *user, APIObject *info) {
        

    }];
}

#pragma mark----****----用户需要更新优惠卷数据
-(void)updateCoup:(NSNotification *)note
{
    [self loadSystemCoup];

}
-(void)handleUserInfoChange:(NSNotification *)note
{
//    MemberObject *item = [MemberObject currentUser];
//    [self.topView loadUIWithData:item];
}

#pragma mark----****----初始化app
- (void)appInit{

    [[APIClient sharedClient] ZLAppInit:^(APIObject *mBaseObj,ZLAPPInfo *mAppInfo) {
        if (mBaseObj.code == RESP_STATUS_YES) {
            
        }else{
            [self showErrorStatus:mBaseObj.msg];
        }
    }];
}
- (void)webAction:(NSNotification *)sender{
    MLLog(@"得到的通知对象:%@",sender);
    ZLWebVc *vc = [ZLWebVc new];
    vc.mUrl = sender.userInfo[@"url"];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushViewController:vc];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:@"ZLAdView"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = M_CO;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (scrollView ==  self.mTableView) {
        MLLog(@"YYYYY是：%f",offsetY);
        if (offsetY > NAVBAR_CHANGE_POINT) {
            CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + NAVBAR_Height - offsetY) / NAVBAR_Height));
            MLLog(@"Yaaaaaa是：%f",alpha);
            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
            [mLocationView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha/2]];
            
        } else {
            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
            [mLocationView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
        }
        
        
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.mTableView.delegate = self;
    [self scrollViewDidScroll:self.mTableView];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mTableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark ----****----加载导航条左右按钮和中间的社区选择view
- (void)initLeftAndRightBarButton{

    [self addRightBtn:YES andTitel:nil andImage:[UIImage imageNamed:@"ZLHome_Message"]];
    
//    [self.navigationController.navigationBar.subviews[3] setHidden:YES];
    
    MLLog(@"%@",self.navigationController.navigationBar.subviews);
    
    mLocationView = [ZLHomeLocationView shareView];
    mLocationView.frame = CGRectMake(0, 0, 200, 30);
    mLocationView.delegate = self;
    self.navigationItem.titleView = mLocationView;
    
    
}
#pragma mark----****----更新回调界面
- (void)upDatePage{

    if (mCommunityObj.cmut_name.length > 0) {
        mLocationView.mAddress.text = mCommunityObj.cmut_name;
    }

    [self reloadTableViewDataSource];
}
#pragma mark ----****----社区选择view代理方法
- (void)ZLHomLocationViewDidSelected{
    ZLSelectArearViewController *ZLAddressVC = [ZLSelectArearViewController new];
    ZLAddressVC.block = ^(CommunityObject *mBlock){
        mCommunityObj = mBlock;
        [self upDatePage];
    };
    ZLAddressVC.mCommunityAdd = [CommunityObject new];
    ZLAddressVC.mCommunityAdd.cmut_lng = mCommunityObj.cmut_lng;
    ZLAddressVC.mCommunityAdd.cmut_lat = mCommunityObj.cmut_lat;
    ZLAddressVC.hidesBottomBarWhenPushed = YES;

    [self pushViewController:ZLAddressVC];
}
#pragma mark ----****----消息按钮方法
- (void)mRightAction:(UIButton *)sender{

//    ZLHomeMessageViewController *ZLHomeMsgVC = [ZLHomeMessageViewController new];
//    ZLHomeMsgVC.hidesBottomBarWhenPushed = YES;
//    [self pushViewController:ZLHomeMsgVC];
    
    ZLFixLineViewController *vc = [ZLFixLineViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushViewController:vc];
}
- (void)TableViewHaveHeader{
    
    
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadTableViewDataSource];
    }];
    self.mTableView.mj_header = header;
    
    [header setTitle:@"" forState:MJRefreshStateIdle];
    [header setTitle:@"" forState:MJRefreshStatePulling];
    [header setTitle:@"" forState:MJRefreshStateRefreshing];
    [self reloadTableViewDataSource];
}


-(void)endHeaderRereshing
{
    if (self.mTableView.mj_footer != nil) {
        if (self.tableArr.count > 0)
            self.mTableView.mj_footer.hidden = NO;
        else
            self.mTableView.mj_footer.hidden = YES;
    }
    
    self.tableIsReloading = NO;
    
    [self.mTableView reloadData];
    [self.mTableView.mj_header endRefreshing];
}
- (void)reloadTableViewData{

    [self beginHeaderRereshing];
}
#pragma mark----****----加载数据
- (void)reloadTableViewDataSource{

    [super reloadTableViewDataSource];
    
    LKDBHelperAddress *mAddress = [Util ZLGetLocalDataWithKey:kAddressCommunity];
    LKDBHomeData *mHomeCacke = [Util ZLGetLocalDataWithKey:kHomeData];
    if (mHomeCacke == nil) {
        mHomeCacke = [LKDBHomeData new];
    }
    if (mAddress) {
        mCommunityObj = mAddress.mAddress;
        mLocationView.mAddress.text = mCommunityObj.cmut_name;
    }else{
        [self loadAddress];
    }
    
    if (mCommunityObj.cmut_lat <= 0 || mCommunityObj.cmut_lng <= 0 ) {
        [self ZLHomLocationViewDidSelected];
        [self endHeaderRereshing];

        return;
    }
    
    [[APIClient sharedClient] ZLgetHomeBanner:^(APIObject *mBaseObj, ZLHomeFunvtionAndBanner *mFunc) {
        [mBannerArr removeAllObjects];
        [mFunctionArr removeAllObjects];
        [SVProgressHUD dismiss];

        [self ZLHideEmptyView];
        if (mBaseObj.code == RESP_STATUS_YES) {

            [mBannerArr addObjectsFromArray:mFunc.banners];
            [mFunctionArr addObjectsFromArray:mFunc.functions];
  
            mHomeCacke.mBannerArr  = mFunc.banners;
            mHomeCacke.mFunctionArr = mFunc.functions;
            
        }else{
            if (mHomeCacke != nil) {
                [mBannerArr addObjectsFromArray:mHomeCacke.mBannerArr];
                [mFunctionArr addObjectsFromArray:mHomeCacke.mFunctionArr];
            }else{
                [self showErrorStatus:mBaseObj.msg];
                
                [self addEmptyView:_mTableView andType:ZLEmptyViewTypeWithNoNet];
            }
            
        }
        [_mTableView reloadData];
        [self endHeaderRereshing];
        MLLog(@"迈左腿");
    }];
    
    [[APIClient sharedClient] ZLGetHome:[NSString stringWithFormat:@"%f", mCommunityObj.cmut_lat] andLng:[NSString stringWithFormat:@"%f", mCommunityObj.cmut_lng] block:^(APIObject *mBaseObj, ZLHomeObj *mHome) {
        [mComDataSourceArr removeAllObjects];
        [mAdvDataSourceArr removeAllObjects];
        if (mBaseObj.code == RESP_STATUS_YES) {

            [mAdvDataSourceArr addObjectsFromArray:mHome.sAdvertList];
            [mComDataSourceArr addObjectsFromArray:mHome.eCompanyNoticeList];
            mHomeCacke.mAdvArr = mHome.sAdvertList;
            mHomeCacke.mCampArr = mHome.eCompanyNoticeList;
            
        }else{
            if (mHomeCacke != nil) {
                [mAdvDataSourceArr addObjectsFromArray:mHomeCacke.mAdvArr];
                [mComDataSourceArr addObjectsFromArray:mHomeCacke.mCampArr];
            }else{
                [self showErrorStatus:mBaseObj.msg];
            }
        }
        [_mTableView reloadData];
        [self endHeaderRereshing];
        MLLog(@"迈右腿");
        [Util ZLSaveLocalData:mHomeCacke withKey:kHomeData];

    }];
    
    
}
#pragma mark----****----加载地址
- (void)loadAddress{

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationStateChange:) name:LocationStateNoti object:nil];
//    
//    [OnlyLocationManager shareManager:NO needVO:YES initCallBack:^(LocationInitType type, CLLocationManager *manager) {
//        
//    } resultCallBack:^(CLLocationCoordinate2D coordinate, CLLocation *location, OnlyLocationVO *locationVO) {
//        [self locationSuccess:locationVO];
//    }];

    [CurentLocation sharedManager].delegate = self;
    [[CurentLocation sharedManager] getUSerLocation];
    

}
#pragma mark----maplitdelegate
- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate{
    
    MLLog(@"定位成功之后返回的东东：%@",mCoordinate);
    mCommunityObj.cmut_lat = [[mCoordinate objectForKey:@"wei"] doubleValue];
    mCommunityObj.cmut_lng = [[mCoordinate objectForKey:@"jing"] doubleValue];
    
}

-(void)locationSuccess:(OnlyLocationVO *)locationVO{

    MLLog(@"定位成功之后返回的东东：%@",locationVO);

    mCommunityObj.cmut_lat = locationVO.location.latitude;
    mCommunityObj.cmut_lng = locationVO.location.longitude;
    

}
-(void)locationStateChange:(NSNotification* )noti{
    OnlyLocationManager* manager = [OnlyLocationManager getLocationManager];
    NSLog(@"%ld",manager.state);
    
    NSString* stateStr = @"初始化";
    switch (manager.state) {
        case 0:
            stateStr = @"初始化失败";
            break;
        case 1:
            stateStr = @"定位中";
            break;
        case 2:
            stateStr = @"已获取初始位置并持续定位中";
            break;
        case 3:
            stateStr = @"已定位，正在逆地理编码";
            break;
        case 4:
            stateStr = @"已定位，逆地理编码完成";
            break;
        case 5:
            stateStr = @"已定位，逆地理编码失败";
            break;
    }
    
    MLLog(@"%@",stateStr);
    self.title = stateStr;
}
//
//
//#pragma mark----maplitdelegate
//- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate{
//    
//    MLLog(@"定位成功之后返回的东东：%@",mCoordinate);
//    mCommunityObj.cmut_lat = [[mCoordinate objectForKey:@"wei"] doubleValue];
//    mCommunityObj.cmut_lng = [[mCoordinate objectForKey:@"jing"] doubleValue];
//}


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
    if (tableView == self.mTableView) {
        return 3;
    }else{
    
        return 1;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.mTableView) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 1;
        } else if (section == 2) {
            return mComDataSourceArr.count;
        }

    }else{
        
        return mSystemCoupList.count;
    }
 
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.mTableView) {
        if (indexPath.section == 0) {
            
            if (mFunctionArr.count<=4) {
                return 360-90;
            }else{
                return 360;
            }
            
            
        }else{
            return 200;
        }
    }else{
        
        return 70;
    }
    

    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (tableView == self.mTableView) {
        if (indexPath.section == 0) {
            reuseCellId = @"cell1";
            
            ZLHomeScrollerTableViewCell  *cell = [[ZLHomeScrollerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId andBannerDataSource:mBannerArr andDataSource:mFunctionArr];
            
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delegate = self;
            
            return cell;
        }else{
            
    
            reuseCellId = @"cell2";
            
            ZLHomeOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            if (indexPath.section == 1) {
//                ZLHomeAdvList *mAdv = mAdvDataSourceArr[indexPath.row];
//                [cell.mImage sd_setImageWithURL:[NSURL imageurl:mAdv.adv_image] placeholderImage:[UIImage imageNamed:@"ZLDefault_Activity"]];
                [cell setMDataSource:mAdvDataSourceArr];
            } else {
                ZLHomeCompainNoticeList *mCampain = mComDataSourceArr[indexPath.row];
                
                [cell.mImage sd_setImageWithURL:[NSURL imageurl:mCampain.not_image] placeholderImage:[UIImage imageNamed:@"ZLDefault_Activity"]];
            }

            
            return cell;
        }

    }else{
        
        reuseCellId = @"CoupCell";
        
        ZLHomeCoupCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setMCoup:mSystemCoupList[indexPath.row]];
        return cell;
    }
    

    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.mTableView) {
        
        if (indexPath.section == 1) {
            if (mComDataSourceArr.count <=0 && mAdvDataSourceArr.count <= 0) {
                
            }else if (mComDataSourceArr && mAdvDataSourceArr.count <= 0){
                
                ZLHomeCompainNoticeList *mCampain = mComDataSourceArr[indexPath.row];
                ZLWebVc *vc = [ZLWebVc new];
                vc.mUrl = [NSString stringWithFormat:@"%@/wap/wcmutNotice/findNotice?user_id=%d&not_id=%d",[[APIClient sharedClient] currentUrl],[ZLUserInfo ZLCurrentUser].user_id,mCampain.not_id];
                vc.mTitle = mCampain.not_title;
                [self pushViewController:vc];

            }else{

            }

        }
        
    }else{
        [self hiddenCoupView];
    }
    
    
   
}
#pragma mark ----****----首页滚动分类功能代理方法
- (void)ZLHomeScrollerTableViewCellDidSelectedWithIndex:(NSInteger)mIndex{

    MLLog(@"点击了第:%ld个",(long)mIndex);
    
    ZLHomeFunctions *mFunc =  mFunctionArr[mIndex];
    
    switch (mFunc.fct_type) {
        case ZLHomeFunctionTypeQuik:
        {
            LifePayVC *vc = [[LifePayVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushViewController:vc];

        }
            break;
        case ZLHomeFunctionTypeSuperMarket:
        {

            ZLSuperMarketViewController *mSuperMarketVC = [ZLSuperMarketViewController new];
            mSuperMarketVC.mType = ZLShopTypeSuperMarket;
            mSuperMarketVC.mLat = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lat];
            mSuperMarketVC.mLng = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lng];
            mSuperMarketVC.hidesBottomBarWhenPushed = YES;
            [self pushViewController:mSuperMarketVC];

        }
            break;
        case ZLHomeFunctionTypeRepair:
        {
            
            ZLTenementRepairsViewController *ZLFixVC = [ZLTenementRepairsViewController new];
            ZLFixVC.hidesBottomBarWhenPushed = YES;
            ZLFixVC.mType = ZLShopTypeFix;
            ZLFixVC.mLat = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lat];
            ZLFixVC.mLng = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lng];
            [self pushViewController:ZLFixVC];

        }
            break;
        case ZLHomeFunctionTypeHouseKeeping:
        {
            
            DryCleanShopTVC *vc = [[DryCleanShopTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.mType = ZLShopTypeHouseKeeping;
            vc.mLat = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lat];
            vc.mLng = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lng];
            [self pushViewController:vc];

        }
            break;
        case ZLHomeFunctionTypeConvenience:
        {
            BianMingVC *vc = [[BianMingVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushViewController:vc];
  

        }
            break;
        case ZLHomeFunctionTypeRunningMan:
        {

            ZLRunningManViewController *ZLFixVC = [ZLRunningManViewController new];
            ZLFixVC.hidesBottomBarWhenPushed = YES;
            ZLFixVC.mAddress = mCommunityObj;
            [self pushViewController:ZLFixVC];
            
        }
            break;
        case ZLHomeFunctionTypeNote:
        {
            ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
            if (user == nil) {
                [ZLLoginViewController startPresent:self];
                return;
            }
            
            ZLAnounceMentViewController *vc = [[ZLAnounceMentViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushViewController:vc];
        }
            break;
        case ZLHomeFunctionTypeNeighbor:
        {
            ZLNeighbourhoodViewController *vc= [[ZLNeighbourhoodViewController alloc] init];
            vc.navigationItem.title = @"邻里圈";
            vc.hidesBottomBarWhenPushed = YES;
            [self pushViewController:vc];
        }
            break;
            
            
        default:
            break;
    }


}
#pragma mark ----****----banner点击方法
- (void)ZLHomeBannerDidSelectedWithIndex:(NSInteger)mIndex{
    MLLog(@"点击了第:%ld个",(long)mIndex);
    
    ZLHomeBanner *mBaner = mBannerArr[mIndex];
//    if (mBaner.bnr_url.length>0) {
//        ZLWebVc *vc = [ZLWebVc new];
//        vc.mUrl = mBaner.bnr_url;
//        vc.hidesBottomBarWhenPushed = YES;
//        
//        [self pushViewController:vc];
//    }

}
#pragma mark ----****----优惠券view
- (void)initCoupView{

    mCoupView = [ZLHomeCoupView shareView];
    mCoupView.delegate = self;
    mCoupView.mCoupTableView.delegate = self;
    mCoupView.mCoupTableView.dataSource = self;
    mCoupView.frame = self.view.bounds;
    mCoupView.alpha = 0;
    mCoupView.mCoupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mCoupView.mCoupTableView.backgroundColor = [UIColor clearColor];
    UINib   *nib = [UINib nibWithNibName:@"ZLHomeCoupCell" bundle:nil];
    [mCoupView.mCoupTableView registerNib:nib forCellReuseIdentifier:@"CoupCell"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:mCoupView];
    
    UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapACount)];
    [mCoupView addGestureRecognizer:mTap];
    [self loadSystemCoup];
    
}
#pragma mark ----****----加载优惠券数据源
- (void)loadSystemCoup{
    
    [[APIClient sharedClient] ZLGetSystemCoupList:^(APIObject *mBaseObj, NSArray *List) {
        [mSystemCoupList removeAllObjects];
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            if (List.count>0) {
                [self showCoupView];
                [mSystemCoupList addObjectsFromArray:List];
                
                [mCoupView.mCoupTableView reloadData];
                [[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil];
            }else{
                [self hiddenCoupView];
            }
            
        }else{
            [self hiddenCoupView];
        }
    }];
}
#pragma mark ----****----隐藏优惠券view
- (void)tapACount{
    
    [self hiddenCoupView];
}
#pragma mark ----****----显示优惠券view
- (void)showCoupView{
    
    [UIView animateWithDuration:0.5 animations:^{
        mCoupView.alpha = 1;
    }];

}
#pragma mark ----****----隐藏优惠券view
- (void)hiddenCoupView{
    [UIView animateWithDuration:0.25 animations:^{
        mCoupView.alpha = 0;
    }];
}
#pragma mark ----****----隐藏优惠券view
- (void)ZLCoupOKBtnSelected{
    [self hiddenCoupView];
}
#pragma mark ----****----模块cell点击代理方法
/**
 点击代理方法
 
 @param mIndex 索引
 */
- (void)ZLHomeOtherCellFuncDidSelectedWithIndex:(NSInteger)mIndex{
    MLLog(@"点击了------%ld",(long)mIndex);
    
    ZLHomeAdvList *mAdv = mAdvDataSourceArr[mIndex];
    
    if (mAdv.adv_click_type == 1) {

        ZLSuperMarketShopViewController *ZLSuperMarketShopVC = [ZLSuperMarketShopViewController new];
        ZLSuperMarketShopVC.mType = kOrderClassType_product;
        ZLSuperMarketShopVC.mShopBaseObj = [ZLShopHomeShopObj new];
        ZLSuperMarketShopVC.mShopBaseObj.shop_id = mAdv.shop_id;
        ZLSuperMarketShopVC.title = mAdv.adv_title;
        
        ZLSuperMarketShopVC.hidesBottomBarWhenPushed = YES;
        
        [self pushViewController:ZLSuperMarketShopVC];
    }else{

        ZLWebVc *vc = [ZLWebVc new];
        vc.mUrl = mAdv.adv_click_url;
        vc.mTitle = mAdv.adv_title;
        vc.hidesBottomBarWhenPushed = YES;
        
        [self pushViewController:vc];
    }
    
    

}
@end
