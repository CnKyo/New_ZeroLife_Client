//
//  ZLHomeViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLHomeViewController.h"
#import "ScrollModelVC.h"
#import "ZLHomeScrollerTableViewCell.h"
@interface ZLHomeViewController ()<UITableViewDelegate,UITableViewDataSource,ZLHomeScrollerTableCellDelegate>

@end

@implementation ZLHomeViewController
{
    NSMutableArray *mBannerArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";

    mBannerArr = [NSMutableArray new];
    
    [self addTableView];
    //UINib   *nib = [UINib nibWithNibName:@"ZLHomeScrollerTableViewCell" bundle:nil];
    //[self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];

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
    
    return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 360;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell1";
    
    ZLHomeScrollerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    if (cell == nil) {
        cell = [[ZLHomeScrollerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId andBannerDataSource:mBannerArr andDataSource:self.tableArr];
    }
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}

- (void)ZLHomeScrollerTableViewCellDidSelectedWithIndex:(NSInteger)mIndex{

    MLLog(@"点击了第:%ld个",(long)mIndex);
}

- (void)ZLHomeBannerDidSelectedWithIndex:(NSInteger)mIndex{
    MLLog(@"点击了第:%ld个",(long)mIndex);

}
@end
