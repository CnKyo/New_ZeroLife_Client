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
        return mHeaderView;
    }else if (section == 1){
        mHeaderSectionView = [ZLCommitOrderHeaderView initWithShopSection];
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
        return 10;
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
        
        cell.delegate = self;
        
        return cell;
    }
    else{
        reuseCellId = @"detailCell";
        
        ZLCommitOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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

}
#pragma mark----****----去支付
/**
 去支付
 */
- (void)ZLCommitGopay{
    
    ZLGoPayViewController *ZLGoPayVC = [ZLGoPayViewController new];
    [self pushViewController:ZLGoPayVC];

}
#pragma mark----****----选择配送方式
///选择配送方式
- (void)ZLCommitWithSendTypeBtnSelected{

}
#pragma mark----****----选择优惠券
///选择优惠券
- (void)ZLCommitWithCoupBtnSelected{

}
@end
