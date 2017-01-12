//
//  ZLPurseViewController.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/10.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLPurseViewController.h"
#import "PlurseValueNameControl.h"

#import <JKCategories/UIButton+JKImagePosition.h>
#import <JKCategories/UIControl+JKActionBlocks.h>

#import "UserScoreYuEVC.h"
#import "UserCouponVC.h"
#import "TransferAccountVC.h"
#import "WithDrawalVC.h"
#import "SouKuanVC.h"
#import "SecurityPasswordVC.h"

#import "SingInView.h"
#import "ZLLoginViewController.h"

#import <UINavigationBar+Awesome.h>


@implementation PurseHeaderView

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIView *superView = self;
        
        UIImageView *bgImgView = [superView newUIImageViewWithImg:IMG(@"qianbao_headerBG.png")];
        
        self.desLable = [superView newUILableWithText:@"累计签到 15天" textColor:[UIColor whiteColor] font:font textAlignment:NSTextAlignmentCenter];
        
        self.singInBtn = [superView newUIButton];
        [self.singInBtn setImage:IMG(@"sigin_qian.png") forState:UIControlStateNormal];
        

        [bgImgView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superView);
        }];
        [self.desLable makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.height.equalTo(30);
            make.left.equalTo(superView.left).offset(padding/2);
            make.right.equalTo(superView.right).offset(-padding/2);
        }];
        [self.singInBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding*3);
            make.bottom.equalTo(_desLable.top);
            make.centerX.equalTo(superView.centerX);
            make.width.equalTo(_singInBtn.height);
        }];
    }
    return self;
}


@end



@interface ZLPurseViewController ()<QUItemBtnViewDelegate>

@property(nonatomic,strong) SingInHeaderView *headerView;
@property(nonatomic,strong) PlurseValueNameControl *userBalanceView;
@property(nonatomic,strong) PlurseValueNameControl *userScoreView;
@property(nonatomic,strong) PlurseValueNameControl *userCouponView;
@end

@implementation ZLPurseViewController


-(void)loadView
{
    [super loadView];
    
    float padding = 10;
    UIView *superView = self.contentView;
    
    //PurseHeaderView *headerView = [[PurseHeaderView alloc] init];
    SingInHeaderView *headerView = [[SingInHeaderView alloc] init];
    //headerView.singView.delegate = self;
    [headerView loadUIWithDay:15];
    [superView addSubview:headerView];
    [headerView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
    }];
    self.headerView = headerView;
    
    UIView *aView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        
        PlurseValueNameControl *yuEView = [[PlurseValueNameControl alloc] init];
        PlurseValueNameControl *jiFenView = [[PlurseValueNameControl alloc] init];
        PlurseValueNameControl *youHuiView = [[PlurseValueNameControl alloc] init];
        [view addSubview:yuEView];
        [view addSubview:jiFenView];
        [view addSubview:youHuiView];
        [yuEView loadName:@"我的余额" value:@"---"];
        [jiFenView loadName:@"我的积分" value:@"---"];
        [youHuiView loadName:@"我的优惠券" value:@"-"];
        self.userBalanceView = yuEView;
        self.userScoreView = jiFenView;
        self.userCouponView = youHuiView;
        
        UIColor *textColor = [UIColor colorWithWhite:0.3 alpha:1];
        UIFont *font = [UIFont systemFontOfSize:16];
        UIButton *btn1 = [superView newUIButton];
        UIButton *btn2 = [superView newUIButton];
        UIButton *btn3 = [superView newUIButton];
        UIButton *btn4 = [superView newUIButton];
        btn1.titleLabel.font = font;
        btn2.titleLabel.font = font;
        btn3.titleLabel.font = font;
        btn4.titleLabel.font = font;
        [btn1 setTitle:@"转帐" forState:UIControlStateNormal];
        [btn2 setTitle:@"提现" forState:UIControlStateNormal];
        [btn3 setTitle:@"二维码" forState:UIControlStateNormal];
        [btn4 setTitle:@"安全密码" forState:UIControlStateNormal];
        [btn1 setTitleColor:textColor forState:UIControlStateNormal];
        [btn2 setTitleColor:textColor forState:UIControlStateNormal];
        [btn3 setTitleColor:textColor forState:UIControlStateNormal];
        [btn4 setTitleColor:textColor forState:UIControlStateNormal];
        [btn1 setImage:IMG(@"purse_zhuanzhuang.png") forState:UIControlStateNormal];
        [btn2 setImage:IMG(@"purse_tixian.png") forState:UIControlStateNormal];
        [btn3 setImage:IMG(@"purse_erweima.png") forState:UIControlStateNormal];
        [btn4 setImage:IMG(@"purse_anquanma.png") forState:UIControlStateNormal];
        [btn1 jk_setImagePosition:LXMImagePositionTop spacing:8];
        [btn2 jk_setImagePosition:LXMImagePositionTop spacing:8];
        [btn3 jk_setImagePosition:LXMImagePositionTop spacing:8];
        [btn4 jk_setImagePosition:LXMImagePositionTop spacing:8];
        
        UIView *lineViewH1 = [view newDefaultLineView];
        UIView *lineViewH2 = [view newDefaultLineView];
        UIView *lineViewS1 = [view newDefaultLineView];
        UIView *lineViewS2 = [view newDefaultLineView];
        
        [yuEView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.top.equalTo(view.top).offset(padding);
            make.height.equalTo(yuEView.width).multipliedBy(0.7);
        }];
        [jiFenView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(yuEView.right).offset(OnePixNumber);
            make.top.bottom.width.equalTo(yuEView);
        }];
        [youHuiView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(jiFenView.right).offset(OnePixNumber);
            make.right.equalTo(view.right).offset(-padding);
            make.top.bottom.width.equalTo(yuEView);
        }];
        [btn1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(yuEView);
            make.top.equalTo(yuEView.bottom).offset(OnePixNumber);
        }];
        [btn2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(jiFenView);
            make.top.bottom.equalTo(btn1);
        }];
        [btn3 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(youHuiView);
            make.top.bottom.equalTo(btn1);
        }];
        [btn4 makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(yuEView);
            make.top.equalTo(btn1.bottom).offset(OnePixNumber);
        }];
        [lineViewH1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(yuEView.left);
            make.right.equalTo(youHuiView.right);
            make.top.equalTo(yuEView.bottom);
            make.height.equalTo(OnePixNumber);
        }];
        [lineViewH2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(lineViewH1);
            make.top.equalTo(btn1.bottom);
            make.height.equalTo(OnePixNumber);
        }];
        [lineViewS1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(yuEView.right);
            make.width.equalTo(OnePixNumber);
            make.top.equalTo(yuEView.top);
            make.bottom.equalTo(btn4.bottom);
        }];
        [lineViewS2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(lineViewS1);
            make.left.equalTo(jiFenView.right);
            make.width.equalTo(OnePixNumber);
        }];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(btn4.bottom).offset(padding);
        }];
        
        //余额
        [yuEView jk_handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
            ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
            if (user == nil) {
                [ZLLoginViewController startPresent:self];
                return;
            }
            
            UserScoreYuEVC *vc = [[UserScoreYuEVC alloc] init];
            vc.isScoreView = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        //积分
        [jiFenView jk_handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
            ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
            if (user == nil) {
                [ZLLoginViewController startPresent:self];
                return;
            }
            
            UserScoreYuEVC *vc = [[UserScoreYuEVC alloc] init];
            vc.isScoreView = YES;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        //优惠券
        [youHuiView jk_handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
            ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
            if (user == nil) {
                [ZLLoginViewController startPresent:self];
                return;
            }
            
            UserCouponVC *vc = [[UserCouponVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        //转帐
        [btn1 jk_addActionHandler:^(NSInteger tag) {
            ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
            if (user == nil) {
                [ZLLoginViewController startPresent:self];
                return;
            }
            
            TransferAccountVC *vc = [[TransferAccountVC alloc] initWithNibName:@"TransferAccountVC" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        //提现
        [btn2 jk_addActionHandler:^(NSInteger tag) {
            ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
            if (user == nil) {
                [ZLLoginViewController startPresent:self];
                return;
            }
            
            WithDrawalVC *vc = [[WithDrawalVC alloc] initWithNibName:@"WithDrawalVC" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        //二维码收款
        [btn3 jk_addActionHandler:^(NSInteger tag) {
            ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
            if (user == nil) {
                [ZLLoginViewController startPresent:self];
                return;
            }
            
            SouKuanVC *vc = [[SouKuanVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        //交易密码
        [btn4 jk_addActionHandler:^(NSInteger tag) {
            ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
            if (user == nil) {
                [ZLLoginViewController startPresent:self];
                return;
            }
            
            SecurityPasswordVC *vc = [[SecurityPasswordVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        view;
    });
    

    [aView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(headerView.bottom).offset(padding);
    }];
    
    [self.contentView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(aView.bottom);
    }];
    [self.scrollView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(-NAVBAR_Height);
    }];
    
    
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHeaderRefreshing];
    }];
    self.scrollView.mj_header = header;
    
    [header setTitle:@"" forState:MJRefreshStateIdle];
    [header setTitle:@"" forState:MJRefreshStatePulling];
    [header setTitle:@"" forState:MJRefreshStateRefreshing];

    
    __weak __typeof__(SingInHeaderView) *weakHeaderViewSelf = headerView;
    headerView.chooseSingInCallBack = ^() {
        ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
        if (user == nil) {
            [ZLLoginViewController startPresent:self];
            return;
        }
        [SVProgressHUD showWithStatus:@"正在签到..."];
        [[APIClient sharedClient] userSignWithTag:self call:^(int score, APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                [[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil];
                
                weakHeaderViewSelf.singView.score = score;
                weakHeaderViewSelf.singView.is_singin = ! weakHeaderViewSelf.singView.is_singin;
                
                [SVProgressHUD showSuccessWithStatus:@"签到成功!"];
            }else{
                [SVProgressHUD showErrorWithStatus:info.msg];
            }
        }];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil]; //更新一下用户数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserInfoChange:) name:MyUserInfoChangedNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self reloadUIWithData];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadHeaderRefreshing{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        [[APIClient sharedClient] userInfoWithTag:self call:^(ZLUserInfo *user, APIObject *info) {
            [self reloadUIWithData];
        }];
    } else
        [self performSelector:@selector(reloadUIWithData) withObject:nil afterDelay:0.1];
}



-(void)reloadUIWithData
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    [self.userBalanceView loadName:@"我的余额" value:[NSString stringWithFormat:@"￥%.2f", user.wallet.uwal_balance]];
    [self.userScoreView loadName:@"我的积分" value:[NSString stringWithFormat:@"%i", user.wallet.uwal_score]];
    [self.userCouponView loadName:@"我的优惠券" value:[NSString stringWithFormat:@"%i", user.wallet.couponCount]];
    
    self.headerView.singView.score = user.wallet.score;
    self.headerView.singView.is_singin = user.wallet.is_sign;
    [self.headerView loadUIWithDay:user.wallet.signCount];
    
    [self.scrollView.mj_header endRefreshing];
}

- (void)selectItemBtnView:(QUItemBtnView *)view
{
    SingInView *singView = (SingInView *)view;
    singView.is_singin = !singView.is_singin;
}


//监测到用户数据修改
-(void)handleUserInfoChange:(NSNotification *)note
{
    [self reloadUIWithData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
