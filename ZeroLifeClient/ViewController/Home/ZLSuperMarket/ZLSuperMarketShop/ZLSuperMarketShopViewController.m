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
@interface ZLSuperMarketShopViewController ()<UITableViewDelegate,UITableViewDataSource,ZLSuperMarketShopDelegate,ZLSuperMarketGoodsCellDelegate,UIScrollViewDelegate>

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
    CGRect mL;
    CGRect mR;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"店铺首页";

    [self addRightBtn:YES andTitel:nil andImage:[UIImage imageNamed:@"ZLSearch_white"]];
    [self initView];
    [self initHeaderView];

}
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
    mLeftTableView.layer.borderColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.96 alpha:1.00].CGColor;
    mLeftTableView.layer.borderWidth = 0.5;
    [self.view addSubview:mLeftTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLSuperMarketShopLeftCellType" bundle:nil];
    [mLeftTableView registerNib:nib forCellReuseIdentifier:@"mLeftCell"];

    
    mRightTableView = [UITableView new];
    mRightTableView.delegate = self;
    mRightTableView.dataSource = self;
    mRightTableView.layer.masksToBounds = YES;
    mRightTableView.layer.borderColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.96 alpha:1.00].CGColor;
    mRightTableView.layer.borderWidth = 0.5;
    [self.view addSubview:mRightTableView];
    
    nib = [UINib nibWithNibName:@"ZLSuperMarketShopRightCell" bundle:nil];
    [mRightTableView registerNib:nib forCellReuseIdentifier:@"mRightCell"];

    
    [mLeftTableView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(156);
        make.bottom.equalTo(self.view).offset(DEVICE_Height-100);
        make.right.equalTo(mRightTableView.left).offset(0);
        make.width.offset(DEVICE_Width/3);
    }];
    
    [mRightTableView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(156);

        make.bottom.equalTo(self.view).offset(DEVICE_Height-100);
        make.left.equalTo(mLeftTableView.right).offset(0);
        make.width.offset(DEVICE_Width-DEVICE_Width/3);
    }];
    
    
//    mGeneraHeaderView = [UIView new];
//    mGeneraHeaderView.backgroundColor = [UIColor clearColor];
//    mGeneraHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 156);
////    [mGeneraHeaderView makeConstraints:^(MASConstraintMaker *make) {
////        make.left.top.right.equalTo(self.view).offset(0);
////        make.height.equalTo(mHeaderView.height);
////    }];
//    
//    mLeftTableView.tableHeaderView = mGeneraHeaderView;
//    mRightTableView.tableHeaderView = mGeneraHeaderView;

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
#pragma mark----****---- 减按钮代理方法
/**
 减按钮代理方法
 
 @param mIndexPath 索引
 */
- (void)ZLSuperMarketGoodsCellWithSubstructSelectedIndexPath:(NSIndexPath *)mIndexPath{

}
#pragma mark----****----  加按钮代理方法
/**
 加按钮代理方法
 
 @param mIndexPath 索引
 */
- (void)ZLSuperMarketGoodsCellWithAddSelectedIndexPath:(NSIndexPath *)mIndexPath{

}
#pragma mark----****----滚动代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    MLLog(@"yyyyyyyyy----------:  %f",offsetY);
    
    mL = mLeftTableView.frame;
//    mR = mRightTableView.frame;
    
    if (offsetY < 156) {
        
        mL.origin.y = 156 - offsetY;
//        mR.origin.y = 156- offsetY;
        
        mLeftTableView.frame = mL;
//        mRightTableView.frame = mR;
        
    } else {
        
        mL.origin.y = 156 + offsetY;
//        mR.origin.y = 156+offsetY;
        
        mLeftTableView.frame = mL;
//        mRightTableView.frame = mR;
    }
}


@end
