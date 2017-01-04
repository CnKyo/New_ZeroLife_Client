//
//  SouKuanVC.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "SouKuanVC.h"
#import <JKCategories/UIColor+JKGradient.h>
#import "SouKuanHistoryTVC.h"
#import <JKCategories/UINavigationBar+JKAwesome.h>

#import "CreatQRCodeAndBarCodeFromLeon.h"

@interface SouKuanVC ()

@end

@implementation SouKuanVC

-(void)loadView
{
    [super loadView];
    
    UIView *superView = self.view;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    gradientLayer.bounds = superView.bounds;
    gradientLayer.borderWidth = 0;
    
    gradientLayer.frame = superView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:
                             (id)[COLOR(74, 184, 196) CGColor],
                             (id)[COLOR(60, 211, 175) CGColor], nil];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    
    [superView.layer insertSublayer:gradientLayer atIndex:0];
    
    [self initSubViews];
}

-(void)initSubViews
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    NSMutableString *str = [NSMutableString new];
    if (user.user_phone.length > 0)
        [str appendString:user.user_phone];
    if (user.user_nick.length > 0)
        [str appendString:user.user_nick];
    if (str.length == 0)
        [str appendString:@"未知"];
    
    CGFloat codeWidth = DEVICE_Width;
    CGFloat codeHeight = codeWidth * 0.7;
    UIImage *codeImg = IMG(@"ercode_default.png");
    if (user.user_qrcode.length > 0)
        codeImg = [CreatQRCodeAndBarCodeFromLeon qrImageWithString:user.user_qrcode size:CGSizeMake(codeWidth, codeHeight) color:[UIColor blackColor] backGroundColor:[UIColor clearColor]];

    
    UIView *superView = self.view;
    int padding = 10;
    UIFont *font = [UIFont systemFontOfSize:15];
    
    UIView *aView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
        //view.layer.masksToBounds = YES;
//        view.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
//        view.layer.borderWidth = 1;
        view.layer.cornerRadius = 5;
        view.layer.shadowColor = [UIColor grayColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(1, 1);
        view.layer.shadowRadius = 2;
        view.layer.shadowOpacity = 0.8;
        UIImageView *imgView = [view newUIImageViewWithImg:codeImg];
        UILabel *lable = [view newUILableWithText:str textColor:[UIColor grayColor] font:font textAlignment:NSTextAlignmentCenter];
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(view.width).multipliedBy(0.7);
            make.centerX.equalTo(view.centerX);
            make.centerY.equalTo(view.centerY).offset(-padding);
        }];
        [lable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgView.bottom);
            //make.bottom.equalTo(view.bottom).offset(padding/2);
            make.height.equalTo(30);
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
        }];

        view;
    });
    [aView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(padding*2);
        make.right.equalTo(superView.right).offset(-padding*2);
        make.top.equalTo(superView.top).offset(@64);
        make.height.equalTo(aView.width).multipliedBy(1.1);
    }];

    
    UILabel *notelable = [superView newUILableWithText:@"扫一扫，看我有什么" textColor:[UIColor whiteColor] font:font textAlignment:NSTextAlignmentCenter];
    [notelable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aView.bottom).offset(padding/2);
        make.height.equalTo(30);
        make.left.right.equalTo(aView);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码";
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[self.navigationController.navigationBar jk_setBackgroundColor:COLOR(74, 184, 196)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"收款记录" style:UIBarButtonItemStylePlain handler:^(id  _Nonnull sender) {
//        SouKuanHistoryTVC *vc = [[SouKuanHistoryTVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
     [self.navigationController.navigationBar setBackgroundImage:[UIImage jk_imageWithColor:COLOR(74, 184, 196)] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar jk_reset];
    //[self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
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
