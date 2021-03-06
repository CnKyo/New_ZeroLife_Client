//
//  otherLoginViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/27.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "CustomVC.h"
#import "APIObjectDefine.h"
@interface otherLoginViewController : CustomVC

@property (nonatomic,strong) NSString *mOpenId;
/**
 *  登录类型  1为qq 2为微信 3为新浪
 */
@property (assign,nonatomic) int mType;
@property (nonatomic,strong) ZLUserInfo *mUserInfo;
/**
 block
 */
@property (nonatomic,strong) void(^block)(NSString *Phone,NSString *Pwd);

@end
