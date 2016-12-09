//
//  ZLHouseKeepingViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/17.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHouseKeepingViewController.h"
#import "ZLHouseKeepingHomeCell.h"
#import "ZLSuperMarketShopCell.h"


@interface ZLHouseKeepingViewController ()<UITableViewDelegate,UITableViewDataSource,ZLHouseKeepingHomeCellDelegate>

@end

@implementation ZLHouseKeepingViewController
{
    //banner数据源
    NSMutableArray *mBannerArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"家政服务";
    mBannerArr = [NSMutableArray new];
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLHouseKeepingHomeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mTypeCell"];
    
    
    nib = [UINib nibWithNibName:@"ZLSuperMarketShopCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mShopCell"];

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
    return 2;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.5;
    }else{
        return 0.5;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return nil;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }else{
        return 10;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (self.tableArr.count<=4) {
            return 360-90;
        }else{
            return 360;
        }
    }else{
        return 80;
    }
    
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"mTypeCell";
        
        ZLHouseKeepingHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.delegate = self;
        [cell setMDataSource:mBannerArr];
        return cell;
    }else{
        
        
        reuseCellId = @"mShopCell";
        
        ZLSuperMarketShopCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
    
    
}
#pragma mark----****----分类点击代理方法
/**
 分类点击代理方法
 
 @param mIndex 索引
 */
- (void)ZLHouseKeepingHomeCellWithTypeBtnClicked:(NSInteger)mIndex{

}
@end
