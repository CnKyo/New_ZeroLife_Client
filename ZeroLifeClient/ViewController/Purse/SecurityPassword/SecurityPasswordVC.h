//
//  SecurityPasswordVC.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/11/14.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"
#import <CustomIOSAlertView/CustomIOSAlertView.h>

@interface NewTextField : UITextField

@end

@interface SecurityPasswordView : UIView
@property(nonatomic,strong) NewTextField *field;
@property(nonatomic,strong) NSMutableString *pwStr;
@end



//密码输入弹框
@interface SecurityPasswordAlertView : CustomIOSAlertView
@property(nonatomic,strong) SecurityPasswordView *secrityView;
@property(nonatomic, copy) void (^inputPwdCallBack)(NSString* pwd); //获取密码字符串
-(void)showAlert; //显示alert
@end



@interface SecurityPasswordVC : CustomVC

@end
