//
//  SecurityPasswordDoneTVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2017/1/17.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "SecurityPasswordDoneTVC.h"
#import "SecurityPasswordComplainVC.h"

@interface SecurityPasswordDoneTVC ()

@end

@implementation SecurityPasswordDoneTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全密码";
    
    [self addTableViewWithStyleGrouped];
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
    return 1;
}

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
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SystemSettingViewControllerTableViewCell1111";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        UIFont *font = [UIFont systemFontOfSize:15];
        cell.textLabel.font = font;
        cell.detailTextLabel.font = font;
        
//        UIView *superView = cell.contentView;
//        int padding = 10;
//        UIFont *font = [UIFont systemFontOfSize:14];
//        UIImageView *imgView = [superView newUIImageView];
//        UILabel *textLable = [superView newUILableWithText:@"" textColor:[UIColor colorWithWhite:0.4 alpha:1] font:font];
//        UITextField *field = [superView newUITextField];
//        field.textAlignment = NSTextAlignmentRight;
//        field.font = font;
//        imgView.tag = 11;
//        textLable.tag = 12;
//        field.tag = 13;
//        [imgView makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(superView.left).offset(padding);
//            make.width.height.equalTo(20);
//            make.centerY.equalTo(superView.centerY);
//        }];
//        [textLable makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(imgView.right).offset(padding);
//            make.top.bottom.equalTo(superView);
//            make.width.equalTo(80);
//        }];
//        [field makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(textLable.right).offset(padding/2);
//            make.top.bottom.equalTo(superView);
//            make.right.equalTo(superView.right).offset(-padding);
//        }];
    }
    
    cell.imageView.image = IMG(@"anquantishi.png");
    cell.textLabel.text = @"已保护";
    cell.detailTextLabel.text = @"申请重置";
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section==0 && indexPath.row==0) {
        SecurityPasswordComplainVC *vc = [[SecurityPasswordComplainVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
