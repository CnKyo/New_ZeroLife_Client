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

@interface ZLUserViewController ()

@end

@implementation ZLUserViewController

-(void)loadView
{
    [super loadView];
    
    [self addTableViewWithStyleGrouped];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:IMG(@"ZLSearch_gray.png") style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
        SystemSettingVC *vc = [[SystemSettingVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"我的";
    
    [self.navigationController.navigationBar.subviews[2] setHidden:YES];

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
        height = 150;
    else if (indexPath.section == 1)
        height = 150;
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ZLUserViewControllerTableViewCell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
        
    } else if (indexPath.section == 2) {
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
                cell.textLabel.text = @"我的二维码名片";
                break;
            case 3:
                cell.imageView.image = IMG(@"ZLSearch_gray.png");
                cell.textLabel.text = @"投诉建议";
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
    

}



@end
