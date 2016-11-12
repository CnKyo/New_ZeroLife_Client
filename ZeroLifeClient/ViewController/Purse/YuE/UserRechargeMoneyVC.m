//
//  UserRechargeMoneyVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserRechargeMoneyVC.h"
#import "UserPayTypeTableViewCell.h"

@interface UserRechargeMoneyVC ()

@end

@implementation UserRechargeMoneyVC

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
