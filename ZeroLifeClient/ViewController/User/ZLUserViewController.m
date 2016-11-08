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
#import <JKCategories/UIButton+JKImagePosition.h>
#import "CustomBtnView.h"

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
        height = 100;
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
            UIView *superView = cell.contentView;
            int padding = 10;
            UIColor *color = [UIColor colorWithWhite:0.2 alpha:1];
            UIFont *font = [UIFont systemFontOfSize:14];
            UILabel *lable = [superView newUILableWithText:@"我的订单" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:15]];
            CustomBtnView *btn1 = [CustomBtnView initWithTag:11 title:@"购物订单" img:IMG(@"gouwu_order.png")];
            CustomBtnView *btn2 = [CustomBtnView initWithTag:11 title:@"报修订单" img:IMG(@"gouwu_order.png")];
            CustomBtnView *btn3 = [CustomBtnView initWithTag:11 title:@"干洗订单" img:IMG(@"gouwu_order.png")];
            CustomBtnView *btn4 = [CustomBtnView initWithTag:11 title:@"跑腿订单" img:IMG(@"gouwu_order.png")];
            [superView addSubview:btn1];
            [superView addSubview:btn2];
            [superView addSubview:btn3];
            [superView addSubview:btn4];
//            UIButton *btn1 = [superView newUIButton];
//            UIButton *btn2 = [superView newUIButton];
//            UIButton *btn3 = [superView newUIButton];
//            UIButton *btn4 = [superView newUIButton];
//            //btn1.backgroundColor = [UIColor redColor];
//            [btn1 setTitle:@"购物订单" forState:UIControlStateNormal];
//            [btn2 setTitle:@"报修订单" forState:UIControlStateNormal];
//            [btn3 setTitle:@"干洗订单" forState:UIControlStateNormal];
//            [btn4 setTitle:@"跑腿订单" forState:UIControlStateNormal];
//            btn1.titleLabel.font = font;
//            btn2.titleLabel.font = font;
//            btn3.titleLabel.font = font;
//            btn4.titleLabel.font = font;
//            [btn1 setTitleColor:color forState:UIControlStateNormal];
//            [btn2 setTitleColor:color forState:UIControlStateNormal];
//            [btn3 setTitleColor:color forState:UIControlStateNormal];
//            [btn4 setTitleColor:color forState:UIControlStateNormal];
//            [btn1 setImage:IMG(@"gouwu_order.png") forState:UIControlStateNormal];
//            [btn2 setImage:IMG(@"gouwu_order.png") forState:UIControlStateNormal];
//            [btn3 setImage:IMG(@"gouwu_order.png") forState:UIControlStateNormal];
//            [btn4 setImage:IMG(@"gouwu_order.png") forState:UIControlStateNormal];
//            [btn1 jk_setImagePosition:LXMImagePositionTop spacing:5];
//            [btn2 jk_setImagePosition:LXMImagePositionTop spacing:5];
//            [btn3 jk_setImagePosition:LXMImagePositionTop spacing:5];
//            [btn4 jk_setImagePosition:LXMImagePositionTop spacing:5];
            [lable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(superView.left).offset(padding);
                make.right.equalTo(superView.right).offset(-padding);
                make.top.equalTo(superView.top);
                make.height.equalTo(40);
            }];
            [btn1 makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lable.left);
                make.top.equalTo(lable.bottom);
                make.height.equalTo(60);
            }];
            [btn2 makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(btn1.right);
                make.top.bottom.width.equalTo(btn1);
            }];
            [btn3 makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(btn2.right);
                make.top.bottom.width.equalTo(btn1);
            }];
            [btn4 makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(btn3.right);
                make.right.equalTo(lable.right);
                make.top.bottom.width.equalTo(btn1);
            }];
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
