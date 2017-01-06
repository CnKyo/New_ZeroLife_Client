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
    
    mShopArr = [NSMutableArray new];
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    

    [self setTableViewHaveHeader];

}

- (void)reloadTableViewData{
    [self reloadTableViewDataSource];
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] ZLGetShopHomePage:self.mLat andLng:self.mLng andType:self.mType block:^(APIObject *mBaseObj, ZLShopHomePage *mShopHome) {
        
        [self.tableArr removeAllObjects];
        
        [self ZLHideEmptyView];
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            [self.tableArr addObjectsFromArray:mShopHome.classify];
            
            [self loadData];
            
            
        }else{
            
            [self showErrorStatus:mBaseObj.msg];
            [self addEmptyView:self.tableView andType:ZLEmptyViewTypeWithCommon];
        }
        
        [self doneHeaderRereshing];
        
    }];
    
    
    
}
- (void)loadData{
    if (self.tableArr.count>0) {
        ZLShopHomeClassify *mShopClassify = self.tableArr[0];
        [[APIClient sharedClient] ZLGetShopHomeShopList:self.mType andLat:self.mLat andLng:self.mLng andClassId:[NSString stringWithFormat:@"%d",mShopClassify.cls_id] andPage:1 block:^(APIObject *mBaseObj, ZLShopHomeShopList *mShopList) {
            
            [mShopArr removeAllObjects];
            if (mBaseObj.code == RESP_STATUS_YES) {
                
                [mShopArr addObjectsFromArray:mShopList.list];
                
            }else{
                
                [self showErrorStatus:mBaseObj.msg];
            }
            [self doneHeaderRereshing];
            
        }];
        
    }
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

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    
    [self.tableArr removeAllObjects];
    [self beginHeaderRereshing];
}


#pragma mark -- tableviewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{

    return 2;

    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return mShopArr.count;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (self.tableArr.count<=4) {
            return 180-90;
        }else{
            return 180;
        }
        
        
    }else{
//        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
        MLLog(@"---HHHH:%f",[super tableView:tableView heightForRowAtIndexPath:indexPath]);
        return 80;
    }
 
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        

        ZLHouseKeepingClearnCell *cell = [[ZLHouseKeepingClearnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2" andDataSource:self.tableArr];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
        cell.delegate = self;
        
        return cell;

    }else{
        static NSString *CellIdentifier = @"Cell_DryCleanShopTVCTableViewCell";
        DryCleanShopTableViewCell *cell = [[DryCleanShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
        cell.backgroundColor = [UIColor whiteColor];
        
        [cell setMShopObj:mShopArr[indexPath.row]];
        

        return cell;
        

    }

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
        vc.mShopObj = mShopArr[indexPath.row];

        [self pushViewController:vc];
    }
    
    
    
}

/**
 分类点击方法
 
 @param mIndex 返回索引
 */
- (void)ZLHouseKeepingClearnCellWithCatigryDidSelectedIndex:(NSInteger)mIndex{

    MLLog(@"----------******---：%ld",(long)mIndex);
    [self upDatePage:self.tableArr[mIndex]];
}
- (void)upDatePage:(ZLShopHomeClassify *)mClassiFy{
    [self showWithStatus:@"加载中..."];
    [[APIClient sharedClient] ZLGetShopHomeShopList:self.mType andLat:self.mLat andLng:self.mLng andClassId:[NSString stringWithFormat:@"%d",mClassiFy.cls_id] andPage:1 block:^(APIObject *mBaseObj, ZLShopHomeShopList *mShopList) {
        
        [mShopArr removeAllObjects];
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self dismiss];
            [mShopArr addObjectsFromArray:mShopList.list];
            
        }else{
            
            [self showErrorStatus:mBaseObj.msg];
        }
        [self.tableView reloadData];
    }];
    
}

@end
