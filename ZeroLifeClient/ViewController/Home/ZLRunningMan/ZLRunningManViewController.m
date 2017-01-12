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
#import "ZLRunningManTopView.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "CurentLocation.h"

static int const ZLRunningManVC_TopView_Height                  = 100;
static int const ZLRunningManVC_ClassView_Height                  = 80;

@interface ZLRunningManViewController ()<UITableViewDelegate,UITableViewDataSource,ZLRunningManHomeCellDelegate,ZLRunningManCellDelegate,ZLRuuningManHomeHeaderSectionViewDelegate,ZLCustomSegViewDelegate,ZLRunningManTopViewDelegate,AMapLocationManagerDelegate,MMApBlockCoordinate>

@property (assign,nonatomic)     NSInteger mIndex;


@end

@implementation ZLRunningManViewController
{

    ZLCustomSegView *mSecondSectionView;

    ZLRuuningManHomeHeaderSectionView *mFirstSectionView;
//    ZLRuuningManHomeHeaderSectionView *mSecondSectionView;

    ZLPPTHomeClassList *mClassObj;

    //NSMutableArray *mTempArr;
    
    
    int mType;
    
    
    ZLRunningManTopView *mTopView;
    ZLRunningManTopView *mClassView;
    
    AMapLocationManager *mLocation;

    BOOL mIsVerrify;
}



- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self updateUserInfo];
    [self beginHeaderRereshing];
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
#pragma mark----****----****加载跑腿者经纬度
- (void)initPPTLocation{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.openInfo) {
        if ([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"NOTOPEN"]) {
            
            MLLog(@"未开通");
            
        }else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"PAYMENTED"]){
            MLLog(@"未支付");
            
        }
        else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"UNCHECK"]){
            MLLog(@"待审核中...");
        } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"REFUSE"]){
            MLLog(@"审核失败！");
        } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOGOFF"]){
            MLLog(@"已注销！");
        } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOCKED"]){
            MLLog(@"已已禁用！");
            
        }else{
            
            
            if (user.user_id <= 0) {
                [APIObject infoWithReLoginErrorMessage:@"请登陆~~"];
            }else{
                if (_mAddress.cmut_lat > 0 || _mAddress.cmut_lng > 0) {
                    
                    [[APIClient sharedClient] ZLGetPPTLocation:_mAddress block:^(APIObject *mBaseObj) {
                        if (mBaseObj.code == RESP_STATUS_YES) {
                            mIsVerrify = YES;
                        }else{
                            mIsVerrify = NO;
                        }
                    }];
                }else{
                    [self loadLocation];
                    
                    
                }
            }

        }

    }
  
}
#pragma mark----****----****获取经纬度
- (void)loadLocation{
    
    [CurentLocation sharedManager].delegate = self;
    [[CurentLocation sharedManager] getUSerLocation];
    
    mLocation = [[AMapLocationManager alloc] init];
    mLocation.delegate = self;
    [mLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    mLocation.locationTimeout = 3;
    mLocation.reGeocodeTimeout = 3;
    [mLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSString *eee =@"定位失败！请检查网络和定位设置！";
            mIsVerrify = NO;
            [self showErrorStatus:eee];
            MLLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        
        
        if (regeocode)
        {
            
            MLLog(@"location:%f", location.coordinate.latitude);
            
            _mAddress.cmut_lat = location.coordinate.latitude;
            _mAddress.cmut_lng = location.coordinate.longitude;
            
            MLLog(@"reGeocode:%@", regeocode);
            mIsVerrify = YES;
            
            
        }
    }];

}
#pragma mark----maplitdelegate
- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate{
    
    MLLog(@"定位成功之后返回的东东：%@",mCoordinate);
    
    _mAddress.cmut_lat = [[mCoordinate objectForKey:@"wei"] doubleValue];
    _mAddress.cmut_lng = [[mCoordinate objectForKey:@"jing"] doubleValue];
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
    //mTempArr = [NSMutableArray new];
    [self initPPTLocation];
    [self addRightBtn:YES andTitel:@"发布跑单" andImage:nil];
    
    
    [self initStaticData];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = COLOR(247, 247, 247);
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NAVBAR_Height+ZLRunningManVC_TopView_Height+ZLRunningManVC_ClassView_Height+1);
        make.left.right.equalTo(self.view).offset(@0);
        make.bottom.equalTo(self.view);
    }];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLRunningManHomeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    nib = [UINib nibWithNibName:@"ZLRunningManCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    
    nib = [UINib nibWithNibName:@"ZLRunningManCellDo" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
    
    [self loadClassData];
    
    self.beginHeaderRereshingWhenViewWillAppear = NO;
}

- (void)initStaticData{

    NSArray *mTT = @[@"跑腿榜",@"我的跑单",@"酬金记录",@"我的评价"];
    NSArray *mII = @[@"ZLPPT_Anouncement",@"ZLPPT_My",@"ZLPPT_Reward",@"ZLPPT_Rate"];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<mTT.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        
        [dic setObject:mTT[i] forKey:@"title"];
        [dic setObject:mII[i] forKey:@"img"];
        
        [arr addObject:dic];
        //[self.tableArr addObject:dic];
        //[self.tableView reloadData];
    }
    
    mTopView = [ZLRunningManTopView initView:arr];
    mTopView.frame = CGRectMake(0, NAVBAR_Height, DEVICE_Width, ZLRunningManVC_TopView_Height);
    mTopView.delegate = self;

    [self.view addSubview:mTopView];
    
    
    
}

- (void)loadClassData{

    ZLUserInfo *mUser = [ZLUserInfo ZLCurrentUser];
    if (!mUser) {
        [APIObject infoWithReLoginErrorMessage:@"请登陆~~"];
        return;
    }
    [self showWithStatus:@"正在加载..."];
    
    [[APIClient sharedClient] ZLGetPPTHome:^(APIObject *mBaseObj, ZLPPTHomeClassList *mList) {
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            mClassObj = mList;
            
            [self dismiss];

            [self initSecondSectionView:mList.classifyList];
            
            if (mList.classifyList.count>0) {
                [self beginHeaderRereshing];
            }
            
            
        }else{
            [self showErrorStatus:mBaseObj.msg];
        }
        
    }];
    
}
- (void)reloadTableViewData{
    ZLUserInfo *mUser = [ZLUserInfo ZLCurrentUser];
    if (!mUser) {
        [APIObject infoWithReLoginErrorMessage:@"请登陆~~"];
        return;
    }else{
        if (mClassObj.classifyList.count<=0) {
            [self loadClassData];
        }else{
            [self beginHeaderRereshing];
        }
        
    }
    


}
- (void)initSecondSectionView:(NSArray *)mData{
    
    NSMutableArray *mTTArr = [NSMutableArray new];
    NSMutableArray *mImgArr = [NSMutableArray new];
    
    for (ZLPPTClassObj *mClass in mData) {
        [mTTArr addObject:mClass.cls_name];
        [mImgArr addObject:mClass.cls_image];
        
    }
    
    mClassView = [ZLRunningManTopView initclassViewText:mTTArr andImg:mImgArr];
    mClassView.delegate = self;
    mClassView.frame = CGRectMake(0, NAVBAR_Height+ZLRunningManVC_TopView_Height, DEVICE_Width, ZLRunningManVC_ClassView_Height);
    [self.view addSubview:mClassView];

    [self setTableViewHaveHeaderFooter];

}

- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];

  
    
    if (_mIndex <=0) {
        _mIndex = 0;
    }
    
    ZLPPTClassObj *mClass = mClassObj.classifyList[_mIndex];
    mType = [Util currentReleaseType:mClass.type_name];
    
    
    //[self showWithStatus:@"正在加载..."];
    [[APIClient sharedClient] ZLGetRunningmanHomeList:self.mAddress.cmut_lat andLng:self.mAddress.cmut_lng andPage:self.page andPageSize:20 andClsId:mClass.cls_id block:^(APIObject *mBaseObj, ZLRunningmanHomeList *mList) {
        [self reloadWithTableArr:mList.list info:mBaseObj];
//        [mTempArr removeAllObjects];
//        if (mBaseObj.code == RESP_STATUS_YES) {
//            [mTempArr addObjectsFromArray:mList.list];
//            if (mList.list.count<=0) {
//                [self addEmptyView:self.tableView andType:ZLEmptyViewTypeWithCommon];
//            }
//            [self showSuccessStatus:@"加载成功！"];
//        }else{
//            [self showErrorStatus:mBaseObj.msg];
//            [self addEmptyView:self.tableView andType:ZLEmptyViewTypeWithCommon];
//        }
//        [self doneLoadingTableViewData];
//        [self.tableView reloadData];

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        
//        if ([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"NOTOPEN"]) {
//            return 40;
//        }else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"PAYMENTED"]){
//            return 40;
//        }
//        else{
//            return 0;
//        }
//
//    }else{
//        return 80;
//    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        
//        mFirstSectionView = [ZLRuuningManHomeHeaderSectionView initView];
//        mFirstSectionView.delegate = self;
//        
//        if ([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"NOTOPEN"]) {
//            mFirstSectionView.mContent.text = @"申请开通跑跑腿才能接单赚取酬金";
//            mFirstSectionView.mDetail.text = @"去开通";
//            return mFirstSectionView;
//        }else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"PAYMENTED"]){
//            mFirstSectionView.mContent.text = @"您还未提交申请跑腿资料哦～";
//            mFirstSectionView.mDetail.text = @"去提交";
//            return mFirstSectionView;
//        }
//        else{
//            return nil;
//        }
//        
//
//    }else{
//        return mSecondSectionView;
//    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 127;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = nil;
    reuseCellId = @"cell3";
    
    
    ZLRunningManCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.delegate = self;
    cell.mType = mType;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setMOrder:self.tableArr[indexPath.row]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (mIsVerrify == NO) {
        [self showErrorStatus:@"您需要打开定位才能接单哦～～"];
        [self initPPTLocation];
        return;
    }
    ZLPPTOrderDetailViewController *vc = [ZLPPTOrderDetailViewController new];
    vc.mOrder = self.tableArr[indexPath.row];
    [self pushViewController:vc];
    
//    OrderObject *item = [self.tableArr objectAtIndex:indexPath.row];
//    
//    OrderDetailVC *vc = [[OrderDetailVC alloc] init];
//    vc.classType = kOrderClassType_paopao;
//    vc.item = item;
//    vc.isShopOrderBool = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark----****----去发布
- (void)mRightAction:(UIButton *)sender{
    
    ZLPPTRealeseOrderViewController *vc = [ZLPPTRealeseOrderViewController new];
    [self pushViewController:vc];
}
#pragma mark----****----接单按钮的代理方法
/**
 接单按钮的代理方法
 
 @param mIndexPath 索引
 */
- (void)ZLRunningManCellDelegateWithBtnClick:(NSIndexPath *)mIndexPath{
    
    ZLRunningmanHomeOrder *mOrder = self.tableArr[mIndexPath.row];
    if ([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:kOpenState_NOTOPEN]) {
        UserPaoPaoRegisterVC*vc = [[UserPaoPaoRegisterVC alloc] initWithNibName:@"UserPaoPaoRegisterVC" bundle:nil];
        [self pushViewController:vc];
    }else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:kOpenState_PAYMENTED]){
        UserPaoPaoApplyVC *vc = [UserPaoPaoApplyVC new];
        [self pushViewController:vc];
        
    }
    else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:kOpenState_UNCHECK]){
        [self showErrorStatus:@"待审核中..."];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:kOpenState_REFUSE]){
        [self showErrorStatus:@"审核失败！"];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:kOpenState_LOGOFF]){
        [self showErrorStatus:@"已注销！"];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:kOpenState_LOCKED]){
        [self showErrorStatus:@"已禁用！"];
    }
    else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"null"] || [ZLUserInfo ZLCurrentUser].openInfo.open_state == nil){
        UserPaoPaoRegisterVC*vc = [[UserPaoPaoRegisterVC alloc] initWithNibName:@"UserPaoPaoRegisterVC" bundle:nil];
        [self pushViewController:vc];
    }else{
        if (mIsVerrify == NO) {
            [self showErrorStatus:@"您需要打开定位才能接单哦～～"];
            [self initPPTLocation];
            return;
        }
        [self showWithStatus:@"正在操作中..."];

        ZLOperatorPPTOrderStatus mOrderStatus;;
        
        if (mOrder.user_id == [ZLUserInfo ZLCurrentUser].user_id) {
            mOrderStatus = ZLOperatorPPTOrderStatusWithCancel;
            [[APIClient sharedClient] ZLReleaseOperatorPPTOrder:mOrder.odr_id andOrderCode:mOrder.odr_code andOperatorStatus:mOrderStatus block:^(APIObject *resb) {
                if (resb.code == RESP_STATUS_YES) {
                    [self showSuccessStatus:resb.msg];
                    [self beginHeaderRereshing];
                }else{
                    
                    [self showErrorStatus:resb.msg];
                }
            }];

            

        }else{
            mOrderStatus = ZLOperatorPPTOrderStatusWithAccept;
            [[APIClient sharedClient] ZLOperatorPPTOrder:mOrder.odr_id andOrderCode:mOrder.odr_code andOperatorStatus:mOrderStatus block:^(APIObject *resb) {
                if (resb.code == RESP_STATUS_YES) {
                    [self showSuccessStatus:resb.msg];
                    [self beginHeaderRereshing];
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
#pragma mark----****----顶部按钮点击代理方法
/**
 按钮点击代理方法
 
 @param mIndex 索引
 */
- (void)ZLRunningManTopViewBtnClickedWithIndex:(NSInteger)mIndex{
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
                OrderTVC *vc = [[OrderTVC alloc] init];
                vc.classType = kOrderClassType_paopao;
                vc.isShopOrderBool = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
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
                vc.mId = [ZLUserInfo ZLCurrentUser].user_id;
                vc.mType = ZLRateVCTypeWithPPT;
                [self pushViewController:vc];
            }
            
            
        }
            break;
            
        default:
            break;
    }

}
#pragma mark----****----选择了哪一个代理方法
/**
 分类按钮点击代理方法
 
 @param mIndex 索引
 */
- (void)ZLRunningManClassViewBtnClickedWithIndex:(NSInteger)mIndex{
    _mIndex = mIndex;
    MLLog(@"%ld",(long)mIndex);
    [self beginHeaderRereshing];
}

@end
