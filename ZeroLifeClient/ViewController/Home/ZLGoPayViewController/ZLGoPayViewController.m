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
@interface ZLGoPayViewController ()<UITableViewDelegate,UITableViewDataSource,ZLGoPayCellDelegate,ZLGoPayShareDelegate>
@property (strong,nonatomic)ZLGoPayPopRedBagView *mPopView;
@end

@implementation ZLGoPayViewController
{
    ZLPayTypeHeaderView *mHeadaerView;
    
    UIButton *mComformBtn;
    
    UIButton *mSendRedBagBtn;
    
    UIView *mRedBgkView;
    
}
@synthesize mPopView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"收银台";

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
}
#pragma mark----****----确定
- (void)mOKBtn:(UIButton *)sender{

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
    return mHeadaerView;
 
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;

    
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark----****----状态按钮点击事件
///状态按钮点击事件
- (void)ZLGoPayStatusBtnClicked{

}

- (void)showRedBagView{

    [UIView animateWithDuration:0.25 animations:^{
        mRedBgkView.alpha = 1;
        CGRect mRRR = mPopView.frame;
        mRRR.origin.y = DEVICE_Height-200;
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
    
    mPopView = [ZLGoPayPopRedBagView initShareViewWithFrame:CGRectMake(0, DEVICE_Height, DEVICE_Width, 200) andDataSource:@[@"a",@"s",@"d",@"w"]];
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

@end
