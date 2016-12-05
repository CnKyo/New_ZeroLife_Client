//
//  CustomScrollVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "Masonry.h"
#import <MJRefresh/MJRefresh.h>
#import "APIObjectDefine.h"
#import "UIView+AutoSize.h"
#import "APIClient.h"

@interface CustomScrollVC : UIViewController

@property(nonatomic,strong) UIScrollView*       scrollView;
@property(nonatomic,strong) UIView*             contentView;

@end
