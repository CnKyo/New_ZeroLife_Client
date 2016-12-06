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

static const CGFloat mTopH = 156;

@interface ZLSuperMarketShopViewController ()<UITableViewDelegate,UITableViewDataSource,ZLSuperMarketShopDelegate,ZLSuperMarketGoodsCellDelegate,UIScrollViewDelegate,ZLSuperMarketShopCarDelegate,ZLSuperMarketGoodsSpecDelegate,UICollectionViewDelegate,ZLHouseKeppingServiceCellDelegate,ZLSpeSelectedViewCellDelegate,StandardsViewDelegate,ZLSKUCellDelegate,LDXScoreDelegate>

/**
 规格瀑布流
 */
@property (nonatomic, strong) UITableView *mSpeTableView;

/**
 选择规格数据源
 */
@property (nonatomic, strong) NSMutableArray *mSpeAddArray;


@property (nonatomic, strong) NSMutableArray *mSelectedSpeArray;


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
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.mShopObj.shop_name;

    self.mSpeAddArray = [NSMutableArray new];
    
    mLeftDataArr = [NSMutableArray new];
    mRightDataArr = [NSMutableArray new];
    self.mSelectedSpeArray = [NSMutableArray new];

    mLeftDataSource = [ZLShopLeftTableArr new];
    
    [self addRightBtn:YES andTitel:nil andImage:[UIImage imageNamed:@"ZLSearch_white"]];

    mShopObj = [ZLShopObj new];
    [self loadData];
    [self initView];
//    [self initData];
    [self initHeaderView];
    [self initSpeView];
    
}

- (void)loadView{

    [super loadView];

}

#pragma mark----****----加载数据
- (void)initData{

    NSArray *mAr = @[@"问题1",@"问题2",@"问题3",@"问题4",@"问题5",@"问题6",@"问题7",@"问题8",@"请点击复合你的)"];
    
    [self.mSpeAddArray addObjectsFromArray:mAr];
    [_mSpeTableView reloadData];
//    for (int i=0; i<8; i++) {
//        [self.mSpeDataArray addObject:[NSString stringWithFormat:@"第%d种规格 %d元",i,i+150]];
//    }
    
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
            [mLeftTableView reloadData];
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
    
    
    mBottomView.mNum.text = @"0";
  

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
        
        if (self.mType == 2) {
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
        ZLGoodsDetailViewController *mShopVC = [ZLGoodsDetailViewController new];

        switch (mRightTabType) {
            case ZLRightGoodsTypeFromCamp:
            {
                mShopVC.mGoodsObj = mRightDataArr[indexPath.row];
                
            }
                break;
            case ZLRightGoodsTypeFromClass:
            {
                mShopVC.mGoods = mRightDataArr[indexPath.row];
                
            }
                break;
                
            default:
                break;
        }
        [self pushViewController:mShopVC];

        
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

    ZLWebViewViewController *mWebvc = [ZLWebViewViewController new];
    mWebvc.mUrl = mShopObj.mShopCoupon.cup_url;
    
    [self pushViewController:mWebvc];
    
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

}
#pragma mark----****----规格按钮代理方法
/**
 规格按钮代理方法
 
 @param mIndexPath 索引
 */
- (void)ZLSuperMarketGoodsCellWithSpecBtnSelectedIndexPath:(NSIndexPath *)mIndexPath{

    [_mSpeAddArray removeAllObjects];
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
            if (mHH>=mTopH) {
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
            [self setHeaderViewY:mH];
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

#pragma mark----****---- 加入购物车代理方法
/**
 购物车代理方法
 */
- (void)ZLSuperMarketShopCarDidSelected{
    ZLSuperMarketShopCarViewController *ZLShopCarVC = [ZLSuperMarketShopCarViewController new];
    [self pushViewController:ZLShopCarVC];
}
#pragma mark----****---- 立即购买代理方法
/**
 立即购买代理方法
 */
- (void)ZLSuperMarketBuyNowBtnSelected{

}

#pragma mark----****----去结算代理方法
/**
 去结算代理方法
 */
- (void)ZLSuperMarketGoPayDidSelected{
    ZLSuperMarketCommitOrderViewController *ZLCommitVC = [ZLSuperMarketCommitOrderViewController new];
    [self pushViewController:ZLCommitVC];
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

    _mSpeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width-40,152) style:UITableViewStyleGrouped];
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
    
    float mP = 0;
    int count = 0;
    for (ZLGoodsSKU *sku in mGoodObj.skus) {
        if (mGoodObj.sku_id == sku.sku_id) {
            mP = sku.sku_price;
            count = sku.sku_stock;
        }
    }
    
    [self UpdateSpeViewPage:mGoodObj.img_url andGoodsName:mGoodObj.pro_name andGoodsPrice:mP andSkuCount:count];
    
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
- (void)UpdateSpeViewPage:(NSString *)mGoodsImg andGoodsName:(NSString *)mName andGoodsPrice:(float)mPrice andSkuCount:(int)mcount{

    
    [mSpeView.mGoodsImg sd_setImageWithURL:[NSURL URLWithString:mGoodsImg] placeholderImage:[UIImage imageNamed:@"ZLDefault_Img"]];
    mSpeView.mGoodsName.text = mName;
    mSpeView.mGoodsPrice.text = [NSString stringWithFormat:@"价格：%.2f元",mPrice];
    mSpeView.mGoodsRep.text = [NSString stringWithFormat:@"库存：%d",mcount];
    
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
#pragma mark----****----  加按钮代理方法
/**
 添加按钮
 */
- (void)ZLSuperMarketAddBtnSelected{

    
}
#pragma mark----****---- 减按钮代理方法
/**
 减按钮
 */
- (void)ZLSuperMarketSubsructBtnSelected{


}
#pragma mark----****----规格ok按钮代理方法
/**
 规格ok按钮
 */
- (void)ZLSuperMarketShopCarBtnSelected{


    
}

- (void)mBackAction{

    [self dismissSearchView];
    [self hiddenSpeView];
    [self popViewController];
}
#pragma mark----****----加减代理方法
/**
 加减代理方法
 
 @param mNum       数量
 @param mIndexPath 索引
 */
- (void)ZLHouseKeppingServiceCellWithNumChanged:(int)mNum andIndexPath:(NSIndexPath *)mIndexPath{

    MLLog(@"索引是：%ld     数量是：%d",(long)mIndexPath.row,mNum);
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
    
    if (mSku.mSku.sta_required == 1) {
        [self UpdateSpeViewPage:mGoodObj.img_url andGoodsName:mGoodObj.pro_name andGoodsPrice:mSku.mSku.sku_price andSkuCount:mSku.mSku.sku_stock];

    }
    
    
    
}


@end
