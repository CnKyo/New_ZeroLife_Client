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

@interface ZLSuperMarketShopViewController ()<UITableViewDelegate,UITableViewDataSource,ZLSuperMarketShopDelegate,ZLSuperMarketGoodsCellDelegate,UIScrollViewDelegate,ZLSuperMarketShopCarDelegate,ZLSuperMarketGoodsSpecDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**
 规格瀑布流
 */
@property (nonatomic, strong) UICollectionView *mCollectionView;

/**
 规格数据源
 */
@property (nonatomic, strong) NSMutableArray *mSpeDataArray;

/**
 选择规格数据源
 */
@property (nonatomic, strong) NSMutableArray *mSpeAddArray;

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
    
    UIScrollView *mMainView;
    ///地步view
    ZLSuperMarketShopCarView *mBottomView;
    ///搜索view
    ZLSuperMArketSearchGoodsView *mSearchView;
    ///规格view
    ZLSuperMArketSearchGoodsView *mSpeView;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"店铺首页";

    self.mSpeDataArray = [NSMutableArray new];
    self.mSpeAddArray = [NSMutableArray new];
    
    [self addRightBtn:YES andTitel:nil andImage:[UIImage imageNamed:@"ZLSearch_white"]];
    [self initHeaderView];

    [self initView];
    [self initData];
    [self initSpeView];
    
    
    
}
#pragma mark----****----加载数据
- (void)initData{

    for (int i=0; i<8; i++) {
        [self.mSpeDataArray addObject:[NSString stringWithFormat:@"第%d种规格 %d元",i,i+150]];
    }
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

    mMainView = [UIScrollView new];
    [self.view addSubview:mMainView];
    mMainView.backgroundColor = [UIColor clearColor];
    [mMainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(@156);
        make.width.offset(DEVICE_Width);
    }];
    
    mLeftTableView = [UITableView new];
    mLeftTableView.delegate = self;
    mLeftTableView.dataSource = self;
    mLeftTableView.layer.masksToBounds = YES;
    mLeftTableView.layer.borderColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.96 alpha:1.00].CGColor;
    mLeftTableView.layer.borderWidth = 0.5;
    [mMainView addSubview:mLeftTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLSuperMarketShopLeftCellType" bundle:nil];
    [mLeftTableView registerNib:nib forCellReuseIdentifier:@"mLeftCell"];

    
    mRightTableView = [UITableView new];
    mRightTableView.delegate = self;
    mRightTableView.dataSource = self;
    mRightTableView.layer.masksToBounds = YES;
    mRightTableView.layer.borderColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.96 alpha:1.00].CGColor;
    mRightTableView.layer.borderWidth = 0.5;
    [mMainView addSubview:mRightTableView];
    
    nib = [UINib nibWithNibName:@"ZLSuperMarketShopRightSpecCell" bundle:nil];
    [mRightTableView registerNib:nib forCellReuseIdentifier:@"mRightCell"];

    
    [mLeftTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mMainView).offset(0);
        make.top.equalTo(mMainView).offset(0);
        make.bottom.equalTo(mMainView).offset(DEVICE_Height-100);
        make.right.equalTo(mRightTableView.left).offset(0);
        make.width.offset(DEVICE_Width/3);
    }];
    
    [mRightTableView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mMainView).offset(0);
        make.top.equalTo(mMainView).offset(0);
        make.bottom.equalTo(mMainView).offset(DEVICE_Height-100);
        make.left.equalTo(mLeftTableView.right).offset(0);
        make.width.offset(DEVICE_Width-DEVICE_Width/3);
    }];

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
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    if (section == 3) {
//        return 40;
//    }else{
//        return 0.5;
//    }
//    
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 3) {
//        ZLSuperMarketHeaderSectionView *mSectionHeader = [ZLSuperMarketHeaderSectionView shareView];
//        return mSectionHeader;
//    }else{
//        return nil;
//    }
//    
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//    if (section == 3) {
        return 10;
//    }else{
//        return 1;
//    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == mLeftTableView) {
        return 50;
    }else{
        return 100;
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
        
    }else{
        
        
        reuseCellId = @"mRightCell";
        
        ZLSuperMarketShopRightCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLSuperMarketShopViewController *mShopVC = [ZLSuperMarketShopViewController new];
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
    CGFloat offsetY = scrollView.contentOffset.y;
    
    MLLog(@"yyyyyyyyy----------:  %f",offsetY);
    
    mRect = mMainView.frame;
    
    if (offsetY > 30 ) {
  
        [UIView animateWithDuration:0.25 animations:^{
            mRect.origin.y = 0;
            mRect.size.height+=156;
            mMainView.frame = mRect;

        }];
        
    }
    else if(offsetY < 0){
        if (offsetY == -30) {
            return;
        }
        [UIView animateWithDuration:0.25 animations:^{
            mRect.origin.y = 156;

            mMainView.frame = mRect;
            
        }];

        

    }

}
#pragma mark----****---- 购物车代理方法
/**
 购物车代理方法
 */
- (void)ZLSuperMarketShopCarDidSelected{
    ZLSuperMarketShopCarViewController *ZLShopCarVC = [ZLSuperMarketShopCarViewController new];
    [self pushViewController:ZLShopCarVC];
}
#pragma mark----****----隐藏搜索view
/**
 去结算代理方法
 */
- (void)ZLSuperMarketGoPayDidSelected{

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

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width-40,152) collectionViewLayout:flowLayout];
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    
    [_mCollectionView setBackgroundColor:[UIColor clearColor]];
    [mSpeView.mGoodsSpeScrollView addSubview:_mCollectionView];
    //注册
    [_mCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"mSpecCell"];
    
    [self.view addSubview:mSpeView];

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


#pragma mark----****----collectionviewdelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.mSpeDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mSpeDataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [self widthForLabel:[NSString stringWithFormat:@"%@",self.mSpeDataArray[indexPath.row]] fontSize:13];
    return CGSizeMake(width+10,22);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mSpecCell" forIndexPath:indexPath];
    
    for (UILabel *vvv in cell.contentView.subviews) {
        [vvv removeFromSuperview];
    }
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"%@",self.mSpeDataArray[indexPath.row]];
    label.frame = CGRectMake(0, 0, ([self widthForLabel:label.text fontSize:13] + 10), 22);
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor lightGrayColor];
    label.layer.cornerRadius = 3;
    label.layer.masksToBounds = YES;
    label.layer.borderWidth = 1.0;
    label.textAlignment = NSTextAlignmentCenter;
    [label.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [cell.contentView addSubview:label];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *selectedCell =
    [collectionView cellForItemAtIndexPath:indexPath];
    
    [self.mSpeAddArray addObject:self.mSpeDataArray[indexPath.row]];
    
    selectedCell.contentView.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
//    [selectedCell.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [selectedCell.contentView.layer setBorderWidth:1];
    
    MLLog(@"%@",self.mSpeAddArray);
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *deselectedCell =
    [collectionView cellForItemAtIndexPath:indexPath];
    [self.mSpeAddArray removeObject:self.mSpeDataArray[indexPath.row]];
    deselectedCell.contentView.backgroundColor = nil;
//    [deselectedCell.contentView.layer setBorderColor:[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:0.75].CGColor];
//    [deselectedCell.contentView.layer setBorderWidth:3.0f];
    
    MLLog(@"%@",self.mSpeAddArray);
}
/**
 *  计算文字长度
 */
- (CGFloat)widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    return size.width;
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


@end
