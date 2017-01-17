//
//  SecurityPasswordComplainVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2017/1/17.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "SecurityPasswordComplainVC.h"
#import "SecurityPasswordComplainTableViewCell.h"
@interface SecurityPasswordComplainVC ()
@property(nonatomic,strong) SecurityPasswordComplainTableViewCell *customCell;
@end

@implementation SecurityPasswordComplainVC

-(void)loadView
{
    [super loadView];
    
    [self addTableViewWithStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[SecurityPasswordComplainTableViewCell jk_nib] forCellReuseIdentifier:[SecurityPasswordComplainTableViewCell reuseIdentifier]];
    
    UIView *footerView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 80)];
        UIButton *btn11 = [view newUIButton];
        btn11.frame = CGRectMake(10, 30, view.bounds.size.width-20, 50);
        [btn11 setTitle:@"确认提交" forState:UIControlStateNormal];
        [btn11 setStyleNavColor];
        [btn11 jk_addActionHandler:^(NSInteger tag) {
            [[IQKeyboardManager sharedManager] resignFirstResponder];
            
            if (_customCell.mobileField.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入联系电话"];
                return ;
            }
            
            if (![Util isMobileNumber:_customCell.mobileField.text]) {
                [SVProgressHUD showErrorWithStatus:@"您输入的手机号码有误！请重新输入！"];
                return;
            }
            
            if (_customCell.idField.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入您的身份证号"];
                return ;
            }
            if (![Util checkIdentityCardNo:_customCell.idField.text]) {
                [SVProgressHUD showErrorWithStatus:@"您输入的身份证号有误！请重新输入！"];
                return;
            }
            
            if (_customCell.pwdField.text.length==0) {
                [SVProgressHUD showErrorWithStatus:@"请输入登录密码"];
                return ;
            }

#warning 接口不是正确的，未测试
            [SVProgressHUD showWithStatus:@"处理中..."];
            [[APIClient sharedClient] userSecurityPasswordCompalainWithTag:self mobile:_customCell.mobileField.text idCard:_customCell.idField.text acc_pass:_customCell.pwdField.text call:^(APIObject *info) {
                if (info.code == RESP_STATUS_YES) {
                    //[[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil];
                    
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
    self.title = @"安全密码";
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 152;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecurityPasswordComplainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SecurityPasswordComplainTableViewCell reuseIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.customCell = cell;
    return cell;
    
}

@end
