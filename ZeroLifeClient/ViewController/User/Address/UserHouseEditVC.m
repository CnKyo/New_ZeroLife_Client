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
@property(nonatomic,strong) NSMutableArray *banArr;
@end

@implementation UserHouseEditVC

-(id)init
{
    self = [super init];
    if (self) {
        self.banArr = [NSMutableArray array];
    }
    return self;
}



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
            
            if (![Util isMobileNumber:_item.real_phone]) {
                [SVProgressHUD showErrorWithStatus:@"您输入的手机号码有误！请重新输入！"];
                return;
            }
            
            if (_item.real_province==0 || _item.real_city==0 || _item.real_county==0) {
                [SVProgressHUD showErrorWithStatus:@"请选择省市区"];
                return ;
            }
            
            if (_item.cmut_id == 0) {
                [SVProgressHUD showErrorWithStatus:@"请先选择小区"];
                return ;
            }
            
            [SVProgressHUD showWithStatus:@"处理中..."];
            [[APIClient sharedClient] houseInfoEditWithTag:self postItem:_item is_default:_customCell.defaultAddressSwitch.on call:^(APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:MyUserAddressNeedUpdateNotification object:nil];
                    
                    [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
                    [SVProgressHUD showSuccessWithStatus:info.msg];
                } else
                    [SVProgressHUD showErrorWithStatus:info.msg];
            }];
        }];
        view;
    });
    self.tableView.tableFooterView = footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.title==nil || self.title.length == 0) {
        if (_item == nil) {
            self.title =  @"添加房屋";
            self.item = [HouseObject new];
            self.item.user_id = [ZLUserInfo ZLCurrentUser].user_id;
            self.item.real_sex = kUserSexType_man;
        } else {
            self.title =  @"编辑房屋";
        }
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
        
        [self clearnCommunityData];
        
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

- (void)noticeTextFieldTextDidBeginEditing:(NSNotification *)note
{
    BanUnitFloorNumberTextField *textField = note.object;
   
    if (_item.real_province==0 || _item.real_city==0 || _item.real_county==0) {
        [SVProgressHUD showErrorWithStatus:@"请先选择省市区"];
        [textField resignFirstResponder];
        return ;
    }
    if (_item.cmut_id == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先选择小区"];
        [textField resignFirstResponder];
        return ;
    }
    
    
    [self reloadBanData];
}


-(void)clearnCommunityData
{
    self.item.cmut_id = 0;
    self.item.real_cmut_name = nil;
    self.customCell.xiaoquField.text = nil;
    [self clearnBanData];
}

-(void)clearnBanData
{
    [self.banArr removeAllObjects];
    
    self.item.real_ban = 0;
    self.item.real_unit = 0;
    self.item.real_floor = 0;
    self.item.real_number = 0;
    
    self.customCell.addressField.text = nil;
    self.customCell.addressField.dataArr = nil;
}

-(void)reloadBanData
{
    if (_banArr.count == 0) {
        [self.customCell.addressField resignFirstResponder];
        
        [SVProgressHUD showWithStatus:@"楼栋信息加载中..."];
        [[APIClient sharedClient] communityBansetListWithTag:self cmut_id:_item.cmut_id call:^(NSArray *tableArr, APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                [self.banArr setArray:tableArr];
                self.customCell.addressField.dataArr = _banArr;
                
                [SVProgressHUD showSuccessWithStatus:info.msg];
            } else
                [SVProgressHUD showErrorWithStatus:info.msg];
        }];
        
    } else
        self.customCell.addressField.dataArr = _banArr;
}


#pragma mark -- tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
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
    cell.realNameField.text = _item.real_owner;
    cell.mobileField.text = _item.real_phone;
    cell.xiaoquField.text = _item.real_cmut_name;
    cell.areaField.text = [_item getProvinceCityCountyStr];
    cell.addressField.text = [_item getBanUnitFloorNumberStr];
    
    HouseObject *defultItem = [HouseObject defaultAddress];
    cell.defaultAddressSwitch.on = _item.real_id==defultItem.real_id ? YES : NO;
    
    
    //选择地区
    [cell.areaView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        ZLSelectedCityViewController *vc = [ZLSelectedCityViewController new];
        vc.mType = 0;
        [self pushViewController:vc];
    }];
    
    //选择小区
    [cell.xiaoquView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        
        if (_item.real_province==0 || _item.real_city==0 || _item.real_county==0) {
            [SVProgressHUD showErrorWithStatus:@"请先选择省市区"];
            return ;
        }
        
        ZLSelectArearViewController *vc = [ZLSelectArearViewController new];
        vc.block = ^(CommunityObject *mBlock){
            self.item.cmut_id = mBlock.cmut_id;
            self.item.real_cmut_name = mBlock.cmut_name;
            cell.xiaoquField.text = mBlock.cmut_name;
            
            //重新加载楼栋信息
            [self clearnBanData];
            [self reloadBanData];
        };
        CommunityObject *at = [CommunityObject new];
        at.cmut_province = _item.real_province;
        at.cmut_city = _item.real_city;
        at.cmut_county = _item.real_county;
        vc.mCommunityAdd = at;
        [self pushViewController:vc];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeTextFieldTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:cell.addressField];
    
    cell.addressField.callBack = ^(NSString *currentText, int ban, int unit, int floor, int number) {
        self.item.real_ban = ban;
        self.item.real_unit = unit;
        self.item.real_floor = floor;
        self.item.real_number = number;
    };
    
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
