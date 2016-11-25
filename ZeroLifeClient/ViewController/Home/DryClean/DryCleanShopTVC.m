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

    NSMutableArray *mArr;
}
-(void)loadView
{
    [super loadView];
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家政干洗";
    mArr = [NSMutableArray new];
    
    UIView *superView = self.view;
    //int padding = 10;
    
    //    HMSegmentedControl *seg = [[HMSegmentedControl alloc] initWithSectionImages:@[IMG(@"juming_off.png"), IMG(@"wuguan_off.png"), IMG(@"gongsi_off.png")]
    //                                                          sectionSelectedImages:@[IMG(@"juming_on.png"), IMG(@"wuguan_on.png"), IMG(@"gongsi_on.png")]
    //                                                              titlesForSections:@[@"洗衣家坊", @"洗鞋", @"窗帘清洗"]];
    //    seg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    //    seg.selectionIndicatorHeight = 2.0f;
    //    seg.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor]};
    //    seg.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_NavBar};
    //    seg.selectionIndicatorColor = COLOR_NavBar;
    //    [superView addSubview:seg];
    //    [seg addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    
    [self addTableView];
    [self setTableViewHaveHeaderFooter];
    
    //    NoticeTextView *noticeView = [[NoticeTextView alloc] init];
    //    [superView addSubview:noticeView];
    //
    //    [seg makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.equalTo(superView);
    //        make.top.equalTo(superView).offset(@64);
    //        make.height.equalTo(60);
    //    }];
    //    [noticeView makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.equalTo(superView);
    //        make.top.equalTo(seg.bottom).offset(OnePixNumber);
    //        make.height.equalTo(40);
    //    }];
    //    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.bottom.equalTo(self.view);
    //        make.top.equalTo(noticeView.bottom).offset(TenPixNumber);
    //    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //    UINib   *nib = [UINib nibWithNibName:@"ZLHouseKeepingClearnCell" bundle:nil];
    //    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    [self loadData];

}
- (void)loadData{
    
    
    NSDictionary *mTempDic = [NSMutableDictionary new];
    for (int i = 0; i<11; i++) {
        if (i == 3) {
            [mTempDic setValue:@"家政" forKey:@"title"];
        } else
            [mTempDic setValue:[NSString stringWithFormat:@"这是第%d",i] forKey:@"title"];
        [mTempDic setValue:@"icon_homepage_default" forKey:@"image"];
        [mArr addObject:mTempDic];
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
        return 10;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (mArr.count<=4) {
            return 220-90;
        }else{
            return 220;
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
        

        ZLHouseKeepingClearnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
     
        if (cell == nil) {
            cell = [[ZLHouseKeepingClearnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2" andDataSource:mArr];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
        cell.delegate = self;
        
        return cell;

    }else{
//        if (self.tableArr.count > 0) {
            static NSString *CellIdentifier = @"Cell_DryCleanShopTVCTableViewCell";
            DryCleanShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[DryCleanShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.iconImgView.image = IMG(@"choose_on.png");
            cell.nameLable.text = @"乐天马特干洗店";
            cell.timeLable.text = @"30分钟内送达";
            cell.saleLable.text = @"月售300份";
            cell.distanceLable.text = @"200m";
            return cell;
//        }

    }
//    return [super tableView:tableView cellForRowAtIndexPath:indexPath];

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
        vc.mType = 2;
        [self pushViewController:vc];
    }
    
    
    
}



- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    [self performSelector:@selector(donwData) withObject:nil afterDelay:0.5];
}

-(void)donwData
{
    for (int i=0; i<10; i++) {
        [self.tableArr addObject:@"111"];
    }
    [self doneLoadingTableViewData];
}
/**
 分类点击方法
 
 @param mIndex 返回索引
 */
- (void)ZLHouseKeepingClearnCellWithCatigryDidSelectedIndex:(NSInteger)mIndex{

    MLLog(@"----------******---：%ld",(long)mIndex);
}

@end
