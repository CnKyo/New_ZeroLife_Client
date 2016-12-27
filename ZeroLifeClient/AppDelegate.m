//
//  AppDelegate.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "AppDelegate.h"
#import "ZLTabBarViewController.h"
#import "ZLWebViewViewController.h"
#import "MTA.h"
#import "MTAConfig.h"
#import "CustomDefine.h"
#import "APIObjectDefine.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <HcdGuideView.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <AlipaySDK/AlipaySDK.h>
#import <WXApi.h>
#import <WeiboSDK.h>
#import <JWLaunchAd/JWLaunchAd.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
@interface AppDelegate ()<UIAlertViewDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    //创建窗口的根控制器
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = COLOR_NavBar;
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:M_CO];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:21], NSFontAttributeName, nil]];
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
 
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    
//    //设置窗口的根控制器
//    self.window.rootViewController = [[ZLTabBarViewController alloc] init];
//    //显示窗口
//    [self.window makeKeyAndVisible];

    [self initLibraries];
    
    return YES;
}
#pragma mark----初始化三方库
- (void)initLibraries{
    
    [AMapServices sharedServices].apiKey = AMAP_KEY;


    //初始化腾讯统计
    [MTA startWithAppkey:@"IBW9PAI485ZQ"];
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"11070552590dc"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxf8feb845b3a4d04e"
                                       appSecret:@"5060f2cb199015e81b74c6d5fc26e4a6"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105204239"
                                      appKey:@"5SShQsbv5YgKswaF"
                                    authType:SSDKAuthTypeBoth];
                 break;
            
             default:
                 break;
         }
     }];
    [WXApi registerApp:WXPAYKEY withDescription:[Util getAPPName]];// 配置info.plist的 Scheme,

    
//    __weak __typeof(self)mSelf = self;
//    
//    //  清理缓存
//    [JWLaunchAd clearDiskCache];
//    
//    //  1.设置启动页广告图片的url
//    //    NSString *imgUrlString =@"http://imgstore.cdn.sogou.com/app/a/100540002/714860.jpg";
//    //  GIF
//    NSString *imgUrlString = @"http://img1.imgtn.bdimg.com/it/u=473895314,616407725&fm=206&gp=0.jpg";
//    
//    //  2.初始化启动页广告
//    [JWLaunchAd initImageWithAttribute:6.0 showSkipType:SkipShowTypeAnimation setLaunchAd:^(JWLaunchAd *launchAd) {
//        __block JWLaunchAd *weakSelf = launchAd;
//        
//        //如果选择 SkipShowTypeAnimation 需要设置动画跳过按钮的属性
//        [weakSelf setAnimationSkipWithAttribute:[UIColor redColor] lineWidth:3.0 backgroundColor:nil textColor:nil];
//        
//        
//        [launchAd setWebImageWithURL:imgUrlString options:JWWebImageDefault result:^(UIImage *image, NSURL *url) {
//            
//            //  3.异步加载图片完成回调(设置图片尺寸)
//            weakSelf.launchAdViewFrame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
//        } adClickBlock:^{
//            
//            //  4.点击广告回调
//            NSString *url = @"https://www.baidu.com";
//            NSNotification *mNotice = [NSNotification notificationWithName:@"ZLAdView" object:nil userInfo:@{@"url":url}];
//            [[NSNotificationCenter defaultCenter] postNotification:mNotice];
//
//            
//        }];
//    }];
    

    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark----****----支付回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // url:wx206e0a3244b4e469://pay/?returnKey=&ret=0 withsouce url:com.tencent.xin
    
    
    
    MLLog(@"url:%@ withsouce url:%@",url,sourceApplication);
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      
                                                      MLLog(@"xxx:%@",resultDic);
                                                      
                                                      APIObject* retobj = nil;
                                                      
                                                      if (resultDic)
                                                      {
                                                          
                                                          if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
                                                          {
                                                              [[NSNotificationCenter defaultCenter] postNotificationName:MyOrderPaySuccessNotification object:nil];
                                                              
                                                              APIObject* retobj = [[APIObject alloc]init];
                                                              retobj.msg = @"支付成功";
                                                              retobj.code = 200;
                                                              [SVProgressHUD showSuccessWithStatus:retobj.msg];
                                                              
                                                              if( [ZLUserInfo ZLCurrentUser].mPayBlock )
                                                              {
                                                                  [ZLUserInfo ZLCurrentUser].mPayBlock(retobj);
                                                              }
                                                              else
                                                              {
                                                                  MLLog(@"may be err no block to back");
                                                              }
                                                          }
                                                          else
                                                          {
                                                              [SVProgressHUD showErrorWithStatus:[resultDic objectForKey:@"memo" ]];
                                                              retobj.msg = [resultDic objectForKey:@"memo" ];
                                                              
                                                          }
                                                      }
                                                      else
                                                      {
                                                          retobj.msg = @"支付成功";
                                                          retobj.code = 200;
                                                          [SVProgressHUD showErrorWithStatus:retobj.msg];
                                                      }
                                                  }];
        
        
        return YES;
    }
    else if( [sourceApplication isEqualToString:@"com.tencent.xin"] )
    {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return NO;
}

-(void) onResp:(BaseResp*)resp
{
    if( [resp isKindOfClass: [PayResp class]] )
    {
        NSString *strMsg    =   [NSString stringWithFormat:@"errcode:%d errmsg:%@ payinfo:%@", resp.errCode,resp.errStr,((PayResp*)resp).returnKey];
        MLLog(@"payresp:%@",strMsg);
        
        APIObject* retobj = APIObject.new;
        if( resp.errCode == -1 )
        {//
            retobj.code = 500;
            retobj.msg = @"支付出现异常";
        }
        else if( resp.errCode == -2 )
        {
            retobj.code = 500;
            retobj.msg = @"用户取消了支付";
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:MyOrderPaySuccessNotification object:nil];
            
            retobj.code = 200;
            retobj.msg = @"支付成功";
        }
        
        if( [ZLUserInfo ZLCurrentUser].mPayBlock )
        {
            [ZLUserInfo ZLCurrentUser].mPayBlock(retobj);
        }
        else
        {
            MLLog(@"may be err no block to back");
        }
    }
    else
    {
        MLLog(@"may be err what class one onResp");
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([[options objectForKey:@"UIApplicationOpenURLOptionsSourceApplicationKey"] isEqualToString:@"com.alipay.iphoneclient"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      
                                                      MLLog(@"xxx:%@",resultDic);
                                                      
                                                      APIObject* retobj = nil;
                                                      
                                                      
                                                      if (resultDic)
                                                      {
                                                          if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
                                                          {
                                                              
                                                              [[NSNotificationCenter defaultCenter] postNotificationName:MyOrderPaySuccessNotification object:nil];
                                                              APIObject* retobj = [[APIObject alloc]init];
                                                              retobj.code = 200;
                                                              retobj.msg = @"支付成功";
                                                              [SVProgressHUD showSuccessWithStatus:retobj.msg];
                                                              
                                                              if( [ZLUserInfo ZLCurrentUser].mPayBlock )
                                                              {
                                                                  [ZLUserInfo ZLCurrentUser].mPayBlock(retobj);
                                                              }
                                                              else
                                                              {
                                                                  MLLog(@"may be err no block to back");
                                                              }
                                                          }
                                                          else
                                                          {
                                                              [SVProgressHUD showErrorWithStatus:[resultDic objectForKey:@"memo" ]];
                                                              retobj.msg = [resultDic objectForKey:@"memo" ];

                                                              [SVProgressHUD showErrorWithStatus:retobj.msg];
                                                          }
                                                      }
                                                      else
                                                      {
                                                          retobj.code = 500;
                                                          retobj.msg = @"支付出现异常";

                                                          [SVProgressHUD showErrorWithStatus:retobj.msg];
                                                      }
                                                  }];
        
        
        return YES;
    }
    else if([[options objectForKey:@"UIApplicationOpenURLOptionsSourceApplicationKey"] isEqualToString:@"com.tencent.xin"]){
        
        return  [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    MLLog(@"hhhhhhurl:%@",url);
    return  [WXApi handleOpenURL:url delegate:self];
}

@end
