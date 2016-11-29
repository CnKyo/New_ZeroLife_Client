//
//  CustomDefine.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#ifndef CustomDefine_h
#define CustomDefine_h
#import "Util.h"
#import "UIViewExt.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "WPHotspotLabel.h"
#import <WPAttributedMarkup/WPHotspotLabel.h>
#import <WPAttributedMarkup/NSString+WPAttributedMarkup.h>
#import <WPAttributedMarkup/WPAttributedStyleAction.h>
#import <CoreText/CoreText.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "PPNumberButton.h"
#import <BlocksKit+UIKit.h>
#import <LPActionSheet.h>
#import <SVProgressHUD.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>


#define  KEY_USERNAME_PASSWORD @"com.company.app.usernamepassword"
#define  KEY_USERNAME @"com.company.app.username"
#define  KEY_PASSWORD @"com.company.app.password"


#define ColorRGB(_R_, _G_, _B_)       ([UIColor colorWithRed:_R_/255.0f green:_G_/255.0f blue:_B_/255.0f alpha:1])

#define COLOR(r,g,b)                [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define COLOR_RGBA(r,g,b,a)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define M_TextColor1 [UIColor colorWithRed:49/255.0f green:50/255.0f blue:51/255.0f alpha:1.000]


#define IMG(_File_)                 [UIImage imageNamed:_File_]
#define IMGRM(_File_)               [[UIImage imageNamed:_File_] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]



//helper macro that creates CGRect, CGSize, CGPoint
#define cgr(__X__, __Y__, __W__, __H__) CGRectMake(__X__, __Y__, __W__, __H__)
#define cgs(__X__, __Y__)			CGSizeMake(__X__, __Y__)
#define cgp(__X__, __Y__)			CGPointMake(__X__,__Y__)


#define NumberWithFloat(i)       [NSNumber numberWithFloat:i]
#define NumberWithInt(i)       [NSNumber numberWithInt:i]
#define NumberWithBool(i)       [NSNumber numberWithBool:i]
#define navigationBarColor RGB(33, 192, 174)

#define M_CO    [UIColor colorWithRed:0.56 green:0.77 blue:0.18 alpha:1.00]

#define VERSION [[UIDevice currentDevice].systemVersion doubleValue]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
//Demo:  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5")) [super viewWillLayoutSubviews];


#define DeviceIsRetina()				([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640.0, 960.0), [[UIScreen mainScreen] currentMode].size) : NO)
#define DeviceIsiPod()                  ([[[UIDevice currentDevice] systemName] isEqualToString:@"iPod touch"])
#define DeviceIsiPod5()                 ([[[UIDevice currentDevice] systemName] isEqualToString:@"iPod touch"] && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define DeviceIsiPhone()				([[UIScreen mainScreen] bounds].size.height == 480.0)
#define DeviceIsiPhone5()				([[UIScreen mainScreen] bounds].size.height == 568.0)
#define DeviceIsiPad()                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define SystemIsiOS4()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 4.0 && [[[UIDevice currentDevice] systemVersion] doubleValue] < 5.0)
#define SystemIsiOS5()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 5.0 && [[[UIDevice currentDevice] systemVersion] doubleValue] < 6.0)
#define SystemIsiOS6()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 6.0)
#define SystemIsiOS7()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)//判断是否为IOS7
#define SystemIsiOS8()                  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)//判断是否为IOS8
#define DEVICE_StatuBar_Height          (20.0)


#define DEVICE_NavBar_Height            (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)?64.0:44.0f)
#define DEVICE_TabBar_Height            (50.0)
#define DEVICE_Width                    ([[UIScreen mainScreen] bounds].size.width)
#define DEVICE_Height                   ([[UIScreen mainScreen] bounds].size.height)
#define DEVICE_InStatusBar_Height       ([[UIScreen mainScreen] bounds].size.height - DEVICE_StatuBar_Height)
#define DEVICE_InNavTabBar_Height       ([[UIScreen mainScreen] bounds].size.height - DEVICE_NavBar_Height - DEVICE_TabBar_Height)
#define DEVICE_InNavBar_Height          (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)?[[UIScreen mainScreen] bounds].size.height-64.0:[[UIScreen mainScreen] bounds].size.height-64.0f)
#define DEVICE_StatuNavBar_Height       (DEVICE_StatuBar_Height + DEVICE_NavBar_Height)
#define DEVICE_ContentView_Height (DEVICE_Height - DEVICE_InStatusBar_Height)
#define TOP_Height                      (DEVICE_StatuBar_Height+DEVICE_NavBar_Height)

#define PerDeviceWidth(__NUMBER__)      (DEVICE_Width * __NUMBER__)
#define PerDeviceHeight(__NUMBER__)     (DEVICE_Height * __NUMBER__)

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

#ifdef DEBUG
#define MLLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define MLLog(format, ...)
#endif

#define INDEXPATH_SUBVIEW_TABLEVIEW(subview,tableview)\
({\
CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];\
NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:subviewFrame.origin];\
indexPath;\
})\

#define CELL_SUBVIEW_TABLEVIEW(subview,tableview)\
({\
CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];\
NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:subviewFrame.origin];\
UITableViewCell *cell=[tableview cellForRowAtIndexPath:indexPath];\
cell;\
})\







static inline NSString *StringWithInteger(NSInteger _Value_)
{
    return [NSString stringWithFormat:@"%li",(long)_Value_];
}
static inline NSString *StringWithInt(int _Value_)
{
    return [NSString stringWithFormat:@"%i",_Value_];
}
static inline NSString *StringWithBool(BOOL _Value_)
{
    return [NSString stringWithFormat:@"%i",_Value_];
}
static inline NSString *StringWithDouble(double _Value_)
{
    return [NSString stringWithFormat:@"%.2f",_Value_];
}



typedef enum {
    kTableNote_Nothing,//空
    kTableNote_NoData,//无数据
    kTableNote_ConError,//链接错误
    kTableNote_ConErrorTimedOut,//链接超时错误
    kTableNote_UpdateError,//下载错误
    kTableNote_UpdateOK,//下载成功
    kTableNote_NoRecord,//暂无记录
} kTableNoteType;




//-----------------------
//自定义的写在下面，通用的写在上面
//-----------------------

// 格式 0xff3737
#define JHUDRGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define JHUDRGBA(r,g,b,a)     [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define COLOR_NavBar                COLOR(150, 200, 43)
#define COLOR_LowNavBar             [UIColor colorWithRed:0.761 green:0.914 blue:0.769 alpha:1.000]
#define COLOR_BtnBar                [UIColor colorWithRed:0.980 green:0.675 blue:0.082 alpha:1.000]
#define TABLE_PAGE_ROW              20  //每次页面调用20条数据
#define WXPAYKEY @"wxf8feb845b3a4d04e"





static int const RESP_STATUS_YES                  = 200;             //成功
static int const RESP_STATUS_NO                   = 1;             //失败


#define RETCODE_SUCCESS  200



//static NSString* const  kAFAppDotNetApiBaseURLString    = @"http://localhost:8080";

static NSString* const  kAFAppDotNetApiBaseURLString    = @"http://192.168.1.114";
static NSString* const  kAFAppDotNetApiExtraURLString    = @"/api/app/client";


typedef enum {
    kUserSexType_man = 1,//
    kUserSexType_woman = 2,//
    kUserSexType_uknown = 0,//
} kUserSexType; //用户性别

typedef enum {
    kOrderClassType_goods,//购物订单
    kOrderClassType_baoxiu,//报修订单
    kOrderClassType_ganxi,//干洗订单
    kOrderClassType_paopao,//跑跑订单
} kOrderClassType;


typedef enum {
    kOrderFixStatus_waitUserPay,//待用户支付
    kOrderFixStatus_userHavePay,//用户已支付
    kOrderFixStatus_waitShopBidding,//待商家竞价
    kOrderFixStatus_shopHaveReceiving,//商家已接单
    kOrderFixStatus_shopInService,//商家正在服务中
    kOrderFixStatus_done,//订单完成
    kOrderFixStatus_cancel,//订单取消
} kOrderFixStatus; //报修流程状态



typedef enum {
    kCouponType_manjian,//满减
    kCouponType_lijian,//立减
} kCouponType;

typedef enum{

    
    ZLWalletNormal,//正常
    ZLWalletLocked,//锁定
    
}ZLWalletStatu;

typedef enum{
    
    
    ZLHomeBannerTypeSystem,//banner类型为平台
    ZLHomeBannerTypeShop,//banner类型为商家
    
}ZLHomeBannerType;

typedef enum{
    
    
    ZLHomeAdvTypeSystem,//1:原生
    ZLHomeAdvTypeWeb,//0:WAP
    
}ZLHomeAdvType;//首页广告跳转类型

typedef enum{
    
    
    ZLHomeNoteTypeSystem,//0：平台
    ZLHomeNoteTypeCommunity,//1：社区
    
}ZLHomeNoteType;//首页公告类型

typedef enum{
    
    
    ZLHomeNewsTypeNote,//1:公告
    ZLHomeNewsTypeActivity,//2：活动
    ZLHomeNewsTypeNews,//3：新闻
    
}ZLHomeNewsType;//首页新闻类型







#endif /* CustomDefine_h */
