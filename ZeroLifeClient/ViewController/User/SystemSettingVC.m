//
//  SystemSettingVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "SystemSettingVC.h"
#import <SDImageCache.h>
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
    
    [self.navigationController.navigationBar jk_setBackgroundColor:[UIColor clearColor]];
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
        cell.textLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = IMG(@"cell_cleanImgs.png");
            cell.textLabel.text = @"清除图片缓存";
            break;
        case 1:
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.imageView.image = IMG(@"cell_msgSetting.png");
            cell.textLabel.text = @"消息通知";
        {
            UISwitch *swi = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
            cell.accessoryView = swi;
            ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
            swi.on = user.user_is_notify;
            
            [swi jk_handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
                ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
                BOOL newStatus = !user.user_is_notify;
                [SVProgressHUD showWithStatus:@"修改中..."];
                [[APIClient sharedClient] userPushSettingWithTag:self isOn:newStatus call:^(APIObject *info) {
                    if (info.code == RESP_STATUS_YES) {
                        user.user_is_notify = newStatus;
                        [ZLUserInfo updateUserInfo:user];
                        
                        [SVProgressHUD showSuccessWithStatus:info.msg];
                    } else {
                        swi.on = !newStatus;
                        [SVProgressHUD showErrorWithStatus:info.msg];
                    }
                }];
            }];
        }
            break;
        case 2:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = IMG(@"cell_about.png");
            cell.textLabel.text = @"关于零生活";
            break;
        case 3:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = IMG(@"cell_help.png");
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
    
    if (indexPath.row == 0) {
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [queue addOperationWithBlock:^{
            SDImageCache *cache = [SDImageCache sharedImageCache];
            
            NSUInteger cacheSize = cache.getDiskCount;
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSString *str = [NSString stringWithFormat:@"缓存的大小：(%.2fM)",cacheSize/1000.0/1000.0];
                MLLog(@"%@",str);
            }];
        }];
        
        [[SDImageCache sharedImageCache] clearDisk];
        
        [[SDImageCache sharedImageCache] clearMemory];//可有可无
        
        
    }
    
    
}


@end
