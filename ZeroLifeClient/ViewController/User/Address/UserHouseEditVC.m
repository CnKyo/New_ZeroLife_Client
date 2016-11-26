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
            
            if (_item.real_name.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入联系人姓名"];
                return ;
            }
            
            if (_item.mobile.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入联系电话"];
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
        self.item.sex = kUserSexType_man;
    } else {
        self.title =  @"编辑房屋";
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
        self.item.real_name = textField.text;
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

- (void)UserHouseEditTableViewCellSelectedCityBtnClicked{

    ZLSelectedCityViewController *vc = [ZLSelectedCityViewController new];
    vc.mTitle = @"选择省市区";
    vc.mType = 1;
   
    [self pushViewController:vc];
    
}





@end
