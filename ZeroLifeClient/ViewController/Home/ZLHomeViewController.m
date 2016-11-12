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

@interface ZLHomeViewController ()<UITableViewDelegate,UITableViewDataSource,ZLHomeScrollerTableCellDelegate,ZLHomeLocationViewDelegate,ZLCoupViewDelegate>

@end

@implementation ZLHomeViewController
{
    //banner数据源
    NSMutableArray *mBannerArr;
    //地址选择view
    ZLHomeLocationView *mLocationView;
    //优惠券弹框
    ZLHomeCoupView *mCoupView;
    //优惠券数据源
    NSMutableArray *mCoupArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";

    mBannerArr = [NSMutableArray new];
    mCoupArr = [NSMutableArray new];

    
    [self initLeftAndRightBarButton];
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLHomeOtherCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

    
    [self initCoupView];
    
    [self loadData];
}
#pragma mark ----****----加载导航条左右按钮和中间的社区选择view
- (void)initLeftAndRightBarButton{

    
    [self addRightBtn:YES andTitel:nil andImage:[UIImage imageNamed:@"ZLHome_Message"]];
    [self.navigationController.navigationBar.subviews[3] setHidden:YES];
    
    MLLog(@"%@",self.navigationController.navigationBar.subviews);
    
    mLocationView = [ZLHomeLocationView shareView];
    mLocationView.frame = CGRectMake(0, 0, 200, 30);
    mLocationView.delegate = self;
    self.navigationItem.titleView = mLocationView;
    
    
}
#pragma mark ----****----社区选择view代理方法
- (void)ZLHomLocationViewDidSelected{
    ZLSelectArearViewController *ZLAddressVC = [ZLSelectArearViewController new];
    ZLAddressVC.block = ^(NSString *mBlockAddress ,NSString *mBlockId){
        mLocationView.mAddress.text = mBlockAddress;
       
    };
    [self pushViewController:ZLAddressVC];
}
#pragma mark ----****----消息按钮方法
- (void)mRightAction:(UIButton *)sender{
    MLLog(@"right");
    
    ZLHomeMessageViewController *ZLHomeMsgVC = [ZLHomeMessageViewController new];
    [self pushViewController:ZLHomeMsgVC];
    
}
- (void)loadData{

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
    for (int i = 0; i<11; i++) {
        if (i == 3) {
            [mTempDic setValue:@"家政" forKey:@"title"];
        } else
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
    if (tableView == self.tableView) {
        return 2;
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
    
    if (tableView == self.tableView) {
        if (section == 0) {
            return 1;
        }else{
            return 5;
        }
    }else{
        
        return 5;
    }
 
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            
            if (self.tableArr.count<=4) {
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
    
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            reuseCellId = @"cell1";
            
            ZLHomeScrollerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            if (cell == nil) {
                cell = [[ZLHomeScrollerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId andBannerDataSource:mBannerArr andDataSource:self.tableArr];
            }
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delegate = self;
            
            return cell;
        }else{
            
            
            reuseCellId = @"cell2";
            
            ZLHomeOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
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
    
    if (tableView == self.tableView) {
        [self showCoupView];
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
        mSuperMarketVC.hidesBottomBarWhenPushed = YES;
        [self pushViewController:mSuperMarketVC];
        
    }else if (mIndex == 2){
        ZLTenementRepairsViewController *ZLFixVC = [ZLTenementRepairsViewController new];
        ZLFixVC.hidesBottomBarWhenPushed = YES;

        [self pushViewController:ZLFixVC];
    }
    
    else if (mIndex == 3) {
        DryCleanShopTVC *vc = [[DryCleanShopTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushViewController:vc];
    }
    

}
#pragma mark ----****----banner点击方法
- (void)ZLHomeBannerDidSelectedWithIndex:(NSInteger)mIndex{
    MLLog(@"点击了第:%ld个",(long)mIndex);

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
