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
@interface ZLSuperMarketShopCarViewController ()<UITableViewDelegate,UITableViewDataSource,ZLShopCarBottomDelegate,ZLShopCarCellDelegate,UIAlertViewDelegate>

@end

@implementation ZLSuperMarketShopCarViewController
{

    UITableView *mTableView;
    
    ZLShopCarBottomView *mBottomView;
    
    
    NSMutableArray *mAddArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"购物车";
    
    mAddArr = [NSMutableArray new];
    
    [self addRightBtn:YES andTitel:@"清空" andImage:nil];

    [self initView];
}

- (void)initView{
    
    
    mTableView = [UITableView new];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

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
    [self reloadTableViewData];
    [self updateBottomView];
}
- (void)reloadTableViewData{
    [super reloadTableViewData];
    
    self.mShopCarArr = [LKDBHelperGoodsObj searchWithWhere:[NSString stringWithFormat:@"%d",self.mShopId]];

    [self ZLHideEmptyView];
    [self.tableArr addObjectsFromArray:self.mShopCarArr];
    if (self.tableArr.count<=0) {
        [self ZLShowEmptyView:@"购物车空空如也，快去选购吧" andImage:nil andHiddenRefreshBtn:YES];

    }else{
        [mTableView reloadData];
    }
    
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
    
    return self.tableArr.count;
    
    
    
    
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
    cell.mIndexPAth = indexPath;
    [cell setMGoods:self.tableArr[indexPath.row]];
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LKDBHelperGoodsObj *mGoods = self.tableArr[indexPath.row];
    mGoods.mSelected = !mGoods.mSelected;
    
    if (mGoods.mSelected) {
        [mAddArr addObject:mGoods];
    }else{
        [mAddArr removeObject:mGoods];
    }
    
    [self.tableArr replaceObjectAtIndex:indexPath.row withObject:mGoods];
    
    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
    
    
    if (mAddArr.count>0 && mAddArr.count == self.tableArr.count) {
        mBottomView.mSelecAllBtn.selected = YES;
    }else{
        mBottomView.mSelecAllBtn.selected = NO;
    }
    [self updateBottomView];
}

- (void)updateBottomView{

    float price = 0.0;
    
    for (LKDBHelperGoodsObj *mGoods in self.tableArr) {
        if (mGoods.mSelected) {
            price+=mGoods.mExtObj.mTotlePrice;
        }
    }
    NSString *mbtnContent = nil;

    if (price<self.mShopMinSendPrice) {
        mbtnContent = [NSString stringWithFormat:@"还差%.2f元起送",self.mShopMinSendPrice-price];
        mBottomView.mGoPayBtn.userInteractionEnabled = NO;
        [mBottomView.mGoPayBtn setBackgroundColor:[UIColor lightGrayColor]];
        mBottomView.mPrice.text = mbtnContent;

    }else if (price<=0){
        mbtnContent = [NSString stringWithFormat:@"还差%.2f元起送",self.mShopMinSendPrice];
        mBottomView.mGoPayBtn.userInteractionEnabled = NO;
        [mBottomView.mGoPayBtn setBackgroundColor:[UIColor lightGrayColor]];
        mBottomView.mPrice.text = mbtnContent;

    }else{
        mbtnContent = @"去结算";
        mBottomView.mGoPayBtn.userInteractionEnabled = YES;
        [mBottomView.mGoPayBtn setBackgroundColor:[UIColor redColor]];
        mBottomView.mPrice.text = [NSString stringWithFormat:@"¥%.2f元",price];

    }
    [mBottomView.mGoPayBtn setTitle:mbtnContent forState:0];


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
    
    for (int i =0; i<self.tableArr.count; i++) {
        LKDBHelperGoodsObj *mGoods = self.tableArr[i];
        mGoods.mSelected = mSelected;
        [self.tableArr replaceObjectAtIndex:i withObject:mGoods];

    }
    [mTableView reloadData];
    [self updateBottomView];


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
    LKDBHelperGoodsObj *mGoods = self.tableArr[mIndexPath.row];
    
    [self.tableArr removeObject:mGoods];
    if(self.tableArr.count <= 0){
        [LKDBHelperGoodsObj deleteWithWhere:[NSString stringWithFormat:@"%d",self.mShopId]];
        [self.tableArr removeAllObjects];
        [mTableView reloadData];
        [self ZLShowEmptyView:@"购物车空空如也，快去选购吧" andImage:nil andHiddenRefreshBtn:YES];
        return;
    }
    else{
        [self.tableArr replaceObjectAtIndex:mIndexPath.row withObject:mGoods];
        [mTableView beginUpdates];
        [mTableView reloadRowsAtIndexPaths:@[mIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [mTableView endUpdates];
    }
    
    
    
    [self updateBottomView];

}
#pragma mark----****----减按钮
/**
 减按钮
 
 @param mIndexPath 索引
 */
- (void)ZLShopCarSubstructBtnDidSelectedWithIndexPath:(NSIndexPath *)mIndexPath{

    LKDBHelperGoodsObj *mGoods = self.tableArr[mIndexPath.row];
    
    
    for (ZLSpeObj *mSpe in mGoods.mGoodsSKU) {
        if (mSpe.mSku.sta_required == 1) {
            mGoods.mExtObj.mTotlePrice-=mSpe.mSku.sku_price;
            
        }
    }
    mGoods.mExtObj.mGoodsNum-=1;
    if (mGoods.mExtObj.mGoodsNum<=0) {
        [self.tableArr removeObject:mGoods];
        if(self.tableArr.count <= 0){
            [LKDBHelperGoodsObj deleteWithWhere:[NSString stringWithFormat:@"%d",self.mShopId]];
            [self.tableArr removeAllObjects];
            [mTableView reloadData];
            [self ZLShowEmptyView:@"购物车空空如也，快去选购吧" andImage:nil andHiddenRefreshBtn:YES];
            return;
        }
    }else{
        [self.tableArr replaceObjectAtIndex:mIndexPath.row withObject:mGoods];
        [mTableView beginUpdates];
        [mTableView reloadRowsAtIndexPaths:@[mIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [mTableView endUpdates];
    }
    


    [self updateBottomView];
    
    
}
#pragma mark----****----加按钮
/**
 加按钮
 
 @param mIndexPath 索引
 */
- (void)ZLShopCarAddBtnDidSelectedWithIndexPath:(NSIndexPath *)mIndexPath{
    
    LKDBHelperGoodsObj *mGoods = self.tableArr[mIndexPath.row];
    
    for (ZLSpeObj *mSpe in mGoods.mGoodsSKU) {
        if (mSpe.mSku.sta_required == 1) {
            mGoods.mExtObj.mTotlePrice+=mSpe.mSku.sku_price;

        }
    }
    
    mGoods.mExtObj.mGoodsNum+=1;

    [self.tableArr replaceObjectAtIndex:mIndexPath.row withObject:mGoods];
    
    [mTableView beginUpdates];
    [mTableView reloadRowsAtIndexPaths:@[mIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [mTableView endUpdates];

    [self updateBottomView];
}

- (void)mRightAction:(UIButton *)sender{
    MLLog(@"晴空");
    if (self.tableArr.count<=0) {
        [self showErrorStatus:@"购物车什么都没有啊～亲"];
        return;
    }
    [self AlertViewShow:@"提示" alertViewMsg:@"确定要清空购物车码？" alertViewCancelBtnTiele:@"取消" alertTag:10];

    


}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if( buttonIndex == 1)
    {
        [LKDBHelperGoodsObj deleteWithWhere:[NSString stringWithFormat:@"%d",self.mShopId]];
        [self.tableArr removeAllObjects];
        [mTableView reloadData];
        
        if (self.tableArr.count<=0) {
            [self ZLShowEmptyView:@"购物车空空如也，快去选购吧" andImage:nil andHiddenRefreshBtn:YES];
        }
    }
    
    
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

@end
