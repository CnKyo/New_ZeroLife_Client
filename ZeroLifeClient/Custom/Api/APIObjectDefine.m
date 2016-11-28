//
//  APIObjectDefine.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "APIObjectDefine.h"

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
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"msg": @"result"};
}


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
    info.code = RESP_STATUS_YES;
    return info;
}

-(void)setCode:(int)code
{
    _code = code;
    
    if (code == 20004)
        [self performSelector:@selector(startLogin) withObject:nil afterDelay:0.8];
}

-(void)startLogin
{
//    UIViewController *se = [UIViewController topViewController];
//    if (![se isKindOfClass:[LoginTVC class]]) {
//        [LoginTVC startPresent:se];
//    }
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
@end



@implementation HouseObject
@end


@implementation CouponObject
@end


@implementation BankCardObject
@end

@implementation ZLGoPayObject

@end

@implementation ZLSeletedAddress

+ (ZLSeletedAddress *)ShareClient{

    //只赋值一次
    static ZLSeletedAddress *mAddress = nil;
    
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

@end


@implementation ZLUserInfo
{
    
    NSOperationQueue *queue;
    NSURLConnection *_connection;
    NSMutableData *_reveivedData;
}

static ZLUserInfo *g_user = nil;
bool g_bined = NO;

+ (ZLUserInfo *)ZLCurrentUser{
    if (g_user) {
        return g_user;
    }
    if (g_bined) {
        MLLog(@"警告！递归错误！");
        return nil;
    }
    g_bined = YES;
    @synchronized (self) {
        if (!g_user) {
            g_user = [ZLUserInfo loadUserInfo];
        }
    }
    g_bined = NO;
    return g_user;
    
}
+(ZLUserInfo*)loadUserInfo
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dat = [def objectForKey:@"userInfo"];
    if( dat )
    {
        ZLUserInfo* tu = [ZLUserInfo mj_objectWithKeyValues:dat];
        return tu;
    }
    return nil;
}
+(void)cleanUserInfo
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:nil forKey:@"userInfo"];
    [def synchronize];
}
-(void)saveUserInfo:(NSDictionary *)dccat
{
    dccat = [Util delNUll:dccat];
    
    NSMutableDictionary *dcc = [[NSMutableDictionary alloc] initWithDictionary:dccat];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:dcc forKey:@"userInfo"];
    
    
    
    [def synchronize];
}

+ (void)ZLDealSession:(APIObject *)info andPwd:(NSString *)mPwd andOpenId:(NSString *)mOpenId block:(void(^)(APIObject* resb, ZLUserInfo *user))block{
    
    if (info.code == 200) {
        NSDictionary *mTempDic = info.data;
        NSMutableDictionary* tdic = [[NSMutableDictionary alloc]initWithDictionary:info.data];
        if (mPwd) {
            [tdic setObject:mPwd forKey:@"mPwd"];
        }
        if (mOpenId) {
            [tdic setObject:mOpenId forKey:@"mOpenId"];
            
        }
        
        ZLUserInfo *tu = [ZLUserInfo mj_objectWithKeyValues:tdic];
        mTempDic = tdic;
        
        
        if ([tu ZLUserIsValid]) {
            [[ZLUserInfo alloc] saveUserInfo:mTempDic];
            g_user = nil;
            
        }
    }
    
    block(info,[ZLUserInfo ZLCurrentUser]);
}
- (BOOL)ZLUserIsValid{
    
    return self.user_id != 0;
}
+ (BOOL)isNeedLogin{
    
    return [ZLUserInfo ZLCurrentUser] == nil;
}
//退出登陆
+(void)logOut
{
    //    [UserDefaults() loadUserZro];
    //    [ZLUserInfo closePush];
    /**
     *  清除用户信息
     */
    [ZLUserInfo cleanUserInfo];
    g_user = nil;
    
    
}

@end

@implementation ZLWalletObj



@end

@implementation ZLUserCommunityObj



@end
@implementation ZLHomeBanner



@end

@implementation ZLHomeObj



@end

@implementation ZLHomeAdvList



@end

@implementation ZLHomeCompainNoticeList



@end
