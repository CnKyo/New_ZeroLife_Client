//
//  ZLPayHydroelectricViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/12/27.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLPayHydroelectricViewController.h"
#import "utilityView.h"

@interface ZLPayHydroelectricViewController ()

@end

@implementation ZLPayHydroelectricViewController
{

    utilityView *mView;
    
    UIScrollView *mScrollerView;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.97 alpha:1.00];
    [self.view addSubview:mScrollerView];
    
    [self upDatePage];

    [self loadData];
    
    
}

- (void)loadData{
    
    [self showWithStatus:@"正在查询..."];
    
    [[APIClient sharedClient] ZLInquireOrder:_mPara block:^(mJHBaseData *resb,NSString *mBalance) {
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            
            self.mPara.mBalance = mBalance;
            
            [self initView];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self initEmptyView];
            mView.mTitle.text = @"查询失败!";
            mView.mContent.text = resb.mMessage;
        }
    }];
    
}

- (void)upDatePage{
    

    if ([_mPara.mPaytype.payProjectName isEqualToString:@"水费"]) {
        mView.mLogo.image = [UIImage imageNamed:@"water"];
        self.mPara.mType = @"001";
    }else if ([_mPara.mPaytype.payProjectName isEqualToString:@"电费"]){
        mView.mLogo.image = [UIImage imageNamed:@"power"];
        self.mPara.mType = @"002";

    }else{
        mView.mLogo.image = [UIImage imageNamed:@"gas"];
        self.mPara.mType = @"003";

    }
    
    
    mView.mPaytypeLb.text = _mPara.mPaytype.payProjectName;
    mView.mTypeLb.text = _mPara.mPaytype.payProjectName;
    mView.mUnitLb.text = _mPara.mPayUnint.payUnitName;
//    mView.mHouseLb.text = self.mHouseNum;
//    mView.mNameLb.text = self.mName;
    mView.mProvinceLb.text = _mPara.mProvince.provinceName;
    mView.mCityLb.text = _mPara.mCity.cityName;
}


- (void)initEmptyView{
    
    mView = [utilityView shareEmpty];
    mView.frame = CGRectMake(0, 0, mScrollerView.mwidth, DEVICE_Height);
    
    MLLog(@"%@",self.mPara);
    
    
    [mScrollerView addSubview:mView];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 618);
    
    
}

- (void)initView{
    
    
    mView = [utilityView shareInquireView];
    mView.frame = CGRectMake(0, 0, mScrollerView.mwidth, DEVICE_Height);
    
    MLLog(@"%@",self.mPara);
    
    
    [mView.mGoPayBtn addTarget:self action:@selector(mPayFeeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mScrollerView addSubview:mView];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, DEVICE_Height);
    
    
    
}

- (void)mPayFeeAction:(UIButton *)sender{

    [self showWithStatus:@"正在查询..."];
    [[APIClient sharedClient] ZLGoPayHyelectricOrder:self.mPara block:^(mJHBaseData *resb) {
        if (resb.mSucess) {
            
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self popViewController_2];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }

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

@end
