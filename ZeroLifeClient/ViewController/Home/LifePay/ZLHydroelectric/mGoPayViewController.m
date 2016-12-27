//
//  mGoPayViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/18.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mGoPayViewController.h"
#import "utilityView.h"
#import "canPayView.h"
@interface mGoPayViewController ()

@end

@implementation mGoPayViewController{
    utilityView *mView;
    
    UIScrollView *mScrollerView;
    
    NSString *mBalance;
}

- (void)upDatePage{

    
    
    
    if ([[self.mPara objectForKey:@"projectName"] isEqualToString:@"水费"]) {
        mView.mLogo.image = [UIImage imageNamed:@"water"];
        
    }else if ([[self.mPara objectForKey:@"projectName"] isEqualToString:@"电费"]){
        mView.mLogo.image = [UIImage imageNamed:@"power"];
        
    }else{
        mView.mLogo.image = [UIImage imageNamed:@"gas"];
    }
    
    
    mView.mPaytypeLb.text = [self.mPara objectForKey:@"projectName"];
    mView.mTypeLb.text = [self.mPara objectForKey:@"projectName"];
    mView.mUnitLb.text = [self.mPara objectForKey:@"unitName"];
    mView.mHouseLb.text = self.mHouseNum;
    mView.mNameLb.text = self.mName;
    mView.mProvinceLb.text = [self.mPara objectForKey:@"provinceName"];
    mView.mCityLb.text = [self.mPara objectForKey:@"cityName"];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self loadData];

    [self upDatePage];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"账单信息";
    self.hiddenTabBar = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;

    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.97 alpha:1.00];
    [self.view addSubview:mScrollerView];
    
}

- (void)loadData{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:[self.mPara objectForKey:@"provinceName"] forKey:@"provname"];
    [para setObject:[self.mPara objectForKey:@"cityName"] forKey:@"cityname"];
    [para setObject:self.mPayType forKey:@"type"];
    [para setObject:[self.mPara objectForKey:@"unitId"] forKey:@"code"];
    [para setObject:[self.mPara objectForKey:@"unitName"] forKey:@"name"];
    [para setObject:[self.mPara objectForKey:@"productId"] forKey:@"cardid"];

    [para setObject:self.mHouseNum forKey:@"account"];
    [para setObject:JH_KEY forKey:@"key"];

    MLLog(@"请求的参数:是%@",para);
    
    [SVProgressHUD showWithStatus:@"正在查询..." maskType:SVProgressHUDMaskTypeClear];
    [[mUserInfo backNowUser] Inquire:para block:^(mJHBaseData *resb) {
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            
            mBalance = [[[[resb.mData objectForKey:@"result"] objectForKey:@"balances"] objectAtIndex:0] objectForKey:@"balance"];
            
            [self initView];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self initEmptyView];
            mView.mTitle.text = @"查询失败!";
            mView.mContent.text = resb.mMessage;
        }
    }];
    
}

- (void)initEmptyView{

    mView = [utilityView shareEmpty];
    mView.frame = CGRectMake(0, 0, mScrollerView.mwidth, 568);
    
    MLLog(@"%@",self.mPara);
    
    
    [mScrollerView addSubview:mView];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 618);

    
}

- (void)initView{
    

    mView = [utilityView shareInquireView];
    mView.frame = CGRectMake(0, 0, mScrollerView.mwidth, 568);

    MLLog(@"%@",self.mPara);

    
    [mView.mGoPayBtn addTarget:self action:@selector(mPayFeeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mScrollerView addSubview:mView];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 618);
    
    
    
}
- (void)mPayFeeAction:(UIButton *)sender{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:[self.mPara objectForKey:@"provinceName"] forKey:@"provname"];
    [para setObject:[self.mPara objectForKey:@"cityName"] forKey:@"cityname"];
//    [para setObject:self.mPayType forKey:@"type"];
    [para setObject:[self.mPara objectForKey:@"unitId"] forKey:@"code"];
    [para setObject:[self.mPara objectForKey:@"unitName"] forKey:@"name"];
    [para setObject:[self.mPara objectForKey:@"productId"] forKey:@"cardid"];
    
    [para setObject:self.mHouseNum forKey:@"account"];
    [para setObject:JH_KEY forKey:@"key"];
    [para setObject:mBalance forKey:@"cardnum"];

    
    [SVProgressHUD showWithStatus:@"正在操作..." maskType:SVProgressHUDMaskTypeClear];
    
    [[mUserInfo backNowUser] goPay:para block:^(mJHBaseData *resb) {
        if (resb.mSucess) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil];
            
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
