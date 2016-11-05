//
//  ZLSuperMarketShopCarViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketShopCarViewController.h"
#import "ZLShopCarBottomView.h"
#import "ZLSuperMarketShopCarCell.h"
@interface ZLSuperMarketShopCarViewController ()<UITableViewDelegate,UITableViewDataSource,ZLShopCarBottomDelegate,ZLShopCarCellDelegate>

@end

@implementation ZLSuperMarketShopCarViewController
{

    UITableView *mTableView;
    
    ZLShopCarBottomView *mBottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"购物车";
    [self addRightBtn:YES andTitel:@"清空" andImage:nil];

    [self initView];
}

- (void)initView{
    
    mTableView = [UITableView new];
    mTableView.delegate = self;
    mTableView.dataSource = self;
//    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:mTableView];
    
    mBottomView = [ZLShopCarBottomView shareView];
    mBottomView.delegate = self;
    [self.view addSubview:mBottomView];
    
    [mTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(mBottomView.top).offset(0);
        make.height.offset(DEVICE_Height - 50);
        
    }];
    [self.tableView setNeedsUpdateConstraints];
    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(mTableView.bottom).offset(0);
        make.height.offset(50);
        
    }];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLSuperMarketShopCarCell" bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0.5;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 90;
    
    
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    
    
    reuseCellId = @"cell";
    
    ZLSuperMarketShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark----****----底部全选按钮
/**
 全选按钮
 */
- (void)ZLShopCarBottomSelecteAllWithSelected:(BOOL)mSelected{

}
#pragma mark----****----底部去结算按钮
/**
 去结算
 */
- (void)ZLShopCarBottomGoPay{

}
#pragma mark----****----左边选择按钮
/**
 左边选择按钮
 
 @param mSelected  是否选中
 @param mIndexPath 索引
 */
- (void)ZLShopCarSelectedBtnDidSelected:(BOOL)mSelected andIndexPath:(NSIndexPath *)mIndexPath{

}
#pragma mark----****----删除按钮
/**
 删除按钮
 
 @param mIndexPath 索引
 */
- (void)ZLShopCarDeleteBtnDidSelectedWithIndexPath:(NSIndexPath *)mIndexPath{

}
#pragma mark----****----减按钮
/**
 减按钮
 
 @param mIndexPath 索引
 */
- (void)ZLShopCarSubstructBtnDidSelectedWithIndexPath:(NSIndexPath *)mIndexPath{

}
#pragma mark----****----加按钮
/**
 加按钮
 
 @param mIndexPath 索引
 */
- (void)ZLShopCarAddBtnDidSelectedWithIndexPath:(NSIndexPath *)mIndexPath{

}

- (void)mRightAction:(UIButton *)sender{
    MLLog(@"晴空");

}
@end
