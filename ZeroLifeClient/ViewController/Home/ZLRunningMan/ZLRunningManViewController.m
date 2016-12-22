//
//  ZLRunningManViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLRunningManViewController.h"
#import "ZLRunningManHomeCell.h"
#import "ZLRuuningManHomeHeaderSectionView.h"
#import "ZLRunningManCell.h"
#import "HMSegmentedControl.h"
#import "ZLPPTAnounceMentViewController.h"
#import "ZLPPTRewardViewController.h"
#import "ZLPPTMyOrderViewController.h"
#import "ZLPPTRateViewController.h"
#import "UserPaoPaoRegisterVC.h"
@interface ZLRunningManViewController ()<UITableViewDelegate,UITableViewDataSource,ZLRunningManHomeCellDelegate,ZLRunningManCellDelegate,ZLRuuningManHomeHeaderSectionViewDelegate>

@end

@implementation ZLRunningManViewController
{

    ZLRuuningManHomeHeaderSectionView *mFirstSectionView;
    ZLRuuningManHomeHeaderSectionView *mSecondSectionView;

    ZLPPTHomeClassList *mClassObj;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"跑跑腿";
  
    mClassObj = [ZLPPTHomeClassList new];
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLRunningManHomeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    nib = [UINib nibWithNibName:@"ZLRunningManCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    [self loadClassData];
}
- (void)loadClassData{

    [self showWithStatus:@"正在加载..."];
    
    [[APIClient sharedClient] ZLGetPPTHome:^(APIObject *mBaseObj, ZLPPTHomeClassList *mList) {
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            mClassObj = mList;
            
            [self showSuccessStatus:mBaseObj.msg];

            [self initSecondSectionView:mList.classifyList];
        }else{
            [self showErrorStatus:mBaseObj.msg];
        }
        
    }];
    
}
- (void)initSecondSectionView:(NSArray *)mData{
    
//    NSMutableArray *mImgArr = [NSMutableArray new];
    NSMutableArray *mTTArr = [NSMutableArray new];

    for (ZLPPTClassObj *mClass in mData) {
//        [mImgArr addObject:mClass.cls_image];
        [mTTArr addObject:mClass.cls_name];

    }
    NSArray *mImgArr =@[IMG(@"ZLPPT_All"), IMG(@"ZLPPT_DFlower"), IMG(@"ZLPPT_DOut_Buy"), IMG(@"ZLPPT_DBuy"), IMG(@"ZLPPT_DShort"),IMG(@"ZLPPT_DBuy"), IMG(@"ZLPPT_DShort"),IMG(@"ZLPPT_DShort")];

    mSecondSectionView = [ZLRuuningManHomeHeaderSectionView initSecondView];
    mSecondSectionView.frame = CGRectMake(0, 0, DEVICE_Width, 130);
    
    HMSegmentedControl *seg = [[HMSegmentedControl alloc] initWithSectionImages:mImgArr
                                                          sectionSelectedImages:mImgArr
                                                              titlesForSections:mTTArr];
    seg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    seg.selectionIndicatorHeight = 2.0f;
    seg.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor]};
    seg.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_NavBar};
    seg.selectionIndicatorColor = COLOR_NavBar;
    [mSecondSectionView.mSectionView addSubview:seg];
    [seg addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [seg makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(mSecondSectionView.mSectionView);
        make.height.equalTo(60);
    }];

    [self initData];

}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    MLLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}
- (void)initData{
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
        return 2;
  
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }else{
        return 90;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        mFirstSectionView = [ZLRuuningManHomeHeaderSectionView initView];
        mFirstSectionView.delegate = self;
        
        return mFirstSectionView;
    }else{
        return mSecondSectionView;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
    
        return 1;
    }else{
        return 5;

    }
   
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        return 100;
    }else{
        return 160;
        
    }
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"cell";
        
        ZLRunningManHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegate = self;
        
        [cell setMDataSource:self.tableArr];
        return cell;
    }else{
        
        
        reuseCellId = @"cell2";
        
        ZLRunningManCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
#pragma mark----****----顶部按钮点击代理方法

/**
 按钮点击代理方法
 
 @param mIndex 索引
 */
- (void)ZLRunningManHomeCellBtnClickedWithIndex:(NSInteger)mIndex{

    MLLog(@"%ld",(long)mIndex);
    switch (mIndex) {
        case 0:
        {
            ZLPPTAnounceMentViewController *vc = [ZLPPTAnounceMentViewController new];
            [self pushViewController:vc];
        }
            break;
        case 1:
        {
            ZLPPTMyOrderViewController *vc = [ZLPPTMyOrderViewController new];
            [self pushViewController:vc];
        }
            break;
        case 2:
        {

            ZLPPTRewardViewController *vc = [ZLPPTRewardViewController new];
            vc.mTotleMoney = mClassObj.amount;
            [self pushViewController:vc];
        }
            break;
        case 3:
        {
            
            ZLPPTRateViewController *vc = [ZLPPTRateViewController new];
            [self pushViewController:vc];
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark----****----接单按钮的代理方法
/**
 接单按钮的代理方法
 
 @param mIndexPath 索引
 */
- (void)ZLRunningManCellDelegateWithBtnClick:(NSIndexPath *)mIndexPath{

}
#pragma mark----****----开通按钮的代理方法
- (void)ZLRuuningManHomeHeaderSectionViewBtnClicked{

    UserPaoPaoRegisterVC*vc = [[UserPaoPaoRegisterVC alloc] initWithNibName:@"UserPaoPaoRegisterVC" bundle:nil];
    [self pushViewController:vc];
    
}

@end
