//
//  WithDrawalVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"
#import "HMSegmentedControl.h"
#import "APIClient.h"

@interface WithDrawalVC : CustomVC
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLable; //可提现余额
@property (weak, nonatomic) IBOutlet UIButton *allOutBtn; //全部提现
@property (weak, nonatomic) IBOutlet UITextField *moneyLable; //提现金额

@property (weak, nonatomic) IBOutlet UIView *bankView;
@property (weak, nonatomic) IBOutlet UIImageView *bankIconImgView;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLable;
@property (weak, nonatomic) IBOutlet UILabel *bankNumberLable;

@property (weak, nonatomic) IBOutlet HMSegmentedControl *typeSeg; //到帐时间类型
@property (weak, nonatomic) IBOutlet UIButton *doneBtn; //确定按钮

@end
