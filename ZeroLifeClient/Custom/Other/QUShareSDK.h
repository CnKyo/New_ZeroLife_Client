//
//  QUShareSDK.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2017/2/3.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//微信SDK头文件
#import "WXApi.h"

#import <ShareSDK/ShareSDK.h>
//第三方平台的SDK头文件，根据需要的平台导入。
//以下分别对应微信、新浪微博、腾讯微博、人人、易信
#import "WXApi.h"
#import "WeiboSDK.h"

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import "CustomDefine.h"



@interface QUShareSDK : NSObject
@property (nonatomic,strong)  NSMutableDictionary *infoDict;

+ (QUShareSDK *)shared;
- (BOOL)applicationDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)getUserInfoWithType:(SSDKPlatformType)shareType call:( void(^)(SSDKUser *user, NSError *error))callback;

- (void)shareAllButtonClickHandler:(UIButton *)sender imageUrl:(NSString *)imageUrl title:(NSString *)title content:(NSString *)content description:(NSString *)des linkUrl:(NSString *)url;


@end
