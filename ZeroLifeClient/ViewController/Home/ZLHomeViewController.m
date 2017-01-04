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

#define NAVBAR_CHANGE_POINT 30
@interface ZLHomeViewController ()<UITableViewDelegate,UITableViewDataSource,ZLHomeScrollerTableCellDelegate,ZLHomeLocationViewDelegate,ZLCoupViewDelegate,AMapLocationManagerDelegate,MMApBlockCoordinate>
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";

    [self appInit];
    mCommunityObj = [CommunityObject new];
    
    NSNotificationCenter *mNotify = [NSNotificationCenter defaultCenter];
    [mNotify addObserver:self selector:@selector(webAction:) name:@"ZLAdView" object:nil];
    
    [self initAdView];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(10, -60) forBarMetrics:UIBarMetricsDefault];

    
    mBannerArr = [NSMutableArray new];
    mFunctionArr = [NSMutableArray new];
    mCoupArr = [NSMutableArray new];
    
    mAdvDataSourceArr = [NSMutableArray new];
    mComDataSourceArr = [NSMutableArray new];


    self.mTableView.dataSource = self;
    self.mTableView.delegate = self;
    self.mTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    [self initLeftAndRightBarButton];
//    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLHomeOtherCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"cell2"];

    
    [self initCoupView];
    
//    [self loadData];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    [self TableViewHaveHeader];

    [self loadAddress];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserInfoNeedChange:) name:MyUserNeedUpdateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserInfoChange:) name:MyUserInfoChangedNotification object:nil];
    
}

#pragma mark----****----用户需要更新数据
-(void)handleUserInfoNeedChange:(NSNotification *)note
{
    [[APIClient sharedClient] userInfoWithTag:self call:^(ZLUserInfo *user, APIObject *info) {
        
    }];
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
}
- (void)initAdView{
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    NSMutableArray *images = [NSMutableArray new];
    
    [images addObject:[UIImage imageNamed:@"ZLGuideImg1"]];
    [images addObject:[UIImage imageNamed:@"ZLGuideImg2"]];
    [images addObject:[UIImage imageNamed:@"ZLGuideImg3"]];
    
    HcdGuideView *guideView = [HcdGuideView sharedInstance];
    guideView.window = window;
    [guideView showGuideViewWithImages:images
                        andButtonTitle:@" "
                   andButtonTitleColor:[UIColor whiteColor]
                      andButtonBGColor:[UIColor clearColor]
                  andButtonBorderColor:[UIColor whiteColor]];
    
    
    
    
        

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = M_CO;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (scrollView ==  self.mTableView) {
        MLLog(@"YYYYY是：%f",offsetY);
        if (offsetY > NAVBAR_CHANGE_POINT) {
            CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
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
    MLLog(@"----******:%@",[ZLAPPInfo ZLCurrentAppInfo].set.fig_phone);
    
    
    ZLHomeMessageViewController *ZLHomeMsgVC = [ZLHomeMessageViewController new];
    ZLHomeMsgVC.hidesBottomBarWhenPushed = YES;

    [self pushViewController:ZLHomeMsgVC];
    
//    ZLLoginViewController *vc = [ZLLoginViewController new];
//    ZLWebViewViewController *vc = [ZLWebViewViewController new];
//    ZLOrderReturnViewController *vc = [ZLOrderReturnViewController new];
//    ZLRatingViewController *vc = [ZLRatingViewController new];

    

//    vc.hidesBottomBarWhenPushed = YES;
//    vc.mUrl = @"www.baidu.com";
//    vc.title = @"web";

//    [self pushViewController:vc];
    
    
    
    
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
#pragma mark----****----加载数据
- (void)reloadTableViewDataSource{

    [super reloadTableViewDataSource];

    if (mCommunityObj.cmut_lat <= 0 || mCommunityObj.cmut_lng <= 0 ) {
        [self loadAddress];

        return;
    }
    
    [[APIClient sharedClient] ZLgetHomeBanner:^(APIObject *mBaseObj, ZLHomeFunvtionAndBanner *mFunc) {
        [mBannerArr removeAllObjects];
        [mFunctionArr removeAllObjects];

        [self ZLHideEmptyView];
        if (mBaseObj.code == RESP_STATUS_YES) {

            [mBannerArr addObjectsFromArray:mFunc.banners];
            [mFunctionArr addObjectsFromArray:mFunc.functions];
  
        
        }else{
        
            [self showErrorStatus:mBaseObj.msg];
            [self ZLShowEmptyView:mBaseObj.msg andImage:nil andHiddenRefreshBtn:NO];
        }
        [self endHeaderRereshing];

    }];
    
    [[APIClient sharedClient] ZLGetHome:[NSString stringWithFormat:@"%f", mCommunityObj.cmut_lat] andLng:[NSString stringWithFormat:@"%f", mCommunityObj.cmut_lng] block:^(APIObject *mBaseObj, ZLHomeObj *mHome) {
        [mComDataSourceArr removeAllObjects];
        [mAdvDataSourceArr removeAllObjects];
        if (mBaseObj.code == RESP_STATUS_YES) {

            [mAdvDataSourceArr addObjectsFromArray:mHome.sAdvertList];
            [mComDataSourceArr addObjectsFromArray:mHome.eCompanyNoticeList];
            
        }else{
        
            [self showErrorStatus:mBaseObj.msg];
        }
        [self endHeaderRereshing];

    }];
    
    
}
#pragma mark----****----加载地址
- (void)loadAddress{
    
    [CurentLocation sharedManager].delegate = self;
    [[CurentLocation sharedManager] getUSerLocation];
    
    mLocation = [[AMapLocationManager alloc] init];
    mLocation.delegate = self;
    [mLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    mLocation.locationTimeout = 3;
    mLocation.reGeocodeTimeout = 3;
    [mLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSString *eee =@"定位失败！请检查网络和定位设置！";
            mLocationView.mAddress.text = eee;

            [self showErrorStatus:eee];
            MLLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            [self ZLHomLocationViewDidSelected];
        }

        
        if (regeocode)
        {
            
            MLLog(@"location:%f", location.coordinate.latitude);
            
            mCommunityObj.cmut_lat = location.coordinate.latitude;
            mCommunityObj.cmut_lng = location.coordinate.longitude;
            
            MLLog(@"reGeocode:%@", regeocode);
            mLocationView.mAddress.text = [NSString stringWithFormat:@"%@%@",regeocode.street,regeocode.number];
            
            [self reloadTableViewDataSource];

        }
    }];

}
#pragma mark----maplitdelegate
- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate{
    
    MLLog(@"定位成功之后返回的东东：%@",mCoordinate);
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
    if (tableView == self.mTableView) {
        
        if (mComDataSourceArr.count <=0 && mAdvDataSourceArr.count <= 0) {
            return 1;
        }else if ((mComDataSourceArr && mAdvDataSourceArr.count <= 0) || (mAdvDataSourceArr && mComDataSourceArr.count <= 0)){
            return 2;
        }else{
            return 3;
        }
        
        
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
        }else {
            if (mComDataSourceArr.count <=0 && mAdvDataSourceArr.count <= 0) {
                return mComDataSourceArr.count;
            }else if (mComDataSourceArr && mAdvDataSourceArr.count <= 0){
                return mComDataSourceArr.count;
            }else{
                return mAdvDataSourceArr.count;
            }

        }
    }else{
        
        return 5;
    }
 
    
    
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
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (mComDataSourceArr.count <=0 && mAdvDataSourceArr.count <= 0) {
                
            }else if (mComDataSourceArr && mAdvDataSourceArr.count <= 0){
                
                ZLHomeCompainNoticeList *mCampain = mComDataSourceArr[indexPath.row];
                
                [cell.mImage sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mCampain.not_image]] placeholderImage:[UIImage imageNamed:@"ZLDefault_Activity"]];
            }else{
                ZLHomeAdvList *mAdv = mAdvDataSourceArr[indexPath.row];
                [cell.mImage sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mAdv.adv_image]] placeholderImage:[UIImage imageNamed:@"ZLDefault_Activity"]];
            }
            
            return cell;
        }

    }else{
        
        reuseCellId = @"CoupCell";
        
        ZLHomeCoupCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    

    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.mTableView) {
//        [self showCoupView];
        
        if (indexPath.section == 1) {
            if (mComDataSourceArr.count <=0 && mAdvDataSourceArr.count <= 0) {
                
            }else if (mComDataSourceArr && mAdvDataSourceArr.count <= 0){
                
                ZLHomeCompainNoticeList *mCampain = mComDataSourceArr[indexPath.row];
                ZLWebVc *vc = [ZLWebVc new];
//                vc.mUrl = mCampain.adv_click_url;
                vc.hidesBottomBarWhenPushed = YES;

                [self pushViewController:vc];
            }else{
                ZLHomeAdvList *mAdv = mAdvDataSourceArr[indexPath.row];
                ZLWebVc *vc = [ZLWebVc new];
                vc.mUrl = mAdv.adv_click_url;
                vc.hidesBottomBarWhenPushed = YES;

                [self pushViewController:vc];
            }

        }
        
    }else{
        [self hiddenCoupView];
    }
    
    
   
}
#pragma mark ----****----首页滚动分类功能代理方法
- (void)ZLHomeScrollerTableViewCellDidSelectedWithIndex:(NSInteger)mIndex{

    MLLog(@"点击了第:%ld个",(long)mIndex);
    if (mIndex == 0) {
        LifePayVC *vc = [[LifePayVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushViewController:vc];
        
    } else if (mIndex == 1) {
        ZLSuperMarketViewController *mSuperMarketVC = [ZLSuperMarketViewController new];
        mSuperMarketVC.mType = ZLShopTypeSuperMarket;
        mSuperMarketVC.mLat = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lat];
        mSuperMarketVC.mLng = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lng];
        mSuperMarketVC.hidesBottomBarWhenPushed = YES;
        [self pushViewController:mSuperMarketVC];
        
    }else if (mIndex == 2){
        ZLTenementRepairsViewController *ZLFixVC = [ZLTenementRepairsViewController new];
        ZLFixVC.hidesBottomBarWhenPushed = YES;
        ZLFixVC.mType = ZLShopTypeFix;
        ZLFixVC.mLat = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lat];
        ZLFixVC.mLng = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lng];
        [self pushViewController:ZLFixVC];
    }
    else if (mIndex == 3) {
        DryCleanShopTVC *vc = [[DryCleanShopTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.mType = ZLShopTypeHouseKeeping;
        vc.mLat = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lat];
        vc.mLng = [NSString stringWithFormat:@"%f", mCommunityObj.cmut_lng];
        [self pushViewController:vc];
    }
	else if (mIndex == 5){
        ZLRunningManViewController *ZLFixVC = [ZLRunningManViewController new];
        ZLFixVC.hidesBottomBarWhenPushed = YES;
        ZLFixVC.mAddress = mCommunityObj;
        [self pushViewController:ZLFixVC];
    }
    else if (mIndex == 4) {
        BianMingVC *vc = [[BianMingVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushViewController:vc];
    }
    else if (mIndex == 6) {
        ZLAnounceMentViewController *vc = [[ZLAnounceMentViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushViewController:vc];
    }

}
#pragma mark ----****----banner点击方法
- (void)ZLHomeBannerDidSelectedWithIndex:(NSInteger)mIndex{
    MLLog(@"点击了第:%ld个",(long)mIndex);
    
    ZLHomeBanner *mBaner = mBannerArr[mIndex];
    
    
    

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
    
}
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
@end
