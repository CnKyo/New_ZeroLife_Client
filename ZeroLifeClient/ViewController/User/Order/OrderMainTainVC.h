//
//  OrderMainTainVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/12/29.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "CustomVC.h"
#import <IQKeyboardManager/IQTextView.h>

@interface OrderMainTainVC : CustomVC
@property (weak, nonatomic) IBOutlet IQTextView *textVIew;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@property (nonatomic, copy) void (^textCallBack)(NSString* text);

@end
