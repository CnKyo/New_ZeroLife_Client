//
//  ZLPPTRealeseOrderViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/16.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTRealeseOrderViewController.h"
#import "ZLRuuningManHomeHeaderSectionView.h"
#import "HMSegmentedControl.h"

#import "ZLPPTReleaseRewardCell.h"
#import "ZLPPTReleaseGeneryCell.h"
#import "ZLPPTReleaseBottomView.h"
#import "ZLPPTReleaseShorSendCell.h"
#import "ZLCustomSegView.h"
#import "UserAddressTVC.h"
#import "ZLGoPayViewController.h"

@interface ZLPPTRealeseOrderViewController ()<UITableViewDelegate,UITableViewDataSource,ZLPPTRewardCellDelegate,ZLPPTReleaseGeneryCellDelegate,ZLPPTReleaseBottomViewDelegate,ZLPPTReleaseShorSendCellDelegate,ZLCustomSegViewDelegate>

@property (strong,nonatomic) UITableView *mTableView;

@end

@implementation ZLPPTRealeseOrderViewController
{

//    ZLRuuningManHomeHeaderSectionView *mHeaderSectionView;
    
    ZLPPTReleaseBottomView *mBottomView;
    
    int mType;
    
    ZLPreOrderObj *mPPTPreOrder;

    ZLCustomSegView *mHeaderSectionView;
    
    
    ZLCommitPPTPreOrder *mCommitPreOrder;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     IQKeyboardManager为自定义收起键盘
     **/
    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
    [IQKeyboardManager sharedManager].shouldHidePreviousNext = YES;///隐藏上／下一步工具条
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].shouldHidePreviousNext = NO;///显示上／下一步工具条
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发布跑腿";

    mType = 0;
    
    mPPTPreOrder = [ZLPreOrderObj new];
    
    mCommitPreOrder = [ZLCommitPPTPreOrder new];
    
    [self initView];

    [self getPreOrder];
}
- (void)getPreOrder{

    [self  showWithStatus:@"正在验证..."];
    [[APIClient sharedClient] ZLGetRunningmanPreOrder:^(APIObject *mBaseObj, ZLPreOrderObj *mPreOrder) {
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            [self showSuccessStatus:@"验证成功!"];
            
            mPPTPreOrder = mPreOrder;
            [self initSecondSectionView];

        }else{
        
            [self showErrorStatus:mBaseObj.msg];
        }
        
    }];
}
- (void)initView{


    [self addTableView];

    UINib   *nib = [UINib nibWithNibName:@"ZLPPTReleaseRewardCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mRewardCell"];
    
    
    nib = [UINib nibWithNibName:@"ZLPPTReleaseGeneryCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mDemadCell"];
    
    
    nib = [UINib nibWithNibName:@"ZLPPTReleaseGeneryCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mDetailCell"];
    
    nib = [UINib nibWithNibName:@"ZLPPTReleaseShorSendCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mShorDetailCell"];
    
    nib = [UINib nibWithNibName:@"ZLPPTReleaseShorSendCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"mExplainCell"];
}
#pragma mark----****----加载sectionview
- (void)initSecondSectionView{
    
    NSMutableArray *mTTArr = [NSMutableArray new];
    NSMutableArray *mImgArr = [NSMutableArray new];

    for (ZLPPTClassObj *mClass in mPPTPreOrder.classify) {
        [mTTArr addObject:mClass.cls_name];
        [mImgArr addObject:mClass.cls_image];

    }
    
    mHeaderSectionView = [ZLCustomSegView initViewType:ZLCustomSegViewTypeTextAndImage andTextArr:mTTArr andImgArr:mImgArr];
    mHeaderSectionView.delegate = self;
    mHeaderSectionView.frame = CGRectMake(0, 0, DEVICE_Width, 80);
    
    ZLPPTClassObj *mClass = mPPTPreOrder.classify[0];
    mCommitPreOrder.mClassId = mClass.cls_id;
    mCommitPreOrder.mClassName = mClass.cls_name;
    mCommitPreOrder.mClassImg = mClass.cls_image;

    mType = [Util currentReleaseType:mClass.type_name];
    
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
 
    return 80;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

        
    return mHeaderSectionView;

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    mBottomView = [ZLPPTReleaseBottomView shareView];
    mBottomView.frame = CGRectMake(0, DEVICE_Height-100, DEVICE_Width, 50);
    mBottomView.delegate = self;
    return mBottomView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        if (mType==0) {
            return 200;
        }else{
            return 333;
        }
        
    }else if(indexPath.row == 1){
        return 130;
        
    }else{
        if (mType==0) {
            return 200;
        }else{
            return 97;
        }
    }
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.row == 0) {
        
        if (mType == 0) {
            reuseCellId = @"mDemadCell";
            
            ZLPPTReleaseGeneryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setMPreOrder:mCommitPreOrder];

            cell.delegate = self;
            
            return cell;

        }else{
            reuseCellId = @"mShorDetailCell";
            
            ZLPPTReleaseShorSendCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setMPreOrder:mCommitPreOrder];
            cell.delegate = self;
            
            return cell;
        }
        
          }else if(indexPath.row == 1){
        
        
        reuseCellId = @"mRewardCell";
        
        ZLPPTReleaseRewardCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        
        if (mType == 0) {
            reuseCellId = @"mDetailCell";
            
            ZLPPTReleaseGeneryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setMPreOrder:mCommitPreOrder];

            return cell;
        }else{
        
            reuseCellId = @"mExplainCell";
            
            ZLPPTReleaseShorSendCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setMPreOrder:mCommitPreOrder];

            return cell;
        }

    }
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark----****----cell的代理方法
#pragma mark----****----选择酬金代理方法
/**
 选择酬金

 @param mReward 返回string
 */
- (void)ZLPPTRewardCellWithRewardBtnDidClicked:(NSString *)mReward{
    mCommitPreOrder.mSendPrice = [Util ZLCharacterString:mReward];
    [self.tableView reloadData];
}
#pragma mark----****----自定义跑腿酬金
/**
 自定义跑腿酬金
 
 @param mCustomReward 返回string
 */
- (void)ZLPPTRewardCellWithRewardCustom:(NSString *)mCustomReward{
    
    mCommitPreOrder.mSendPrice = [Util ZLCharacterString:mCustomReward];
    [self.tableView reloadData];
}
#pragma mark----****----办理时间代理方法
///办理时间代理方法
- (void)ZLPPTReleaseGeneryCellWithWorkTimeBtnClicked:(NSString *)mTime{

    mCommitPreOrder.mServiceTime = mTime;
    [self.tableView reloadData];
}
#pragma mark----****----送达地址代理方法
///送达地址代理方法
- (void)ZLPPTReleaseGeneryCellWithArriveTimeBtnClicked{
    UserAddressTVC *vc = [UserAddressTVC new];
    vc.isChooseAddress = YES;
    vc.block = ^(AddressObject *mAddress){
        MLLog(@"%@",mAddress);
        mCommitPreOrder.mArriveAddress = mAddress;
        mCommitPreOrder.mPhone = mAddress.addr_phone;

        [self.tableView reloadData];
    };
    [self pushViewController:vc];
}
#pragma mark----****----需求代理方法
/**
 需求代理方法
 
 @param mDemand 返回string
 */
- (void)ZLPPTReleaseGeneryCellWithDemand:(NSString *)mDemand{
    mCommitPreOrder.mDemand = mDemand;
    [self.tableView reloadData];
}
#pragma mark----****----商品价格代理方法
/**
 商品价格代理方法
 
 @param mProductPrice 返回string
 */
- (void)ZLPPTReleaseGeneryCellWithProductPrice:(NSString *)mProductPrice{
    mCommitPreOrder.mGoodsPrice = mProductPrice;
    [self.tableView reloadData];
}
#pragma mark----****----联系方式和备注代理方法
/**
 联系方式和备注代理方法
 
 @param mConnect 联系方式
 */
- (void)ZLPPTReleaseGeneryCellWithConnect:(NSString *)mConnect{
    mCommitPreOrder.mPhone = mConnect;
    [self.tableView reloadData];
}
#pragma mark----****----联系方式和备注代理方法
/**
 联系方式和备注代理方法
 
 @param mNote 备注
 */
- (void)ZLPPTReleaseGeneryCellWithNote:(NSString *)mNote{
    mCommitPreOrder.mRemark = mNote;

    [self.tableView reloadData];
}
#pragma mark----****----去支付代理方法
/**
 去支付代理方法
 */
- (void)ZLPPTReleaseBottomViewWithGoPayBtnClicked{

    NSMutableArray *mPayArr = [NSMutableArray new];
    NSMutableDictionary *mPara = [NSMutableDictionary new];
    
    if (mType == ZLPPTReleaseTypeWithSendDo) {
        
        if (!mCommitPreOrder.mSendAddress) {
            [self showErrorStatus:@"您还没有选择送出地址呐～"];
            return;
        }
        if (!mCommitPreOrder.mArriveAddress) {
            [self showErrorStatus:@"您还没有选择送达地址呐～"];
            return;
        }
        if (mCommitPreOrder.mServiceTime.length<=0) {
            [self showErrorStatus:@"您还没有选择服务时间呐～"];
            return;
        }
        if (mCommitPreOrder.mGoodsName.length<=0) {
            [self showErrorStatus:@"您还没有选择物品名称呐～"];
            return;
        }
        if (mCommitPreOrder.mSendPrice.length<=0) {
            [self showErrorStatus:@"您还没有选择跑腿酬金呐～"];
            return;
        }
        
        [mPara setInt:mCommitPreOrder.mClassId forKey:@"cls_id"];
        [mPara setObject:mCommitPreOrder.mClassName forKey:@"odrg_pro_name"];
        [mPara setObject:mCommitPreOrder.mGoodsName forKey:@"odrg_spec"];
        
        [mPara setObject:@"0.0" forKey:@"odrg_price"];
        
        [mPara setObject:mCommitPreOrder.mClassImg forKey:@"odrg_img"];
        [mPara setObject:@"" forKey:@"odrg_img_repair"];
        [mPara setObject:@"" forKey:@"odrg_video_repair"];
        
        if (mCommitPreOrder.mIndex<=0) {
            mCommitPreOrder.mIndex = 0;
            ZLPPTClassObj *mClass = mPPTPreOrder.classify[mCommitPreOrder.mIndex];
            mCommitPreOrder.mTypeName = mClass.type_name;

        }
        
        [mPara setObject:mCommitPreOrder.mTypeName forKey:@"odrg_memo"];

   
        [mPayArr addObject:mPara];
        
        [self showWithStatus:@"正在提交..."];
        [[APIClient sharedClient] ZLCommitOrder:kOrderClassType_paopao andShopId:nil andGoods:[Util arrToJson:mPayArr] andSendAddress:[NSString stringWithFormat:@"%d",mCommitPreOrder.mSendAddress.addr_id] andArriveAddress:[NSString stringWithFormat:@"%d",mCommitPreOrder.mArriveAddress.addr_id] andServiceTime:mCommitPreOrder.mServiceTime andSendType:3 andSendPrice:mCommitPreOrder.mSendPrice andCoupId:nil andRemark:mCommitPreOrder.mRemark andSign:mPPTPreOrder.sign block:^(APIObject *mBaseObj,ZLCreateOrderObj *mOrder) {
            
            if (mBaseObj.code == RESP_STATUS_YES) {
                
                [self showSuccessStatus:mBaseObj.msg];
                ZLGoPayViewController *ZLGoPayVC = [ZLGoPayViewController new];
                ZLGoPayVC.mOrder = [ZLCreateOrderObj new];
                ZLGoPayVC.mOrder = mOrder;
                ZLGoPayVC.mOrder.sign = mPPTPreOrder.sign;

                [self pushViewController:ZLGoPayVC];
                
            }else{
                
                [self showErrorStatus:mBaseObj.msg];
            }
            
            
        }];
        
    }else{
    
      
        if (mCommitPreOrder.mDemand.length<=0) {
            [self showErrorStatus:@"您还没有输入您的需求呐～"];
            return;
        }
        if (mCommitPreOrder.mGoodsPrice.length<=0) {
            [self showErrorStatus:@"您还没有选择物品价格呐～"];
            return;
        }
        if (mCommitPreOrder.mSendPrice.length<=0) {
            [self showErrorStatus:@"您还没有选择跑腿酬金呐～"];
            return;
        }
        if (mCommitPreOrder.mServiceTime.length<=0) {
            [self showErrorStatus:@"您还没有选择服务时间呐～"];
            return;
        }
        if (!mCommitPreOrder.mArriveAddress) {
            [self showErrorStatus:@"您还没有选择送达地址呐～"];
            return;
        }
        if (mCommitPreOrder.mPhone.length<=0) {
            [self showErrorStatus:@"您还没有输入联系方式呐～"];
            return;
        }
        
        [mPara setInt:mCommitPreOrder.mClassId forKey:@"cls_id"];
        [mPara setObject:mCommitPreOrder.mClassName forKey:@"odrg_pro_name"];
        [mPara setObject:mCommitPreOrder.mDemand forKey:@"odrg_spec"];
        [mPara setObject:mCommitPreOrder.mGoodsPrice forKey:@"odrg_price"];
        
        [mPara setObject:mCommitPreOrder.mClassImg forKey:@"odrg_img"];
        [mPara setObject:@"" forKey:@"odrg_img_repair"];
        [mPara setObject:@"" forKey:@"odrg_video_repair"];

        if (mCommitPreOrder.mIndex<=0) {
            mCommitPreOrder.mIndex = 0;
            ZLPPTClassObj *mClass = mPPTPreOrder.classify[mCommitPreOrder.mIndex];
            mCommitPreOrder.mTypeName = mClass.type_name;
            
        }
        
        [mPara setObject:mCommitPreOrder.mTypeName forKey:@"odrg_memo"];

        [mPayArr addObject:mPara];
        
        [self showWithStatus:@"正在提交..."];
        [[APIClient sharedClient] ZLCommitOrder:kOrderClassType_paopao andShopId:nil andGoods:[Util arrToJson:mPayArr] andSendAddress:[NSString stringWithFormat:@"%d",mCommitPreOrder.mArriveAddress.addr_id] andArriveAddress:nil andServiceTime:mCommitPreOrder.mServiceTime andSendType:3 andSendPrice:mCommitPreOrder.mSendPrice andCoupId:nil andRemark:mCommitPreOrder.mRemark andSign:mPPTPreOrder.sign block:^(APIObject *mBaseObj,ZLCreateOrderObj *mOrder) {
            
            if (mBaseObj.code == RESP_STATUS_YES) {
                
                [self showSuccessStatus:mBaseObj.msg];
                ZLGoPayViewController *ZLGoPayVC = [ZLGoPayViewController new];
                ZLGoPayVC.mOrder = [ZLCreateOrderObj new];
                ZLGoPayVC.mOrder = mOrder;
                ZLGoPayVC.mOrder.sign = mPPTPreOrder.sign;

                [self pushViewController:ZLGoPayVC];
                
            }else{
                
                [self showErrorStatus:mBaseObj.msg];
            }
            
            
        }];

        
    }
    
}



#pragma mark----****----送出地址代理方法
/**
 送出地址代理方法
 */
- (void)ZLPPTReleaseShorSendCellWithSendAddressAction{
    UserAddressTVC *vc = [UserAddressTVC new];
    vc.isChooseAddress = YES;
    vc.block = ^(AddressObject *mAddress){
        MLLog(@"%@",mAddress);
        mCommitPreOrder.mSendAddress = mAddress;
        [self.tableView reloadData];
    };
    [self pushViewController:vc];
}
#pragma mark----****----送达地址代理方法
/**
 送达地址代理方法
 */
- (void)ZLPPTReleaseShorSendCellWithArriveAddressAction{
    UserAddressTVC *vc = [UserAddressTVC new];
    vc.isChooseAddress = YES;
    vc.block = ^(AddressObject *mAddress){
        MLLog(@"%@",mAddress);
        mCommitPreOrder.mArriveAddress = mAddress;
        [self.tableView reloadData];
    };
    [self pushViewController:vc];
}
#pragma mark----****----服务时间代理方法
/**
 服务时间代理方法
 */
- (void)ZLPPTReleaseShorSendCellWithWorkTimeBtnAction:(NSString *)mTime{
    mCommitPreOrder.mServiceTime = mTime;
    [self.tableView reloadData];
}
#pragma mark----****----物品名称代理方法
/**
 物品名称代理方法
 
 @param mProductName 返回string
 */
- (void)ZLPPTReleaseShorSendCellWithProductNameTx:(NSString *)mProductName{
    mCommitPreOrder.mGoodsName = mProductName;
    [self.tableView reloadData];

}
#pragma mark----****----备注代理方法
/**
 备注代理方法
 
 @param mNote 返回string
 */
- (void)ZLPPTReleaseShorSendCellWithNoteTx:(NSString *)mNote{
    mCommitPreOrder.mRemark = mNote;
    [self.tableView reloadData];

}
#pragma mark----****----选择了哪一个代理方法
/**
 选择了哪一个
 
 @param mIndex 返回索引
 */
- (void)ZLCustomSegViewDidBtnSelectedWithIndex:(NSInteger)mIndex{
    MLLog(@"%ld",(long)mIndex);
    ZLPPTClassObj *mClass = mPPTPreOrder.classify[mIndex];
    mCommitPreOrder.mIndex = mIndex;
    mCommitPreOrder.mClassId = mClass.cls_id;
    mCommitPreOrder.mClassName = mClass.cls_name;
    mCommitPreOrder.mClassImg = mClass.cls_image;
    mCommitPreOrder.mTypeName = mClass.type_name;
    mType = [Util currentReleaseType:mClass.type_name];
    [self.tableView reloadData];
}


@end
