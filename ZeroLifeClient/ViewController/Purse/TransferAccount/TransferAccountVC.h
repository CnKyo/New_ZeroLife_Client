//
//  TransferAccountVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface TransferAccountVC : CustomVC
@property (weak, nonatomic) IBOutlet UILabel *yuEMoneyLable; //我的余额
@property (weak, nonatomic) IBOutlet UITextField *accountField; //转帐帐号
@property (weak, nonatomic) IBOutlet UITextField *moneyField; //转帐金额
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *xieyiBtn;

@end
