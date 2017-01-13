//
//  OrderVC+Custom.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/29.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "OrderVC+Custom.h"


@implementation UIViewController (OrderVC_Custom)


/**
 *   跑跑者订单列表接口
 *
 *  @param stateStr         处理逻辑状态
 *  @param item             订单原始信息
 *  @param isShopOrderBool  是否为商铺订单
 *  @param callback 返回新的订单信息
 */
-(void)loadAPIwithState:(NSString *)stateStr orderItem:(OrderObject *)item isShopOrderBool:(BOOL)isShopOrderBool call:( void(^)(OrderObject *itemNew))callback
{
    
    if (stateStr==nil || stateStr.length==0)
        return;
    
    
    if (isShopOrderBool) //商户端订单操作逻辑
    {
        if (item.odr_type == kOrderClassType_paopao) //跑跑者订单操作逻辑
        {
            
            if ([stateStr isEqualToString:kOrderState_DIFFWAIT]) //跑跑者提交差价
            {
                [self loadPaopaoManDiffWithOrderItem:item call:^(OrderObject *itemNew) {
                    callback(itemNew);
                }];
            }
            else //其它通用操作
            {
                [SVProgressHUD showWithStatus:@"操作中..."];
                [[APIClient sharedClient] orderPaopaoManOprateWithTag:self odr_id:item.odr_id odr_code:item.odr_code odr_state_next:stateStr call:^(NSString *odr_state_val, NSMutableArray *odr_state_next, APIObject *info) {
                    if (info.code == RESP_STATUS_YES) {
                        item.odr_state_next = odr_state_next;
                        item.odr_state_val = odr_state_val;
                        
                        callback(item);
                        [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                    } else
                        [SVProgressHUD showErrorWithStatus:info.msg];
                }];
            }
            
        }
    }
    
    else //用户端订单操作逻辑
    {
        if ([stateStr isEqualToString:kOrderState_PAYMENTED]) //去支付（调支付接口）
        {
            ZLCreateOrderObj *pay = [ZLCreateOrderObj new];
            pay.odr_id = item.odr_id;
            pay.odr_code = item.odr_code;
            pay.odr_shop_name = item.shop_name;
            pay.odr_amount = item.odr_amount;
            pay.odr_pay_price = item.odr_pay_price;
            pay.notify = item.notify;
            
            ZLGoPayViewController *vc = [ZLGoPayViewController new];
            vc.mOrder = pay;
            
            vc.paySuccessCallBack = ^(ZLGoPayViewController *payVC){
                [payVC performSelector:@selector(popViewController) withObject:nil afterDelay:0.2];
                
                item.odr_state = kOrderState_PAYMENTED; //已付款
                item.odr_state_val = @"用户已付款";
                item.odr_state_next = [NSMutableArray arrayWithObjects:kOrderState_UCANCEL, nil];
                callback(item);
            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if ([stateStr isEqualToString:kOrderState_DIFFPAYED]) //支付差价
        {
            [SVProgressHUD showWithStatus:@"操作中..."];
            [[APIClient sharedClient] orderOprateDiffPriceWithTag:self odr_id:item.odr_id odr_code:item.odr_code call:^(ZLCreateOrderObj *payItem, APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    
                    [self loadPay:payItem orderItem:item call:^(OrderObject *itemNew111) {
                        callback(itemNew111); //返回新订单信息
                    }];
                   
                } else
                    [SVProgressHUD showErrorWithStatus:info.msg];
            }];
            
        }
        else if ([stateStr isEqualToString:kOrderState_SERPOINT]) //报修选定服务商
        {
            OrderRepairBidObject *bidItem = [self bk_associatedValueForKey:USER_FIX_CHOOSE_BID_Key]; //获取当前界面选择的服务商
            
            if (bidItem != nil)
            {
                [self loadFixWithBidItem:bidItem orderItem:item call:^(OrderObject *itemNew222) {
                    callback(itemNew222);  //返回新订单信息
                }];
            }
            else
            {
                //未选择服务商则去选择
                OrderBaoXiuChooseShopVC *vc = [[OrderBaoXiuChooseShopVC alloc] init];
                vc.odr_id = item.odr_id;
                vc.odr_code = item.odr_code;
                vc.chooseCallBack = ^(OrderRepairBidObject* item111){
                    [self bk_associateValue:item111 withKey:USER_FIX_CHOOSE_BID_Key];
                    
                    [self loadFixWithBidItem:item111 orderItem:item call:^(OrderObject *itemNew222) {
                        callback(itemNew222);  //返回新订单信息
                    }];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else if ([stateStr isEqualToString:kOrderState_MAINTAIN]) //维权操作
        {
            OrderMainTainVC *vc = [[OrderMainTainVC alloc] initWithNibName:@"OrderMainTainVC" bundle:nil];
            vc.textCallBack = ^(NSString* text) {
                [SVProgressHUD showWithStatus:@"提交维权..."];
                [[APIClient sharedClient] orderOprateWithTag:self odr_id:item.odr_id odr_type:item.odr_type odr_code:item.odr_code odr_state_next:stateStr odr_memo:text call:^(NSString *odr_state_val, NSMutableArray *odr_state_next, APIObject *info) {
                    if (info.code == RESP_STATUS_YES) {
                        item.odr_state_next = odr_state_next;
                        item.odr_state_val = odr_state_val;
                        
                        callback(item); //返回新订单信息
                        [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                    } else
                        [SVProgressHUD showErrorWithStatus:info.msg];
                }];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([stateStr isEqualToString:kOrderState_EVALUATE]) //去评价
        {
            ZLRatingViewController *vc = [[ZLRatingViewController alloc] init];
            vc.orderItem = item;
            vc.evaluateSuccessCallBack = ^(NSString *odr_state_val, NSMutableArray *odr_state_next) {
                item.odr_state_next = odr_state_next;
                item.odr_state_val = odr_state_val;
                callback(item); //返回新订单信息
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        else //其它通用操作
        {
            [SVProgressHUD showWithStatus:@"操作中..."];
            [[APIClient sharedClient] orderOprateWithTag:self odr_id:item.odr_id odr_type:item.odr_type odr_code:item.odr_code odr_state_next:stateStr odr_memo:nil call:^(NSString *odr_state_val, NSMutableArray *odr_state_next, APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    item.odr_state_next = odr_state_next;
                    item.odr_state_val = odr_state_val;
                    
                    callback(item);
                    [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                } else
                    [SVProgressHUD showErrorWithStatus:info.msg];
            }];
        }
        
    }
}

//根据支付信息处理订单差价支付
-(void)loadPay:(ZLCreateOrderObj *)payItem orderItem:(OrderObject *)item call:( void(^)(OrderObject *itemNew))callback
{
    
    if (payItem.odr_pay_price <= 0) //需支付金额（如果金额小于等于0，使用差价确认接口；否则使用创建支付接口）
    {
        SecurityPasswordAlertView *alertView = [[SecurityPasswordAlertView alloc] init];
        __strong __typeof(SecurityPasswordAlertView *)strongSelf = alertView;
        alertView.inputPwdCallBack = ^(NSString* pwd) {
            [strongSelf close];
            
            [SVProgressHUD showWithStatus:@"获取支付差价信息中..."];
            [[APIClient sharedClient] orderOprateRecycleWithTag:self odr_id:payItem.odr_id odr_code:payItem.odr_code pay_amount:payItem.odr_pay_price pass:pwd call:^(NSString *odr_state_val, NSMutableArray *odr_state_next, APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    item.odr_state_next = odr_state_next;
                    item.odr_state_val = odr_state_val;
                    callback(item);
                    
                    [SVProgressHUD showSuccessWithStatus:info.msg];
                } else
                    [SVProgressHUD showErrorWithStatus:info.msg];
            }];
        };
        [alertView showAlert];
        
    }
    else
    {
        [SVProgressHUD dismiss];
        
        ZLGoPayViewController *vc = [ZLGoPayViewController new];
        vc.mOrder = payItem;
        vc.paySuccessCallBack = ^(ZLGoPayViewController *payVC){
            [payVC performSelector:@selector(popViewController) withObject:nil afterDelay:0.2];
            
//            item.odr_state = kOrderState_PAYMENTED; //已付款
//            item.odr_state_val = @"用户已付款";
//            item.odr_state_next = nil;
            callback(item);  //返回新订单信息
        };
        [self.navigationController pushViewController:vc animated:YES];
    }

}


//维修根据选择的服务商处理订单逻辑
-(void)loadFixWithBidItem:(OrderRepairBidObject *)bidItem orderItem:(OrderObject *)item call:( void(^)(OrderObject *itemNew))callback
{
    [SVProgressHUD showWithStatus:@"操作中..."];
    [[APIClient sharedClient] orderOprateBidWithTag:self odr_id:item.odr_id odr_code:item.odr_code bid_id:bidItem.bid_id call:^(ZLCreateOrderObj *payItem, APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            ZLGoPayViewController *vc = [ZLGoPayViewController new];
            vc.mOrder = payItem;
            vc.paySuccessCallBack = ^(ZLGoPayViewController *payVC){
                [payVC performSelector:@selector(popViewController) withObject:nil afterDelay:0.2];
                
                item.odr_state = kOrderState_PAYMENTED; //已付款
                item.odr_state_val = @"用户已付款";
                item.odr_state_next = [NSMutableArray arrayWithObjects:kOrderState_MAINTAIN, nil];
                
                callback(item);  //返回新订单信息
            };
            [self.navigationController pushViewController:vc animated:YES];
        } else
            [SVProgressHUD showErrorWithStatus:info.msg];
    }];
}


//跑跑者提交差价
-(void)loadPaopaoManDiffWithOrderItem:(OrderObject *)item call:( void(^)(OrderObject *itemNew))callback
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提交差价" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入差价金额";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *moneyField = [alert.textFields objectAtIndex:0];
        if (moneyField.text.length > 0) {
            
            [SVProgressHUD showWithStatus:@"操作中..."];
            [[APIClient sharedClient] orderPaopaoManOprateDiffWithTag:self odr_id:item.odr_id odr_code:item.odr_code diff_price:[moneyField.text floatValue] call:^(float odr_amount, float odr_pay_price, NSString *odr_state_val, NSMutableArray *odr_state_next, APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    item.odr_state_next = odr_state_next;
                    item.odr_state_val = odr_state_val;
                    item.odr_amount = odr_amount;
                    item.odr_pay_price = odr_pay_price;
                    
                    callback(item);
                    [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                } else
                    [SVProgressHUD showErrorWithStatus:info.msg];
            }];
        } else
            [SVProgressHUD showErrorWithStatus:@"请输入差价金额"];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) { }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
