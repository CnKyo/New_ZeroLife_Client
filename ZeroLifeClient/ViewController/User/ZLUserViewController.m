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
#import "UserComplaintUpVC.h"
#import <JKCategories/UIButton+JKImagePosition.h>
#import "CustomBtnView.h"
#import "FavoriteTVC.h"
#import "OrderTVC.h"
#import "ZLLoginViewController.h"
#import <UINavigationBar+Awesome.h>

#import "ZLLoginViewController.h"
#import "ZLLoginViewController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

#import "WebTestVC.h"
#import "UserPaoPaoApplyVC.h"

#define NAVBAR_CHANGE_POINT 30

@interface ZLUserViewController ()<QUItemBtnViewDelegate>

@end

@implementation ZLUserViewController

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableViewWithStyleGrouped];
    [self setTableViewHaveHeader];
    
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.top).offset(-NAVBAR_Height-1);
    }];
    
    [self.tableView registerNib:[ZLUserHeaderTableViewCell jk_nib] forCellReuseIdentifier:[ZLUserHeaderTableViewCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:IMG(@"itemBar_setting.png") style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
        SystemSettingVC *vc = [[SystemSettingVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.navigationController.navigationBar.subviews[2] setHidden:YES];
    
    

    //[[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil]; //更新一下用户数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserInfoChange:) name:MyUserInfoChangedNotification object:nil];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 1)];
    self.tableView.tableHeaderView = view;
    [self.tableView reloadData];
    
    //__weak __typeof(self)weakSelf = self;
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user != nil) {
        UIView *footerView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 70)];
            UIButton *btn11 = [view newUIButton];
            btn11.frame = CGRectMake(10, 10, view.bounds.size.width-20, 50);
            [btn11 setTitle:@"退出登陆" forState:UIControlStateNormal];
            [btn11 setStyleNavColor];
            
            [btn11 jk_addActionHandler:^(NSInteger tag) {
                
                [SVProgressHUD showWithStatus:@"退出中..."];
                [[APIClient sharedClient] userLoginOutWithTag:self call:^(APIObject *info) {
                    if (info.code == RESP_STATUS_YES) {
                        [SVProgressHUD dismiss];
                        
                        [ZLUserInfo logOut];
                        [ZLLoginViewController startPresent:self];
                    } else
                        [SVProgressHUD showErrorWithStatus:info.msg];
                }];

            }];
            view;
        });
        self.tableView.tableFooterView = footerView;
    } else
        self.tableView.tableFooterView = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = M_CO;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    MLLog(@"YYYYY是：%f",offsetY);
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        MLLog(@"Yaaaaaa是：%f",alpha);
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        self.navigationItem.title = @"管家";

    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.navigationItem.title = nil;
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

#pragma mark -- 监测到用户数据修改
-(void)handleUserInfoChange:(NSNotification *)note
{
    [self.tableView reloadData];
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if (section == 2)
        row = 3;
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
        height = 250+NAVBAR_Height;
    else if (indexPath.section == 1)
        height = 120;
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        ZLUserHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZLUserHeaderTableViewCell reuseIdentifier]];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
        
        if (user == nil) { //显示登录ui
            cell.userLoginView.hidden = NO;
            cell.userInfoView.hidden = YES;
        } else {
            cell.userLoginView.hidden = YES;
            cell.userInfoView.hidden = NO;
            
            //设置用户信息
            cell.userNameLable.text = [NSString compIsNone:user.user_nick];
            cell.userMobileLable.text = [NSString compIsNone:user.user_phone];
            NSMutableString *str = [NSMutableString new];
            [str appendString:[NSString strUserSexType:user.user_sex]];
            if (user.user_is_authent == NO)
                [str appendString:@" 未认证"];
            else {
                [str appendString:@" 已认证"];
                if (user.community.cmut_name.length > 0)
                    [str appendFormat:@" %@", user.community.cmut_name];
            }
            cell.userNoteLable.text = str;
            NSURL *url = [NSURL imageurl:user.user_header];
            [cell.userImgView sd_setImageWithURL:url placeholderImage:IMG(@"user_header.png")];

            //判断跑跑信息
            if ([user.openInfo.open_state isEqualToString:kOpenState_CHECKED]) {
                cell.paopaoRegisterView.hidden = YES;
                cell.paopaoInfoView.hidden = NO;
                
                //设置跑跑者信息
                float progress = 0;
                if (user.openInfo.max_experience > 0)
                    progress = (float)user.openInfo.uopen_empiric_val / user.openInfo.max_experience;
                cell.paopaoProgressView.progress = progress;
                cell.paopaoLevelLable.text = [NSString stringWithFormat:@"LV%i", user.openInfo.uopen_rank];
            } else {
                cell.paopaoRegisterView.hidden = NO;
                cell.paopaoInfoView.hidden = YES;
            }
        }
        
        //进入个人信息界面
        [cell.userInfoView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            UserInfoVC *vc = [[UserInfoVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        //进入跑跑腿注册界面
        [cell.paopaoRegisterView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (user.openInfo==nil || [user.openInfo.open_state isEqualToString:kOpenState_NOTOPEN]) {
                UserPaoPaoRegisterVC*vc = [[UserPaoPaoRegisterVC alloc] initWithNibName:@"UserPaoPaoRegisterVC" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            } else if([user.openInfo.open_state isEqualToString:kOpenState_PAYMENTED]) {
                UserPaoPaoApplyVC *vc = [UserPaoPaoApplyVC new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            } else
                [SVProgressHUD showInfoWithStatus:[NSString strDesWithOpenState:user.openInfo.open_state]];
        }];
        
        //进入登录界面
        [cell.userLoginView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [ZLLoginViewController startPresent:self];
        }];


        
        return cell;
        
    } else if (indexPath.section == 1) {
        
        static NSString *CellIdentifier = @"ZLUserViewControllerTableViewCell222";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *superView = cell.contentView;
            int padding = 10;

            UILabel *lable = [superView newUILableWithText:@"我的订单" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:15]];
            CustomBtnView *btn1 = [CustomBtnView initWithTag:11 title:@"购物订单" img:IMG(@"gouwu_order.png")];
            CustomBtnView *btn2 = [CustomBtnView initWithTag:12 title:@"报修订单" img:IMG(@"order_fix.png")];
            CustomBtnView *btn3 = [CustomBtnView initWithTag:13 title:@"干洗订单" img:IMG(@"order_ganxi.png")];
            CustomBtnView *btn4 = [CustomBtnView initWithTag:14 title:@"跑腿订单" img:IMG(@"order_paopao.png")];
            btn1.delegate = self;
            btn2.delegate = self;
            btn3.delegate = self;
            btn4.delegate = self;
            [superView addSubview:btn1];
            [superView addSubview:btn2];
            [superView addSubview:btn3];
            [superView addSubview:btn4];
//            UIColor *color = [UIColor colorWithWhite:0.2 alpha:1];
//            UIFont *font = [UIFont systemFontOfSize:14];
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
        static NSString *CellIdentifier = @"ZLUserViewControllerTableViewCell111";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.textLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = IMG(@"cell_souchang.png");
                cell.textLabel.text = @"我的收藏";
                break;
            case 1:
                cell.imageView.image = IMG(@"cell_address.png");
                cell.textLabel.text = @"地址管理";
                break;
            case 2:
                cell.imageView.image = IMG(@"cell_tousu.png");
                cell.textLabel.text = @"投诉建议";
                break;
            case 3:
                cell.imageView.image = IMG(@"cell_tousu.png");
                cell.textLabel.text = @"网页测试";
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
    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user == nil) {
        [ZLLoginViewController startPresent:self];
        return;
    }
    
    if (indexPath.section == 0) {

        
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            FavoriteTVC *vc = [[FavoriteTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if (indexPath.row == 1) {
            UserAddressTVC *vc = [[UserAddressTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if (indexPath.row == 2) {
            UserComplaintUpVC *vc = [[UserComplaintUpVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if (indexPath.row == 3) {
            //UserPaoPaoApplyVC *vc = [[UserPaoPaoApplyVC alloc] init];
            WebTestVC *vc = [[WebTestVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
}


- (void)reloadTableViewDataSource{
    [super reloadTableViewDataSource];
    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        [[APIClient sharedClient] userInfoWithTag:self call:^(ZLUserInfo *user, APIObject *info) {
            [self.tableView reloadData];
            [self doneLoadingTableViewData];
        }];
    } else
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];

}

- (void)selectItemBtnView:(QUItemBtnView *)view
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user == nil) {
        [ZLLoginViewController startPresent:self];
        return;
    }
    
    OrderTVC *vc = [[OrderTVC alloc] init];
    
    if (view.tag == 11)
        vc.classType = kOrderClassType_product;
    else if (view.tag == 12)
        vc.classType = kOrderClassType_fix;
    else if (view.tag == 13)
        vc.classType = kOrderClassType_dryclean;
    else if (view.tag == 14)
        vc.classType = kOrderClassType_paopao;
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
