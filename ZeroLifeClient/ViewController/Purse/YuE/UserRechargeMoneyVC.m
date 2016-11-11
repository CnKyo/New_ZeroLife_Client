//
//  UserRechargeMoneyVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserRechargeMoneyVC.h"

@interface UserRechargeMoneyVC ()

@end

@implementation UserRechargeMoneyVC

-(void)loadView
{
    [super loadView];
    [self addTableViewWithStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
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
    return 2;
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
        }
        return cell;
        
    } else {
        static NSString *CellIdentifier = @"SystemSettingViewControllerTableViewCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;

        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

}

@end
