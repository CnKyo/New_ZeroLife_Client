//
//  UIViewController+Additions.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIViewController (Additions)


+ (UIViewController*)topViewController;  //获取最外层rootvc的活动vc
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController; //获取对应rootvc的活动vc
+(UIViewController *)getCurrentRootViewController; //获取当前活动vc


@end
