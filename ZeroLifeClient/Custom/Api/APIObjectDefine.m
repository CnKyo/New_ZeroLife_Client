//
//  APIObjectDefine.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "APIObjectDefine.h"
#import "UIViewController+Additions.h"
#import "ZLLoginViewController.h"

#pragma mark -
#pragma mark NSDictionary
@implementation NSDictionary (QUAdditions)
-(id)objectWithKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if ([obj isEqual:[NSNull null]]) {
        obj = nil;
    }
    return obj;
}
@end

@implementation NSMutableDictionary (QUAdditions)
- (void)setNeedStr:(NSString *)anObject forKey:(id)aKey
{
    if (anObject.length > 0)
        [self setObject:anObject forKey:aKey];
    else
        [self setObject:@"" forKey:aKey];
}

- (void)setValidStr:(NSString *)anObject forKey:(id)aKey
{
    if (anObject.length > 0)
        [self setObject:anObject forKey:aKey];
}

- (void)setInt:(int)anObject forKey:(id)aKey
{
    [self setObject:StringWithInt(anObject) forKey:aKey];
}
@end



@implementation NSString(QUAdd)
-(NSString *)compSelfIsNone
{
    if (self==nil || self.length==0)
        return @"无";
    else
        return self;
}

+(NSString *)houseIsOwner:(BOOL)is_owner
{
    return is_owner ? @"房主" : @"租客";
}

+(NSString *)urlWithExtra:(NSString *)str
{
    return [NSString stringWithFormat:@"%@%@", kAFAppDotNetApiExtraURLString, str];
}

+(NSString *)strUserSexType:(kUserSexType)type
{
    NSString *str = @"";
    switch (type) {
        case kUserSexType_uknown:
            str = @"未知";
            break;
        case kUserSexType_man:
            str = @"男";
            break;
        case kUserSexType_woman:
            str = @"女";
            break;
        default:
            break;
    }
    return str;
}

@end

@implementation NSObject(QUAdd)
+(void)arrInsertToDB:(NSArray *)arr
{
    Class clazz = [self class];
    //LKDBHelper* globalHelper = [clazz getUsingLKDBHelper];
    [LKDBHelper clearTableData:clazz];
    [clazz insertToDBWithArray:arr filter:^(id model, BOOL inserted, BOOL *rollback) {}];
    //    [globalHelper executeDB:^(FMDatabase *db) {
    //        [db beginTransaction];
    //        for (id item in arr) {
    //            [globalHelper insertToDB:item];
    //        }
    //        [db commit];
    //    }];
}
@end



#pragma mark -
#pragma mark APIObject
@implementation APIShareSdkObject

+(APIShareSdkObject *)infoWithError:(NSError *)error
{
    APIShareSdkObject *info = [[APIShareSdkObject alloc] init];
    NSString *des = [error.userInfo objectWithKey:@"NSLocalizedDescription"];
    if (des.length > 0)
        info.msg = des;
    else
        info.msg       = @"网络请示失败，请检查网络";
    info.retCode = 0;
    return info;
}

+(APIShareSdkObject *)infoWithErrorMessage:(NSString *)errMsg
{
    APIShareSdkObject *info = [[APIShareSdkObject alloc] init];
    info.msg       = errMsg;
    info.retCode = 0;
    return info;
}

-(void)loadErrorCode
{
    switch (_retCode) {
        case 200:
            self.msg = @"成功";
            break;
        case 10001:
            self.msg = @"appkey不合法";
            break;
        case 10020:
            self.msg = @"接口维护";
            break;
        case 10021:
            self.msg = @"接口停用";
            break;
            
        case 20101:
            self.msg = @"查询不到相关数据";
            break;
        case 20102:
            self.msg = @"手机号码格式错误";
            break;
            
        case 20301:
            self.msg = @"邮编号码为空";
            break;
        case 20302:
            self.msg = @"邮编号码查询不到对应的地址";
            break;
            
        case 20401:
            self.msg = @"城市参数为空";
            break;
        case 20402:
            self.msg = @"查询不到该城市的天气";
            break;
            
        case 20601:
            self.msg = @"请输入正确的15或18位身份证号码";
            break;
        case 20602:
            self.msg = @"错误的身份证或无结果";
            break;
            
        case 20701:
            self.msg = @"城市参数为空";
            break;
        case 20702:
            self.msg = @"查询不到该城市的空气质量";
            break;
            
        case 21401:
            self.msg = @"卡号有误,或者旧银行卡，暂时没有收录";
            break;
            
        case 21901:
            self.msg = @"查询不到相关数据";
            break;
        case 21902:
            self.msg = @"name为空或不合法";
            break;
            
        case 22001:
            self.msg = @"查询不到相关数据";
            break;
        case 22002:
            self.msg = @"name为空或不合法";
            break;
        default:
            break;
    }
}
@end


@implementation CookCategoryInfoObject
@end

@implementation CookCategoryObject
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"childs" : @"CookCategoryObject"};
}
@end



@implementation CookRecipeStepObject
@end

@implementation CookRecipeObject
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"method" : @"CookRecipeStepObject"};
}
@end

@implementation CookObject
@end








@implementation APIObjectDefine

@end






#pragma mark -
#pragma mark APIObject
@implementation APIObject
+(APIObject *)infoWithError:(NSError *)error
{
    APIObject *info = [[APIObject alloc] init];
    NSString *des = [error.userInfo objectForKey:@"NSLocalizedDescription"];
    if (des.length > 0)
        info.msg = des;
    else
        info.msg       = @"网络请示失败，请检查网络";
    info.code = RESP_STATUS_NO;
    return info;
}

+(APIObject *)infoWithErrorMessage:(NSString *)errMsg
{
    APIObject *info = [[APIObject alloc] init];
    info.msg       = errMsg;
    info.code = RESP_STATUS_NO;
    return info;
}

+(APIObject *)infoWithReLoginErrorMessage:(NSString *)errMsg
{
    APIObject *info = [[APIObject alloc] init];
    info.msg       = errMsg.length>0 ? errMsg : @"请登录";
    info.code = RESP_STATUS_LOGIN;
    return info;
}

-(void)setCode:(int)code
{
    _code = code;
    
    if (code == RESP_STATUS_LOGIN)
        [self performSelector:@selector(startLogin) withObject:nil afterDelay:0.8];
}
#pragma mark----****----登录
-(void)startLogin
{
    UIViewController *se = [UIViewController topViewController];
    if (![se isKindOfClass:[ZLLoginViewController class]]) {
        [ZLLoginViewController startPresent:se];
    }
}

@end



@implementation RegionObject

@end



@implementation OrderObject

@end




@implementation AddressObject
+(AddressObject *)defaultAddress
{
    AddressObject *item = [AddressObject searchSingleWithWhere:nil orderBy:nil];
    return item;
}

-(NSMutableString *)getProvinceCityCountyStr
{
    NSMutableString *str = [NSMutableString new];
    if (_addr_province_val.length > 0)
        [str appendString:_addr_province_val];
    
    if (_addr_city_val.length > 0)
        [str appendString:_addr_city_val];
    
    if (_addr_county_val.length > 0)
        [str appendString:_addr_county_val];
    return str;
}

-(NSMutableString *)getProvinceCityCountyAddressStr
{
    NSMutableString *str = [self getProvinceCityCountyStr];
    if (_addr_address.length > 0)
        [str appendString:_addr_address];
    return str;
}

@end



@implementation HouseObject
+(HouseObject *)defaultAddress
{
    HouseObject *item = [HouseObject searchSingleWithWhere:nil orderBy:nil];
    return item;
}
-(NSMutableString *)getProvinceCityCountyStr
{
    NSMutableString *str = [NSMutableString new];
    if (_real_province_val.length > 0)
        [str appendString:_real_province_val];
    
    if (_real_city_val.length > 0)
        [str appendString:_real_city_val];
    
    if (_real_county_val.length > 0)
        [str appendString:_real_county_val];
    return str;
}
-(NSMutableString *)getFullStr
{
    NSMutableString *str = [self getProvinceCityCountyStr];
    if (_real_cmut_name.length > 0)
        [str appendString:_real_cmut_name];
    return str;
}
-(NSString *)getBanUnitFloorNumberStr
{
    if (_real_ban==0 || _real_unit==0 || _real_floor==0 || _real_number==0) {
        return nil;
    }
    return [NSString stringWithFormat:@"%i-%i-%i-%i", _real_ban, _real_unit, _real_floor, _real_number];
}


@end



@implementation CommunityObject
@end

@implementation CommunityBansetObject
@end
@implementation CommunityUmitsetObject
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"umitList" : @"CommunityBansetObject"};
}
@end



@implementation WalletObject
@end


@implementation CouponObject
@end


@implementation BankCardObject
@end

@implementation ZLGoPayObject

@end


static ZLSeletedAddress *mAddress = nil;
@implementation ZLSeletedAddress

+ (ZLSeletedAddress *)ShareClient{
    @synchronized (self) {
        if (!mAddress) {
            mAddress = [[ZLSeletedAddress alloc] init];
        }
    }
    return mAddress;
}

-(NSString *)getAddress
{
    NSMutableString *str = [NSMutableString new];
    if (_mProvinceStr.length > 0)
        [str appendString:_mProvinceStr];
    
    if (_mCityStr.length > 0)
        [str appendString:_mCityStr];
    
    if (_mArearStr.length > 0)
        [str appendString:_mArearStr];
    
    return str;
}
+(void)destory
{
    mAddress = nil;
}

@end


@implementation ZLUserInfo
//{
//    
//    NSOperationQueue *queue;
//    NSURLConnection *_connection;
//    NSMutableData *_reveivedData;
//}

static ZLUserInfo *g_user = nil;
//bool g_bined = NO;

+ (ZLUserInfo *)ZLCurrentUser{
    @synchronized (self) {
        if (!g_user) {
            g_user = [ZLUserInfo searchSingleWithWhere:nil orderBy:nil];
        }
    }
    return g_user;
    
}

//+(void)cleanUserInfo
//{
//    [LKDBHelper clearTableData:[ZLUserInfo class]];
//    g_user = nil;
//}

+(void)updateUserInfo:(ZLUserInfo *)user
{
    [ZLUserInfo logOut];
    LKDBHelper* globalHelper = [ZLUserInfo getUsingLKDBHelper];
    [globalHelper insertToDB:user];
    g_user = user;
}


//-(void)saveUserInfo:(NSDictionary *)dccat
//{
//    dccat = [Util delNUll:dccat];
//    
//    NSMutableDictionary *dcc = [[NSMutableDictionary alloc] initWithDictionary:dccat];
//    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
//    
//    [def setObject:dcc forKey:@"userInfo"];
//    
//    
//    
//    [def synchronize];
//}
//
//+ (void)ZLDealSession:(APIObject *)info andPwd:(NSString *)mPwd andOpenId:(NSString *)mOpenId block:(void(^)(APIObject* resb, ZLUserInfo *user))block{
//    
//    if (info.code == 200) {
//        NSDictionary *mTempDic = info.data;
//        NSMutableDictionary* tdic = [[NSMutableDictionary alloc]initWithDictionary:info.data];
//        if (mPwd) {
//            [tdic setObject:mPwd forKey:@"mPwd"];
//        }
//        if (mOpenId) {
//            [tdic setObject:mOpenId forKey:@"mOpenId"];
//            
//        }
//        
//        ZLUserInfo *tu = [ZLUserInfo mj_objectWithKeyValues:tdic];
//        mTempDic = tdic;
//        
//        
//        if ([tu ZLUserIsValid]) {
//            [[ZLUserInfo alloc] saveUserInfo:mTempDic];
//            g_user = nil;
//            
//        }
//    }
//    
//    block(info,[ZLUserInfo ZLCurrentUser]);
//}
- (BOOL)ZLUserIsValid{
    
    return self.user_id != 0;
}
+ (BOOL)isNeedLogin{
    
    return [ZLUserInfo ZLCurrentUser] == nil;
}

//退出登陆
+(void)logOut
{
    [LKDBHelper clearTableData:[ZLUserInfo class]]; //清空用户信息表
    [LKDBHelper clearTableData:[WalletObject class]]; //清空用户钱包信息表
    [LKDBHelper clearTableData:[CommunityObject class]]; //清空用户绑定小区信息表
    [LKDBHelper clearTableData:[AddressObject class]]; //清空用户地址信息表
    [LKDBHelper clearTableData:[HouseObject class]]; //清空用户房屋绑定信息表
    g_user = nil;
}

@end

//@implementation ZLWalletObj
//
//@end

//@implementation ZLUserCommunityObj
//@end



@implementation ZLHomeBanner



@end

@implementation ZLHomeObj



@end

@implementation ZLHomeAdvList



@end

@implementation ZLHomeCompainNoticeList



@end

@implementation ZLHomeCommunity



@end





@implementation ExternalPlatformObject
@end

