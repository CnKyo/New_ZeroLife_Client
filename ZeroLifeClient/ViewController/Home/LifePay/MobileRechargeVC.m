//
//  MobileRechargeVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/7.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "MobileRechargeVC.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import <JKCategories/NSString+JKNormalRegex.h>

#import "ZLGoPayViewController.h"
#import "FeePayHistoryVC.h"

@implementation MobileRechargeMoneyView

- (id)initWithTitleArr:(NSArray *)arr
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.arr = [arr mutableCopy];

        [self reloadUIWithData];
    }
    return self;
}

-(void)reloadUIWithData
{
    int row = 4;
    int offsetX = 10;
    int offsetY = 20;
    
    [self removeAllSubviews];
    
    UIView *lastView = nil;
    for (int i=0; i<_arr.count; i++) {
        NSString *item = [_arr objectAtIndex:i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //btn.backgroundColor = [UIColor redColor];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(chooseMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = 100 + i;
        [btn setTitle:item forState:UIControlStateNormal];
        //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [btn makeConstraints:^(MASConstraintMaker *make) {
            if (i % row == 0) {
                make.left.equalTo(self.left).offset(offsetX);
                if (lastView == nil) {
                    make.top.equalTo(self.top).offset(offsetY);
                } else
                    make.top.equalTo(lastView.bottom).offset(offsetY);
                
                make.height.equalTo(btn.width).multipliedBy(0.45);
            } else {
                make.width.top.bottom.equalTo(lastView);
                make.left.equalTo(lastView.right).offset(offsetX);
                
                if (i % row == row-1)
                    make.right.equalTo(self.right).offset(-offsetX);
            }
        }];
        
        
        lastView = btn;
        
    }
    
    
    
    if (lastView != nil) {
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.bottom).offset(offsetY);
        }];
    }
    
    [self reloadBtnChooseState];
}

-(void)chooseMethod:(UIButton *)sender
{
    NSInteger index = sender.tag - 100;
    NSLog(@"index:%li", (long)index);
    
    NSString *title = [sender titleForState:UIControlStateNormal];
    self.chooseStr = title;
    
    [self reloadBtnChooseState];
    
    if (self.chooseCallBack) {
        self.chooseCallBack(title);
    }
}

-(void)reloadBtnChooseState
{
    UIColor *colorChoose = [UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000];
    UIColor *colorNormal = [UIColor colorWithWhite:0.5 alpha:1];
    UIImage *bgNormal = IMG(@"MobileRechargeMoneyView_kuangNormal.png");
    UIImage *bgChoose = IMG(@"MobileRechargeMoneyView_kuangChoose.png");
    
    NSArray *arr = [self subviews];
    for (UIView *view in arr) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            NSString *title = [btn titleForState:UIControlStateNormal];
            if ([title isEqualToString:_chooseStr]) {
//                btn.layer.borderWidth = 1;
//                btn.layer.borderColor = colorChoose.CGColor;
//                btn.layer.masksToBounds = YES;
                [btn setTitleColor:colorChoose forState:UIControlStateNormal];
                [btn setBackgroundImage:bgChoose forState:UIControlStateNormal];
            } else {
//                btn.layer.borderWidth = 1;
//                btn.layer.borderColor = COLOR(220, 220, 220).CGColor;
//                btn.layer.masksToBounds = YES;
                [btn setTitleColor:colorNormal forState:UIControlStateNormal];
                [btn setBackgroundImage:bgNormal forState:UIControlStateNormal];
            }
            
        }
    }
}



@end


@interface MobileRechargeVC () <ABPeoplePickerNavigationControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong) UITextField *mobileField;
@property(nonatomic,strong) MobileRechargeMoneyView *moneyChooseView;

@property(nonatomic,strong) PreApplyObject *item;

@end

@implementation MobileRechargeVC
{

    NSString *mMoneyStr;
}



-(void)loadView
{
    [super loadView];
    UIView *superView = self.view;
    int padding = 10;
    
    UIView *aView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        UIImageView *imgView = [view newUIImageViewWithImg:IMG(@"MobileRechargeMoneyView_mobile.png")];
        UITextField *field = [view newUITextFieldWithPlaceholder:@"请输入手机号码"];
        field.keyboardType = UIKeyboardTypePhonePad;
        self.mobileField = field;
        UIView *lineView = [view newDefaultLineView];
        UIButton *btn = [view newUIButton];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setImage:IMG(@"MobileRechargeMoneyView_person.png") forState:UIControlStateNormal];
        [btn setTitle:@"通讯录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn jk_setImagePosition:LXMImagePositionLeft spacing:-5];
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.centerY.equalTo(view.centerY);
            make.width.height.equalTo(30);
        }];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view.right).offset(-padding);
            make.centerY.equalTo(view.centerY);
            make.height.equalTo(40);
            make.width.equalTo(90);
        }];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(btn);
            make.width.equalTo(OnePixNumber);
            make.right.equalTo(btn.left);
        }];
        [field makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.right).offset(padding);
            make.right.equalTo(lineView.left).offset(-padding);
            make.centerY.equalTo(view.centerY);
        }];
        [btn jk_addActionHandler:^(NSInteger tag) {
            ABPeoplePickerNavigationController *pNC = [[ABPeoplePickerNavigationController alloc] init];
            pNC.peoplePickerDelegate = self;
            [pNC setDelegate:self];
            if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
                pNC.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
            }
            ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, NULL), ^(bool granted, CFErrorRef error) {
                if (granted) {
                    [self presentViewController:pNC animated:YES completion:nil];
                } else
                    [SVProgressHUD showErrorWithStatus:@"请打开访问权限"];
                
            });
            
//            ABAddressBookRequestAccessWithCompletion(self.addressBookRef, ^(bool granted, CFErrorRef error) {
//                if success {
//                    [self presentViewController:pNC animated:YES completion:nil];
//                    //self.presentViewController(self.contactPicker, animated: true, completion: nil)
//                }
//            }));
            
//            ZLPeoplePickerViewController *vc4 = [[ZLPeoplePickerViewController alloc] init];
//            //vc4.filedMask = ZLContactFieldAll;
//            vc4.title = @"联系人";
//            vc4.allowAddPeople = NO;
//            vc4.numberOfSelectedPeople = ZLNumSelectionNone;
//            vc4.delegate = self;
//            [self.navigationController pushViewController:vc4 animated:YES];
//            [self presentViewController:vc4 animated:YES completion:^{
//                
//            }];
        }];
        view;
    });
    
    self.moneyChooseView = [[MobileRechargeMoneyView alloc] initWithTitleArr:@[@"30", @"50", @"100", @"300",]];
    self.moneyChooseView.chooseCallBack = ^(NSString *chooseStr){
    
        mMoneyStr = chooseStr;
    };
    [superView addSubview:_moneyChooseView];
    
    UIButton *btn11 = [superView newUIButton];
    [btn11 setTitle:@"确认充值" forState:UIControlStateNormal];
    [btn11 setStyleNavColor];
    [btn11 jk_addActionHandler:^(NSInteger tag) {
        
        if (![Util isMobileNumber:_mobileField.text]) {
            [self showErrorStatus:@"请选择您要充值的手机号码！"];
            [_mobileField becomeFirstResponder];
            return ;
        }
        
        if (mMoneyStr.length <= 0) {
            [self showErrorStatus:@"请选择您要充值的金额！"];
            return ;
        }
        
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        NSString *spec = [_item getCustomSpecWithMoney:[mMoneyStr floatValue]];
        
        NSMutableArray *mPayArr = [NSMutableArray new];
        NSMutableDictionary *mPara = [NSMutableDictionary new];
        [mPara setObject:_item.odrg_pro_name forKey:@"odrg_pro_name"];
        [mPara setObject:spec forKey:@"odrg_spec"];
        [mPara setObject:mMoneyStr forKey:@"odrg_price"];
        [mPara setObject:_mobileField.text forKey:@"mobile"];
        [mPayArr addObject:mPara];
        
        [SVProgressHUD showWithStatus:@"加载中"];
        [[APIClient sharedClient] ZLCommitOrder:kOrderClassType_fee_mobile andShopId:nil andGoods:[Util arrToJson:mPayArr] andSendAddress:nil andArriveAddress:nil andServiceTime:nil andSendType:0 andSendPrice:nil andCoupId:nil andRemark:nil andSign:_item.sign block:^(APIObject *mBaseObj, ZLCreateOrderObj *mOrder) {
            if (mBaseObj.code == RESP_STATUS_YES) {
                ZLGoPayViewController *vc = [ZLGoPayViewController new];
                vc.mOrder = mOrder;
                vc.mOrder.sign = _item.sign;
                vc.mOrderType = kOrderClassType_fee_mobile;

                vc.paySuccessCallBack = ^(ZLGoPayViewController *payVC){
                    [payVC performSelector:@selector(popViewController_2) withObject:nil afterDelay:0.2];
                };
                [self.navigationController pushViewController:vc animated:YES];
                
                [self showSuccessStatus:mBaseObj.msg];
            } else
                [self showErrorStatus:mBaseObj.msg];
        }];
        
    }];
    
    [aView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(superView).offset(@64);
        make.height.equalTo(60);
    }];
    [self.moneyChooseView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(aView.bottom).offset(padding);
    }];
    [btn11 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(padding);
        make.right.equalTo(superView.right).offset(-padding);
        make.top.equalTo(_moneyChooseView.bottom).offset(50);
        make.height.equalTo(50);
    }];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"缴费记录" style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
        FeePayHistoryVC *vc = [[FeePayHistoryVC alloc] init];
        vc.orderType = kOrderClassType_fee_mobile;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机充值";
    mMoneyStr = nil;
//    _addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
//    [ZLPeoplePickerViewController initializeAddressBook];
    
    
    [SVProgressHUD showWithStatus:@"正在验证..."];
    [[APIClient sharedClient] preOrderMobileWithTag:self call:^(PreApplyObject *item, APIObject *info) {
        if (info.code==RESP_STATUS_YES && item!=nil) {
            self.item = item;
            [SVProgressHUD showSuccessWithStatus:@"验证成功"];
        } else {
            [SVProgressHUD showErrorWithStatus:info.msg];
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
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

#pragma mark - ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    [self setSelectedPerson:person identifier:identifier];
//    
//    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
//    
//    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
//    
//    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
//    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    NSLog(@"%@", phoneNO);
//    if (phone && phoneNO.length == 11) {
//        self.mobileField.text = phoneNO;
//        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//        return;
//    }else{
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误提示" message:@"请选择正确手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
//    }
}


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0)
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    
    [peoplePicker pushViewController:personViewController animated:YES];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}



- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person NS_DEPRECATED_IOS(2_0, 8_0)
{
    return YES;
}



- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier NS_DEPRECATED_IOS(2_0, 8_0)
{
    return [self setSelectedPerson:person identifier:identifier];
}


-(BOOL)setSelectedPerson:(ABRecordRef)person identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
    if ([phoneNO jk_isMobileNumber]) {
        self.mobileField.text = phoneNO;
        return NO;
    } else
        [SVProgressHUD showErrorWithStatus:@"请选择正确手机号"];
    
    return YES;
}

@end
