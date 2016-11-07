//
//  UserInfoVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserInfoVC.h"
#import "NSObject+PickPhoto.h"
#import "UserHouseEditVC.h"

@interface UserInfoVC ()

@end

@implementation UserInfoVC
-(void)loadView
{
    [super loadView];
    
    [self addTableViewWithStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"个人信息";
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
        return row = 3;
    else if (section == 1)
        return row = 2;

    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
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
    static NSString *CellIdentifier = @"SystemSettingViewControllerTableViewCell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        UIView *superView = cell.contentView;
        int padding = 10;
        UIImageView *imgView = [superView newUIImageView];
        UILabel *textLable = [superView newUILableWithText:@"" textColor:[UIColor colorWithWhite:0.4 alpha:1] font:[UIFont systemFontOfSize:14]];
        UITextField *field = [superView newUITextField];
        field.textAlignment = NSTextAlignmentRight;
        imgView.tag = 11;
        textLable.tag = 12;
        field.tag = 13;
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.width.height.equalTo(20);
            make.centerY.equalTo(superView.centerY);
        }];
        [textLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.right).offset(padding);
            make.top.bottom.equalTo(superView);
            make.width.equalTo(80);
        }];
        [field makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(textLable.right).offset(padding/2);
            make.top.bottom.equalTo(superView);
            make.right.equalTo(superView.right).offset(-padding);
        }];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:11];
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:12];
    UITextField *field = (UITextField *)[cell.contentView viewWithTag:13];
    field.hidden = NO;
    field.enabled = YES;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                imgView.image = IMG(@"ZLSearch_gray.png");
                textLabel.text = @"头像";
                field.hidden = YES;
            {
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                imgView.image = IMG(@"ZLSearch_gray.png");
                cell.accessoryView = imgView;
            }
                break;
            case 1:
                
                imgView.image = IMG(@"ZLSearch_gray.png");
                textLabel.text = @"昵称";
                field.placeholder = @"请输入昵称";
                break;
            case 2:
                imgView.image = IMG(@"ZLSearch_gray.png");
                textLabel.text = @"性别";
                field.placeholder = @"请选择性别";
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                imgView.image = IMG(@"ZLSearch_gray.png");
                textLabel.text = @"电话";
                field.placeholder = @"请输入联系电话";
                break;
            case 1:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                imgView.image = IMG(@"ZLSearch_gray.png");
                textLabel.text = @"房屋地址";
                field.placeholder = @"请添加房屋地址";
                field.enabled = NO;
                break;
            default:
                break;
        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self startChoosePhotoCall:^(UIImage *img) {
                
            }];
        }
    } else {
        if (indexPath.row == 1) {
            UserHouseEditVC *vc = [[UserHouseEditVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}



@end
