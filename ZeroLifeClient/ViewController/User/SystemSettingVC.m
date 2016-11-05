//
//  SystemSettingVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "SystemSettingVC.h"

@interface SystemSettingVC ()

@end

@implementation SystemSettingVC

-(void)loadView
{
    [super loadView];
    
    [self addTableViewWithStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"设置";
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
    return 4;
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
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SystemSettingViewControllerTableViewCell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = IMG(@"ZLSearch_gray.png");
            cell.textLabel.text = @"清除图片缓存";
            break;
        case 1:
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.imageView.image = IMG(@"ZLSearch_gray.png");
            cell.textLabel.text = @"消息通知";
        {
            UISwitch *swi = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            cell.accessoryView = swi;
        }
            break;
        case 2:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = IMG(@"ZLSearch_gray.png");
            cell.textLabel.text = @"关于零生活";
            break;
        case 3:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = IMG(@"ZLSearch_gray.png");
            cell.textLabel.text = @"使用帮助";
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
