//
//  BankCardAddVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "BankCardAddVC.h"
#import <CardIO/CardIO.h>

@interface BankCardAddVC ()<CardIOPaymentViewControllerDelegate>

@end

@implementation BankCardAddVC

-(void)loadView
{
    [super loadView];

    [self.doneBtn setStyleNavColor];
    
    
    //提交
    [self.doneBtn jk_addActionHandler:^(NSInteger tag) {
        if (_bankCardNumberField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入银行卡卡号"];
            return ;
        }
        if (![Util checkBankCard:_bankCardNumberField.text]) {
            [SVProgressHUD showErrorWithStatus:@"您输入的银行卡卡号有误！请重新输入！"];
            return;
        }
        
        if (_bankCardMobileField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入银行卡预留手机号"];
            return ;
        }
        if (![Util isMobileNumber:_bankCardMobileField.text]) {
            [SVProgressHUD showErrorWithStatus:@"您输入的手机号码有误！请重新输入！"];
            return;
        }
        
        if (_realNameField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入您的真实姓名"];
            return ;
        }
        
        
        if (_idCardField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入您的身份证号"];
            return ;
        }
        if (![Util checkIdentityCardNo:_idCardField.text]) {
            [SVProgressHUD showErrorWithStatus:@"您输入的身份证号有误！请重新输入！"];
            return;
        }
        
        [SVProgressHUD showWithStatus:@"银行卡添加中..."];
        [[APIClient sharedClient] bankCardAddWithTag:self bank_real_name:_realNameField.text bank_mobile:_bankCardMobileField.text bank_card:_bankCardNumberField.text id_card:_idCardField.text call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
                
                [SVProgressHUD showSuccessWithStatus:info.msg];
            } else
                [SVProgressHUD showErrorWithStatus:info.msg];
        }];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [CardIOUtilities preloadCardIO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bankCardAutoMethod:(id)sender {
    CardIOPaymentViewController *vc = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    vc.languageOrLocale = @"zh-Hans";
    vc.hideCardIOLogo = YES;
    vc.collectExpiry = NO;
    vc.collectCVV = NO;
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark -  CardIOPaymentViewControllerDelegate
- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    NSLog(@"User canceled payment info");
    // Handle user cancellation here...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    self.bankCardNumberField.text = info.cardNumber;
    // The full card number is available as info.cardNumber, but don't log that!
    //NSLog(@"Received card info. Number: %@, expiry: %02i/%i, cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv);
    // Use the card info...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
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
