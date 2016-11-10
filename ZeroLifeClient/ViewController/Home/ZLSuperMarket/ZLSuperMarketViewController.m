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
    
    ZLSuperMarketSearchView *mSearchView;
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    mBannerArr = [NSMutableArray new];
    
    mSearchView = [ZLSuperMarketSearchView shareView];
    mSearchView.frame = CGRectMake(0, 0, 200, 30);
    self.navigationItem.titleView = mSearchView;

    
    [self addTableView];

    [self addRightBtn:YES andTitel:@"搜索" andImage:nil];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLSuperMarketShopCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"shopCell"];

    
    nib = [UINib nibWithNibName:@"ZLSuperMarketShopActivityCell1" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"actovotyTypeCell1"];

    
    nib = [UINib nibWithNibName:@"ZLSuperMarketShopActivityCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"actovotyTypeCell2"];

    
    [self loadData];

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
    return 4;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 3) {
        return 40;
    }else{
        return 0.5;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        ZLSuperMarketHeaderSectionView *mSectionHeader = [ZLSuperMarketHeaderSectionView shareView];
        return mSectionHeader;
    }else{
        return nil;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 3) {
        return 10;
    }else{
        return 1;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (self.tableArr.count<=4) {
            return 330-90;
        }else{
            return 330;
        }
        
        
    }else if (indexPath.section == 1){
        return 100;
    }else if(indexPath.section == 2){
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
            
            ZLSupMarketCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            if (cell == nil) {
                cell = [[ZLSupMarketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId andBannerDataSource:mBannerArr andDataSource:self.tableArr];
            }
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delegate = self;
            
            return cell;
        }else if (indexPath.section == 1){
            reuseCellId = @"actovotyTypeCell1";
            
            ZLSuperMarketShopCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;

        }else if (indexPath.section == 2){
            reuseCellId = @"actovotyTypeCell2";
            
            ZLSuperMarketShopCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;

        }else{
            
            
            reuseCellId = @"shopCell";
            
            ZLSuperMarketShopCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }

    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLSuperMarketShopViewController *ZLSuperMarketShopVC = [ZLSuperMarketShopViewController new];
    [self pushViewController:ZLSuperMarketShopVC];
    
    
    
}
#pragma mark ----****----首页滚动分类功能代理方法
/**
 分类点击的代理方法
 
 @param mIndex 索引
 */
- (void)ZLSupermarketClassCellDidSelectedWithIndex:(NSInteger)mIndex{

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
