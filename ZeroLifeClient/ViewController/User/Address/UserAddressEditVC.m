//
//  UserAddressEditVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserAddressEditVC.h"
#import "UserAddressEditTableViewCell.h"
#import "ZLSelectedCityViewController.h"
#import "APIObjectDefine.h"

@interface UserAddressEditVC ()<UITextFieldDelegate,UserAddressEditTableViewCellDelegate>
@property(nonatomic,strong) UserAddressEditTableViewCell *customCell;
@end

@implementation UserAddressEditVC

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    ZLSeletedAddress *mAddressObj = [ZLSeletedAddress ShareClient];
    
    if (mAddressObj.mProvinceStr.length) {
        self.navigationItem.title = mAddressObj.mProvinceStr;
    }
}

-(void)loadView
{
    [super loadView];
    
    [self addTableViewWithStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UserAddressEditTableViewCell jk_nib] forCellReuseIdentifier:[UserAddressEditTableViewCell reuseIdentifier]];

    UIView *footerView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 80)];
        UIButton *btn11 = [view newUIButton];
        btn11.frame = CGRectMake(10, 30, view.bounds.size.width-20, 50);
        [btn11 setTitle:@"确认" forState:UIControlStateNormal];
        [btn11 setStyleNavColor];
        [btn11 jk_addActionHandler:^(NSInteger tag) {
            [[IQKeyboardManager sharedManager] resignFirstResponder];
            
            if (_item.consignee.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入收货联系人"];
                return ;
            }
            
            if (_item.mobile.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入联系电话"];
                return ;
            }
            
            if (_item.address.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入详细地址"];
                return ;
            }
        }];
        view;
    });
    self.tableView.tableFooterView = footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (_item == nil) {
        self.title =  @"添加地址";
        self.item = [AddressObject new];
        self.item.sex = kUserSexType_man;
    } else {
        self.title =  @"编辑地址";
    }
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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _customCell.consigneeField) {
        self.item.consignee = textField.text;
    }
    else if (textField == _customCell.mobileField) {
        self.item.mobile = textField.text;
    }
    else if (textField == _customCell.addressField) {
        self.item.address = textField.text;
    }
}

#pragma mark -- tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 330;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserAddressEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserAddressEditTableViewCell reuseIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.consigneeField.delegate = self;
    cell.mobileField.delegate = self;
    cell.addressField.delegate = self;
    cell.delegate = self;
    [cell reloadSexUI:_item.sex];

    [cell.sexManBtn jk_addActionHandler:^(NSInteger tag) {
        self.item.sex = kUserSexType_man;
        [cell reloadSexUI:_item.sex];
    }];
    [cell.sexWomanBtn jk_addActionHandler:^(NSInteger tag) {
        self.item.sex = kUserSexType_woman;
        [cell reloadSexUI:_item.sex];
    }];
    
    self.customCell = cell;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}



- (void)UserAddressEditTableViewCellSelectedCityClicked{

    
    ZLSeletedAddress *mJumpObj = [ZLSeletedAddress ShareClient];
    mJumpObj.mProvinceStr = @"选择省市区";
    
    ZLSelectedCityViewController *vc = [ZLSelectedCityViewController new];
    vc.mTitle = @"选择省市区";
    vc.mType = 1;
 
    [self pushViewController:vc];
}

@end
