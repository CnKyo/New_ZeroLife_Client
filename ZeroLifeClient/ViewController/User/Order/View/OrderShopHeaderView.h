//
//  OrderShopHeaderView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"
#import "APIObjectDefine.h"

@interface OrderShopHeaderView : UIView

@property(nonatomic,strong) UIImageView *shopIconImgView;
@property(nonatomic,strong) UILabel *shopNameLable;
@property(nonatomic,strong) UILabel *orderStatusLable;

-(void)reloadUIWithShopName:(NSString *)name shopLogo:(NSString *)logo orderStatus:(NSString *)state;

@end
