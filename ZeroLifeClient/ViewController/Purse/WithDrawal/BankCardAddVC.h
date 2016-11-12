//
//  BankCardAddVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/12.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface BankCardAddVC : CustomVC
@property (weak, nonatomic) IBOutlet UITextField *bankCardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *realNameField;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end
