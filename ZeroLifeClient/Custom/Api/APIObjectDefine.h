//
//  APIObjectDefine.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomDefine.h"
#import <LKDBHelper/LKDBHelper.h>
#import <MJExtension/MJExtension.h>
#import <JKCategories/NSString+JKHash.h>


#pragma mark - NSDictionary自定义
@interface NSDictionary (QUAdditions)
-(id)objectWithKey:(NSString *)key; //返回有效值
@end

@interface NSMutableDictionary (QUAdditions)
- (void)setNeedStr:(NSString *)anObject forKey:(id)aKey;  //设置必须有的值
- (void)setValidStr:(NSString *)anObject forKey:(id)aKey;  //当值不为空时，设置该值
- (void)setInt:(int)anObject forKey:(id)aKey;
@end



@interface NSString(QUAdd)
-(NSString *)compSelfIsNone;
+(NSString *)houseIsOwner:(BOOL)is_owner; //得到房主租客文字
+(NSString *)strUserSexType:(kUserSexType)type;  //得到性别文字
+(NSString *)urlWithExtra:(NSString *)str;  //组合url地址
@end


#pragma mark - NSObject
@interface NSObject (QUAdd)
/**
 *  把该对象object的数组集插入到db中
 *
 *  @param arr object的arr
 */
+(void)arrInsertToDB:(NSArray *)arr;
@end




#pragma mark - shareSDK 菜谱

@interface APIShareSdkObject : NSObject
@property (nonatomic,strong) id                     result;         //正文
@property (nonatomic,strong) NSString *             msg;   //错误消息
@property (nonatomic,assign) int                    retCode;         //非0表示 错误,调试使用
+(APIShareSdkObject *)infoWithError:(NSError *)error;
+(APIShareSdkObject *)infoWithErrorMessage:(NSString *)errMsg;
@end



@interface CookCategoryInfoObject : NSObject
@property (nonatomic, strong) NSString *            ctgId;              //分类ID
@property (nonatomic, strong) NSString *            name;              //分类描述
@property (nonatomic, strong) NSString *            parentId;              //上层分类ID
@end

@interface CookCategoryObject : NSObject
@property (nonatomic, strong) CookCategoryInfoObject *  categoryInfo;              //分类ID
@property (nonatomic, strong) NSMutableArray *      childs;              //子集合
@end


@interface CookRecipeStepObject : NSObject
@property (nonatomic, strong) NSString *            img;              //图片显示
@property (nonatomic, strong) NSString *            step;               //制作步骤
@end


@interface CookRecipeObject : NSObject
@property (nonatomic, strong) NSString *            img;              //预览图地址
@property (nonatomic, strong) NSString *            ingredients;              //原材料
@property (nonatomic, strong) NSMutableArray *      method;              //具体方法
@property (nonatomic, strong) NSString *            sumary;              //简介
@property (nonatomic, strong) NSString *            title;              //标题
@property (nonatomic, strong) NSMutableArray *      childs;              //子集合
@end


@interface CookObject : NSObject
@property (nonatomic, strong) NSMutableArray *      ctgIds;              //分类ID
@property (nonatomic, strong) NSString *            ctgTitles;              //分类标签
@property (nonatomic, strong) NSString *            menuId;              //菜谱id
@property (nonatomic, strong) NSString *            name;              //菜谱名称
@property (nonatomic, strong) NSString *            thumbnail;              //预览图地址
@property (nonatomic, strong) CookRecipeObject *    recipe;              //制作步骤
@end



@interface APIObjectDefine : NSObject

@end




#pragma mark - APIObject 接口外层对象
@interface APIObject : NSObject
@property (nonatomic,strong) id                     data;         //正文
@property (nonatomic,strong) NSString *             msg;   //错误消息
@property (nonatomic,assign) int                    code;         //非0表示 错误,调试使用
+(APIObject *)infoWithError:(NSError *)error;
+(APIObject *)infoWithErrorMessage:(NSString *)errMsg;
+(APIObject *)infoWithReLoginErrorMessage:(NSString *)errMsg;
@end



#pragma mark -  省市区对象
@interface RegionObject : NSObject
@property(nonatomic,assign) int                     gion_id;         //
@property(nonatomic,strong) NSString *              gion_code;            //地区编码
@property(nonatomic,strong) NSString *              gion_name;          // 地区名字
@property(nonatomic,assign) int                     parent_id;             // 上级ID
@property(nonatomic,assign) int                     gion_level;              // 级别
@property(nonatomic,strong) NSString *              gion_name_en;           //地区拼音名称
@property(nonatomic,strong) NSString *              gion_name_en_s;            // 地区短名称
@end


//用户选择省市区对象
@interface ZLSeletedAddress : NSObject
@property (nonatomic,assign) int                    mProvince;
@property (nonatomic,assign) int                    mCity;
@property (nonatomic,assign) int                    mArear;
@property (nonatomic,strong) NSString *             mProvinceStr;
@property (nonatomic,strong) NSString *             mCityStr;
@property (nonatomic,strong) NSString *             mArearStr;

+ (ZLSeletedAddress *)ShareClient;
+(void)destory;
-(NSString *)getAddress;

@end




#pragma mark -  用户地址对象
@interface AddressObject : NSObject
@property(nonatomic,assign) int                     addr_id;         //
@property(nonatomic,assign) kUserSexType            addr_sex;         //
@property(nonatomic,strong) NSString *              user_id;            //用户id
@property(nonatomic,strong) NSString *              addr_name;          // 收货人姓名
@property(nonatomic,strong) NSString *              addr_phone;             // 手机号
@property(nonatomic,strong) NSString *              addr_address;            // 详细地址
@property(nonatomic,assign) int                     addr_province;         //
@property(nonatomic,assign) int                     addr_city;         //
@property(nonatomic,assign) int                     addr_county;         //
@property(nonatomic,strong) NSString *              addr_province_val;            // 省
@property(nonatomic,strong) NSString *              addr_city_val;            // 市
@property(nonatomic,strong) NSString *              addr_county_val;            // 区
@property(nonatomic,assign) int                     addr_sort;         //排序（从大到小，第一个为默认地址）
@property(nonatomic,assign) BOOL                    addr_state;         // 可用状态
+(AddressObject *)defaultAddress; //默认选择地区
-(NSMutableString *)getProvinceCityCountyStr; //获取省市区文字
-(NSMutableString *)getProvinceCityCountyAddressStr; //获取完整地址
@end


#pragma mark -  用户房屋对象
@interface HouseObject : NSObject
@property(nonatomic,assign) int                     real_id;         //房屋认证ID
@property(nonatomic,assign) int                     user_id;            //用户id
@property(nonatomic,assign) kUserSexType            real_sex;         //
@property(nonatomic,strong) NSString *              real_owner;          // 联系人姓名
@property(nonatomic,strong) NSString *              real_phone;             // 手机号
@property(nonatomic,assign) int                     real_province;         //所属省
@property(nonatomic,assign) int                     real_city;         //所属市
@property(nonatomic,assign) int                     real_county;         //所属县区
@property(nonatomic,strong) NSString *              real_province_val;            // 省
@property(nonatomic,strong) NSString *              real_city_val;            // 市
@property(nonatomic,strong) NSString *              real_county_val;            // 区
@property(nonatomic,assign) int                     cmut_id;              // 小区id
@property(nonatomic,strong) NSString *              real_cmut_name;           //小区名称
@property(nonatomic,assign) int                     real_ban;           //楼栋
@property(nonatomic,assign) int                     real_unit;           //单元
@property(nonatomic,assign) int                     real_floor;           //楼层
@property(nonatomic,assign) int                     real_number;           //房号
@property(nonatomic,assign) BOOL                    real_is_owner;         // 是否为业主（Y(1), N(0)）
@property(nonatomic,assign) int                     real_sort;         //排序（从大到小）
@property(nonatomic,strong) NSString *              real_add_time;           //认证时间
+(HouseObject *)defaultAddress;
-(NSMutableString *)getProvinceCityCountyStr; //获取省市区文字
-(NSMutableString *)getFullStr; //获取完整地址文字
-(NSString *)getBanUnitFloorNumberStr; //获取楼单元文字
@end





#pragma mark -  小区对象
@interface CommunityObject : NSObject
@property(nonatomic,assign) int                     cmut_id;         //小区id
@property(nonatomic,strong) NSString *              cmut_name;          // 小区名称
@property(nonatomic,assign) int                     cmut_province;         //小区所属省id
@property(nonatomic,assign) int                     cmut_city;         //小区所属市id
@property(nonatomic,assign) int                     cmut_county;         //小区所属区县id
@property(nonatomic,strong) NSString *              cmut_address;            // 小区地址
@property(nonatomic,assign) double                  cmut_lng;         //小区经度
@property(nonatomic,assign) double                  cmut_lat;         //小区纬度
@property(nonatomic,strong) NSString *              gion_name;            // 小区所属县区名称
@property(nonatomic,strong) NSString *              cmut_add_time;            // 小区添加时间
@end


#pragma mark -  小区楼栋对象
@interface CommunityBansetObject : NSObject //楼栋对象
@property(nonatomic,assign) int                     bset_unit;         //单元
@property(nonatomic,assign) int                     bset_number;         //户数最大值
@property(nonatomic,assign) int                     bset_floor;         //楼层最大值
@end

@interface CommunityUmitsetObject : NSObject //单元对象
@property(nonatomic,assign) int                     bset_ban;         //楼栋号
@property(nonatomic,strong) NSArray *               umitList;          //单元列表
@end


///钱包对象
@interface WalletObject : NSObject
@property (assign,nonatomic) int                    user_id;           ///用户id
@property (assign,nonatomic) float                  uwal_balance;       ///余额
@property (assign,nonatomic) int                    uwal_id;      ///钱包ID
@property (assign,nonatomic) int                    uwal_score;     ///积分
@property (strong,nonatomic) NSString *             uwal_state;///钱包状态（normal 正常 locked 锁定）
@end


#pragma mark -  用户优惠券对象
@interface CouponObject : NSObject
@property (nonatomic,strong) NSString *             iD;         //
@property (nonatomic,assign) kCouponType            type;
@end



#pragma mark -  用户银行卡对象
@interface BankCardObject : NSObject
@property (nonatomic,strong) NSString *             iD;         //
@property (nonatomic,strong) NSString *             name;         //
@end

#pragma mark----****----收银台测试model
@interface ZLGoPayObject : NSObject
@property(nonatomic, assign) BOOL                   isSelected;
@end









#pragma mark -  用户订单对象
@interface OrderObject : NSObject
@property (nonatomic,strong) NSString *             iD;         //
@property (nonatomic,assign) kOrderClassType        type;         //
@property (nonatomic,assign) int                    status;         //
@end

#pragma mark----****----用户信息

@class WalletObject;
@class CommunityObject;
///
@interface ZLUserInfo : NSObject
@property (assign,nonatomic) int                    user_id; ///对应用户id
@property (strong,nonatomic) NSString*              user_nick; ///用户昵称
@property (assign,nonatomic) kUserSexType           user_sex; ///性别（UNKNOW(0), MALE(1), FEMALE(2)）
@property (strong,nonatomic) NSString*              user_phone; //手机号
@property (strong,nonatomic) NSString*              user_header; //用户头像图片url
@property (strong,nonatomic) NSString*              user_birth; //生日
@property (assign,nonatomic) int                    user_province; //所属省
@property (assign,nonatomic) int                    user_city; //所属市
@property (assign,nonatomic) int                    user_county; //所属县区
@property (strong,nonatomic) NSString*              user_qrcode; //用户二维码图片url
@property (strong,nonatomic) NSString*              user_emaill; //用户邮箱
@property (assign,nonatomic) int                    user_is_notify; //是否开启推送消息功能（Y(1), N(0)）
@property (strong,nonatomic) NSString*              user_add_time; ///

@property (nonatomic,strong) WalletObject*           wallet; //用户钱包信息
@property (nonatomic,strong) CommunityObject*       community; //用户绑定小区信息

#pragma mark----****----登录
///需要登录
- (BOOL)isNeedLogin;
///用户信息实效
- (BOOL)ZLUserIsValid;

//更新用户数据
+(void)updateUserInfo:(ZLUserInfo *)user;
/**
 *  退出登录
 */
+ (void)logOut;
///返回当前用户信息
+ (ZLUserInfo *)ZLCurrentUser;
//+ (void)ZLDealSession:(APIObject *)info andPwd:(NSString *)mPwd andOpenId:(NSString *)mOpenId block:(void(^)(APIObject* resb, ZLUserInfo *user))block;

@end
/////用户默认绑定小区对象
//@interface ZLUserCommunityObj : NSObject
/////小区id
//@property (assign,nonatomic) int ZLUmut_id;
/////小区名称
//@property (strong,nonatomic) NSString* ZLUmut_name;
/////小区所属省id
//@property (assign,nonatomic) int ZLUmut_province;
/////小区所属市id
//@property (assign,nonatomic) int ZLUmut_city;
/////小区所属区县id
//@property (assign,nonatomic) int ZLUmut_county;
/////小区地址
//@property (strong,nonatomic) NSString* ZLUmut_address;
/////小区纬度
//@property (strong,nonatomic) NSString* ZLUmut_lng;
/////小区经度
//@property (strong,nonatomic) NSString* ZLUmut_lat;
/////小区所属县区名称
//@property (strong,nonatomic) NSString* ZLGion_name;
//
//
//@end
/////钱包对象
//@interface ZLWalletObj : NSObject
/////用户id
//@property (assign,nonatomic) int user_id;
/////余额
//@property (assign,nonatomic) float uwal_balance;
/////钱包ID
//@property (assign,nonatomic) int uwal_id;
/////积分
//@property (assign,nonatomic) int uwal_score;
/////钱包状态（normal 正常 locked 锁定）
//@property (assign,nonatomic) ZLWalletStatu uwal_state;
//
//
//@end
///


@interface ZLHomeBanner : NSObject
@property (assign,nonatomic) int                    bnr_id; ///banner	ID
@property (assign,nonatomic) int                    bnr_type;///类型(1:平台/2:超市)
@property (assign,nonatomic) int                    bnr_sort;///排序
@property (strong,nonatomic) NSString*              bnr_explain;///banner说明
@property (strong,nonatomic) NSString*              bnr_page;///page(跳转界面)
@property (strong,nonatomic) NSString*              bnr_image;///url（图片URL）
@property (assign,nonatomic) ZLHomeBannerType       bnr_state;///状态1平台 2超市
@end



@interface ZLHomeObj : NSObject

//平台活动广告
@property (strong,nonatomic) NSArray* sAdvertList;

//平台公告(List)
@property (strong,nonatomic) NSArray* eCompanyNoticeList;


@end



///平台活动广告  //活动广告
@interface ZLHomeAdvList : NSObject
@property (assign,nonatomic) int                    shop_id;//店铺ID
@property (assign,nonatomic) int                    adv_id;//广告活动ID
@property (assign,nonatomic) int                    cpn_id;//公司ID
@property (strong,nonatomic) NSString*              distance;//活动距离(单位：米)
@property (strong,nonatomic) NSString*              adv_image;//活动图片
@property (strong,nonatomic) NSString*              adv_click_url;////点击的URL
@property (assign,nonatomic) int                    adv_type;//类型（0:WAP;1:原生）
@property (assign,nonatomic) int                    cam_type;//活动类型
@end



///平台公告(List)
@interface ZLHomeCompainNoticeList : NSObject
@property (assign,nonatomic) int                    not_id;//公告ID
@property (strong,nonatomic) NSString*              not_title;//公告标题;
@property (assign,nonatomic) int                    cmut_id;//社区ID
@property (assign,nonatomic) int                    not_is_cmut;//是否是社区发布(0：平台；1：社区)
@property (assign,nonatomic) int                    not_state;//新闻状态
@property (strong,nonatomic) NSString*              not_sub;//内容简介
@property (strong,nonatomic) NSString*              not_add_time;//公告发布时间
@property (strong,nonatomic) NSString*              not_image;////公告图片
@property (strong,nonatomic) NSString*              not_deadline;//失效时间
@property (strong,nonatomic) NSString*              not_add_person;//发布者
@property (strong,nonatomic) NSString*              not_type;
@end



@interface ZLHomeCommunity : NSObject
@property (assign,nonatomic) int                    cmut_id;///小区id
@property (strong,nonatomic) NSString*              cmut_name;///小区名称
@property (assign,nonatomic) int                    cmut_province;///小区所属省id
@property (assign,nonatomic) int                    cmut_city;///小区所属市id
@property (assign,nonatomic) int                    cmut_county;///小区所属区县id
@property (strong,nonatomic) NSString*              cmut_address;///小区地址
@property (strong,nonatomic) NSString*              cmut_lng;///小区纬度
@property (strong,nonatomic) NSString*              cmut_lat;///小区经度
@property (strong,nonatomic) NSString*              gion_name;///小区所属县区名称
@end



//便民服务对象
@interface ExternalPlatformObject : NSObject
@property (assign,nonatomic) int                    pla_id;///对应id
@property (strong,nonatomic) NSString*              pla_name;///第三方名称
@property (strong,nonatomic) NSString*              pla_logo;///Logo图片URL
@property (strong,nonatomic) NSString*              pla_uri;///点击链接url
@end




