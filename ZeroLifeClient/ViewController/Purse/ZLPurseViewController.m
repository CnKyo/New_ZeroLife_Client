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



@interface ZLPurseViewController ()

@end

@implementation ZLPurseViewController


-(void)loadView
{
    [super loadView];
    
    float padding = 10;
    UIView *superView = self.view;
    
    PurseHeaderView *headerView = [[PurseHeaderView alloc] init];
    [superView addSubview:headerView];
    
    UIView *aView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        
        PlurseValueNameControl *yuEView = [[PlurseValueNameControl alloc] init];
        PlurseValueNameControl *jiFenView = [[PlurseValueNameControl alloc] init];
        PlurseValueNameControl *youHuiView = [[PlurseValueNameControl alloc] init];
        [view addSubview:yuEView];
        [view addSubview:jiFenView];
        [view addSubview:youHuiView];
        [yuEView loadName:@"我的余额" value:@"￥1000"];
        [jiFenView loadName:@"我的积分" value:@"1000"];
        [youHuiView loadName:@"我的优惠券" value:@"3"];
        
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
            UserScoreYuEVC *vc = [[UserScoreYuEVC alloc] init];
            vc.isScoreView = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        //积分
        [jiFenView jk_handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
            UserScoreYuEVC *vc = [[UserScoreYuEVC alloc] init];
            vc.isScoreView = YES;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        
        view;
    });
    
    [headerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.height.equalTo(headerView.width).multipliedBy(0.6);
    }];
    [aView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(headerView.bottom);
    }];
    
    [headerView.singInBtn jk_addActionHandler:^(NSInteger tag) {
        [headerView.singInBtn setImage:IMG(@"sigin_qianYes.png") forState:UIControlStateNormal];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
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

@end
