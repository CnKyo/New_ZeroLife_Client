//
//  ZLGoPayViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLGoPayViewController.h"
#import "ZLPayTypeTableViewCell.h"
#import "ZLPayTypeHeaderView.h"
#import "ZLGoPayPopRedBagView.h"
#import "ZLGoPaySucsessCell.h"
#import "CustomDefine.h"
#import "SecurityPasswordVC.h"
@interface ZLGoPayViewController ()<UITableViewDelegate,UITableViewDataSource,ZLGoPayCellDelegate,ZLGoPayShareDelegate>
@property (strong,nonatomic)ZLGoPayPopRedBagView *mPopView;
@property (nonatomic,strong) ZLGoPayObject *selectModel;

@end

@implementation ZLGoPayViewController
{
    ZLPayTypeHeaderView *mHeadaerView;
    
    UIButton *mComformBtn;
    
    UIButton *mSendRedBagBtn;
    
    UIView *mRedBgkView;
    
    NSMutableArray *mPayTypeArr;
}
@synthesize mPopView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"收银台";

  
    
    mPayTypeArr = [NSMutableArray new];
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLPayTypeTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"ZLGoPaySucsessCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    nib = [UINib nibWithNibName:@"ZLGoPaySucsessViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
    
    mComformBtn = [UIButton new];
    
    [mComformBtn setTitle:@"确认支付" forState:0];
    mComformBtn.backgroundColor = M_CO;
    mComformBtn.layer.masksToBounds = YES;
    mComformBtn.layer.cornerRadius = 4;
    [mComformBtn addTarget:self action:@selector(mOKBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mComformBtn];
    

    mSendRedBagBtn = [UIButton new];
    mSendRedBagBtn.hidden = YES;
    [mSendRedBagBtn setTitle:@"红包" forState:0];
    mSendRedBagBtn.backgroundColor = M_CO;
    mSendRedBagBtn.layer.masksToBounds = YES;
    mSendRedBagBtn.layer.cornerRadius = 4;
    [mSendRedBagBtn addTarget:self action:@selector(mRedBag:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mSendRedBagBtn];
    
    
    [mComformBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(@10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-10);
        make.height.offset(@45);
        make.width.offset(DEVICE_Width-20);
    }];
    
    [mSendRedBagBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-150);
        make.height.width.offset(@80);
    }];
    
    [self initShareView];
    [self initData];
}
- (void)initData{
    NSArray *mTT = @[@"支付宝支付",@"微信支付",@"余额支付"];
    NSArray *mPP = @[@"ZLPayType_Alipay",@"ZLPayType_Wechat",@"ZLPayType_Balance"];
    
    NSInteger j = mTT.count;
    if (_mOrderType == kOrderClassType_balance_recharge) {
        j -= 1;
    }
    
    for (int i = 0; i<j; i++) {
        
        ZLGoPayObject *mObj = [ZLGoPayObject new];
        mObj.mPayName = mTT[i];
        mObj.mPayType = i+1;
        mObj.mImgName = mPP[i];
        [self.tableArr addObject:mObj];
    }
    
    [self.tableView reloadData];

}
#pragma mark----****----确认支付
- (void)mOKBtn:(UIButton *)sender{

    if (mPayTypeArr.count <= 0) {
        [self showErrorStatus:@"请选择支付方式！"];
        return;
    }
    
    ZLGoPayObject *mObj = mPayTypeArr[0];
    
    [self createOrder:mObj];
    
    
}
- (void)createOrder:(ZLGoPayObject *)mOrder{
    [self showWithStatus:@"正在支付..."];
    [[APIClient sharedClient] ZLSendToPayOrderObjGoPay:ZLPayTypeWithCreatePay andPayObj:self.mOrder andPayType:mOrder.mPayType block:^(APIObject *mBaseObj,ZLCreateOrderObj* mPayOrderObj) {
        
        if (mBaseObj.code == RESP_STATUS_YES) {

            [self showSuccessStatus:mBaseObj.msg];
            
            if (mOrder.mPayType == ZLPayTypeWithBalance) {
            
                //
                
                if ([[mBaseObj.data objectForKey:@"result_code"] isEqualToString:@"SUCCESS"]) {
                    self.mOrder.sign = [mBaseObj.data objectForKey:@"sign"];

                    SecurityPasswordAlertView *alertView = [[SecurityPasswordAlertView alloc] init];
                    __strong __typeof(SecurityPasswordAlertView *)strongSelf = alertView;
                    alertView.inputPwdCallBack = ^(NSString* pwd) {
                        [strongSelf close];
                        self.mOrder.pass = pwd;
                      
                        [self commitOrder:mOrder];
                        
                    };
                    [alertView showAlert];
                } else{
                    [SVProgressHUD showErrorWithStatus:[mBaseObj.data objectForKey:@"result_msg"]];
                    
                    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
                    if ([user.wallet.pass isEqualToString:kWalletPayment_NoPass]) {
                        [self performSelector:@selector(pushSecurityPasswordVC) withObject:nil afterDelay:0.25];
                    }
                    
                    return;
                }
                
            }else{
                [self commitOrder:mOrder];
            }

        }else{
            
            [self showErrorStatus:mBaseObj.msg];
        }
    }];

}
- (void)commitOrder:(ZLGoPayObject *)mOrder{

    MLLog(@"%@",mPayTypeArr);
    [self showWithStatus:@"正在支付..."];
    [[APIClient sharedClient] ZLSendToPayOrderObjGoPay:ZLGoPayTypeWithConfirmPay andPayObj:self.mOrder andPayType:mOrder.mPayType block:^(APIObject *mBaseObj,ZLCreateOrderObj* mPayOrderObj) {
        
        if (mBaseObj.code == RESP_STATUS_YES) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil];
            
            [self showSuccessStatus:mBaseObj.msg];
            
            if (_mShopId > 0) {
                [LKDBHelperGoodsObj deleteWithWhere:[NSString stringWithFormat:@"mShopId=%d",self.mShopId]];
            }
            
            if (self.paySuccessCallBack) {
                self.paySuccessCallBack(self);
            } else {
                [self performSelector:@selector(mPopAction) withObject:nil afterDelay:0.25];
            }
            
        }else{
            
            [self showErrorStatus:mBaseObj.msg];
        }
    }];

}
- (void)mPopAction{
    
    switch (_mOrderType) {
        case kOrderClassType_fix:
            [self popViewController_3];
            break;
        case kOrderClassType_product:
            [self popViewController_3];
            break;
        case kOrderClassType_dryclean:
            [self popViewController_3];

            break;
        case kOrderClassType_paopao:
            [self popViewController_2];
            break;
        case kOrderClassType_paopao_apply:
            [self popViewController_2];
            break;
        case kOrderClassType_fee_mobile:
            [self popViewController];
            break;
        case kOrderClassType_fee_peroperty:
            [self popViewController];
            break;
        case kOrderClassType_balance_present:
            [self popViewController];
            break;
        case kOrderClassType_balance_recharge:
            [self popViewController_2];
            break;
        case kOrderClassType_balance_transfer:
            [self popViewController];
            break;
        case kOrderClassType_balance_collection:

            break;
        case kOrderClassType_fee_sdq:

            break;
        case kOrderClassType_fee_parking:

            break;
        default:
            [self popViewController];
            break;
    }

}


- (void)pushSecurityPasswordVC{
    SecurityPasswordVC *vc = [SecurityPasswordVC new];
    [self pushViewController:vc];
}
#pragma mark----****----发红包
- (void)mRedBag:(UIButton *)sender{
    [self showRedBagView];
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
    
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    mHeadaerView = [ZLPayTypeHeaderView shareView];
    mHeadaerView.mName.text = self.mOrder.odr_shop_name;
    mHeadaerView.mPricce.text = [NSString stringWithFormat:@"¥%.1f元",self.mOrder.odr_pay_price];
    mHeadaerView.mLogo.image = [UIImage imageNamed:@"ZLPayType_Head"];
    return mHeadaerView;
 
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tableArr.count;

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    ZLPayTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.delegate = self;
    [cell cellWithData:self.tableArr[indexPath.row]];
    cell.mIndexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//}

#pragma mark----****----状态按钮点击事件
///状态按钮点击事件
- (void)ZLGoPayStatusBtnClicked{

}

- (void)showRedBagView{

    [UIView animateWithDuration:0.25 animations:^{
        mRedBgkView.alpha = 1;
        CGRect mRRR = mPopView.frame;
        mRRR.origin.y = DEVICE_Height-160;
        mPopView.frame = mRRR;
    }];
}
- (void)dissmissRedBagView{
    [UIView animateWithDuration:0.25 animations:^{
        mRedBgkView.alpha = 0;
        CGRect mRRR = mPopView.frame;
        mRRR.origin.y = DEVICE_Height;
        mPopView.frame = mRRR;
    }];
}
- (void)initShareView{
    
    
    
    mRedBgkView  = [UIView new];
    mRedBgkView.frame = self.view.bounds;
    mRedBgkView.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.5];
    mRedBgkView.alpha = 0;
    [self.view addSubview:mRedBgkView];
    
    mPopView = [ZLGoPayPopRedBagView initShareViewWithFrame:CGRectMake(0, DEVICE_Height, DEVICE_Width, 160) andDataSource:@[@"a",@"s",@"d",@"w"]];
    mPopView.delegate = self;
    
    [mRedBgkView addSubview:mPopView];
    
    UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapA)];
    [self.view addGestureRecognizer:mTap];
    
    
}
- (void)tapA{
    [self dissmissRedBagView];
}
- (void)ZLGoPayShareWithBtnClickIndex:(NSInteger)mIndex{

    MLLog(@"点击了%ld",(long)mIndex);
    
    
}
- (void)ZLSelectedBtnClicked:(NSIndexPath *)mIndexPath{
    [mPayTypeArr removeAllObjects];
    
    MLLog(@"你选了第%ld行",(long)mIndexPath.row);

    if (self.selectModel) {
        self.selectModel.isSelected = !self.selectModel.isSelected;
    }
    ZLGoPayObject *model = self.tableArr[mIndexPath.row];
    if (!model.isSelected) {
        model.isSelected = !model.isSelected;
        self.selectModel = model;
        self.selectModel.mPayType = [[NSString stringWithFormat:@"%ld",mIndexPath.row+1] intValue];
    }
    

    [mPayTypeArr addObject:model];
    
    [self.tableView reloadData];

}

@end
