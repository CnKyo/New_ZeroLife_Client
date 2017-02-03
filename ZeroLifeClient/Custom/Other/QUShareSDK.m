//
//  QUShareSDK.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2017/2/3.
//  Copyright © 2017年 ChaoerTEC. All rights reserved.
//

#import "QUShareSDK.h"

#import <UIKit/UIKitDefines.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MessageUI/MessageUI.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

@implementation QUShareSDK


#define ShareTitle (@"重庆发现购科技有限公司")
#define ShareWebURL (@"http://go.chinafxg.com")

+ (QUShareSDK *)shared {
    static QUShareSDK *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[QUShareSDK alloc] init];
    });
    return _sharedClient;
}

- (id)init
{
    if(self = [super init])
    {
        self.infoDict = [NSMutableDictionary dictionary];
    }
    return self;
}



- (BOOL)applicationDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [ShareSDK registerApp:@"104f0624c5e55"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy)]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             //截止发布ShareSDK新版，新浪微博最新的SDK在iOS9真机下初始化很多时候都会直接崩溃。因而注释掉这行，即不使用新浪微博SDK。
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"1729295531"
                                                appSecret:@"2203a0f6095cce1df142e13d908f8de6"
                                              redirectUri:ShareWebURL
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx81013437f356c5de"
                                            appSecret:@"b3bc186242ba3c527859e125fd397caf"];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"1104430887"
                                           appKey:@"AV0KWEDwalAYfA9h"
                                         authType:SSDKAuthTypeBoth];
                      break;
                  default:
                      break;
              }
          }];
    
    return YES;
}



#pragma mark - 分享内容

/**
 *	@brief	分享全部
 *
 *	@param 	sender 	事件对象
 */
- (void)shareAllButtonClickHandler:(UIButton *)sender imageUrl:(NSString *)imageUrl title:(NSString *)title content:(NSString *)content description:(NSString *)des linkUrl:(NSString *)url
{
    if (title==nil || title.length==0)
        title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (content==nil || content.length == 0)
        content = @"重庆发现之旅科技有限公司\n";
    
    
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                     images:@[imageUrl]
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    
    SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:sender
                                                                     items:nil
                                                               shareParams:shareParams
                                                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                                           switch (state) {
                                                               case SSDKResponseStateBegin:
                                                               {
                                                                   [SVProgressHUD showWithStatus:@"分享中..."];;
                                                                   break;
                                                               }
                                                               case SSDKResponseStateSuccess:
                                                               {
                                                                   [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                                                                   break;
                                                               }
                                                               case SSDKResponseStateFail:
                                                               {
                                                                   if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                                                                   {
                                                                       [SVProgressHUD showErrorWithStatus:@"分享失败"];
                                                                       break;
                                                                   }
                                                                   else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                                                                   {
                                                                       [SVProgressHUD showErrorWithStatus:@"分享失败"];
                                                                       break;
                                                                   }
                                                                   else
                                                                   {
                                                                       [SVProgressHUD showErrorWithStatus:@"分享失败"];
                                                                       break;
                                                                   }
                                                                   break;
                                                               }
                                                               case SSDKResponseStateCancel:
                                                               {
                                                                   [SVProgressHUD showInfoWithStatus:@"分享取消"];
                                                                   break;
                                                               }
                                                               default:
                                                                   break;
                                                           }
                                                           
                                                       }];
    
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeCopy)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeMail)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSMS)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeQQ)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeWechat)];
}

#pragma mark - 用户资料读取
- (void)getUserInfoWithType:(SSDKPlatformType)shareType call:( void(^)(SSDKUser *user))callback
{
    [SSEThirdPartyLoginHelper loginByPlatform:shareType
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       associateHandler (user.uid, user, user);
                                       callback(user);
                                       NSLog(@"user: %@", user);
                                       
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    NSLog(@"error:%@",error);
                                    callback(nil);
                                }];
}



@end
