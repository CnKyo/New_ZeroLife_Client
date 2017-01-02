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
#import "TXTimeChoose.h"

#define  KEY_USERNAME_PASSWORD @"com.company.app.usernamepassword"
#define  KEY_USERNAME @"com.company.app.username"
#define  KEY_PASSWORD @"com.company.app.password"
#define AMAP_KEY @"7970dba38f00e9b34aed65fb0bd29194"

#define  JH_KEY @"29c41f5f6374ad7a7a6bc635b9e06cfa"

#define  JH_API @"http://op.juhe.cn/ofpay/public/province"

#define ZLDefaultGoodsImg           [UIImage imageNamed:@"ZLDefault_Img"]
#define ZLDefaultShopImg           [UIImage imageNamed:@"ZLDefault_Shop"]
#define ZLDefaultBannerImg           [UIImage imageNamed:@"ZLDefault_Banner"]
#define ZLDefaultAvatorImg           [UIImage imageNamed:@"ZLDefault_Avator"]
#define ZLDefaultClassImg           [UIImage imageNamed:@"ZLDefault_Green"]


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



typedef enum {
    ZLPPTReleaseTypeWithBuyStaff = 0,//买东西
    ZLPPTReleaseTypeWithSendDo = 1,//送东西办事情
} ZLPPTReleaseType;//发布跑腿类型


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
static int const RESP_STATUS_LOGIN                  = 300;             //需要登录


#define RETCODE_SUCCESS  200


//static NSString* const  kAFAppDotNetApiBaseURLString    = @"http://localhost:8080";
//static NSString* const  kAFAppDotNetApiExtraURLString    = @"/crkj_zlife/api/app/client";
//static NSString* const  kAFAppDotNetApiServiceURLString    = @"/crkj_zlife/api/app/service";

static NSString* const  kAFAppDotNetApiBaseURLString    = @"http://192.168.1.114";
static NSString* const  kAFAppDotNetApiExtraURLString    = @"/api/app/client";
static NSString* const  kAFAppDotNetApiServiceURLString    = @"/api/app/service";
static NSString* const  kAFAppDotNetImgBaseURLString    = @"http://192.168.1.114/resource";


static NSString * const MyUserNeedUpdateNotification     = @"MyUserNeedUpdateNotification";
static NSString * const MyUserInfoChangedNotification   = @"MyUserInfoChangedNotification";

static NSString * const MyUserAddressNeedUpdateNotification   = @"MyUserAddressNeedUpdateNotification"; //地址信息需要更新
static NSString * const MyOrderPaySuccessNotification   = @"MyOrderPaySuccessNotification";

//功能参数（用户头像-U_PHOTO，用户认证文件-U_AUT，用户跑跑腿申请资料-U_APPLY，用户订单处理-U_ORDERS）
static NSString* const  kFileUploadPath_Photo       = @"U_PHOTO";
static NSString* const  kFileUploadPath_Aut         = @"U_AUT";
static NSString* const  kFileUploadPath_Apply       = @"U_APPLY";
static NSString* const  kFileUploadPath_Orders      = @"U_ORDERS";


//是否有支付密码(NOPASS-无/PASS-有)
static NSString* const  kWalletPayment_NoPass       = @"NOPASS";
static NSString* const  kWalletPayment_Pass         = @"PASS";



// 用户红包、优惠券状态（创建，发放中，暂停发放，过期，未使用，已使用）
// 1. 用户领取后的优惠券：NOUSE->ISUSED->OVERDUE
// 2. 用户领取后的红包：CONFIRM->NOUSE->ISUSED
static NSString* const  kCouponState_NoUse          = @"NOUSE";
static NSString* const  kCouponState_IsUsed         = @"ISUSED";
static NSString* const  kCouponState_Overdue        = @"OVERDUE";



//	 * 1. 报修订单： 待竞价--[维修单竞价选择]--待支付--已支付--商户确认[并选择员工--员工确认开始服务]--员工确认上门--员工确认维修价格--用户支付差额--员工完成维修--用户确认完成--用户完成评价
//	 * 2. 跑跑腿订单：待支付--完成支付--[跑跑腿订单接单]--员工开始服务--[如果为购买商品员工确认商品价格--用户支付差额]--员工完成服务--用户确认完成--用户评价
//	 * 3. 超市订单：待支付--完成支付--商户确认接单[拒绝接单]--商户出货--[商户选择配送--配送中--配送完成]--商户完成配送--用户确认--用户评价
//	 * 4. 干洗订单：待支付--完成支付--商户确认接单[拒绝接单]--商户确认收货--商户服务中--商户完成服务--用户确认完成--用户评价
//	 * 5. 提现订单：待支付--完成支付--平台确认[出款疑问]--平台完成出款--订单确认完成--用户确认完成
//	 * 6. 手机缴费：待支付--完成支付--三方充值提交--充值成功--订单完成--用户确认完成
//	 * 7. 充值订单：待支付--完成支付--[余额到账]
//	 * 8. 物业费订单：待支付--完成支付--[缴费成功]
//	 * 9. 转账订单：待支付--完成支付--[确认到账]
//	 * 10. 跑跑腿押金：待支付--完成支付--[申请成功]
static NSString* const  kOrderState_WAITUP              = @"WAITUP";  //订单创建
static NSString* const  kOrderState_BIDDING             = @"BIDDING";  //竞价中
static NSString* const  kOrderState_SERPOINT            = @"SERPOINT";  //用户选定服务商
static NSString* const  kOrderState_WAITPAY             = @"WAITPAY";  //待付款
static NSString* const  kOrderState_PAYMENTED           = @"PAYMENTED";  //已付款
static NSString* const  kOrderState_UCANCEL             = @"UCANCEL";  //用户取消订单
static NSString* const  kOrderState_TIMEOUT             = @"TIMEOUT";  //订单超时（系统取消）
static NSString* const  kOrderState_SCANCEL             = @"SCANCEL";  //商户取消订单
static NSString* const  kOrderState_SSELECT             = @"SSELECT";  //商户接单（提现确认、话费充值提交）
static NSString* const  kOrderState_SREFUSE             = @"SREFUSE";  //商户拒单
static NSString* const  kOrderState_SSERVICE            = @"SSERVICE";  //服务中（超市出货、干洗报修上门、跑跑到达指定地点）
static NSString* const  kOrderState_DIFFWAIT            = @"DIFFWAIT";  //用户待支付差价
static NSString* const  kOrderState_DIFFPAYED           = @"DIFFPAYED";  //用户已付款差价
static NSString* const  kOrderState_SDONE               = @"SDONE";  //商户完成订单完成
static NSString* const  kOrderState_UDONE               = @"UDONE";  //用户完成订单完成
static NSString* const  kOrderState_EVALUATE            = @"EVALUATE";  //订单已评价
static NSString* const  kOrderState_MAINTAIN            = @"MAINTAIN";  //维权中


//购物订单：待支付（WAITPAY）、待发货（ING）、待收货(SDONE)、已完成（UDONE）
//干洗订单：待支付（WAITPAY）、待取件（ING）、待确认(SDONE)、已完成（UDONE）
//报修订单：待支付（WAITPAY）、待上门（ING）、待确认(SDONE)、已完成（UDONE）
//跑跑腿-用户订单：待支付（WAITPAY）、待接单（ING）、待确认(SDONE)、已完成（UDONE）
//跑跑腿-跑腿者订单：待处理（ING）、已完成（DONE）、已取消(CANCEL)
static NSString* const  kOrderSegState_WAITPAY          = @"WAITPAY";  //待支付
static NSString* const  kOrderSegState_ING              = @"ING";  //待发货/待取件/待上门/待接单
static NSString* const  kOrderSegState_SDONE            = @"SDONE";  //待确认
static NSString* const  kOrderSegState_UDONE            = @"UDONE";  //已完成
static NSString* const  kOrderSegState_DONE             = @"DONE";  //已完成
static NSString* const  kOrderSegState_CANCEL           = @"CANCEL";  //已取消


static NSString* const  kOpenState_NOTOPEN              = @"NOTOPEN";  //未开通跑跑腿
static NSString* const  kOpenState_PAYMENTED            = @"PAYMENTED";  //未提交资料-已支付押金
static NSString* const  kOpenState_UNCHECK              = @"UNCHECK";  //待审核
static NSString* const  kOpenState_CHECKED              = @"CHECKED";  //审核通过
static NSString* const  kOpenState_REFUSE               = @"REFUSE";  //审核失败
static NSString* const  kOpenState_LOGOFF               = @"LOGOFF";  //注销
static NSString* const  kOpenState_LOCKED               = @"LOCKED";  //禁用


typedef enum {
    kUserSexType_man = 1,//
    kUserSexType_woman = 2,//
    kUserSexType_uknown = 0,//
} kUserSexType; //用户性别


typedef enum {
    kOrderClassType_product             = 1,//超市购物订单
    kOrderClassType_fix                 = 2,//报修订单
    kOrderClassType_dryclean            = 3,//干洗订单
    kOrderClassType_paopao              = 4,//跑跑订单
    kOrderClassType_balance_recharge    = 11,//用户余额充值
    kOrderClassType_balance_present     = 12,//用户余额提现
    kOrderClassType_balance_collection  = 13,//用户收款
    kOrderClassType_balance_transfer    = 14,//用户转账
    kOrderClassType_paopao_apply        = 21,//申请跑跑腿
    kOrderClassType_fee_peroperty       = 31,//物管费
    kOrderClassType_fee_mobile          = 32,//手机缴费
    kOrderClassType_fee_sdq             = 33,//水电气缴费
    kOrderClassType_fee_parking         = 34,//停车缴费
} kOrderClassType;


//typedef enum {
//    kOrderFixStatus_waitUserPay,//待用户支付
//    kOrderFixStatus_userHavePay,//用户已支付
//    kOrderFixStatus_waitShopBidding,//待商家竞价
//    kOrderFixStatus_shopHaveReceiving,//商家已接单
//    kOrderFixStatus_shopInService,//商家正在服务中
//    kOrderFixStatus_done,//订单完成
//    kOrderFixStatus_cancel,//订单取消
//} kOrderFixStatus; //报修流程状态


typedef enum {
    kComplaintType_company      = 1,//
    kComplaintType_community    = 2,//
    kComplaintType_people       = 3,//
} kComplaintType; //用户投诉建议类型 1:公司建议；2：社区物管投诉 3:投诉居民


typedef enum {
    kWalletRecordType_input      = 1,//
    kWalletRecordType_output    = 2//
} kWalletRecordType; //!< 记录类型，1:收入、2:支出


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
    ZLHomeFunctionTypeQuik,//Function类型为缴费
    ZLHomeFunctionTypeSuperMarket,//Function类型为超市
    ZLHomeFunctionTypeRepair,//Function类型为报修
    ZLHomeFunctionTypeHouseKeeping,//Function类型为家政
    ZLHomeFunctionTypeConvenience,//Function类型为便民服务
    ZLHomeFunctionTypeRunningMan,//Function类型为跑跑腿
    ZLHomeFunctionTypeNote,//Function类型为公告
    ZLHomeFunctionTypeNeighbor,//Function类型为邻里圈
}ZLHomeFunctionType;


typedef enum{
    ZLHomeAdvTypeSystem = 1,//1:原生
    ZLHomeAdvTypeWeb = 0,//0:WAP
}ZLHomeAdvType;//首页广告跳转类型



typedef enum{
    ZLHomeNoteTypeSystem = 0,//0：平台
    ZLHomeNoteTypeCommunity = 1,//1：社区
}ZLHomeNoteType;//首页公告类型


typedef enum{
    ZLHomeNewsTypeNote = 1,//1:公告
    ZLHomeNewsTypeActivity = 2,//2：活动
    ZLHomeNewsTypeNews = 3,//3：新闻
}ZLHomeNewsType;//首页新闻类型



typedef enum{
    ZLShopHomeCampainTypeWap,//0:wap
    ZLShopHomeCampainTypeSys,//1是原生
}ZLShopHomeCampainType;//社区超市首页活动类型



typedef enum {
    kFileType_photo = 1,//
    kFileType_video = 2,//
} kFileType; //文件类型（1-图片，2-音频）


typedef enum{
    ZLRightGoodsTypeFromCamp = 1,//1:从活动来
    ZLRightGoodsTypeFromClass = 2,//2:从分类来
}ZLRightGoodsType;//社区超市首页活动类型


typedef enum{
    ZLShopTypeSuperMarket = 1,///1:社区超市
    ZLShopTypeFix = 2,///2:物业报修
    ZLShopTypeHouseKeeping = 3,///3:家政干洗
}ZLShopType;//社区超市首页活动类型


typedef enum{
    ZLShopSendTypeWithSelf = 1,///1:自提
    ZLShopSendTypeWithShop = 2,///2:店铺配送
    ZLShopSendTypeWithPaopao = 3,///2:跑跑腿
}ZLShopSendType;///社区超市订单配送方式


typedef enum{
    ///1:提交订单选择优惠卷页面
    ZLPushCouponVCTypeWithCommitOrder = 1,
    ///2:普通优惠卷页面
    ZLPushCouponVCTypeWithCouponVC = 2,
}ZLPushCouponVCType;///进入优惠卷vc页面类型


//typedef enum{
//    ///1:社区超市订单
//    ZLCommitOrderTypeWithSuperMarket = 1,
//    ///2:报修订单
//    ZLCommitOrderTypeWithFix = 2,
//    ///3:家政订单
//    ZLCommitOrderTypeWithHousKeeping = 3,
//    ///4:跑跑腿订单
//    ZLCommitOrderTypeWithPPt = 4,
//}ZLCommitOrderType;///提交订单类型



typedef enum{
    ///1:去支付
    ZLGoPayTypeWithConfirmPay = 1,
    ///2:发起支付
    ZLPayTypeWithCreatePay = 2,
}ZLGoPayType;///发起支付和创建

typedef enum{
    ///1:支付宝支付
    ZLPayTypeWithAlipay = 1,
    ///2:微信支付
    ZLPayTypeWithWechat = 2,
    ///3:余额支付
    ZLPayTypeWithBalance = 3,
}ZLPayType;///支付通道类型


typedef enum{
    ///1:成功
    ZLBalancePayStatus_SUCCESS = 1,
    ///2:失败
    ZLBalancePayStatus_FAIL = 2,
    ///3:无支付密码
    ZLBalancePayStatus_NOPASS = 3,
}ZLBalancePayStatus;///[余额]余额支付创建状态


typedef enum {
    ZLHydroelectricTypeWithProvince,///选择省份
    ZLHydroelectricTypeWithCity,///选择市区县
    ZLHydroelectricTypeWithPayType,///选择缴费类型
    ZLHydroelectricTypeWithPayUnint,///选择缴费单位
    ZLHydroelectricTypeWithFind,///查询
} ZLHydroelectricType;///选择的类型


typedef enum {
    ZLOperatorPPTOrderStatusWithAccept = 1,///接单
    ZLOperatorPPTOrderStatusWithServicing = 2,///服务中
    ZLOperatorPPTOrderStatusWithCancel = 3,///取消
    ZLOperatorPPTOrderStatusWithFinish = 4,///完成
} ZLOperatorPPTOrderStatus;///跑腿订单通用操作


typedef enum {
    
    ZLOrdreStatusWithSymb,///待处理
    ZLOrdreStatusWithFinish,///已完成
    ZLOrdreStatusWithCancel,///已取消
    
}ZLOrdreStatus;///订单状态

typedef enum {
    
    ZLRateVCTypeWithShop,///评价界面类型-店铺
    ZLRateVCTypeWithPPT,///评价界面类型-跑跑腿
    
}ZLRateVCType;///评价界面类型

#endif /* CustomDefine_h */
