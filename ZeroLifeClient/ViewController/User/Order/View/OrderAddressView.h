//
//  OrderAddressView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"
#import "TopLeftLabel.h"

@interface OrderAddressView : UIView
@property(nonatomic,strong) UILabel *noteLable;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) TopLeftLabel *addressLable;

- (id)initWithNote:(NSString *)noteStr name:(NSString *)nameStr address:(NSString *)addressStr;

@end
