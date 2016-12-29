//
//  ZLTenementRepairsViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLTenementRepairsViewController.h"
#import "ZLRepairsColumsView.h"
#import "ZLRepairsCell.h"
#import "ZLRepairsCustomView.h"
#import "ZLRepairsDetailViewController.h"


@interface ZLTenementRepairsViewController ()<UITableViewDelegate,UITableViewDataSource,ZLRepairsColumsViewDelegate>

@end

@implementation ZLTenementRepairsViewController
{

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"物业报修";
    
    [self addRightBtn:YES andTitel:@"竞价说明" andImage:nil];

    
    [self initView];

}

- (void)initView{

    
    
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLRepairsCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self setTableViewHaveHeader];

    
}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] ZLGetShopHomePage:self.mLat andLng:self.mLng andType:self.mType block:^(APIObject *mBaseObj, ZLShopHomePage *mShopHome) {
        
        [self.tableArr removeAllObjects];
      
        [self ZLHideEmptyView];
        if (mBaseObj.code == RESP_STATUS_YES) {

            [self.tableArr addObjectsFromArray:mShopHome.classify];
            [self replaceDataSource];
            
        }else{
            
            [self showErrorStatus:mBaseObj.msg];
            [self ZLShowEmptyView:mBaseObj.msg andImage:nil andHiddenRefreshBtn:NO];
        }
        
        [self doneHeaderRereshing];
        
    }];


    
}
- (void)replaceDataSource{

    NSMutableArray *mClassArr = [NSMutableArray new];
    
    for (int i =0; i<self.tableArr.count; i++) {
        ZLShopHomeClassify *mOne = self.tableArr[i];
        BOOL mIsAdd = YES;
        for (int j = 0; j<mClassArr.count; j++) {
            
        ZLFixClassExtObj *mTwo = mClassArr[j];
            
            if (mOne.cls_parent == mTwo.mParentId) {
                
                ZLFixSubExtObj *mC = [ZLFixSubExtObj new];
                mC.mClassId = mOne.cls_id;
                mC.mClassName = mOne.cls_name;
                mC.mClassImg = mOne.cls_image;

                [mTwo.mClassArr addObject:mC];
                
                [mClassArr replaceObjectAtIndex:j withObject:mTwo];
                mIsAdd = NO;
                continue;
                
            }
            
        }
        if (mIsAdd == YES) {
            ZLFixClassExtObj *mP = [ZLFixClassExtObj new];
            mP.mParentId = mOne.cls_parent;
            mP.mParentName = mOne.parent_name;
            
            ZLFixSubExtObj *mC = [ZLFixSubExtObj new];
            mC.mClassId = mOne.cls_id;
            mC.mClassName = mOne.cls_name;
            mC.mClassImg = mOne.cls_image;
            
            NSMutableArray *mTempArr = [NSMutableArray new];
            [mTempArr addObject:mC];
            mP.mClassArr = mTempArr;
            [mClassArr addObject:mP];
     
        }
        
    }
    
    [self.tableArr removeAllObjects];
    [self.tableArr addObjectsFromArray:mClassArr];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSArray * array = [self.dataDictionary objectForKey:self.allkeys[section]];
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLRepairsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZLRepairsCell" owner:nil options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    ZLFixClassExtObj *mP = self.tableArr[indexPath.section];
    cell.mTitle.text = mP.mParentName;
    cell.dataArray = mP.mClassArr;
    cell.indexPath = indexPath;
    cell.mMainView.indexPath = indexPath;
    cell.mMainView.delegate = self;

    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    ZLFixClassExtObj *mP = self.tableArr[section];

    return mP.mParentName;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *vvv = [UIView new];
    vvv.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    return vvv;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHt = 0.0;
   
    if (self.tableArr.count != 0) {
        ZLRepairsColumsView * cellView = [[ZLRepairsColumsView alloc] init];
        cellView.dataArrayCount = self.tableArr.count;
        cellHt += cellView.cellHeight;
    }
    
    return cellHt;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark----****----cell点击代理方法
/**
 cell点击代理方法
 
 @param mItem  item
 @param mIndex 索引index
 */
- (void)ZLRepairsColumsViewClickedWithItem:(NSIndexPath *)mItem andIndex:(NSInteger)mIndex{
     MLLog(@"----###----###---(%ld,%ld)----##---%ld----###-----",mItem.section,mItem.row,mIndex);
    ZLFixClassExtObj *mP = self.tableArr[mItem.section];
    ZLFixSubExtObj *mC = mP.mClassArr[mIndex];
    
    ZLRepairsDetailViewController *ZLRepDetailVC = [ZLRepairsDetailViewController new];
    ZLRepDetailVC.mParentObj = mP;
    ZLRepDetailVC.mClassObj = mC;
    
    ZLRepDetailVC.mUrl = [NSString stringWithFormat:@"%@/wap/good/repairDetails?cls_id=%d&shop_id=0",[[APIClient sharedClient] currentUrl],mC.mClassId];

    [self pushViewController:ZLRepDetailVC];
}
#pragma mark----****----右边的按钮
- (void)mRightAction:(UIButton *)sender{
    
}
@end
