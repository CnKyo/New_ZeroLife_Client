//
//  ZLNavViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLNavViewController.h"

@interface ZLNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ZLNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  清空代理,默认用户的手势就是有效的
     */
    //    self.interactivePopGestureRecognizer.delegate = nil;
    self.navigationBar.translucent = NO;
    self.interactivePopGestureRecognizer.delegate = self;
//    self.navigationBar.barTintColor = [UIColor colorWithRed:0.55 green:0.75 blue:0.15 alpha:1.00];
//    //设置导航栏文字
//    [self.navigationBar setTitleTextAttributes:@{
//                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]
//                                                 
//                                                 }];

    
    
    UIColor *color = [UIColor whiteColor];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.navigationBar.tintColor = COLOR_NavBar;
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = NO;
    if (SystemIsiOS7()) {
        self.navigationBar.barTintColor = COLOR_NavBar;
        self.navigationBar.tintColor = color;
    }
    [self.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {
        [[UINavigationBar appearance] setShadowImage:[UIImage jk_imageWithColor:COLOR_NavBar]];
    }
//     [self.navigationBar.layer setMasksToBounds:YES];
//     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(10, -60) forBarMetrics:UIBarMetricsDefault];

}
/**
 *  重写push方法目的: 拦截push进来的自控制器
 *
 *  @param viewController 被push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if (self.childViewControllers.count > 0) {
//        UIButton *backButton = [[UIButton alloc] init];
//        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        //        [backButton setTitle:@"返回" forState:UIControlStateNormal];
//        [backButton setImage:[UIImage imageNamed:@"ZLBackBtn_Image"] forState:UIControlStateNormal];
//        [backButton setImage:[UIImage imageNamed:@"ZLBackBtn_Image"] forState:UIControlStateHighlighted];
//        [backButton sizeToFit];
//        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//        viewController.hidesBottomBarWhenPushed = YES;
//        
//    }
    
    [super pushViewController:viewController animated:YES];
    
}

#pragma mark - 监听
- (void)back
{
    [self popViewControllerAnimated:YES];
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //档子控制器个数大于1是,手势有效
    return self.childViewControllers.count > 1;
    
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
