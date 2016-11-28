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

static const CGFloat mTopH = 156;

@interface ZLSuperMarketShopViewController ()<UITableViewDelegate,UITableViewDataSource,ZLSuperMarketShopDelegate,ZLSuperMarketGoodsCellDelegate,UIScrollViewDelegate,ZLSuperMarketShopCarDelegate,ZLSuperMarketGoodsSpecDelegate,UICollectionViewDelegate,ZLHouseKeppingServiceCellDelegate,ZLSpeSelectedViewCellDelegate>

/**
 规格瀑布流
 */
@property (nonatomic, strong) UITableView *mSpeTableView;

/**
 规格数据源
 */
@property (nonatomic, strong) NSMutableArray *mSpeDataArray;

/**
 选择规格数据源
 */
@property (nonatomic, strong) NSMutableArray *mSpeAddArray;

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
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"店铺首页";

    self.mSpeDataArray = [NSMutableArray new];
    self.mSpeAddArray = [NSMutableArray new];
    
    [self addRightBtn:YES andTitel:nil andImage:[UIImage imageNamed:@"ZLSearch_white"]];

    [self initView];
    [self initData];
    [self initHeaderView];
    [self initSpeView];
    
}

- (void)loadView{

    [super loadView];

}

#pragma mark----****----加载数据
- (void)initData{

    NSArray *mAr = [NSArray arrayWithObjects:@{@"num":@[@"问题1",@"问题2",@"问题3",@"问题4",@"问题5",@"问题6",@"问题7",@"问题8",@"请点击复合你的)"]}, nil];
    
    [self.mSpeAddArray addObjectsFromArray:mAr];
    
//    for (int i=0; i<8; i++) {
//        [self.mSpeDataArray addObject:[NSString stringWithFormat:@"第%d种规格 %d元",i,i+150]];
//    }
}
#pragma mark----****----加载headerview
- (void)initHeaderView{
    mHeaderView = [ZLSuperMarketHeaderView shareView];
    [self.view addSubview:mHeaderView];
    
    [mHeaderView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view).offset(0);
        make.height.offset(@156);
    }];
    
    

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
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(-50);
        make.right.equalTo(mRightTableView.left).offset(0);
        make.width.offset(DEVICE_Width/3);
    }];
    
    [mRightTableView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
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
    return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.mSpeTableView) {
        return 40;
    }else{
        return 0.15;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.mSpeTableView) {
        _mSpeHeaderView = [[ZLSpeHeaderView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_Width, 40)];
        _mSpeHeaderView.mNameLabel.text = [NSString stringWithFormat:@"%@:",[[[self.mSpeAddArray objectAtIndex:0]objectForKey:@"num"]objectAtIndex:section]];
        return _mSpeHeaderView;
    }else{
        return nil;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == mLeftTableView) {
        return 5;
    }else if (tableView == mRightTableView){
        return 10;
    }else{
        return 3;
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
        return 100;
    }else{
    return ([[[self.mSpeAddArray objectAtIndex:0]objectForKey:@"num"] count]/4 + [[[self.mSpeAddArray objectAtIndex:0]objectForKey:@"num"] count]%4) * 40;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
     if (tableView == mLeftTableView){
        reuseCellId = @"mLeftCell";
        
        ZLSuperMarketShopLeftCellType *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
            reuseCellId = @"mRightCell";
            
            ZLSuperMarketShopRightCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        
    }else{
    
        static NSString *cellName = @"cellName";
        ZLSpeSelectedViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ZLSpeSelectedViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName andDataSource:self.mSpeAddArray];
            cell.delegate = self;
            cell.mIndexPathSection = indexPath;
        }
        return cell;

    }
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLGoodsDetailViewController *mShopVC = [ZLGoodsDetailViewController new];
    [self pushViewController:mShopVC];
    
    
    
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

    [self showSpeView];
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
        }
        else if (offsetY <= -mTopH){
            
            
            [self setHeaderViewY:0];
            mLeftTableView.contentInset = UIEdgeInsetsMake(mTopH, 0, 0, 0);
            mRightTableView.contentInset = UIEdgeInsetsMake(mTopH, 0, 0, 0);
        }
        else{
            CGFloat mH = -mTopH - offsetY;
            [self setHeaderViewY:mH];
            
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
    ZLSuperMarketShopCarViewController *ZLShopCarVC = [ZLSuperMarketShopCarViewController new];
    [self pushViewController:ZLShopCarVC];
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
#pragma mark----****----规格view
- (void)initSpeView{



    
    CGRect mSpeRect = self.view.bounds;
    mSpeRect.origin.y = DEVICE_Height;
    
    
    mSpeView = [ZLSuperMArketSearchGoodsView initWithSpeView:mSpeRect];
    mSpeView.delegate = self;

    _mSpeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width-40,152) style:UITableViewStyleGrouped];
    _mSpeTableView.delegate = self;
    _mSpeTableView.dataSource = self;
    _mSpeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [mSpeView.mGoodsSpeScrollView addSubview:_mSpeTableView];
    
    
    [self.view addSubview:mSpeView];
    [self initData];
    [_mSpeTableView reloadData];
}
#pragma mark----****----显示规格view
- (void)showSpeView{

    [self dismissSearchView];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mSpeRect = mSpeView.frame;
        mSpeRect.origin.y = 0;
        mSpeView.frame = mSpeRect;
    }];
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
@end
