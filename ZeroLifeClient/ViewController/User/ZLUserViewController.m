//
//  ZLUserViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLUserViewController.h"
#import "SystemSettingVC.h"
#import "UserInfoVC.h"
#import "ZLUserHeaderTableViewCell.h"
#import "UserIDAuthVC.h"
#import "UserAddressTVC.h"
#import "UserPaoPaoRegisterVC.h"
#import "UserComplaintAddVC.h"

@interface ZLUserViewController ()

@end

@implementation ZLUserViewController

-(void)loadView
{
    [super loadView];
    
    
    [self addTableViewWithStyleGrouped];
    [self.tableView registerNib:[ZLUserHeaderTableViewCell jk_nib] forCellReuseIdentifier:[ZLUserHeaderTableViewCell reuseIdentifier]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:IMG(@"ZLSearch_gray.png") style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
        SystemSettingVC *vc = [[SystemSettingVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar.subviews[2] setHidden:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage jk_imageWithColor:COLOR_NavBar] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    

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
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if (section == 2)
        row = 4;
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 50;
    if (indexPath.section == 0)
        height = 230;
    else if (indexPath.section == 1)
        height = 150;
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        ZLUserHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZLUserHeaderTableViewCell reuseIdentifier]];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.paopaoRegisterView.hidden = NO;
        cell.paopaoInfoView.hidden = YES;
        
        [cell.paopaoRegisterView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            UserPaoPaoRegisterVC *vc = [[UserPaoPaoRegisterVC alloc] initWithNibName:@"UserPaoPaoRegisterVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        return cell;
        
    } else if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"ZLUserViewControllerTableViewCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
        }
        return cell;
        
    } else {
        static NSString *CellIdentifier = @"ZLUserViewControllerTableViewCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = IMG(@"ZLSearch_gray.png");
                cell.textLabel.text = @"我的收藏";
                break;
            case 1:
                cell.imageView.image = IMG(@"ZLSearch_gray.png");
                cell.textLabel.text = @"地址管理";
                break;
            case 2:
                cell.imageView.image = IMG(@"ZLSearch_gray.png");
                cell.textLabel.text = @"投诉建议";
                break;
            default:
                break;
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        UserInfoVC *vc = [[UserInfoVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UserIDAuthVC *vc = [[UserIDAuthVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if (indexPath.row == 1) {
            UserAddressTVC *vc = [[UserAddressTVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if (indexPath.row == 2) {
            UserComplaintAddVC *vc = [[UserComplaintAddVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
}



@end
