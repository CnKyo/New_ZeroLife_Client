//
//  UserInfoVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "UserInfoVC.h"
#import "NSObject+PickPhoto.h"

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
    else if (section == 0)
        return row = 2;

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
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SystemSettingViewControllerTableViewCell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.imageView.image = IMG(@"ZLSearch_gray.png");
                cell.textLabel.text = @"头像";
            {
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                imgView.image = IMG(@"ZLSearch_gray.png");
                cell.accessoryView = imgView;
            }
                break;
            case 1:
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.imageView.image = IMG(@"ZLSearch_gray.png");
                cell.textLabel.text = @"昵称";

                break;
            case 2:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.imageView.image = IMG(@"ZLSearch_gray.png");
                cell.textLabel.text = @"性别";
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.imageView.image = IMG(@"ZLSearch_gray.png");
                cell.textLabel.text = @"电话";
                break;
            case 1:
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.imageView.image = IMG(@"ZLSearch_gray.png");
                cell.textLabel.text = @"房屋地址";
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
        
    }
}



@end
