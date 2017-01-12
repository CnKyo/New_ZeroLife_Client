//
//  DryCleanShopTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "DryCleanShopTVC.h"
#import "HMSegmentedControl.h"
#import "DryCleanShopTableViewCell.h"
#import "NoticeTextView.h"
#import "ZLSuperMarketShopViewController.h"
#import "ZLHouseKeepingClearnCell.h"
@interface DryCleanShopTVC ()<ZLHouseKeepingClearnCellDelegate>
@property(nonatomic,strong) NSMutableArray *classArr;
@property(nonatomic,strong) ZLShopHomeClassify *classCurrentItem;

@property(nonatomic,strong) ZLHouseKeepingClearnCell *classView;

@end

@implementation DryCleanShopTVC
{
    NSMutableArray *mShopArr;
}
-(void)loadView
{
    [super loadView];
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家政干洗";
    
    self.beginHeaderRereshingWhenViewWillAppear = NO;
    self.classArr = [NSMutableArray new];
    
    
    [self addTableView];
    [self setTableViewHaveHeader];
    [self setTableViewHaveHeaderFooter];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    

    [self loadClassData];
    
}


//加载分类数据
-(void)loadClassData
{
    NSMutableArray *arr = [ZLShopHomeClassify arrWithClassType:self.mType];
    [self reloadClassData:arr]; //先加载本地数据

    [[APIClient sharedClient] ZLGetShopHomePage:self.mLat andLng:self.mLng andType:self.mType block:^(APIObject *mBaseObj, ZLShopHomePage *mShopHome) {
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            [ZLShopHomeClassify updateWithClassType:self.mType newArr:mShopHome.classify];
            [self reloadClassData:mShopHome.classify];
        } else
            [SVProgressHUD showErrorWithStatus:mBaseObj.msg];
    }];
}

//设置分类数据
-(void)reloadClassData:(NSArray *)arr
{
    if (arr.count > 0) {
        [self.classArr setArray:arr];
        [self reloadClassUI];
        
        ZLShopHomeClassify *item0 = [arr objectAtIndex:0];
        [self loadTableArrWithItem:item0];
    }
}

//根据数据显示界面UI
-(void)reloadClassUI
{
    UIView *view = self.view;
    
    NSUInteger row = self.classArr.count/4;
    if (self.classArr.count%4 != 0)
        row ++;
    CGFloat height = row * 90;
    
    ZLHouseKeepingClearnCell *cell = [[ZLHouseKeepingClearnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2" andDataSource:self.classArr];
    cell.delegate = self;
    [view addSubview:cell];
    self.classView = cell;
    [cell makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.top.equalTo(view.top).offset(NAVBAR_Height);
        make.height.equalTo(height);
    }];
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.top.equalTo(view.top).offset(height);
    }];
    
}

-(void)loadTableArrWithItem:(ZLShopHomeClassify *)mClassiFy
{
    self.classCurrentItem = mClassiFy;
    self.page = 1;
    [self beginHeaderRereshing];
}

- (void)reloadTableViewData{
    [self beginHeaderRereshing];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    ZLShopHomeClassify *mShopClassify = _classCurrentItem;
    [[APIClient sharedClient] ZLGetShopHomeShopList:self.mType andLat:self.mLat andLng:self.mLng andClassId:[NSString stringWithFormat:@"%d",mShopClassify.cls_id] andPage:1 block:^(APIObject *mBaseObj, ZLShopHomeShopList *mShopList) {
        [self reloadWithTableArr:mShopList.list info:mBaseObj];
    }];
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_DryCleanShopTVCTableViewCell";
    DryCleanShopTableViewCell *cell = [[DryCleanShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
    cell.backgroundColor = [UIColor whiteColor];
    
    [cell setMShopObj:self.tableArr[indexPath.row]];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    if (self.tableArr.count > 0) {
    //        UserAddressEditVC *vc = [[UserAddressEditVC alloc] init];
    //        [self.navigationController pushViewController:vc animated:YES];
    //    }
    
    if (indexPath.section == 1) {
        ZLSuperMarketShopViewController *vc = [ZLSuperMarketShopViewController new];
        vc.mType = ZLShopTypeHouseKeeping;
        vc.mShopObj = self.tableArr[indexPath.row];

        [self pushViewController:vc];
    }
    
    
    
}

/**
 分类点击方法
 
 @param mIndex 返回索引
 */
- (void)ZLHouseKeepingClearnCellWithCatigryDidSelectedIndex:(NSInteger)mIndex{

    MLLog(@"----------******---：%ld",(long)mIndex);
    
    [self loadTableArrWithItem:self.classArr[mIndex]];
}


@end
