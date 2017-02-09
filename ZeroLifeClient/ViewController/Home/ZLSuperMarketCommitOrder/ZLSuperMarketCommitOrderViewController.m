//
//  ZLSuperMarketCommitOrderViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketCommitOrderViewController.h"
#import "ZLCommitOrderCell.h"
#import "ZLCommitOrderHeaderView.h"
#import "ZLGoPayViewController.h"
#import "UserAddressTVC.h"
#import "mSelectSenTypeViewController.h"
#import "UserCouponVC.h"
@interface ZLSuperMarketCommitOrderViewController ()<UITableViewDelegate,UITableViewDataSource,ZLCommitOrderDelegate,ZLCommitDelegate>

@property (strong,nonatomic)UITableView *mTableView;

@end

@implementation ZLSuperMarketCommitOrderViewController
{

    ZLCommitOrderHeaderView *mHeaderView;
    
    ZLCommitOrderHeaderView *mBottomView;
    
    ZLCommitOrderHeaderView *mHeaderSectionView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"确认订单";

    [self initView];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    /**
//     IQKeyboardManager为自定义收起键盘
//     **/
//    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
//    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
//    
//}

- (void)initView{

    
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.mTableView];
    self.mTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.mTableView.tableFooterView = [[UIView alloc] init];
    self.mTableView.backgroundColor = COLOR(247, 247, 247);
    
    UINib   *nib = [UINib nibWithNibName:@"ZLCommitOrderCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"detailCell"];
    
    nib = [UINib nibWithNibName:@"ZLCommitGoodsCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"goodsCell"];
    
    mBottomView = [ZLCommitOrderHeaderView initWithBottom];
    mBottomView.delegate = self;
    [self.view addSubview:mBottomView];
    
    [self.mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(mBottomView.top).offset(0);

    }];
 

    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mTableView.bottom).offset(0);
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.height.offset(@60);
    }];
    self.mPreOrder.mSendType = ZLShopSendTypeWithSelf;
    [self UpdataBottomView:self.mPreOrder];
    
}
#pragma mark ----****----更新bottomView
- (void)UpdataBottomView:(ZLPreOrderObj *)mObj{
    
    NSDictionary *mAttStyle = @{@"color": [UIColor redColor],@"font":[UIFont systemFontOfSize:12]};

    mBottomView.mTotelPrice.attributedText = [[NSString stringWithFormat:@"订单金额：<color><font>¥</font></color><color>%.2f</color>元 <font><color>已优惠：%.2f元</font></color>",mObj.payMoney,mObj.campaignMoney] attributedStringWithStyleBook:mAttStyle];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 3;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 120;
    }else if (section == 1){
        return 60;
    }
    else{
        return 0.5;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {

        mHeaderView = [ZLCommitOrderHeaderView initWithHeder];
        mHeaderView.delegate = self;
        
        AddressObject *mLocalAddress = [Util ZLGetLocalDataWithKey:kDeliveryAddress];
        if (self.mPreOrder.mAddress == nil) {
            self.mPreOrder.mAddress = mLocalAddress;
        }
        
        NSString *mConnectP = [NSString stringWithFormat:@"%@-%@",self.mPreOrder.mAddress.addr_name,self.mPreOrder.mAddress.addr_phone];
        NSString *mAddress = [NSString stringWithFormat:@"%@",self.mPreOrder.mAddress.addr_address];
        
        if (mConnectP.length <= 1 || [mConnectP isEqualToString:@"(null)-(null)"]) {
            
            mConnectP = @"点击选择收货地址";
            mHeaderView.mDisplayAddress.text = mConnectP;
        }else{
            mHeaderView.mName.text = mConnectP;
            mHeaderView.mDisplayAddress.text = nil;

        }
        if (mAddress.length <= 0 || [mAddress isEqualToString:@"(null)"]) {
            mAddress = @"点击选择收货地址";
            mHeaderView.mDisplayAddress.text = mAddress;

        }else{
            mHeaderView.mContent.text = mAddress;
            mHeaderView.mDisplayAddress.text = nil;

        }
        
        
        
        return mHeaderView;
    }else if (section == 1){
        mHeaderSectionView = [ZLCommitOrderHeaderView initWithShopSection];
        mHeaderSectionView.mShopName.text = self.mPreOrder.shop_name;
        [mHeaderSectionView.mShopLogo sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:self.mPreOrder.shop_logo]] placeholderImage:ZLDefaultShopImg];
        return mHeaderSectionView;
    }
    else{
        return nil;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return self.mPreOrder.goods.count;
    }
    else{
        return 1;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        
        return 0;
        
        
        
    }else if (indexPath.section == 1){
        return 80;
    }
    else{
        return 375;
    }
    
    
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        
        return nil;
    }else if (indexPath.section == 1) {
        reuseCellId = @"goodsCell";
        
        ZLCommitOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setMGoodsObj:self.mPreOrder.goods[indexPath.row]];
        cell.delegate = self;
        
        return cell;
    }
    else{
        reuseCellId = @"detailCell";
        
        ZLCommitOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setMPreOrderObj:self.mPreOrder];
        cell.delegate = self;
        return cell;
        
    }
    

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark----****----选择收获地址
/**
 选择收获地址
 */
- (void)ZLCommitSelectAddress{
    
    
    UserAddressTVC *vc = [UserAddressTVC new];
    vc.isChooseAddress = YES;
    vc.oldAdrItem = self.mPreOrder.mAddress;
    vc.block = ^(AddressObject *mAddress){
        MLLog(@"%@",mAddress);
        self.mPreOrder.mAddress = mAddress;
        [self.mTableView reloadData];
    };
    [self pushViewController:vc];
    
}
#pragma mark----****----去支付
/**
 去支付
 */
- (void)ZLCommitGopay{
    
    if (!self.mPreOrder.mAddress) {
        [self showErrorStatus:@"您还没有收货地址呐～"];
        return;
    }
    
    NSMutableArray *mPayArr = [NSMutableArray new];
    
    for (OrderGoodsObject *mGoods in self.mPreOrder.goods) {
        NSMutableDictionary *mPara = [NSMutableDictionary new];

        [mPara setInt:mGoods.pro_id forKey:@"pro_id"];
        [mPara setInt:mGoods.odrg_number forKey:@"odrg_number"];
        [mPara setInt:mGoods.cam_gid forKey:@"cam_gid"];
        [mPara setInt:mGoods.sku_id forKey:@"sku_id"];
        [mPara setObject:mGoods.odrg_spec forKey:@"odrg_spec"];

        [mPayArr addObject:mPara];
    }

    [self showWithStatus:@"正在提交..."];
    [[APIClient sharedClient] ZLCommitOrder:_mOrderType andShopId:[NSString stringWithFormat:@"%d",self.mPreOrder.shop_id] andGoods:[Util arrToJson:mPayArr] andSendAddress:[NSString stringWithFormat:@"%d",self.mPreOrder.mAddress.addr_id] andArriveAddress:nil andServiceTime:nil andSendType:self.mPreOrder.mSendType andSendPrice:nil andCoupId:[NSString stringWithFormat:@"%d",self.mPreOrder.mCoupon.cuc_id] andRemark:self.mPreOrder.mNote andSign:self.mPreOrder.sign block:^(APIObject *mBaseObj,ZLCreateOrderObj *mOrder) {
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            
            [self showSuccessStatus:mBaseObj.msg];
            ZLGoPayViewController *ZLGoPayVC = [ZLGoPayViewController new];
            ZLGoPayVC.mOrderType = kOrderClassType_product;
            ZLGoPayVC.mOrder = [ZLCreateOrderObj new];
            ZLGoPayVC.mOrder = mOrder;
            ZLGoPayVC.mOrderType = _mOrderType;

            ZLGoPayVC.mOrder.sign = self.mPreOrder.sign;
            ZLGoPayVC.mShopId = self.mShopId;
            ZLGoPayVC.paySuccessCallBack = ^(ZLGoPayViewController *payVC){
                [payVC performSelector:@selector(popViewController_3) withObject:nil afterDelay:0.2];
            };
            [self pushViewController:ZLGoPayVC];
            
        }else{
        
            [self showErrorStatus:mBaseObj.msg];
        }
        
        
    }];
    
    


}
#pragma mark----****----选择配送方式
///选择配送方式
- (void)ZLCommitWithSendTypeBtnSelected{
    
    mSelectSenTypeViewController *vc = [[mSelectSenTypeViewController alloc] initWithNibName:@"mSelectSenTypeViewController" bundle:nil];
    vc.block = ^(ZLShopSendType mSendType){
    
        self.mPreOrder.mSendType = mSendType;
        
        float mTT = self.mPreOrder.payMoney;

        if (mSendType == ZLShopSendTypeWithSelf) {
            mTT-=self.mPreOrder.deliver_price_free;
            if (mTT<=self.mPreOrder.totalMoney) {
                mTT = self.mPreOrder.totalMoney;
            }
        }else{
            mTT+=self.mPreOrder.deliver_price_free;
            if (mTT>=self.mPreOrder.totalMoney+self.mPreOrder.deliver_price_free) {
                mTT = self.mPreOrder.totalMoney+self.mPreOrder.deliver_price_free;
            }
        }
        self.mPreOrder.payMoney = mTT;
        [self UpdataBottomView:self.mPreOrder];
        [self.mTableView reloadData];

    };
    [self pushViewController:vc];

}
#pragma mark----****----选择优惠券
///选择优惠券
- (void)ZLCommitWithCoupBtnSelected{
    
    UserCouponVC *vc = [[UserCouponVC alloc] init];
    [vc.tableArr setArray: self.mPreOrder.coupons];
    vc.block = ^(CouponObject *mCoupon) {
        ///这里每次block回来就把之前减去的加回来，不然会引起循环调用
        self.mPreOrder.payMoney+=self.mPreOrder.mCoupon.cup_price;
        self.mPreOrder.campaignMoney-=self.mPreOrder.mCoupon.cup_price;
        
        self.mPreOrder.payMoney-=mCoupon.cup_price;
        self.mPreOrder.campaignMoney+=mCoupon.cup_price;
        
        self.mPreOrder.mCoupon = mCoupon;
        
        [self.mTableView reloadData];
        [self UpdataBottomView:self.mPreOrder];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark----****----备注代理方法
///备注代理方法
- (void)ZLCommitWithNote:(NSString *)mNote{

    self.mPreOrder.mNote = mNote;
}

@end
