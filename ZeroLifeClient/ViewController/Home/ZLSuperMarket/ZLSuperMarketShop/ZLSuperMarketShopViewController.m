//
//  ZLSuperMarketShopViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketShopViewController.h"
#import "ZLSuperMarketHeaderView.h"

#import "ZLSuperMarketShopLeftCellType.h"
#import "ZLSuperMarketShopRightCell.h"
#import "ZLSuperMarketShopCarView.h"
#import "ZLSuperMArketSearchGoodsView.h"
#import "ZLSuperMarketShopCarViewController.h"
#import "ZLSuperMarketCommitOrderViewController.h"

#import "ZLGoodsDetailViewController.h"

#import "ZLHouseKeppingServiceCell.h"

#import "ZLSpeSelectedViewCell.h"
#import "ZLSpeHeaderView.h"

#import "ZLShopCampainSubView.h"

#import "StandardsView.h"
#import "ZLSkuCell.h"
#import "LDXScore.h"
#import "mCheckMoreActivityView.h"
#import <LKDBHelper.h>
#import "ZLSuperMarketCommitOrderViewController.h"


static const CGFloat mTopH = 156;

@interface ZLSuperMarketShopViewController ()<UITableViewDelegate,UITableViewDataSource,ZLSuperMarketShopDelegate,ZLSuperMarketGoodsCellDelegate,UIScrollViewDelegate,ZLSuperMarketShopCarDelegate,ZLSuperMarketGoodsSpecDelegate,UICollectionViewDelegate,ZLHouseKeppingServiceCellDelegate,ZLSpeSelectedViewCellDelegate,StandardsViewDelegate,ZLSKUCellDelegate,LDXScoreDelegate,mCheckMoreActivityViewDelegate>

/**
 规格瀑布流
 */
@property (nonatomic, strong) UITableView *mSpeTableView;

/**
 选择规格数据源
 */
@property (nonatomic, strong) NSMutableArray *mSpeAddArray;


@property (nonatomic, strong) NSMutableArray *mSelectedSpeArray;



@property (nonatomic, strong) NSMutableArray *mAddSkuArray;


@property(strong,nonatomic)ZLSpeHeaderView *mSpeHeaderView;



@end

@implementation ZLSuperMarketShopViewController
{
    ///店铺header
    ZLSuperMarketHeaderView *mHeaderView;
    ///左边的列表的数据源
    NSMutableArray *mLeftDataArr;
    ///右边列表的数据源
    NSMutableArray *mRightDataArr;
    ///左边的列表
    UITableView *mLeftTableView;
    ///右边的列表
    UITableView *mRightTableView;
    ///通用headerview
    UIView *mGeneraHeaderView;
    
    CGRect mRect;
    
//    UIScrollView *mMainView;
    ///地步view
    ZLSuperMarketShopCarView *mBottomView;
    ///搜索view
    ZLSuperMArketSearchGoodsView *mSearchView;
    ///规格view
    ZLSuperMArketSearchGoodsView *mSpeView;

    BOOL mIsScroller;
    
    
    ZLShopObj *mShopObj;
    ///店铺活动子view
    ZLShopCampainSubView *mCampSubView;
    
    ZLShopLeftTableArr *mLeftDataSource;
    
    ZLRightGoodsType mRightTabType;
    ///加入购物车扩展对象
    ZLAddShopCarExObj *mAddShopCarEx;
    
    ///查看更多活动view
    mCheckMoreActivityView *mMoreCampView;
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self loadData];
    [self updateBottomView:mAddShopCarEx];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.mShopObj.shop_name;

    self.mSpeAddArray = [NSMutableArray new];
    
    mLeftDataArr = [NSMutableArray new];
    mRightDataArr = [NSMutableArray new];
    self.mSelectedSpeArray = [NSMutableArray new];
    self.mAddSkuArray = [NSMutableArray new];

    mAddShopCarEx = [ZLAddShopCarExObj new];
    mLeftDataSource = [ZLShopLeftTableArr new];
    
    [self addRightBtn:NO andTitel:nil andImage:[UIImage imageNamed:@"ZLSearch_white"]];

    mShopObj = [ZLShopObj new];
    [self initView];
    [self initHeaderView];
    [self initSpeView];
    [self initMoreCampView];
    [self loadData];
}

- (void)loadView{

    [super loadView];

}

#pragma mark----****----加载headerview
- (void)initHeaderView{
    mHeaderView = [ZLSuperMarketHeaderView shareView];
    mHeaderView.mRateBtn.hidden = YES;
    mHeaderView.delegaate = self;
    [self.view addSubview:mHeaderView];
    
    [mHeaderView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(64);
        make.height.offset(@156);
    }];
    
    

}
- (void)loadData{
    [self showWithStatus:@"正在加载..."];
    
    [[APIClient sharedClient] ZLGetShopMsgWithShopType:1 andShopId:self.mShopObj.shop_id block:^(APIObject *mBaseObj, ZLShopObj *mShop,ZLShopLeftTableArr *mLeftTabArr) {
        
        [mLeftDataArr removeAllObjects];
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self dismiss];
            mShopObj = mShop;
            
            NSMutableArray *mCamArr = [NSMutableArray new];
            
            for (ZLShopCampain *mCam in mLeftTabArr.mCampainArr) {
                if (mCam.cam_is_goods == 1) {
                    [mCamArr addObject:mCam];
                }
            }
            
            mLeftDataSource.mCampainArr = mCamArr;
            mLeftDataSource.mClassArr = mLeftTabArr.mClassArr;
            mLeftDataSource.mLeftType = mLeftTabArr.mLeftType;

            [self upDatePage:mShop];
            [self updaMoreView:mShop];
            [mLeftTableView reloadData];
            [self updateBottomView:mAddShopCarEx];
        }else{
        
            [self showErrorStatus:mBaseObj.msg];
            [self ZLShowEmptyView:mBaseObj.msg andImage:nil andHiddenRefreshBtn:YES];
        }
        
    }];
}
- (void)upDatePage:(ZLShopObj *)mShop{
    
    [mHeaderView.mShopLogo sd_setImageWithURL:[NSURL URLWithString:mShop.mShopMsg.shop_logo] placeholderImage:[UIImage imageNamed:@"ZLDefault_Shop"]];
    self.navigationItem.title = mShop.mShopMsg.shop_name;
    
    mHeaderView.mContent.text = [NSString stringWithFormat:@"满%.0f元起送 %@",mShop.mShopMsg.ext_min_price,mShop.mShopMsg.ext_max_time];
    mHeaderView.mSubContent.text = [NSString stringWithFormat:@"月销售:%d单",mShop.mShopMsg.ext_sales_month];
    
    
    mHeaderView.mCoupBtn.hidden = [Util iscoupon:mShop.mShopCoupon.is_coupon];
    
    NSInteger mScore = [[NSString stringWithFormat:@"%.1f",mShop.mShopMsg.ext_score] integerValue];
    
  
    mHeaderView.mScoreView.isSelect = NO;
    mHeaderView.mScoreView.delegate = self;
    mHeaderView.mScoreView.show_star = mScore;


    
    CGRect mHeadFrame = mHeaderView.frame;
    
    CGFloat mH = 0;
    
    for (ZLShopCampainSubView *vvv in mHeaderView.mActivityView.subviews) {
        [vvv removeFromSuperview];
    }
    if (mShop.mShopCampains.count > 0) {
        
        for (int i =0; i<mShop.mShopCampains.count; i++) {
     
            if (i >= 1) {
                return;
            }
            
            ZLShopCampain *mCampain = mShop.mShopCampains[i];
            
            mCampSubView = [ZLShopCampainSubView shareView];
            mCampSubView.frame = CGRectMake(0, 30*i, mHeaderView.mActivityView.mwidth, 30);
            
            mCampSubView.mTitle.text = [Util ZLCutStringWithText:mCampain.cam_name andRangeWithLocation:0 andRangeWithLength:1];
            mCampSubView.mContent.text = mCampain.cam_name;
            [mHeaderView.mActivityView addSubview:mCampSubView];
            mH+=30;
        }
    }else{
        mCampSubView = [ZLShopCampainSubView shareView];
        mCampSubView.frame = CGRectMake(0, 0, mHeaderView.mActivityView.mwidth, 30);
        
        mCampSubView.mTitle.text = @"无";
        mCampSubView.mContent.text = @"暂无活动";
        [mHeaderView.mActivityView addSubview:mCampSubView];
        mH = 30;
    }
    
   
    mHeadFrame.size.height = 126+mH;
    mHeaderView.frame = mHeadFrame;
    
    
  

}
#pragma mark----****----更新底部数量和总价
///更新底部数量和总价
- (void)updateBottomView:(ZLAddShopCarExObj *)mEx{
    
    NSInteger num = 0;
    float price = 0.0;
    
    NSArray *mLKDArr =  [LKDBHelperGoodsObj searchWithWhere:[NSString stringWithFormat:@"%d",self.mShopObj.shop_id]];
    num = mLKDArr.count;
    
    for (int i = 0; i<mLKDArr.count; i++) {
        LKDBHelperGoodsObj *mLKD = mLKDArr[i];
        price+=mLKD.mExtObj.mTotlePrice;
    }
    
    if (num<=0) {
        num=0;
    }if (price<=0) {
        price=0;
    }
    
    if (num<=0) {
        mBottomView.mNum.hidden = YES;
    }else{
    
        mBottomView.mNum.hidden = NO;

    }
    
    NSString *mbtnContent = nil;
    
    if (price<mShopObj.mShopMsg.ext_min_price) {
        mbtnContent = [NSString stringWithFormat:@"还差%.2f元起送",mShopObj.mShopMsg.ext_min_price-price];
        mBottomView.mGopayBtn.userInteractionEnabled = NO;
        [mBottomView.mGopayBtn setBackgroundColor:[UIColor lightGrayColor]];
    }else if (price<=0){
        mbtnContent = [NSString stringWithFormat:@"还差%.2f元起送",mShopObj.mShopMsg.ext_min_price];
        mBottomView.mGopayBtn.userInteractionEnabled = NO;
        [mBottomView.mGopayBtn setBackgroundColor:[UIColor lightGrayColor]];
    }else{
        mbtnContent = @"去结算";
        mBottomView.mGopayBtn.userInteractionEnabled = YES;
        [mBottomView.mGopayBtn setBackgroundColor:[UIColor redColor]];
    }
    [mBottomView.mGopayBtn setTitle:mbtnContent forState:0];
    mBottomView.mNum.text = [NSString stringWithFormat:@"%lu",(unsigned long)mLKDArr.count];

    mBottomView.mTotlePrice.text = [NSString stringWithFormat:@"总价：%.2f元",price];
    
}
- (void)LDXScoreWithScore:(NSInteger)mScore{
    
    MLLog(@"分数是：%ld",(long)mScore);
}
- (void)initView{

   
    mLeftTableView = [UITableView new];
    mLeftTableView.delegate = self;
    mLeftTableView.dataSource = self;
    mLeftTableView.layer.masksToBounds = YES;
    mRightTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    mLeftTableView.layer.borderColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.96 alpha:1.00].CGColor;
    mLeftTableView.layer.borderWidth = 0.5;
    [self.view addSubview:mLeftTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLSuperMarketShopLeftCellType" bundle:nil];
    [mLeftTableView registerNib:nib forCellReuseIdentifier:@"mLeftCell"];

    
    mRightTableView = [UITableView new];
    mRightTableView.delegate = self;
    mRightTableView.dataSource = self;
    mRightTableView.layer.masksToBounds = YES;
    mRightTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    mRightTableView.layer.borderColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.96 alpha:1.00].CGColor;
    mRightTableView.layer.borderWidth = 0.5;
    [self.view addSubview:mRightTableView];
    
    nib = [UINib nibWithNibName:@"ZLSuperMarketShopRightSpecCell" bundle:nil];
    [mRightTableView registerNib:nib forCellReuseIdentifier:@"mRightCell"];

    nib = [UINib nibWithNibName:@"ZLHouseKeppingServiceCell" bundle:nil];
    [mRightTableView registerNib:nib forCellReuseIdentifier:@"mHouseKeepCell"];
    
    [mLeftTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view).offset(-50);
        make.right.equalTo(mRightTableView.left).offset(0);
        make.width.offset(DEVICE_Width/3);
    }];
    
    [mRightTableView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view).offset(-50);
        make.left.equalTo(mLeftTableView.right).offset(0);
        make.width.offset(DEVICE_Width-DEVICE_Width/3);
    }];
    
    mLeftTableView.contentInset = UIEdgeInsetsMake(mTopH, 0, 0, 0);
    mRightTableView.contentInset = UIEdgeInsetsMake(mTopH, 0, 0, 0);

    mBottomView = [ZLSuperMarketShopCarView shareView];
    mBottomView.delegate = self;
    mBottomView.mNum.hidden = YES;
    mBottomView.mTotlePrice.text = @"";
    [self.view addSubview:mBottomView];
    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.height.offset(@60);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    if (tableView == mLeftTableView) {
        
        if (mLeftDataSource.mLeftType == 1 || mLeftDataSource.mLeftType == 2) {
            return 1;
        }else{
            return 2;
        }
        
    }else
        return 1;
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    

        return 0.15;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
        return nil;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == mLeftTableView) {
        
        if (section == 0) {
            if (mLeftDataSource.mLeftType == 1) {
                return mLeftDataSource.mCampainArr.count;
            }else if(mLeftDataSource.mLeftType == 2 ){
                return mLeftDataSource.mClassArr.count;
            }else{
                return mLeftDataSource.mCampainArr.count;

            }
        }else{
            return mLeftDataSource.mClassArr.count;
        }
        
        
    }else if (tableView == mRightTableView){
        return mRightDataArr.count;
    }else{
        return self.mSpeAddArray.count;
    }
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == mLeftTableView) {
        return 50;
    }else if(tableView == mRightTableView){
        
        switch (mRightTabType) {
            case ZLRightGoodsTypeFromCamp:
            {
                return 85;

                
            }
                break;
            case ZLRightGoodsTypeFromClass:
            {
                return 100;
                
            }
                break;
                
            default:
                break;
        }

        
    }else{
        
        
        ZLSkuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mSpeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ZLGoodsSpeList *mGoodSpe = self.mSpeAddArray[indexPath.row];
        [cell setMDataSource:mGoodSpe.mSpeArr];
        return cell.mCellH;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (tableView == mLeftTableView){
        reuseCellId = @"mLeftCell";
        
        ZLSuperMarketShopLeftCellType *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) {
            if (mLeftDataSource.mLeftType == 1) {
                [cell setMCampain:mLeftDataSource.mCampainArr[indexPath.row]];

            }else if(mLeftDataSource.mLeftType == 2 ){
                [cell setMClassify:mLeftDataSource.mClassArr[indexPath.row]];
            }else{
                [cell setMCampain:mLeftDataSource.mCampainArr[indexPath.row]];
                
            }
        }else{
            [cell setMClassify:mLeftDataSource.mClassArr[indexPath.row]];

        }

        
        
        return cell;
        
    }else if(tableView == mRightTableView){
        
        if (self.mType == ZLShopTypeHouseKeeping) {
            reuseCellId = @"mHouseKeepCell";
            
            ZLHouseKeppingServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.delegate = self;
            cell.mIndexPath = indexPath;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else{
  
            switch (mRightTabType) {
                case ZLRightGoodsTypeFromCamp:
                {
                    reuseCellId = @"mHouseKeepCell";
                    
                    ZLHouseKeppingServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
                    cell.delegate = self;
                    cell.mIndexPath = indexPath;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell setMGoodsObj:mRightDataArr[indexPath.row]];

                    return cell;
                    
                }
                    break;
                case ZLRightGoodsTypeFromClass:
                {
                    reuseCellId = @"mRightCell";
                    
                    ZLSuperMarketShopRightCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.mIndexPath = indexPath;
                    [cell setMGoods:mRightDataArr[indexPath.row]];
                    return cell;

                }
                    break;
                    
                default:
                    break;
            }
            
            
        }
        
        
    }else{
    
        reuseCellId = @"mSpeCell";
        
        ZLSkuCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ZLGoodsSpeList *mGoodSpe = self.mSpeAddArray[indexPath.row];
        cell.delegate = self;
        cell.mIndexPath = indexPath;
        [cell setMName:mGoodSpe.mSpeName];

        [cell setMDataSource:mGoodSpe.mSpeArr];
        
        return cell;

    }
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _mSpeTableView) {
        
    }else if (tableView == mRightTableView) {
        [self showWithStatus:@"正在加载..."];

        switch (mRightTabType) {
            case ZLRightGoodsTypeFromCamp:
            {
                
                ZLGoodsWithCamp *mCGoodsObj = mRightDataArr[indexPath.row];
                
                ZLWebViewViewController *mWebvc = [ZLWebViewViewController new];
                mWebvc.mUrl = [NSString stringWithFormat:@"%@/wap/good/goodsdetails?pro_id=%d&sku_id=%d&shop_id=%d&user_id=%d",[[APIClient sharedClient] currentUrl],mCGoodsObj.pro_id,mCGoodsObj.sku_id,self.mShopObj.shop_id,[ZLUserInfo ZLCurrentUser].user_id];
                mWebvc.mCamGoodsObj = mCGoodsObj;
                [self pushViewController:mWebvc];

                
            }
                break;
            case ZLRightGoodsTypeFromClass:
            {
                
                ZLGoodsWithClass *mCGoodsObj = mRightDataArr[indexPath.row];
                
                ZLWebViewViewController *mWebvc = [ZLWebViewViewController new];
                mWebvc.mUrl = [NSString stringWithFormat:@"%@/wap/good/goodsdetails?pro_id=%d&sku_id=%d&shop_id=%d&user_id=%d",[[APIClient sharedClient] currentUrl],mCGoodsObj.pro_id,mCGoodsObj.sku_id,self.mShopObj.shop_id,[ZLUserInfo ZLCurrentUser].user_id];
                mWebvc.mClsGoodsObj = mCGoodsObj;

                [self pushViewController:mWebvc];
            }
                break;
                
            default:
                break;
        }

        
    }else{
        
        ZLShopClassify *mClassObj = [ZLShopClassify new];
        ZLShopCampain *mCampObj = [ZLShopCampain new];

        if (indexPath.section == 0) {
            if (mLeftDataSource.mLeftType == 1) {
                
                mCampObj = mLeftDataSource.mCampainArr[indexPath.row];
                
                [self upDateRightTableView:mShopObj.mShopMsg.shop_id andCampId:[NSString stringWithFormat:@"%d",mCampObj.cam_id] andClassId:nil andPage:1 andType:ZLRightGoodsTypeFromCamp];
                
            }else if(mLeftDataSource.mLeftType == 2 ){
                mClassObj = mLeftDataSource.mClassArr[indexPath.row];
                [self upDateRightTableView:mShopObj.mShopMsg.shop_id andCampId:nil andClassId:[NSString stringWithFormat:@"%d",mClassObj.cls_id] andPage:1 andType:ZLRightGoodsTypeFromClass];
            }else{
                mCampObj = mLeftDataSource.mCampainArr[indexPath.row];
                [self upDateRightTableView:mShopObj.mShopMsg.shop_id andCampId:[NSString stringWithFormat:@"%d",mCampObj.cam_id] andClassId:nil andPage:1 andType:ZLRightGoodsTypeFromCamp];

            }
        }else{
                mClassObj = mLeftDataSource.mClassArr[indexPath.row];
            [self upDateRightTableView:mShopObj.mShopMsg.shop_id andCampId:nil andClassId:[NSString stringWithFormat:@"%d",mClassObj.cls_id] andPage:1 andType:ZLRightGoodsTypeFromClass];

        }

    }

    
    
    
}
#pragma mark----****----更新商品列表
///更新商品列表
- (void)upDateRightTableView:(int)mShopId andCampId:(NSString *)mCampId andClassId:(NSString *)mClassId andPage:(int)mPage andType:(ZLRightGoodsType)mType{
    mRightTabType = mType;
    NSString *mCamptr = nil;
    NSString *mClassstr = nil;
    
    if (mCampId) {
        mCamptr = mCampId;
    }
    if (mClassId) {
        mClassstr = mClassId;
    }
    
    [self showWithStatus:@"正在加载中..."];
    [[APIClient sharedClient] ZLGetShopGoodsList:mShopId andCamId:[[NSString stringWithFormat:@"%@",mCamptr] intValue] andClassId:[[NSString stringWithFormat:@"%@",mClassstr] intValue] andPage:mPage andType:mType block:^(APIObject *mBaseObj, ZLShopGoodsList *mShopGoodsObj) {
        [mRightDataArr removeAllObjects];
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self dismiss];

            [mRightDataArr addObjectsFromArray:mShopGoodsObj.list];

        }else{
        
            [self showErrorStatus:mBaseObj.msg];
        }
        [mRightTableView reloadData];

    }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark----****----优惠券按钮方法
/**
 优惠券按钮方法
 */
- (void)ZLSuperMarketCoupBtnSelected{

    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id < 0) {
        [APIObject infoWithReLoginErrorMessage:@"登录之后才能领取哦～"];
    }else{
        ZLWebViewViewController *mWebvc = [ZLWebViewViewController new];
        mWebvc.mUrl = [NSString stringWithFormat:@"%@/shop/coupon_wap?shop_id=%d&user_id=%d",[[APIClient sharedClient] currentUrl],self.mShopObj.shop_id,[ZLUserInfo ZLCurrentUser].user_id];
        
        [self pushViewController:mWebvc];
    }

    
    
    
    
}
#pragma mark----****----查看评价按钮
/**
 查看评价按钮
 */
- (void)ZLSuperMarketRateBtnSelected{

}
#pragma mark----****----查看更多活动按钮
/**
 查看更多活动按钮
 */
- (void)ZLSuperMarketCheckMoreBtnSelected{
    [self showMoreView];
}
#pragma mark----****----规格按钮代理方法
/**
 规格按钮代理方法
 
 @param mIndexPath 索引
 */
- (void)ZLSuperMarketGoodsCellWithSpecBtnSelectedIndexPath:(NSIndexPath *)mIndexPath{

    
    [_mSpeAddArray removeAllObjects];
    mAddShopCarEx.mGoodsNum = 0;
    mAddShopCarEx.mTotlePrice = 0.0;
    
    switch (mRightTabType) {
        case ZLRightGoodsTypeFromCamp:
        {

            ZLGoodsWithCamp *mCampGoods = mRightDataArr[mIndexPath.row];
            [_mSpeAddArray addObject:mCampGoods];
        }
            break;
        case ZLRightGoodsTypeFromClass:
        {
            

//            [_mSpeDataArray addObjectsFromArray:mGoods.skus];
//            [_mSpeTableView reloadData];
            [self.mSelectedSpeArray removeAllObjects];
            [self.mSelectedSpeArray addObject:mRightDataArr[mIndexPath.row]];
            [self showSpeView:mIndexPath];

        }
            break;
            
        default:
            break;
    }
}

#pragma mark----****----滚动代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView == mRightTableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        
        MLLog(@"yyyyyyyyy----------:  %f",offsetY);
        
        if (offsetY >= 0 ) {
            
            CGFloat mHH = offsetY;
            MLLog(@"mHH----------:  %f",mHH);
            if (mHH>=mTopH || mHH >= 0) {
                mHH = mTopH;
            }
            
            [self setHeaderViewY:-mHH];
            mLeftTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            mRightTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
            MLLog(@"执行A");
        }
        else if (offsetY <= -mTopH){
            
            
            [self setHeaderViewY:64];
            mLeftTableView.contentInset = UIEdgeInsetsMake(mTopH, 0, 0, 0);
            mRightTableView.contentInset = UIEdgeInsetsMake(mTopH, 0, 0, 0);
            MLLog(@"执行B");
        }
        else{
            CGFloat mH = -mTopH - offsetY;
            MLLog(@"mHH----------:  %f",mH);
            [self setHeaderViewY:64+mH];
            MLLog(@"执行C");
            mLeftTableView.contentOffset = mRightTableView.contentOffset;
            mLeftTableView.contentInset = UIEdgeInsetsMake(-offsetY, 0, 0, 0 );
            mRightTableView.contentInset = UIEdgeInsetsMake(-offsetY, 0, 0, 0 );
            
        }
        
        
    }
    
    
}

- (void)setHeaderViewY:(CGFloat)mY{

    CGRect mRRR = mHeaderView.frame;
    mRRR.origin.y = mY;
    mHeaderView.frame = mRRR;
 
    
}

#pragma mark----****---- 购物车代理方法
/**
 购物车代理方法
 */
- (void)ZLSuperMarketShopCarDidSelected{
    
    
    if ([LKDBHelperGoodsObj searchWithWhere:[NSString stringWithFormat:@"%d",self.mShopObj.shop_id]].count <= 0) {
        [self showErrorStatus:@"购物车空空如也，快去挑选商品吧！"];
        return;
    }
    
    ZLSuperMarketShopCarViewController *ZLShopCarVC = [ZLSuperMarketShopCarViewController new];
    ZLShopCarVC.mShopId = self.mShopObj.shop_id;
    ZLShopCarVC.mType = self.mType;
    ZLShopCarVC.mShopMinSendPrice = mShopObj.mShopMsg.ext_min_price;
    [self pushViewController:ZLShopCarVC];
}


#pragma mark----****----去结算代理方法
/**
 去结算代理方法
 */
- (void)ZLSuperMarketGoPayDidSelected{
    
    NSArray *mShopCarArrSource = [LKDBHelperGoodsObj searchWithWhere:[NSString stringWithFormat:@"%d",self.mShopObj.shop_id]];
    
    if (mShopCarArrSource.count <= 0) {
        [self showErrorStatus:@"购物车空空如也，快去挑选商品吧！"];
        return;
    }
    
    NSMutableArray *mPayArr = [NSMutableArray new];
    NSMutableDictionary *mPara = [NSMutableDictionary new];
    NSString *mContent = @"";
    
    for (LKDBHelperGoodsObj *mGoods in mShopCarArrSource) {
        [mPara setInt:mGoods.mGoodsId forKey:@"pro_id"];
        [mPara setInt:mGoods.mExtObj.mGoodsNum forKey:@"odrg_number"];
        [mPara setInt:mGoods.mCampId forKey:@"cam_gid"];
        
        for (int i =0;i<mGoods.mGoodsSKU.count;i++) {
            ZLSpeObj *mSpe = mGoods.mGoodsSKU[i];
            
            if (mSpe.mSku.sta_required == 1) {
                [mPara setInt:mSpe.mSku.sku_id forKey:@"sku_id"];
            }
            
            if (i==mGoods.mGoodsSKU.count-1) {
                mContent = [mContent stringByAppendingString:[NSString stringWithFormat:@"%@",mSpe.mSpeGoodsName]];
                
            }else{
                mContent = [mContent stringByAppendingString:[NSString stringWithFormat:@"%@,",mSpe.mSpeGoodsName]];
            }
        }
        [mPara setObject:mContent forKey:@"odrg_spec"];
        
        [mPayArr addObject:mPara];
    }
    
    [self showWithStatus:@"正在提交订单..."];
    [[APIClient sharedClient] ZLCommitPreOrder:self.mShopObj.shop_id andGoodsArr:[Util arrToJson:mPayArr] block:^( APIObject *mBaseObj,ZLPreOrderObj *mPreOrder) {
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self dismiss];
            ZLSuperMarketCommitOrderViewController *ZLCommitVC = [ZLSuperMarketCommitOrderViewController new];
            ZLCommitVC.mPreOrder = [ZLPreOrderObj new];
            ZLCommitVC.mPreOrder =  mPreOrder;
            ZLCommitVC.mShopId = self.mShopObj.shop_id;
            [self pushViewController:ZLCommitVC];
        }else{
            [self showErrorStatus:mBaseObj.msg];
        }
    }];

}

#pragma mark----****----加载搜索view
- (void)initSearchView{
    [self hiddenSpeView];
    mSearchView = [ZLSuperMArketSearchGoodsView shareView];
    mSearchView.frame = CGRectMake(0, 0, 200, 30);
    mSearchView.layer.masksToBounds = YES;
    mSearchView.layer.cornerRadius = 15;
    mSearchView.alpha = 0;
    self.navigationItem.titleView = mSearchView;
    [UIView animateWithDuration:0.25 animations:^{
        mSearchView.alpha = 1;
    }];

    
}
#pragma mark----****----隐藏搜索view
- (void)dismissSearchView{
    [UIView animateWithDuration:0.25 animations:^{
        mSearchView.alpha = 0;
        [mSearchView removeFromSuperview];
        self.navigationItem.titleView = nil;
    }];
}
- (void)mRightAction:(UIButton *)sender{

    sender.selected = !sender.selected;
    if (sender.selected) {
        [self initSearchView];
    }else{
        [self dismissSearchView];
    }
    
}
#pragma mark----****----加载规格view
- (void)initSpeView{



    
    CGRect mSpeRect = self.view.bounds;
    mSpeRect.origin.y = DEVICE_Height;
    
    
    mSpeView = [ZLSuperMArketSearchGoodsView initWithSpeView:mSpeRect];
    mSpeView.delegate = self;

    _mSpeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width-40,187) style:UITableViewStyleGrouped];
    _mSpeTableView.delegate = self;
    _mSpeTableView.dataSource = self;
    _mSpeTableView.backgroundColor = [UIColor whiteColor];
    _mSpeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"ZLSkuCell" bundle:nil];
    [_mSpeTableView registerNib:nib forCellReuseIdentifier:@"mSpeCell"];
    
    [mSpeView.mGoodsSpeScrollView addSubview:_mSpeTableView];
    
    
    [self.view addSubview:mSpeView];
}
#pragma mark----****----显示规格view
- (void)showSpeView:(NSIndexPath *)mIndexPath{
    
    ZLGoodsWithClass *mGoodObj = mRightDataArr[mIndexPath.row];
    mSpeView.mIndexPath = mIndexPath;
    mSpeView.mModel = mGoodObj;
    float mP = 0;
    int count = 0;
    for (ZLGoodsSKU *sku in mGoodObj.skus) {
        if (mGoodObj.sku_id == sku.sku_id) {
            mP = sku.sku_price;
            count = sku.sku_stock;
        }
    }
    
    [self UpdateSpeViewPage:mGoodObj.img_url andGoodsName:mGoodObj.pro_name andGoodsPrice:mP andSkuCount:count andGoodsNum:mGoodObj.mNum];
    
    ///规格数组
    NSMutableArray *mSkuTempArr = [NSMutableArray new];
    
    ///从这里取值
    ZLGoodsWithClass *mGoods = mRightDataArr[mIndexPath.row];
    
    
    for (int i = 0;i<mGoods.skus.count;i++) {
        
        ZLGoodsSKU *mOne = mGoods.skus[i];
        
        BOOL mIsAdd = YES;
        
        for (int j = 0; j<mSkuTempArr.count ; j++) {
            
            
            
            ZLGoodsSpeList *mTwo = mSkuTempArr[j];
            
            if (mOne.sta_id == mTwo.mStaId) {
                
                
                
                ZLSpeObj *mSkuValue  = [ZLSpeObj new];
                mSkuValue.mSpeGoodsName = mOne.sta_val_name;
                mSkuValue.mSku = mOne;
                mSkuValue.mSta_val_id = mOne.sta_val_id;
                
                [mTwo.mSpeArr addObject:mSkuValue];
                [mSkuTempArr replaceObjectAtIndex:j withObject:mTwo];
                mIsAdd = NO;
                continue;
                
            }
            
        }
        
        
        if (mIsAdd == YES) {
            
            ZLGoodsSpeList *mSpeListObj = [ZLGoodsSpeList new];
            mSpeListObj.mSpeName = mOne.sta_name;
            mSpeListObj.mStaId = mOne.sta_id;
            
            ZLSpeObj *mSkuValue  = [ZLSpeObj new];
            mSkuValue.mSpeGoodsName = mOne.sta_val_name;
            mSkuValue.mSku = mOne;
            mSkuValue.mSta_val_id = mOne.sta_val_id;
            
            NSMutableArray *tempArr = [NSMutableArray new];
            [tempArr addObject:mSkuValue];
            mSpeListObj.mSpeArr = tempArr;
            
            [mSkuTempArr addObject:mSpeListObj];
            
        }
        
        
    }

    [self.mSpeAddArray addObjectsFromArray:mSkuTempArr];
    
    [_mSpeTableView reloadData];
    [self dismissSearchView];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mSpeRect = mSpeView.frame;
        mSpeRect.origin.y = 0;
        mSpeView.frame = mSpeRect;
    }];


    
//    StandardsView *mystandardsView = [self buildStandardView:[UIImage imageNamed:@"bg.jpg"] andIndex:mIndexPath.row];
//    mystandardsView.GoodDetailView = self.view;//设置该属性 对应的view 会缩小
//    
//    mystandardsView.showAnimationType = StandsViewShowAnimationShowFrombelow;
//    mystandardsView.dismissAnimationType = StandsViewDismissAnimationDisFrombelow;
//    
//    
//    [mystandardsView show];

}
#pragma mark----****----更新规格页面数据
/**
 更新规格页面数据

 @param mGoodsImg 商品图片
 @param mName     商品名称
 @param mPrice    商品价格
 @param mcount    库存
 */
- (void)UpdateSpeViewPage:(NSString *)mGoodsImg andGoodsName:(NSString *)mName andGoodsPrice:(float)mPrice andSkuCount:(int)mcount andGoodsNum:(int)mNum{

    int num = mNum;
    if (num<=0) {
        num = 1;
    }
    
    [mSpeView.mGoodsImg sd_setImageWithURL:[NSURL URLWithString:mGoodsImg] placeholderImage:[UIImage imageNamed:@"ZLDefault_Img"]];
    mSpeView.mGoodsName.text = mName;
    mSpeView.mGoodsPrice.text = [NSString stringWithFormat:@"价格：%.2f元",mPrice];
    mSpeView.mGoodsRep.text = [NSString stringWithFormat:@"库存：%d",mcount];
    mSpeView.mNum.text = [NSString stringWithFormat:@"%d",num];
    
}
-(StandardsView *)buildStandardView:(UIImage *)img andIndex:(NSInteger)index
{
    ///规格数组
    NSMutableArray *mSkuTempArr = [NSMutableArray new];
    
    ///从这里取值
    ZLGoodsWithClass *mGoods = mRightDataArr[index];
    
    
    for (int i = 0;i<mGoods.skus.count;i++) {
        
        ZLGoodsSKU *mOne = mGoods.skus[i];
        
        BOOL mIsAdd = YES;
        
        for (int j = 0; j<mSkuTempArr.count ; j++) {
            
            
            
            ZLGoodsSpeList *mTwo = mSkuTempArr[j];
            
            if (mOne.sta_id == mTwo.mStaId) {
                
                
                
                ZLSpeObj *mSkuValue  = [ZLSpeObj new];
                mSkuValue.mSpeGoodsName = mOne.sta_val_name;
                mSkuValue.mSku = mOne;
                mSkuValue.mSta_val_id = mOne.sta_val_id;
                
                [mTwo.mSpeArr addObject:mSkuValue];
                [mSkuTempArr replaceObjectAtIndex:j withObject:mTwo];
                mIsAdd = NO;
                continue;
                
            }
            
        }
        
        
        if (mIsAdd == YES) {
            
            ZLGoodsSpeList *mSpeListObj = [ZLGoodsSpeList new];
            mSpeListObj.mSpeName = mOne.sta_name;
            mSpeListObj.mStaId = mOne.sta_id;
            
            ZLSpeObj *mSkuValue  = [ZLSpeObj new];
            mSkuValue.mSpeGoodsName = mOne.sta_val_name;
            mSkuValue.mSku = mOne;
            mSkuValue.mSta_val_id = mOne.sta_val_id;
            
            NSMutableArray *tempArr = [NSMutableArray new];
            [tempArr addObject:mSkuValue];
            mSpeListObj.mSpeArr = tempArr;
            
            [mSkuTempArr addObject:mSpeListObj];
            
        }
        
        
    }
    
    
    StandardsView *standview = [[StandardsView alloc] init];
    standview.tag = index;
    standview.delegate = self;
    
    standview.mainImgView.image = img;
    standview.mainImgView.backgroundColor = [UIColor whiteColor];
    standview.priceLab.text = @"¥100.0";
    standview.tipLab.text = @"请选择规格";
    standview.goodNum.text = @"库存 10件";
    
    
    standview.customBtns = @[@"加入购物车",@"立即购买"];
    
    
    standardClassInfo *tempClassInfo1 = [standardClassInfo StandardClassInfoWith:@"0" andStandClassName:@"红色das"];
    standardClassInfo *tempClassInfo2 = [standardClassInfo StandardClassInfoWith:@"1" andStandClassName:@"蓝色ads"];
    
    NSArray *tempClassInfoArr = @[tempClassInfo1,tempClassInfo2];
    StandardModel *tempModel = [StandardModel StandardModelWith:tempClassInfoArr andStandName:@"颜色"];
    
    
    
    standardClassInfo *tempClassInfo3 = [standardClassInfo StandardClassInfoWith:@"2" andStandClassName:@"XL"];
    standardClassInfo *tempClassInfo4 = [standardClassInfo StandardClassInfoWith:@"3" andStandClassName:@"XXL"];
    
    NSArray *tempClassInfoArr2 = @[tempClassInfo3,tempClassInfo4];
    StandardModel *tempModel2 = [StandardModel StandardModelWith:tempClassInfoArr2 andStandName:@"尺寸"];
    standview.standardArr = @[tempModel,tempModel2];
    
    
    
    return standview;
}

#pragma mark - standardView  delegate
//点击自定义按键
-(void)StandardsView:(StandardsView *)standardView CustomBtnClickAction:(UIButton *)sender
{
    if (sender.tag == 0) {
        //将商品图片抛到指定点
        [standardView ThrowGoodTo:CGPointMake(200, 100) andDuration:1.6 andHeight:150 andScale:20];
    }
    else
    {
        [standardView dismiss];
    }
}

//点击规格代理
-(void)Standards:(StandardsView *)standardView SelectBtnClick:(UIButton *)sender andSelectID:(NSString *)selectID andStandName:(NSString *)standName andIndex:(NSInteger)index
{
    
    MLLog(@"selectID = %@ standName = %@ index = %ld",selectID,standName,(long)index);
    
}
//设置自定义btn的属性
-(void)StandardsView:(StandardsView *)standardView SetBtn:(UIButton *)btn
{
    if (btn.tag == 0) {
        btn.backgroundColor = M_CO;
    }
    else if (btn.tag == 1)
    {
        btn.backgroundColor = [UIColor redColor];
    }
}


#pragma mark----****----隐藏规格view
- (void)hiddenSpeView{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mSpeRect = mSpeView.frame;
        mSpeRect.origin.y = DEVICE_Height;
        mSpeView.frame = mSpeRect;
    }];
    
}


#pragma mark----****---- 关闭按钮代理方法
/**
 关闭按钮
 */
- (void)ZLSuperMarketCloseBtnSelected{

    [self hiddenSpeView];
    
}
#pragma mark----****---- 规格 加按钮代理方法
/**
 添加按钮
 */
- (void)ZLSuperMarketAddBtnSelected:(NSIndexPath *)mIndexPath{

    ZLGoodsWithClass *mGoodObj = mRightDataArr[mIndexPath.row];
    if (mGoodObj.mNum == 0) {
        mGoodObj.mNum = 1;
    }
    
    mGoodObj.mNum +=1;
    [mRightDataArr replaceObjectAtIndex:mIndexPath.row withObject:mGoodObj];

    if (self.mAddSkuArray.count<= 0) {
        [self showErrorStatus:@"请先选择规格！"];
        return;
    }

    for (ZLSpeObj *mObj  in self.mAddSkuArray) {
        if (mObj.mSku.sta_required == 1) {
            mAddShopCarEx.mTotlePrice+=mObj.mSku.sku_price;

        }
    }
    mAddShopCarEx.mGoodsNum += 1;
    mSpeView.mNum.text = [NSString stringWithFormat:@"%d",mGoodObj.mNum];
//    [self updateBottomView:mAddShopCarEx];

}
#pragma mark----****---- 规格 减按钮代理方法
/**
 减按钮
 */
- (void)ZLSuperMarketSubsructBtnSelected:(NSIndexPath *)mIndexPath{
    ZLGoodsWithClass *mGoodObj = mRightDataArr[mIndexPath.row];
    if (mGoodObj.mNum == 0) {
        mGoodObj.mNum = 1;
    }
    if (mGoodObj.mNum <= 0) {
        mGoodObj.mNum = 0;
    }else{
        mGoodObj.mNum -=1;

    }
    
    [mRightDataArr replaceObjectAtIndex:mIndexPath.row withObject:mGoodObj];
    
    
    for (ZLSpeObj *mObj  in self.mAddSkuArray) {
        if (mObj.mSku.sta_required == 1) {
            mAddShopCarEx.mTotlePrice-=mObj.mSku.sku_price;
            
        }
    }
    mAddShopCarEx.mGoodsNum -= 1;

    mSpeView.mNum.text = [NSString stringWithFormat:@"%d",mGoodObj.mNum];

//    [self updateBottomView:mAddShopCarEx];
    
}
#pragma mark----****----规格加入购物车按钮代理方法
/**
 规格ok按钮
 */
- (void)ZLSuperMarketShopCarBtnSelected:(NSIndexPath *)mIndexPath{
    
    ZLGoodsWithClass *mGoodObj = mRightDataArr[mIndexPath.row];
    LKDBHelperGoodsObj *ZLAddObj = [LKDBHelperGoodsObj new];
    ZLAddObj.mExtObj = [ZLAddShopCarExObj new];
    

    NSString *mSKUname = @"";

    
    for (int i = 0;i<self.mAddSkuArray.count;i++) {
        
        ZLSpeObj *mSpeO = self.mAddSkuArray[i];
        
        if (mSpeO.mSku.sta_required == 1) {
            ZLAddObj.mSKUID = mSpeO.mSku.sku_id;
            ZLAddObj.mExtObj.mTotlePrice = mGoodObj.mNum*mSpeO.mSku.sku_price;

        }
        
        if (i==self.mAddSkuArray.count-1) {
            mSKUname = [mSKUname stringByAppendingString:[NSString stringWithFormat:@"%@",mSpeO.mSku.sta_val_name]];
            
        }else{
            mSKUname = [mSKUname stringByAppendingString:[NSString stringWithFormat:@"%@-",mSpeO.mSku.sta_val_name]];
        }

    }
    
    ZLAddObj.mNum = mGoodObj.mNum;
    ZLAddObj.mGoodsId = mGoodObj.pro_id;
    ZLAddObj.mGoodsName =mGoodObj.pro_name;
    ZLAddObj.mGoodsImg = mGoodObj.img_url;
    ZLAddObj.mExtObj.mGoodsNum = mGoodObj.mNum;
    ZLAddObj.mShopId = self.mShopObj.shop_id;
    ZLAddObj.mGoodsSKU = self.mAddSkuArray;
    ZLAddObj.mSpe = [ZLSpeObj new];
    ZLAddObj.mSpe.mSpeGoodsName = mSKUname;
    if (!ZLAddObj.mSKUID) {
        [self showErrorStatus:@"请先选择规格！"];
        return;
    }
    if (ZLAddObj.mExtObj.mGoodsNum==0) {
        
        ZLAddObj.mExtObj.mGoodsNum = 1;
        
    }else if (ZLAddObj.mExtObj.mGoodsNum<0){
        [self showErrorStatus:@"请选择数量！"];
        return;
    }
    [ZLAddObj saveToDB];

    
    NSArray *mLKDArr =  [LKDBHelperGoodsObj searchWithWhere:[NSString stringWithFormat:@"%d",self.mShopObj.shop_id]];

    [self updateBottomView:mAddShopCarEx];
    [self hiddenSpeView];
    [self.mAddSkuArray removeAllObjects];

}

#pragma mark----****---- 规格立即购买代理方法
/**
 立即购买代理方法
 */
- (void)ZLSuperMarketBuyNowBtnSelected:(NSIndexPath *)mIndexPath{
    ZLGoodsWithClass *mGoodObj = mRightDataArr[mIndexPath.row];

    LKDBHelperGoodsObj *ZLAddObj = [LKDBHelperGoodsObj new];
    ZLAddObj.mExtObj = [ZLAddShopCarExObj new];
    
    
    NSString *mSKUname = @"";
    
    
    for (int i = 0;i<self.mAddSkuArray.count;i++) {
        
        ZLSpeObj *mSpeO = self.mAddSkuArray[i];
        
        if (mSpeO.mSku.sta_required == 1) {
            ZLAddObj.mSKUID = mSpeO.mSku.sku_id;
            ZLAddObj.mExtObj.mTotlePrice = mGoodObj.mNum*mSpeO.mSku.sku_price;
            
        }
        
        if (i==self.mAddSkuArray.count-1) {
            mSKUname = [mSKUname stringByAppendingString:[NSString stringWithFormat:@"%@",mSpeO.mSku.sta_val_name]];
            
        }else{
            mSKUname = [mSKUname stringByAppendingString:[NSString stringWithFormat:@"%@-",mSpeO.mSku.sta_val_name]];
        }
        
    }
    
    ZLAddObj.mNum = mGoodObj.mNum;
    ZLAddObj.mGoodsId = mGoodObj.pro_id;
    ZLAddObj.mGoodsName =mGoodObj.pro_name;
    ZLAddObj.mGoodsImg = mGoodObj.img_url;
    ZLAddObj.mExtObj.mGoodsNum = mGoodObj.mNum;
    ZLAddObj.mShopId = self.mShopObj.shop_id;
    ZLAddObj.mGoodsSKU = self.mAddSkuArray;
    ZLAddObj.mSpe = [ZLSpeObj new];
    ZLAddObj.mSpe.mSpeGoodsName = mSKUname;
    if (!ZLAddObj.mSKUID) {
        [self showErrorStatus:@"请先选择规格！"];
        return;
    }
    if (ZLAddObj.mExtObj.mGoodsNum==0) {
        
        ZLAddObj.mExtObj.mGoodsNum = 1;
        
    }else if (ZLAddObj.mExtObj.mGoodsNum<0){
        [self showErrorStatus:@"请选择数量！"];
        return;
    }
    NSMutableArray *mShopCarArr = [NSMutableArray new];
    [mShopCarArr addObject:ZLAddObj];
    
    [self hiddenSpeView];
    
    NSMutableArray *mPayArr = [NSMutableArray new];
    NSMutableDictionary *mPara = [NSMutableDictionary new];
    NSString *mContent = @"";

    for (ZLSpeObj *mSP in self.mAddSkuArray) {
        if (mSP.mSku.sta_required == 1) {
            [mPara setInt:mSP.mSku.sku_id forKey:@"sku_id"];
        }

    }
    [self.mAddSkuArray removeAllObjects];


    for (LKDBHelperGoodsObj *mGoods in mShopCarArr) {
        [mPara setInt:mGoods.mGoodsId forKey:@"pro_id"];
        [mPara setInt:mGoods.mExtObj.mGoodsNum forKey:@"odrg_number"];
        [mPara setInt:mGoods.mCampId forKey:@"cam_gid"];
        
        for (int i =0;i<mGoods.mGoodsSKU.count;i++) {
            ZLSpeObj *mSpe = mGoods.mGoodsSKU[i];
            
            if (mSpe.mSku.sta_required == 1) {
                [mPara setInt:mSpe.mSku.sku_id forKey:@"sku_id"];
            }
            
            if (i==mGoods.mGoodsSKU.count-1) {
                mContent = [mContent stringByAppendingString:[NSString stringWithFormat:@"%@",mSpe.mSpeGoodsName]];
                
            }else{
                mContent = [mContent stringByAppendingString:[NSString stringWithFormat:@"%@,",mSpe.mSpeGoodsName]];
            }
        }
        [mPara setObject:mSKUname forKey:@"odrg_spec"];
        
        [mPayArr addObject:mPara];
    }
    [self showWithStatus:@"正在提交订单..."];
    [[APIClient sharedClient] ZLCommitPreOrder:self.mShopObj.shop_id andGoodsArr:[Util arrToJson:mPayArr] block:^(APIObject *mBaseObj,ZLPreOrderObj *mPreOrder) {
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self dismiss];
            ZLSuperMarketCommitOrderViewController *ZLCommitVC = [ZLSuperMarketCommitOrderViewController new];
            ZLCommitVC.mPreOrder = [ZLPreOrderObj new];
            ZLCommitVC.mPreOrder =  mPreOrder;
            [self pushViewController:ZLCommitVC];
        }else{
            [self showErrorStatus:mBaseObj.msg];
        }
    }];
    


    
}
- (void)mBackAction{

    [self dismissSearchView];
    [self hiddenSpeView];
    [self popViewController];
}

/**
 加按钮代理方法
 
 @param mIndexPath 索引
 */
- (void)ZLHouseKeepingAddBtnClicked:(NSIndexPath *)mIndexPath{
    
    
    ZLGoodsWithCamp *mCamGoods = mRightDataArr[mIndexPath.row];

    
    switch (mRightTabType) {
        case ZLRightGoodsTypeFromCamp:
        {
            
            mAddShopCarEx.mGoodsNum+=1;
            mAddShopCarEx.mTotlePrice += mCamGoods.sku_price;
            mCamGoods.mNum+=1;
            if (mAddShopCarEx.mTotlePrice <= 0 || mAddShopCarEx.mGoodsNum <= 0) {
                mAddShopCarEx.mTotlePrice = 0.0;
            }
            MLLog(@"得到的购物车扩展对象是:商品数量：%d   商品总价：%.2f",mAddShopCarEx.mGoodsNum,mAddShopCarEx.mTotlePrice);
            
            LKDBHelperGoodsObj *ZLAddObj = [LKDBHelperGoodsObj new];
            ZLAddObj.mExtObj = [ZLAddShopCarExObj new];
            ZLAddObj.mSKUID = mCamGoods.sku_id;

            ZLAddObj.mCampId = mCamGoods.cam_gid;
            ZLAddObj.mGoodsId = mCamGoods.pro_id;
            ZLAddObj.mGoodsName =mCamGoods.pro_name;
            ZLAddObj.mGoodsImg = mCamGoods.img_url;
            ZLAddObj.mNum = mCamGoods.mNum;
            ZLAddObj.mExtObj.mGoodsNum = mCamGoods.mNum;
            ZLAddObj.mExtObj.mTotlePrice = mCamGoods.mNum*mCamGoods.sku_price;

            ZLAddObj.mShopId = self.mShopObj.shop_id;
            ZLAddObj.mGoodsSKU = self.mAddSkuArray;
            ZLAddObj.mSpe = [ZLSpeObj new];
            ZLAddObj.mSpe.mSpeGoodsName = mCamGoods.sta_val_name;
            
            
            [ZLAddObj saveToDB];
            [mRightDataArr replaceObjectAtIndex:mIndexPath.row withObject:mCamGoods];
            
            [mRightTableView beginUpdates];
            [mRightTableView reloadRowsAtIndexPaths:@[mIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [mRightTableView endUpdates];

            [self updateBottomView:mAddShopCarEx];
            
        }
            break;
        case ZLRightGoodsTypeFromClass:
        {
            ZLGoodsWithClass *mClasGoods = mRightDataArr[mIndexPath.row];
            
            
            
        }
            break;
            
        default:
            break;
    }
    

    
}

/**
 减按钮代理方法
 
 @param mIndexPath 索引
 */
- (void)ZLHouseKeepingSubstructBtnClicked:(NSIndexPath *)mIndexPath{

    
    ZLGoodsWithCamp *mCamGoods = mRightDataArr[mIndexPath.row];
    if (mCamGoods.mNum<=0) {
        return;
    }
    switch (mRightTabType) {
        case ZLRightGoodsTypeFromCamp:
        {
            
            mAddShopCarEx.mGoodsNum-=1;
            mAddShopCarEx.mTotlePrice -= mCamGoods.sku_price;
            mCamGoods.mNum-=1;
            if (mAddShopCarEx.mTotlePrice <= 0 || mAddShopCarEx.mGoodsNum <= 0) {
                mAddShopCarEx.mTotlePrice = 0.0;
            }
            MLLog(@"得到的购物车扩展对象是:商品数量：%d   商品总价：%.2f",mAddShopCarEx.mGoodsNum,mAddShopCarEx.mTotlePrice);
            
            LKDBHelperGoodsObj *ZLAddObj = [LKDBHelperGoodsObj new];
            ZLAddObj.mExtObj = [ZLAddShopCarExObj new];
            ZLAddObj.mSKUID = mCamGoods.sku_id;
            ZLAddObj.mCampId = mCamGoods.cam_gid;
            ZLAddObj.mGoodsId = mCamGoods.pro_id;
            ZLAddObj.mGoodsName =mCamGoods.pro_name;
            ZLAddObj.mGoodsImg = mCamGoods.img_url;
            ZLAddObj.mExtObj.mGoodsNum = mCamGoods.mNum;
            ZLAddObj.mExtObj.mTotlePrice = mCamGoods.mNum*mCamGoods.sku_price;
            ZLAddObj.mShopId = self.mShopObj.shop_id;
            ZLAddObj.mGoodsSKU = self.mAddSkuArray;
            ZLAddObj.mSpe = [ZLSpeObj new];
            ZLAddObj.mSpe.mSpeGoodsName = mCamGoods.sta_val_name;
            
            
            [ZLAddObj saveToDB];
            [mRightDataArr replaceObjectAtIndex:mIndexPath.row withObject:mCamGoods];
            
            [mRightTableView beginUpdates];
            [mRightTableView reloadRowsAtIndexPaths:@[mIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [mRightTableView endUpdates];
            [self updateBottomView:mAddShopCarEx];
            
        }
            break;
        case ZLRightGoodsTypeFromClass:
        {
            ZLGoodsWithClass *mClasGoods = mRightDataArr[mIndexPath.row];
            
            
            
        }
            break;
            
        default:
            break;
    }
    

}

#pragma mark----****----加减商品代理方法
/**
 加减代理方法
 @param mType       按钮类型: 1 加  2是减
 @param mNum       数量
 @param mIndexPath 索引
 */
- (void)ZLHouseKeppingServiceCellWithNumChanged:(int)mType andNum:(int)mNum andIndexPath:(NSIndexPath *)mIndexPath{

    int mTnum = mNum-1;
    MLLog(@"索引是：%ld     数量是：%d",(long)mIndexPath.row,mNum);
    
    mAddShopCarEx.mGoodsNum += mTnum;

    switch (mRightTabType) {
        case ZLRightGoodsTypeFromCamp:
        {
            
            ZLGoodsWithCamp *mCamGoods = mRightDataArr[mIndexPath.row];
            
            mAddShopCarEx.mTotlePrice += mCamGoods.sku_price*mTnum;
            
            if (mAddShopCarEx.mTotlePrice <= 0 || mAddShopCarEx.mGoodsNum <= 0) {
                mAddShopCarEx.mTotlePrice = 0.0;
            }
            MLLog(@"得到的购物车扩展对象是:商品数量：%d   商品总价：%.2f",mAddShopCarEx.mGoodsNum,mAddShopCarEx.mTotlePrice);

            ZLGoodsWithCamp *mGoodObj = mRightDataArr[mIndexPath.row];
            LKDBHelperGoodsObj *ZLAddObj = [LKDBHelperGoodsObj new];
            ZLAddObj.mCampId = mGoodObj.cam_gid;
            ZLAddObj.mGoodsId = mGoodObj.pro_id;
            ZLAddObj.mGoodsName =mGoodObj.pro_name;
            ZLAddObj.mGoodsImg = mGoodObj.img_url;
            ZLAddObj.mExtObj = mAddShopCarEx;
            ZLAddObj.mShopId = self.mShopObj.shop_id;
            ZLAddObj.mGoodsSKU = self.mAddSkuArray;
            ZLAddObj.mSpe = [ZLSpeObj new];
            ZLAddObj.mSpe.mSpeGoodsName = mGoodObj.sta_val_name;
            
        
            [ZLAddObj saveToDB];
            
            [self updateBottomView:mAddShopCarEx];
            
        }
            break;
        case ZLRightGoodsTypeFromClass:
        {
            ZLGoodsWithClass *mClasGoods = mRightDataArr[mIndexPath.row];


            
        }
            break;
            
        default:
            break;
    }

}

/**
 选择的代理方法
 
 @param mIndexPathSection 返回索引的section分组
 @param mIndexPathRow     返回索引的row
 */
- (void)ZLSpeSelectedViewCellWithSelectedBtnRow:(NSIndexPath *)mIndexPathSection andIndex:(NSIndexPath *)mIndexPathRow{
    MLLog(@"%ld,%ld",(long)mIndexPathSection.section,(long)mIndexPathRow.row);

}
#pragma mark----****---- 选中规格的代理方法
/**
 选中规格的代理方法

 @param mIndexPath 索引row
 @param mIndex     下标
 */
- (void)ZLSkuCellWithSelectedIndexPath:(NSIndexPath *)mIndexPath andIndex:(NSInteger)mIndex{

    MLLog(@"点击了第几个规格？：%ld----%ld",(long)mIndexPath.row,(long)mIndex);
    
    
    if (self.mSelectedSpeArray.count<=0) {
        return;
    }
    
    ZLGoodsWithClass *mGoodObj = self.mSelectedSpeArray[0];
    ZLGoodsSpeList *mSpe = self.mSpeAddArray[mIndexPath.row];
    ZLSpeObj *mSku = mSpe.mSpeArr[mIndex];
    
    if (self.mAddSkuArray.count <= 0) {
        [self.mAddSkuArray addObject:mSku];
    }else{
        for (int i = 0;i<self.mAddSkuArray.count;i++) {
            
            ZLSpeObj *mOne =  self.mAddSkuArray[i];
            
            
            if (mOne.mSku.sta_id == mSku.mSku.sta_id) {
                [self.mAddSkuArray removeObject:mOne];
                [self.mAddSkuArray addObject:mSku];

            }else{
                [self.mAddSkuArray addObject:mSku];
                
            }
            
            
          
        }
    }
 
    
    if (mSku.mSku.sta_required == 1) {
      
//        mAddShopCarEx.mTotlePrice = mSku.mSku.sku_price;
        [self UpdateSpeViewPage:mGoodObj.img_url andGoodsName:mGoodObj.pro_name andGoodsPrice:mSku.mSku.sku_price andSkuCount:mSku.mSku.sku_stock andGoodsNum:mGoodObj.mNum];

    }
    
    
    
}


- (void)initMoreCampView{
    mMoreCampView = [mCheckMoreActivityView shareView];
    mMoreCampView.frame = self.view.bounds;
    mMoreCampView.alpha = 0;
    mMoreCampView.delegate = self;
    [self.view addSubview:mMoreCampView];
    
}
- (void)closeMCheckMoreActivityView{
    [self hiddenMoreView];
}
- (void)showMoreView{

    [UIView animateWithDuration:0.25 animations:^{
        mMoreCampView.alpha = 1;
    }];
}
- (void)hiddenMoreView{
    [UIView animateWithDuration:0.25 animations:^{
        mMoreCampView.alpha = 0;
    }];
}

- (void)updaMoreView:(ZLShopObj *)mShop{
    
    for (ZLShopCampainSubView *vvv in mMoreCampView.mCampainView.subviews) {
        [vvv removeFromSuperview];
    }
    if (mShop.mShopCampains.count > 0) {
        
        for (int i =0; i<mShop.mShopCampains.count; i++) {
            
            
            ZLShopCampain *mCampain = mShop.mShopCampains[i];
            
            mCampSubView = [ZLShopCampainSubView shareView];
            mCampSubView.mContent.textColor = [UIColor whiteColor];
            mCampSubView.backgroundColor = [UIColor clearColor];
            mCampSubView.frame = CGRectMake(mHeaderView.mActivityView.mwidth/2, 30*i, 300, 30);
            mCampSubView.mTitle.text = [Util ZLCutStringWithText:mCampain.cam_name andRangeWithLocation:0 andRangeWithLength:1];
            mCampSubView.mContent.text = mCampain.cam_name;
            [mMoreCampView.mCampainView addSubview:mCampSubView];
        }
    }else{
        mCampSubView = [ZLShopCampainSubView shareView];
        mCampSubView.frame = CGRectMake(0, 0, mHeaderView.mActivityView.mwidth, 30);
        
        mCampSubView.mTitle.text = @"无";
        mCampSubView.mContent.text = @"暂无活动";
        mCampSubView.mContent.textColor = [UIColor whiteColor];
        mCampSubView.backgroundColor = [UIColor clearColor];
        [mMoreCampView.mCampainView addSubview:mCampSubView];
    }

    
    mMoreCampView.mShopName.text = mShop.mShopMsg.shop_name;
    mMoreCampView.mContent.text = [NSString stringWithFormat:@"营业时间：%@-%@",mShop.mShopMsg.ext_open_time,mShop.mShopMsg.ext_close_time];
    
}

@end
