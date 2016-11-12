//
//  OrderHeaderStatusView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"

@interface OrderHeaderStatusView : UIView
@property(nonatomic,strong) UILabel *msgLable;

//加载文字
-(void)loadStatus:(NSString *)statusStr note:(NSString *)noteStr;

@end
