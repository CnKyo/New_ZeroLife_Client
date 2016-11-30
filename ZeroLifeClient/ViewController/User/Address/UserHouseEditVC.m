//
//  UserHouseEditVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserHouseEditVC.h"
#import "UserHouseEditTableViewCell.h"
#import "ZLSelectedCityViewController.h"
#import "APIObjectDefine.h"
#import "ZLSelectArearViewController.h"

@interface UserHouseEditVC ()<UITextFieldDelegate,UserHouseEditTableViewCellDelegate>
@property(nonatomic,strong) UserHouseEditTableViewCell *customCell;
@end

@implementation UserHouseEditVC

-(void)loadView
{
    [super loadView];
    
    [self addTableViewWithStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UserHouseEditTableViewCell jk_nib] forCellReuseIdentifier:[UserHouseEditTableViewCell reuseIdentifier]];

    UIView *footerView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 100)];
        UIButton *btn11 = [view newUIButton];
        btn11.frame = CGRectMake(10, 30, view.bounds.size.width-20, 50);
        [btn11 setTitle:@"确定" forState:UIControlStateNormal];
        [btn11 setStyleNavColor];
        [btn11 jk_addActionHandler:^(NSInteger tag) {
            [[IQKeyboardManager sharedManager] resignFirstResponder];
            
            if (_item.real_owner.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入联系人姓名"];
                return ;
            }
            
            if (_item.real_phone.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入联系电话"];
                return ;
            }
            
            if (_item.real_province==0 || _item.real_city==0 || _item.real_county==0) {
                [SVProgressHUD showErrorWithStatus:@"请选择省市区"];
                return ;
            }
            
            if (_item.cmut_id == 0) {
                [SVProgressHUD showErrorWithStatus:@"请先选择小区"];
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
        self.title =  @"添加房屋";
        self.item = [HouseObject new];
        self.item.real_sex = kUserSexType_man;
    } else {
        self.title =  @"编辑房屋";
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    ZLSeletedAddress *mAddressObj = [ZLSeletedAddress ShareClient];
    if (mAddressObj.mProvinceStr.length > 0) {
        self.customCell.areaField.text = [mAddressObj getAddress];
        
        self.item.real_province = mAddressObj.mProvince;
        self.item.real_city = mAddressObj.mCity;
        self.item.real_county = mAddressObj.mArear;
        
        [ZLSeletedAddress destory];
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
    if (textField == _customCell.realNameField) {
        self.item.real_owner = textField.text;
    }
    else if (textField == _customCell.mobileField) {
        self.item.real_phone = textField.text;
    }
    else if (textField == _customCell.addressField) {
        self.item.real_add_time = textField.text;
    }
}

#pragma mark -- tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 325;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserHouseEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserHouseEditTableViewCell reuseIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.realNameField.delegate = self;
    cell.mobileField.delegate = self;
    cell.addressField.delegate = self;
    cell.delegate = self;
    [cell reloadSexUI:_item.real_sex];
    
    //选择地区
    [cell.areaView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        ZLSelectedCityViewController *vc = [ZLSelectedCityViewController new];
        vc.mType = 0;
        [self pushViewController:vc];
    }];
    
    //选择小区
    [cell.xiaoquView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (_item.real_province==0 || _item.real_city==0 || _item.real_county==0) {
            [SVProgressHUD showErrorWithStatus:@"请先选择省市区"];
            return ;
        }
        
        ZLSelectArearViewController *vc = [ZLSelectArearViewController new];
        vc.block = ^(ZLHomeCommunity *mBlock){
            self.item.cmut_id = mBlock.cmut_id;
            self.item.real_cmut_name = mBlock.cmut_name;
            cell.xiaoquField.text = mBlock.cmut_name;
        };
        ZLHomeCommunity *at = [ZLHomeCommunity new];
        at.cmut_province = _item.real_province;
        at.cmut_city = _item.real_city;
        at.cmut_county = _item.real_county;
        vc.mCommunityAdd = at;
        [self pushViewController:vc];
    }];
    
    [cell.addressView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (_item.real_province==0 || _item.real_city==0 || _item.real_county==0) {
            [SVProgressHUD showErrorWithStatus:@"请先选择省市区"];
            return ;
        }
        if (_item.cmut_id == 0) {
            [SVProgressHUD showErrorWithStatus:@"请先选择小区"];
            return ;
        }
        
        [SVProgressHUD showWithStatus:@"加载中..."];
        [[APIClient sharedClient] communityBansetListWithTag:self cmut_id:_item.cmut_id call:^(NSArray *tableArr, APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                
                [SVProgressHUD showSuccessWithStatus:info.msg];
            } else
                [SVProgressHUD showErrorWithStatus:info.msg];
        }];
    }];
    
    [cell.sexManBtn jk_addActionHandler:^(NSInteger tag) {
        self.item.real_sex = kUserSexType_man;
        [cell reloadSexUI:_item.real_sex];
    }];
    [cell.sexWomanBtn jk_addActionHandler:^(NSInteger tag) {
        self.item.real_sex = kUserSexType_woman;
        [cell reloadSexUI:_item.real_sex];
    }];
    
    self.customCell = cell;
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}






@end
