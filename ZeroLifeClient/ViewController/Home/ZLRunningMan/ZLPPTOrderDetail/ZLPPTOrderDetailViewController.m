//
//  ZLPPTOrderDetailViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/15.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPPTOrderDetailViewController.h"
#import "ZLPPTOrderDetailCell.h"
#import "ZLPPTOrderDetailHeaderSectionView.h"
#import "UserPaoPaoRegisterVC.h"
#import "UserPaoPaoApplyVC.h"
@interface ZLPPTOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,ZLPPTOrderDetailCellBtnWithClicked,ZLPPTOrderDetailHeaderSectionViewDelegate>

@end

@implementation ZLPPTOrderDetailViewController
{

    ZLPPTOrderDetailHeaderSectionView *mFirstHeaderView;
    
    ZLPPTOrderDetailHeaderSectionView *mSecondHeaderView;

    OrderObject *mOrderDetail;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"跑单详情";

    mOrderDetail =  OrderObject.new;
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"ZLPPTOrderDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"ZLPPTOrderDetailCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    
    [self setTableViewHaveHeader];

}

- (void)reloadTableViewDataSource{

    [super reloadTableViewDataSource];
    
    [[APIClient sharedClient] orderInfoWithTag:self odr_id:self.mOrder.odr_id odr_code:self.mOrder.odr_code call:^(OrderObject *item, APIObject *info) {
        [self ZLHideEmptyView];
        if (info.code == RESP_STATUS_YES) {
            [self dismiss];
            mOrderDetail = item;
        }else{
        
            [self showErrorStatus:info.msg];
            [self ZLShowEmptyView:info.msg andImage:nil andHiddenRefreshBtn:NO];
        }
        
        [self doneLoadingTableViewData];
        [self.tableView reloadData];
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 40;
    }else{
        return 70;
    }
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        mFirstHeaderView = [ZLPPTOrderDetailHeaderSectionView initFirstView];
        
        return mFirstHeaderView;
    }else{
        mSecondHeaderView = [ZLPPTOrderDetailHeaderSectionView initSecondView];
        mSecondHeaderView.delegate = self;
        
        mSecondHeaderView.mRunnerName.text = [NSString stringWithFormat:@"%@-%@",mOrderDetail.odr_deliver_name,mOrderDetail.odr_deliver_phone];
        
        return mSecondHeaderView;
    }
    
    
    
}
- (void)mGoReleaseAction:(UIButton *)sender{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 90;
    }else{
        return 420;
    }
    
    
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"cell";
        
        ZLPPTOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.mHStatus.text = mOrderDetail.odr_state_val;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        reuseCellId = @"cell2";
        
        ZLPPTOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell setMOrderDetail:mOrderDetail];
        return cell;
    }
    

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark----****----操作按钮的代理方法
- (void)ZLPPTOrderDetailCell:(ZLPPTOrderDetailCell *)mCell andWithLeftBtn:(NSIndexPath *)mIndexPath{}

- (void)ZLPPTOrderDetailCell:(ZLPPTOrderDetailCell *)mCell andWithRightBtn:(NSIndexPath *)mIndexPath{

    if ([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"NOTOPEN"]) {
        UserPaoPaoRegisterVC*vc = [[UserPaoPaoRegisterVC alloc] initWithNibName:@"UserPaoPaoRegisterVC" bundle:nil];
        [self pushViewController:vc];
    }else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"PAYMENTED"]){
        UserPaoPaoApplyVC *vc = [UserPaoPaoApplyVC new];
        [self pushViewController:vc];
        
    }
    else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"UNCHECK"]){
        [self showErrorStatus:@"待审核中..."];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"REFUSE"]){
        [self showErrorStatus:@"审核失败！"];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOGOFF"]){
        [self showErrorStatus:@"已注销！"];
    } else if([[ZLUserInfo ZLCurrentUser].openInfo.open_state isEqualToString:@"LOCKED"]){
        [self showErrorStatus:@"已禁用！"];
    }else{
        
        [self showWithStatus:@"正在操作中..."];
        [[APIClient sharedClient] ZLOperatorPPTOrder:mOrderDetail.odr_id andOrderCode:mOrderDetail.odr_code andOperatorStatus:ZLOperatorPPTOrderStatusWithAccept block:^(APIObject *resb) {
            if (resb.code == RESP_STATUS_YES) {
                [self showSuccessStatus:resb.msg];
                [self popViewController];
            }else{
                
                [self showErrorStatus:resb.msg];
            }
        }];
        
    }

}

- (void)ZLPPTOrderDetailHeaderSectionViewWithRunnerPhoneAction{
    
    if (mOrderDetail.odr_deliver_phone.length<=0) {
        [self showErrorStatus:@"暂无电话哦～"];
        return;
    }else if ([ZLUserInfo ZLCurrentUser].user_id == _mOrder.user_id){
        [self showErrorStatus:@"您不能给自己打电话哟～～"];
        return;
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",mOrderDetail.odr_deliver_phone]]];
    }
    
    
}

@end
