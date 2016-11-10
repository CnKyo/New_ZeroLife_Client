//
//  UserPaoPaoRegisterVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/5.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface UserPaoPaoRegisterVC : CustomVC
@property (weak, nonatomic) IBOutlet UILabel *moneyLable; //用户余额
@property (weak, nonatomic) IBOutlet UIButton *xieyiChooseBtn; //选择协议按钮
@property (weak, nonatomic) IBOutlet UIButton *payBtn; //支付按钮

@end
