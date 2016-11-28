//
//  ZLExtension.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/28.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLExtension.h"
#import "Util.h"
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
@interface ZLBaseObj()

@property (nonatomic,strong)    id mcoredat;


@end

@implementation ZLBaseObj

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        self.mData = [obj objectForKeyMy:@"data"];
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    _mTitle = [obj objectForKeyMy:@"title"];
    _mState = [[obj objectForKeyMy:@"code"] intValue];
    self.mMessage = [obj objectForKeyMy:@"msg"];
    self.mAlert = [[obj objectForKeyMy:@"alert"] intValue];
    self.mData = [obj objectForKeyMy:@"data"];
    
    
    if (self.mState == 200) {
        self.mSucess = YES;
    }else{
        self.mSucess = NO;
    }
    
}
+ (ZLBaseObj *)infoWithError:(NSString *)error{
    ZLBaseObj *retobj = ZLBaseObj.new;
    retobj.mTitle = @"";
    retobj.mState = 400301;
    retobj.mData = nil;
    retobj.mMessage = @"服务器君开小差啦!";
    return retobj;
}
@end

@implementation ZLExtension

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
        ZLUserInfo* tu = [[ZLUserInfo alloc]initWithObj:dat];
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
- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{

    

    _ZLUser_add_time = [[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_add_time"];
    _ZLUser_birth = [[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_birth"];
    _ZLUser_city = [[[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_city"] intValue];
    _ZLUser_county = [[[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_county"] intValue];
    _ZLUser_emaill = [[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_emaill"];
    _ZLUser_header  = [[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_header"];
    _ZLUser_id = [[[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_id"] intValue];
    _ZLUser_is_notify = [[[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_is_notify"] intValue];
    _ZLUser_phone = [[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_phone"];
    _ZLUser_province = [[[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_province"] intValue];
    _ZLUser_qrcode = [[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_qrcode"];
    _ZLUser_sex = [[[obj objectForKeyMy:@"user"] objectForKeyMy:@"user_sex"] intValue];

    _ZLWallet = [[ZLWalletObj alloc] initWithObj:[obj objectForKeyMy:@"wallet"]];
    

    NSMutableArray *mComty = [NSMutableArray new];
    id mArr =  [obj objectForKeyMy:@"community"];
    
    if ([mArr isEqual:[NSArray class]]) {
        for ( NSDictionary *dic in mArr) {
            [mComty addObject:[[ZLUserCommunityObj alloc] initWithObj:dic]];
        }

    }
    _ZLCommunityArr = mComty;

    
}
-(void)saveUserInfo:(NSDictionary *)dccat
{
    dccat = [Util delNUll:dccat];
    
    NSMutableDictionary *dcc = [[NSMutableDictionary alloc] initWithDictionary:dccat];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:dcc forKey:@"userInfo"];
    
    
    
    [def synchronize];
}

- (void)ZLDealSession:(ZLBaseObj *)info andPwd:(NSString *)mPwd andOpenId:(NSString *)mOpenId block:(void(^)(ZLBaseObj* resb, ZLUserInfo *user))block{

    if (info.mSucess || info.mState == 200) {
        NSDictionary *mTempDic = info.mData;
        NSMutableDictionary* tdic = [[NSMutableDictionary alloc]initWithDictionary:info.mData];
        if (mPwd) {
            [tdic setObject:mPwd forKey:@"mPwd"];
        }
        if (mOpenId) {
            [tdic setObject:mOpenId forKey:@"mOpenId"];
            
        }

        ZLUserInfo *tu = [[ZLUserInfo alloc] initWithObj:tdic];
        mTempDic = tdic;
        
        
        if ([tu ZLUserIsValid]) {
            [self saveUserInfo:mTempDic];
            g_user = nil;

        }
    }
    
    block(info,[ZLUserInfo ZLCurrentUser]);
}
- (BOOL)ZLUserIsValid{

    return self.ZLUser_id != 0;
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


+ (void)ZLLoginWithPhone:(NSString *)mPhone andPwd:(NSString *)mPwd block:(void(^)(ZLBaseObj *mBaseObj,ZLUserInfo *mUser))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"acc_phone"];
    [para setObject:mPwd forKey:@"acc_pass"];
    [para setObject:@"ios" forKey:@"sys_t"];
    [para setObject:[Util getAppVersion] forKey:@"app_v"];
    [para setObject:[Util getAPPBuildNum] forKey:@"sys_v"];

    
    [[ZLHttpRequest sharedHDNetworking] postUrl:@"user/user_login" parameters:para call:^(ZLBaseObj * _Nonnull info) {
        

        [[ZLUserInfo alloc] ZLDealSession:info andPwd:mPwd andOpenId:nil block:block];
    
        
    }];

}
+ (void)ZLRegistPhone:(NSString *)mPhone andPwd:(NSString *)mPwd andCode:(NSString *)mCode block:(void(^)(ZLBaseObj *mBaseObj))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"acc_phone"];
    [para setObject:mPwd forKey:@"acc_pass"];
    [para setObject:mCode forKey:@"v_code"];


    
    [[ZLHttpRequest sharedHDNetworking] postUrl:@"user/user_register" parameters:para call:^(ZLBaseObj * _Nonnull info) {
        
        if (info.mSucess) {
            block( info );
            
        }else{
            block( info );
            
        }
        
    }];
}

+ (void)ZLGetVerigyCode:(NSString *)mCode andType:(int)mtype block:(void(^)(ZLBaseObj *mBaseObj))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mCode forKey:@"mobile"];
    [para setObject:NumberWithInt(mtype) forKey:@"type"];

    
    
    [[ZLHttpRequest sharedHDNetworking] postUrl:@"common/get_sms_code" parameters:para call:^(ZLBaseObj * _Nonnull info) {
        
        if (info.mSucess) {
            block( info );
            
        }else{
            block( info );
            
        }
        
    }];
}

///获取首页banner
+ (void)ZLgetHomeBanner:(void(^)(ZLBaseObj *mBaseObj,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    [[ZLHttpRequest sharedHDNetworking] postUrl:@"home/banner" parameters:para call:^(ZLBaseObj * _Nonnull info) {
        
        NSMutableArray *mtempArr = [NSMutableArray new];
        
        if (info.mSucess) {
        
            id mArr = info.mData;
            
            if ([mArr isEqual:[NSArray class]]) {
                for (NSDictionary *dic in info.mData) {
                    [mtempArr addObject:[ZLBanner mj_objectWithKeyValues:dic]];
                }

            }
            
            
            block (info,mtempArr);
        
            
        }else{
            block (info,mtempArr);
            
        }
        
    }];
    
}
@end

@implementation ZLUserCommunityObj

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    
    _ZLUmut_id = [[obj objectForKeyMy:@"cmut_id"] intValue];
    _ZLUmut_province = [[obj objectForKeyMy:@"cmut_province"] intValue];
    _ZLUmut_city = [[obj objectForKeyMy:@"cmut_city"] intValue];
    _ZLUmut_county = [[obj objectForKeyMy:@"cmut_county"] intValue];

    _ZLUmut_name = [obj objectForKeyMy:@"cmut_name"];
    _ZLUmut_address = [obj objectForKeyMy:@"cmut_address"];
    _ZLUmut_lng = [obj objectForKeyMy:@"cmut_lng"];
    _ZLUmut_lat = [obj objectForKeyMy:@"cmut_lat"];
    _ZLGion_name = [obj objectForKeyMy:@"gion_name"];

}

@end

@implementation ZLWalletObj

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    _ZLUser_id = [[obj objectForKeyMy:@"user_id"] intValue];
    
    _ZLUwal_id = [[obj objectForKeyMy:@"uwal_id"] intValue];
    _ZLUwal_balance = [[obj objectForKeyMy:@"uwal_balance"] floatValue];
    _ZLUwal_score = [[obj objectForKeyMy:@"uwal_score"] intValue];
    _ZLUwal_state = [obj objectForKeyMy:@"uwal_state"];
    

    
}

@end

@implementation ZLBanner



@end
