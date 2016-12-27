//
//  ZLHydroelectricViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/12/27.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLHydroelectricViewController.h"
#import "utilityView.h"
#import "LTPickerView.h"
#import "ZLPayHydroelectricViewController.h"
@interface ZLHydroelectricViewController ()<utilityViewDelegate>

@end

@implementation ZLHydroelectricViewController
{
    UIScrollView *mScrollerView;
    
    utilityView *mView;

    ZLHydroelectricPreOrder *mPreOrder;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"水电煤";
    
    mPreOrder = [ZLHydroelectricPreOrder new];
    
    [self initView];
}
- (void)initView{
    
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.97 alpha:1.00];
    [self.view addSubview:mScrollerView];
    
    
    mView = [utilityView shareView];
    mView.delegate = self;
    mView.frame = CGRectMake(0, 0, mScrollerView.mwidth, DEVICE_Height);
    
    [mView.mProvinceBtn addTarget:self action:@selector(mProvinceAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mCityBtn addTarget:self action:@selector(mCityAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mPayType addTarget:self action:@selector(mPayTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mUnitBtn addTarget:self action:@selector(mUnitAction:) forControlEvents:UIControlEventTouchUpInside];

    [mView.mInquireBtn addTarget:self action:@selector(mPayFeeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mScrollerView addSubview:mView];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 618);
    
    
    
}
#pragma mark----****----省份
- (void)mProvinceAction:(UIButton *)sender{
    [self initData:ZLHydroelectricTypeWithProvince];
    
}
#pragma mark----****----城市
- (void)mCityAction:(UIButton *)sender{
    [self initData:ZLHydroelectricTypeWithCity];

    
}
#pragma mark----****----缴费类型
- (void)mPayTypeAction:(UIButton *)sender{
    [self initData:ZLHydroelectricTypeWithPayType];

    
}
#pragma mark----****----缴费单位
- (void)mUnitAction:(UIButton *)sender{
    
    [self initData:ZLHydroelectricTypeWithPayUnint];

}
#pragma mark----****----去支付／查询账单
- (void)mPayFeeAction:(UIButton *)sender{
    
    if (!mPreOrder.mProvince) {
        [self showErrorStatus:@"请选择省份!"];
        return;
    }
    if (!mPreOrder.mCity) {
        [self showErrorStatus:@"请选择城市!"];
        return;
    }
    if (!mPreOrder.mPaytype) {
        [self showErrorStatus:@"请选择缴费类型!"];
        return;
    }
    if (!mPreOrder.mPayUnint) {
        [self showErrorStatus:@"请选择缴费单位!"];
        return;
    }

    if (mPreOrder.mPayAmount.length <= 0) {
        [self showErrorStatus:@"请输入缴费户号!"];
        return;
    }
    
    ZLPayHydroelectricViewController *vc = [ZLPayHydroelectricViewController new];
    vc.title = @"账单查询";
    vc.mPara = mPreOrder;
    [self pushViewController:vc];
    
    
}
#pragma mark----****----加载数据
- (void)initData:(ZLHydroelectricType)mType{

    [self showWithStatus:@"正在查询..."];
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:JH_KEY forKey:@"key"];
    
    if (mType == ZLHydroelectricTypeWithProvince) {
 
    }else if (mType == ZLHydroelectricTypeWithCity){
    
        if (!mPreOrder.mProvince) {
            [self showErrorStatus:@"请选择省份!"];
            return;
        }
        [para setObject:mPreOrder.mProvince.provinceId forKey:@"provid"];

    }else if (mType == ZLHydroelectricTypeWithPayType){
        
        if (!mPreOrder.mProvince) {
            [self showErrorStatus:@"请选择省份!"];
            return;
        }
        if (!mPreOrder.mCity) {
            [self showErrorStatus:@"请选择城市!"];
            return;
        }
        [para setObject:mPreOrder.mProvince.provinceId forKey:@"provid"];
        [para setObject:mPreOrder.mCity.cityId forKey:@"cityid"];

        
    }else{
        if (!mPreOrder.mProvince) {
            [self showErrorStatus:@"请选择省份!"];
            return;
        }
        if (!mPreOrder.mCity) {
            [self showErrorStatus:@"请选择城市!"];
            return;
        }
        if (!mPreOrder.mPaytype) {
            [self showErrorStatus:@"请选择缴费类型!"];
            return;
        }
        [para setObject:mPreOrder.mProvince.provinceId forKey:@"provid"];
        [para setObject:mPreOrder.mCity.cityId forKey:@"cityid"];
        [para setObject:mPreOrder.mPaytype.payProjectId forKey:@"type"];

    }
    [[APIClient sharedClient] ZLFindPublic:mType andPara:para block:^(mJHBaseData *resb, NSArray *mArr) {
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            [self initLTPickerView:mType andDataSource:mArr];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
        
    }];
}
#pragma mark----****----显示弹出框
- (void)initLTPickerView:(ZLHydroelectricType)mType andDataSource:(NSArray *)mArr{
    
    NSMutableArray *mArrTemp = [NSMutableArray new];

    if (mType == ZLHydroelectricTypeWithProvince) {
 
        for (ZLJHProvince *mProvince in mArr) {
            [mArrTemp addObject:mProvince.provinceName];

        }
        
    }else if (mType == ZLHydroelectricTypeWithCity){
        
        for (ZLJHCity *mCity in mArr) {
            [mArrTemp addObject:mCity.cityName];
            
        }
    }else if (mType == ZLHydroelectricTypeWithPayType){
        for (ZLJHPayType *mPayType in mArr) {
            [mArrTemp addObject:mPayType.payProjectName];
            
        }
    }else{
        
        for (ZLJHPayUnint *mPayUnint in mArr) {
            [mArrTemp addObject:mPayUnint.payUnitName];
            
        }
    }

    LTPickerView *LtpickerView = [LTPickerView new];
    LtpickerView.dataSource = mArrTemp;//设置要显示的数据
    LtpickerView.defaultStr = mArrTemp[0];//默认选择的数据
    [LtpickerView show];//显示
    
    //回调block
    LtpickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        MLLog(@"选择了第%d行的%@",num,str);
        if (mType == ZLHydroelectricTypeWithProvince) {
            mPreOrder.mProvince = mArr[num];
        }else if (mType == ZLHydroelectricTypeWithCity){
            mPreOrder.mCity = mArr[num];
        }else if (mType == ZLHydroelectricTypeWithPayType){
            mPreOrder.mPaytype = mArr[num];
        }else{
            mPreOrder.mPayUnint = mArr[num];

        }
        
        [self upDatePage];
    };

}
#pragma mark----****----更新ui
- (void)upDatePage{
    if (mPreOrder.mProvince) {
        [mView.mProvinceBtn setTitle:mPreOrder.mProvince.provinceName forState:0];

    }
    if (mPreOrder.mCity) {
        [mView.mCityBtn setTitle:mPreOrder.mCity.cityName forState:0];

    }
    if (mPreOrder.mPaytype) {
        [mView.mPayType setTitle:mPreOrder.mPaytype.payProjectName forState:0];

    }
    if (mPreOrder.mPayUnint) {
        [mView.mUnitBtn setTitle:mPreOrder.mPayUnint.payUnitName forState:0];

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
#pragma mark----****----缴费账号代理方法
/**
 
 
 @param mText 返回文本内容
 */
- (void)utilityViewCurrentAmountText:(NSString *)mText{
    mPreOrder.mPayAmount = mText;
}

@end
