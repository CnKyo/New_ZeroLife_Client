//
//  ZLExtension.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/28.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomDefine.h"
#import <LKDBHelper/LKDBHelper.h>
#import <MJExtension/MJExtension.h>
#import "NSObject_Objc.h"
#import "APIClient.h"
#import "ZLHttpRequest.h"

@interface ZLExtension : NSObject

@end
#pragma mark - NSDictionary自定义
@interface NSDictionary (QUAdditions)
-(id)objectWithKey:(NSString *)key; //返回有效值
@end

@interface NSMutableDictionary (QUAdditions)
///设置必须有的值
- (void)setNeedStr:(NSString *)anObject forKey:(id)aKey;
//当值不为空时，设置该值
- (void)setValidStr:(NSString *)anObject forKey:(id)aKey;
- (void)setInt:(int)anObject forKey:(id)aKey;
@end
#pragma mark----****----基本数据结构
@interface ZLBaseObj : NSObject
@property (nonatomic,strong) NSString   *mTitle;

@property (nonatomic,assign) int        mState;

@property (nonatomic,assign) BOOL        mSucess;

@property (nonatomic,strong) id         mData;


@property (nonatomic,assign) int        mAlert;


@property (nonatomic,strong) NSString   *mMessage;


-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

+(ZLBaseObj *)infoWithError:(NSString*)error;

@end
#pragma mark----****----用户信息

@class ZLWalletObj;
///
@interface ZLUserInfo : NSObject
///
@property (nonatomic,strong) NSArray        *ZLCommunityArr;
///
@property (nonatomic,strong) NSString        *ZLUser_add_time;
///
@property (nonatomic,strong) NSString        *ZLUser_birth;
///
@property (nonatomic,assign) int        ZLUser_city;
///
@property (nonatomic,assign) int        ZLUser_county;
///
@property (nonatomic,strong) NSString        *ZLUser_emaill;
///
@property (nonatomic,strong) NSString        *ZLUser_header;
///
@property (nonatomic,assign) int        ZLUser_id;
///
@property (nonatomic,assign) int        ZLUser_is_notify;
///
@property (nonatomic,strong) NSString        *ZLUser_nick;
///
@property (nonatomic,strong) NSString        *ZLUser_phone;
///
@property (nonatomic,assign) int        ZLUser_province;
///
@property (nonatomic,strong) NSString        *ZLUser_qrcode;
///
@property (nonatomic,assign) int        ZLUser_sex;
///
@property (nonatomic,strong) ZLWalletObj        *ZLWallet;

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

#pragma mark----****----登录
///需要登录
- (BOOL)ZLIsNeedLogin;
///用户信息实效
- (BOOL)ZLUserIsValid;
/**
 *  退出登录
 */
+ (void)logOut;
///返回当前用户信息
+ (ZLUserInfo *)ZLCurrentUser;

///登录
+ (void)ZLLoginWithPhone:(NSString *)mPhone andPwd:(NSString *)mPwd block:(void(^)(ZLBaseObj *mBaseObj,ZLUserInfo *mUser))block;

///注册
+ (void)ZLRegistPhone:(NSString *)mPhone andPwd:(NSString *)mPwd andCode:(NSString *)mCode block:(void(^)(ZLBaseObj *mBaseObj))block;

///获取验证码
+ (void)ZLGetVerigyCode:(NSString *)mCode andType:(int)mtype block:(void(^)(ZLBaseObj *mBaseObj))block;
///获取首页banner
+ (void)ZLgetHomeBanner:(void(^)(ZLBaseObj *mBaseObj,NSArray *mArr))block;


@end
///用户默认绑定小区对象
@interface ZLUserCommunityObj : NSObject
///小区id
@property (assign,nonatomic) int ZLUmut_id;
///小区名称
@property (strong,nonatomic) NSString* ZLUmut_name;
///小区所属省id
@property (assign,nonatomic) int ZLUmut_province;
///小区所属市id
@property (assign,nonatomic) int ZLUmut_city;
///小区所属区县id
@property (assign,nonatomic) int ZLUmut_county;
///小区地址
@property (strong,nonatomic) NSString* ZLUmut_address;
///小区纬度
@property (strong,nonatomic) NSString* ZLUmut_lng;
///小区经度
@property (strong,nonatomic) NSString* ZLUmut_lat;
///小区所属县区名称
@property (strong,nonatomic) NSString* ZLGion_name;

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;
@end
///钱包对象
@interface ZLWalletObj : NSObject
///用户id
@property (assign,nonatomic) int ZLUser_id;
///余额
@property (assign,nonatomic) float ZLUwal_balance;
///钱包ID
@property (assign,nonatomic) int ZLUwal_id;
///积分
@property (assign,nonatomic) int ZLUwal_score;
///钱包状态（normal 正常 locked 锁定）
@property (strong,nonatomic) NSString* ZLUwal_state;

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

@end

@interface ZLBanner : NSObject

@property (assign,nonatomic) int bnr_id;

@property (assign,nonatomic) int bnr_type;
@property (assign,nonatomic) int bnr_sort;

@property (strong,nonatomic) NSString* bnr_explain;
@property (strong,nonatomic) NSString* bnr_page;
@property (strong,nonatomic) NSString* bnr_image;
@property (strong,nonatomic) NSString* bnr_state;


@end

