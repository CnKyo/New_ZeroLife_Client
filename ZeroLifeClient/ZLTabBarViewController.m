//
//  ZLTabBarViewController.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLTabBarViewController.h"
#import "ZLNavViewController.h"
#import "ZLHomeViewController.h"
#import "ZLUserViewController.h"
#import "ZLPurseViewController.h"
#import "ZLCookViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ZLTabBarViewController ()

@end

@implementation ZLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置文字的属性
    [self setUpItemTitleTextAttrs];
    //添加子控件
    [self setUpChildVcs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 添加子控制器
 */
- (void)setUpChildVcs
{
    
    [self setUpOneChildVc:[[ZLNavViewController alloc] initWithRootViewController:[[ZLHomeViewController alloc] init]] title:@"首页" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setUpOneChildVc:[[ZLNavViewController alloc] initWithRootViewController:[[ZLUserViewController alloc] init]] title:@"我的" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setUpOneChildVc:[[ZLNavViewController alloc] initWithRootViewController:[[ZLPurseViewController alloc] init]]title:@"钱包" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpOneChildVc:[[ZLNavViewController alloc] initWithRootViewController:[[ZLCookViewController alloc] init]]title:@"厨房" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
 
    
}
- (void)setUpOneChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.tabBarItem.title = title;
    if (image.length) childVc.tabBarItem.image = [UIImage imageNamed:image];
    if (selectedImage.length) childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:childVc];
    
}


- (void)setUpItemTitleTextAttrs
{
    //设置tabbar边缘线
    self.tabBar.layer.borderWidth = 0.50;
    self.tabBar.layer.borderColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:0.3].CGColor;
    
    //设置normal状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //设置selected状态下的文字属性
    NSMutableDictionary *selectedArrts= [NSMutableDictionary dictionary];
    selectedArrts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.55 green:0.75 blue:0.15 alpha:1.00];
    
    //利用Appearance对象同意设置文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedArrts forState:UIControlStateSelected];
    
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
