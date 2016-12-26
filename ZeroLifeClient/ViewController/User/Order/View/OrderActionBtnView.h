//
//  OrderActionBtnView.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/9.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "CustomDefine.h"
#import "APIObjectDefine.h"
#import "APIClient.h"

@interface OrderButton : UIButton
@property(nonatomic,strong) NSString *stateStr;
@end

@interface OrderActionBtnView : UIView
@property(nonatomic,strong) OrderButton *actionBtn1;
@property(nonatomic,strong) OrderButton *actionBtn2;
@property(nonatomic,strong) OrderButton *actionBtn3;

-(void)reloadUIWithStateArr:(NSArray *)arr;


@end
