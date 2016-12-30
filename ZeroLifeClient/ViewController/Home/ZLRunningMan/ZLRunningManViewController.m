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
#import "UserPaoPaoApplyVC.h"

#import "ZLCustomSegView.h"
#import "ZLPPTOrderDetailViewController.h"
#import "ZLPPTRealeseOrderViewController.h"

#import "OrderTVC.h"

@interface ZLRunningManViewController ()<UITableViewDelegate,UITableViewDataSource,ZLRunningManHomeCellDelegate,ZLRunningManCellDelegate,ZLRuuningManHomeHeaderSectionViewDelegate,ZLCustomSegViewDelegate>

@property (assign,nonatomic)     NSInteger mIndex;


@end

@implementation ZLRunningManViewController
{

    ZLCustomSegView *mSecondSectionView;

    ZLRuuningManHomeHeaderSectionView *mFirstSectionView;
//    ZLRuuningManHomeHeaderSectionView *mSecondSectionView;

    ZLPPTHomeClassList *mClassObj;

    NSMutableArray *mTempArr;
    
    
    int mType;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self updateUserInfo];
    [self loadTableData:_mIndex];

}
- (void)updateUserInfo{

//    [[APIClient sharedClient] ZLUpdateUserInfo:^(APIObject *info) {
//        if (info.code == RESP_STATUS_YES) {
//            [self dismiss];
//        }else{
//            [self showErrorStatus:info.msg];
//        }
//    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserInfoNeedChange:) name:MyUserNeedUpdateNotification object:nil];

    
}
#pragma mark----****----用户需要更新数据
-(void)handleUserInfoNeedChange:(NSNotification *)note
{
    [[APIClient sharedClient] userInfoWithTag:self call:^(ZLUserInfo *user, APIObject *info) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"跑跑腿";
    _mIndex = 0;
    mClassObj = [ZLPPTHomeClassList new];
    mTempArr = [NSMutableArray new];
    
    [self addRightBtn:YES andTitel:@"发布" andImage:nil];
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLRunningManHomeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    nib = [UINib nibWithNibName:@"ZLRunningManCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    
    nib = [UINib nibWithNibName:@"ZLRunningManCellDo" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
    
    [self loadClassData];
}

- (void)initStaticData{

    NSArray *mTT = @[@"跑腿榜",@"我的跑单",@"酬金记录",@"我的评价"];
    NSArray *mII = @[@"ZLPPT_Anouncement",@"ZLPPT_My",@"ZLPPT_Reward",@"ZLPPT_Rate"];
    
    for (int i = 0; i<mTT.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        
        [dic setObject:mTT[i] forKey:@"title"];
        [dic setObject:mII[i] forKey:@"img"];
        
        [self.tableArr addObject:dic];
        [self.tableView reloadData];
        
    }
    
}

- (void)loadClassData{

    [self showWithStatus:@"正在加载..."];
    
    [[APIClient sharedClient] ZLGetPPTHome:^(APIObject *mBaseObj, ZLPPTHomeClassList *mList) {
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            mClassObj = mList;
            
            [self showSuccessStatus:mBaseObj.msg];

            [self initSecondSectionView:mList.classifyList];
            
            if (mList.classifyList.count>0) {
                [self loadTableData:0];
            }
            
            
        }else{
            [self showErrorStatus:mBaseObj.msg];
        }
        
    }];
    
}
- (void)initSecondSectionView:(NSArray *)mData{
    
    NSMutableArray *mTTArr = [NSMutableArray new];
    NSMutableArray *mImgArr = [NSMutableArray new];
    
    for (ZLPPTClassObj *mClass in mData) {
        [mTTArr addObject:mClass.cls_name];
        [mImgArr addObject:mClass.cls_image];
        
    }
    
    mSecondSectionView = [ZLCustomSegView initViewType:ZLCustomSegViewTypeTextAndImage andTextArr:mTTArr andImgArr:mImgArr];
    mSecondSectionView.delegate = self;
    mSecondSectionView.frame = CGRectMake(0, 0, DEVICE_Width, 80);
    
//    NSArray *mImgArr =@[IMG(@"ZLPPT_All"), IMG(@"ZLPPT_DFlower"), IMG(@"ZLPPT_DOut_Buy"), IMG(@"ZLPPT_DBuy"), IMG(@"ZLPPT_DShort"),IMG(@"ZLPPT_DBuy"), IMG(@"ZLPPT_DShort"),IMG(@"ZLPPT_DShort")];

//    mSecondSectionView = [ZLRuuningManHomeHeaderSectionView initSecondView];
//    mSecondSectionView.frame = CGRectMake(0, 0, DEVICE_Width, 130);
//    
//    HMSegmentedControl *seg = [[HMSegmentedControl alloc] initWithSectionImages:mImgArr
//                                                          sectionSelectedImages:mImgArr
//                                                              titlesForSections:mTTArr];
//    seg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
//    seg.selectionIndicatorHeight = 2.0f;
//    seg.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor]};
//    seg.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_NavBar};
//    seg.selectionIndicatorColor = COLOR_NavBar;
//    [mSecondSectionView.mSectionView addSubview:seg];
//    [seg addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
//    [seg makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(mSecondSectionView.mSectionView);
//        make.height.equalTo(60);
//    }];

    [self initStaticData];

}
- (void)loadTableData:(NSInteger)mIndex{
    
    if (mIndex<=0) {
        mIndex = 0;
    }
    
   ZLPPTClassObj *mClass = mClassObj.classifyList[mIndex];
    mType = [Util currentReleaseType:mClass.type_name];
    
    [self showWithStatus:@"正在加载..."];
    [[APIClient sharedClient] ZLGetRunningmanHomeList:self.mAddress.cmut_lat andLng:self.mAddress.cmut_lng andPage:self.page andPageSize:20 andClsId:mClass.cls_id block:^(APIObject *mBaseObj, ZLRunningmanHomeList *mList) {
        [mTempArr removeAllObjects];
        if (mBaseObj.code == RESP_STATUS_YES) {
            [self showSuccessStatus:@"加载成功"];
            [mTempArr addObjectsFromArray:mList.list];
            [self.tableView reloadData];
        }else{
            [self showErrorStatus:mBaseObj.msg];
        }
        
    }];
    
    
}
//- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
//    
//    MLLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
//    
//    NSInteger mIndex = segmentedControl.selectedSegmentIndex;
//    
//    [self loadTableData:mIndex];
//    
//}

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
        
        if ([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"NOTOPEN"]) {
            return 40;
        }else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"PAYMENTED"]){
            return 40;
        }
        else{
            return 0;
        }

    }else{
        return 80;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        mFirstSectionView = [ZLRuuningManHomeHeaderSectionView initView];
        mFirstSectionView.delegate = self;
        
        if ([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"NOTOPEN"]) {
            mFirstSectionView.mContent.text = @"申请开通跑跑腿才能接单赚取酬金";
            mFirstSectionView.mDetail.text = @"去开通";
            return mFirstSectionView;
        }else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"PAYMENTED"]){
            mFirstSectionView.mContent.text = @"您还未提交申请跑腿资料哦～";
            mFirstSectionView.mDetail.text = @"去提交";
            return mFirstSectionView;
        }
        else{
            return nil;
        }
        

    }else{
        return mSecondSectionView;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
    
        return 1;
    }else{
        return mTempArr.count;

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
        
//        if (mType == ZLPPTReleaseTypeWithBuyStaff) {
//            reuseCellId = @"cell2";
//
//        }else{
            reuseCellId = @"cell3";

//        }
        
        ZLRunningManCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setMOrder:mTempArr[indexPath.row]];
        return cell;
    }
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        ZLPPTOrderDetailViewController *vc = [ZLPPTOrderDetailViewController new];
        vc.mOrder = mTempArr[indexPath.row];
        [self pushViewController:vc];
    }
    
}

#pragma mark----****----去发布
- (void)mRightAction:(UIButton *)sender{
    
    ZLPPTRealeseOrderViewController *vc = [ZLPPTRealeseOrderViewController new];
    [self pushViewController:vc];
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
            OrderTVC *vc = [[OrderTVC alloc] init];
            vc.classType = kOrderClassType_paopao;
            vc.isShopOrderBool = YES;
            [self.navigationController pushViewController:vc animated:YES];
//            ZLPPTMyOrderViewController *vc = [ZLPPTMyOrderViewController new];
//            [self pushViewController:vc];
        }
            break;
        case 2:
        {
            
            if ([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"NOTOPEN"]) {
                
                [self showErrorStatus:@"您还未成为跑腿者，赶紧去申请吧～"];
                [self performSelector:@selector(ZLRuuningManHomeHeaderSectionViewBtnClicked) withObject:nil afterDelay:0.25];
                return;
                
            }else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"PAYMENTED"]){
                UserPaoPaoApplyVC *vc = [UserPaoPaoApplyVC new];
                [self pushViewController:vc];
                
            }
            else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"UNCHECK"]){
                [self showErrorStatus:@"待审核中..."];
            } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"REFUSE"]){
                [self showErrorStatus:@"审核失败！"];
            } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOGOFF"]){
                [self showErrorStatus:@"已注销！"];
            } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOCKED"]){
                [self showErrorStatus:@"已禁用！"];
            }else{
                ZLPPTRewardViewController *vc = [ZLPPTRewardViewController new];
                vc.mTotleMoney = mClassObj.amount;
                [self pushViewController:vc];
            }

            
        }
            break;
        case 3:
        {
            
            
            if ([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"NOTOPEN"]) {
               
                [self showErrorStatus:@"您还未成为跑腿者，赶紧去申请吧～"];
                [self performSelector:@selector(ZLRuuningManHomeHeaderSectionViewBtnClicked) withObject:nil afterDelay:0.25];
                return;

            }else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"PAYMENTED"]){
                UserPaoPaoApplyVC *vc = [UserPaoPaoApplyVC new];
                [self pushViewController:vc];
                
            }
            else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"UNCHECK"]){
                [self showErrorStatus:@"待审核中..."];
            } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"REFUSE"]){
                [self showErrorStatus:@"审核失败！"];
            } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOGOFF"]){
                [self showErrorStatus:@"已注销！"];
            } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOCKED"]){
                [self showErrorStatus:@"已禁用！"];
            }else{
                ZLPPTRateViewController *vc = [ZLPPTRateViewController new];
                [self pushViewController:vc];
            }


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
    
    ZLRunningmanHomeOrder *mOrder = mTempArr[mIndexPath.row];
    if ([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"NOTOPEN"]) {
        UserPaoPaoRegisterVC*vc = [[UserPaoPaoRegisterVC alloc] initWithNibName:@"UserPaoPaoRegisterVC" bundle:nil];
        [self pushViewController:vc];
    }else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"PAYMENTED"]){
        UserPaoPaoApplyVC *vc = [UserPaoPaoApplyVC new];
        [self pushViewController:vc];
        
    }
    else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"UNCHECK"]){
        [self showErrorStatus:@"待审核中..."];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"REFUSE"]){
        [self showErrorStatus:@"审核失败！"];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOGOFF"]){
        [self showErrorStatus:@"已注销！"];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOCKED"]){
        [self showErrorStatus:@"已禁用！"];
    }else{

        [self showWithStatus:@"正在操作中..."];

        ZLOperatorPPTOrderStatus mOrderStatus;;
        
        if (mOrder.user_id == [ZLUserInfo ZLCurrentUser].user_id) {
            mOrderStatus = ZLOperatorPPTOrderStatusWithCancel;
            [[APIClient sharedClient] ZLReleaseOperatorPPTOrder:mOrder.odr_id andOrderCode:mOrder.odr_code andOperatorStatus:mOrderStatus block:^(APIObject *resb) {
                if (resb.code == RESP_STATUS_YES) {
                    [self showSuccessStatus:resb.msg];
                    [self loadTableData:_mIndex];
                    
                }else{
                    
                    [self showErrorStatus:resb.msg];
                }
            }];

            

        }else{
            mOrderStatus = ZLOperatorPPTOrderStatusWithAccept;
            [[APIClient sharedClient] ZLOperatorPPTOrder:mOrder.odr_id andOrderCode:mOrder.odr_code andOperatorStatus:mOrderStatus block:^(APIObject *resb) {
                if (resb.code == RESP_STATUS_YES) {
                    [self showSuccessStatus:resb.msg];
                    [self loadTableData:_mIndex];
                    
                }else{
                    
                    [self showErrorStatus:resb.msg];
                }
            }];

        }
        
 
    }

    
    

}
#pragma mark----****----开通按钮的代理方法
- (void)ZLRuuningManHomeHeaderSectionViewBtnClicked{

    
    if ([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"NOTOPEN"]) {
        UserPaoPaoRegisterVC*vc = [[UserPaoPaoRegisterVC alloc] initWithNibName:@"UserPaoPaoRegisterVC" bundle:nil];
        [self pushViewController:vc];
    }else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"PAYMENTED"]){
        UserPaoPaoApplyVC *vc = [UserPaoPaoApplyVC new];
        [self pushViewController:vc];

    }
    else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"UNCHECK"]){
        [self showErrorStatus:@"待审核中..."];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"REFUSE"]){
        [self showErrorStatus:@"审核失败！"];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOGOFF"]){
        [self showErrorStatus:@"已注销！"];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOCKED"]){
        [self showErrorStatus:@"已禁用！"];
    }else{
        [self showErrorStatus:@"已成为跑腿者！"];
    }

    

    
}

#pragma mark----****----选择了哪一个代理方法
/**
 选择了哪一个
 
 @param mIndex 返回索引
 */
- (void)ZLCustomSegViewDidBtnSelectedWithIndex:(NSInteger)mIndex{
    _mIndex = mIndex;
    MLLog(@"%ld",(long)mIndex);
    [self loadTableData:mIndex];

}
@end
