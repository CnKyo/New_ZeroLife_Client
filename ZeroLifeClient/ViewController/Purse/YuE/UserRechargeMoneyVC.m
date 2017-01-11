//
//  UserRechargeMoneyVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserRechargeMoneyVC.h"
#import "UserPayTypeTableViewCell.h"
#import "ZLGoPayViewController.h"


@interface UserRechargeMoneyVC ()<UITextFieldDelegate>
@property(nonatomic,strong) PreApplyObject *item;

@property(nonatomic,strong) UITextField *moneyField;
@end

@implementation UserRechargeMoneyVC
{

    
}



-(void)loadView
{
    [super loadView];
    [self addTableViewWithStyleGrouped];
    
    UIView *footerView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 60)];
        UIButton *btn11 = [view newUIButton];
        btn11.frame = CGRectMake(10, 10, view.bounds.size.width-20, 50);
        [btn11 setTitle:@"确认" forState:UIControlStateNormal];
        [btn11 setStyleNavColor];
        [btn11 jk_addActionHandler:^(NSInteger tag) {
        
            if (_moneyField.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入您要充值的金额"];
                return ;
            }
            
            float money = [_moneyField.text floatValue];
            if (money <= 0) {
                [SVProgressHUD showErrorWithStatus:@"您要充值的金额不能大或等于0"];
                return ;
            }
            
            [[IQKeyboardManager sharedManager] resignFirstResponder];
            
            NSString *spec = [_item getCustomSpecWithMoney:money];
            
            NSMutableArray *mPayArr = [NSMutableArray new];
            NSMutableDictionary *mPara = [NSMutableDictionary new];
            [mPara setObject:_item.odrg_pro_name forKey:@"odrg_pro_name"];
            [mPara setObject:spec forKey:@"odrg_spec"];
            [mPara setObject:_moneyField.text forKey:@"odrg_price"];
            [mPayArr addObject:mPara];
            
            [SVProgressHUD showWithStatus:@"加载中"];
            [[APIClient sharedClient] ZLCommitOrder:kOrderClassType_balance_recharge andShopId:nil andGoods:[Util arrToJson:mPayArr] andSendAddress:nil andArriveAddress:nil andServiceTime:nil andSendType:0 andSendPrice:nil andCoupId:nil andRemark:nil andSign:_item.sign block:^(APIObject *mBaseObj, ZLCreateOrderObj *mOrder) {
                if (mBaseObj.code == RESP_STATUS_YES) {
                    ZLGoPayViewController *vc = [ZLGoPayViewController new];
                    vc.mOrderType = kOrderClassType_balance_recharge;
                    vc.mOrder = mOrder;
                    vc.mOrder.sign = _item.sign;
                    vc.paySuccessCallBack = ^(ZLGoPayViewController *payVC){
                        [payVC performSelector:@selector(popViewController_2) withObject:nil afterDelay:0.2];
                    };
                    [self pushViewController:vc];
                    
                    [self showSuccessStatus:mBaseObj.msg];
                } else
                    [self showErrorStatus:mBaseObj.msg];
            }];
            
        }];
        view;
    });
    self.tableView.tableFooterView = footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    
    
    
    for (int i=0; i<2; i++) {
        [self.tableArr addObject:@"111"];
    }
    

    [self createPreOrder];
}
#pragma mark----****----创建预订单
- (void)createPreOrder{
    
    [self showWithStatus:@"正在验证..."];
    [[APIClient sharedClient] preOrderRechargeWithTag:self call:^(PreApplyObject *item, APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            [self showSuccessStatus:@"验证成功!"];
            
            self.item = item;
            
        }else{
            
            [self showErrorStatus:info.msg];
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
        }
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    if (section == 0)
        return row = 1;
    else if (section == 1)
        return row = self.tableArr.count;
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 10;
    else
        return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
        return @"选择支付方式";
    else
        return @"";
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"Cell_UserRechargeMoneyVC111";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            UIView *superView = cell.contentView;
            int padding = 10;
            UIFont *font = [UIFont systemFontOfSize:14];
            UILabel *textLable = [superView newUILableWithText:@"金额" textColor:[UIColor blackColor] font:font];
            UITextField *field = [superView newUITextFieldWithPlaceholder:@"请输入充值金额"];
            field.delegate = self;
            field.keyboardType = UIKeyboardTypeNumberPad;
            field.font = font;
            textLable.tag = 12;
            field.tag = 13;
            [textLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(superView.left).offset(padding);
                make.top.bottom.equalTo(superView);
                make.width.equalTo(80);
            }];
            [field makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(textLable.right).offset(padding/2);
                make.top.bottom.equalTo(superView);
                make.right.equalTo(superView.right).offset(-padding);
            }];
            self.moneyField = field;
        }
        return cell;
        
    } else {
        static NSString *CellIdentifier = @"Cell_UserRechargeMoneyVC222";
        UserPayTypeTableViewCell *cell = (UserPayTypeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell= [[UserPayTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        if (indexPath.row == 0) {
            cell.imgView.image = IMG(@"user_payTyple_weixin.png");
            cell.nameLable.text = @"微信支付";
            
            UIImageView *chooseImgView = [[UIImageView alloc] initWithImage:IMG(@"shimingrenzheng_on.png")];
            chooseImgView.frame = CGRectMake(0, 0, 20, 20);
            cell.accessoryView = chooseImgView;
        } else {
            cell.imgView.image = IMG(@"user_payTyple_alipay.png");
            cell.nameLable.text = @"支付宝支付";
            cell.accessoryView = nil;
        }

        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

}


@end
