//
//  APIClient.m
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "APIClient.h"
#import "CustomDefine.h"

#pragma mark -
#pragma mark NSMutableDictionary
@implementation NSMutableDictionary (APIClient_MyAdditions)

+(NSMutableDictionary *)quDic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"104ef5c579850" forKey:@"key"];
    return dic;
}

+(NSMutableDictionary *)quDicWithPage:(int)page pageRow:(int)row
{
    NSMutableDictionary *dic = [NSMutableDictionary quDic];
    [dic addCustomTableParamWithPage:page row:row];
    return dic;
}

-(void)addCustomTableParamWithPage:(int)page row:(int)row
{
    [self setValue:StringWithInt(page) forKey:@"page"]; //起始页
    [self setValue:StringWithInt(row) forKey:@"size"]; //默认每一次取20条数据
}

@end



#pragma mark -
#pragma mark APIClient
@implementation APIClient

+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //[APIClient loadDefault];
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDotNetApiBaseURLString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        ;
        //_sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.requestSerializer.HTTPShouldHandleCookies = YES;
        //_sharedClient.requestSerializer.Content = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer.HTTPShouldHandleCookies = YES;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        //self.requestSerializer = [AFHTTPRequestSerializer serializer];
        //self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.conDic = [NSMutableDictionary dictionary];
    }
    return self;
}


#pragma mark -
- (void)cancelHttpOpretion:(NSURLSessionDataTask *)http
{
    for (NSOperation *operation in [self.operationQueue operations]) {
        if (![operation isKindOfClass:[NSURLSessionDataTask class]]) {
            continue;
        }
        if ([operation isEqual:http]) {
            [operation cancel];
            break;
        }
    }
}

- (void)addConnection:(NSURLSessionDataTask *)operation group:(NSString *)key
{
    NSMutableArray *arr = [self.conDic objectForKey:key];
    if (arr == nil)
        arr = [[NSMutableArray alloc] init];
    [arr addObject:operation];
    
    if (key==nil || key.length==0)
        key = @"defaultKey";
    
    [self.conDic setObject:arr forKey:key];
}

- (void)removeConnection:(NSURLSessionDataTask *)operation group:(NSString *)key
{
    NSMutableArray *arr = [self.conDic objectForKey:key];
    if ([arr containsObject:operation]) {
        [arr removeObject:operation];
        [self.conDic setObject:arr forKey:key];
    }
}

- (void)removeConnections:(NSString *)key
{
    NSMutableArray *arr = [self.conDic objectForKey:key];
    if (arr != nil) {
        for (NSURLSessionDataTask *operation in arr)
            [self cancelHttpOpretion:operation];
        [self.conDic removeObjectForKey:key];
    }
}


-(void)urlGroupKey:(NSString *)key path:(NSString *)URLString parameters:(id)parameters call:(void (^)(NSError *error, id responseObject))callback
{
    id operation = nil;
    operation = [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(nil, responseObject);
        [self removeConnection:operation group:key];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(error, nil);
        [self removeConnection:operation group:key];
    }];
    [self addConnection:operation group:key];
}

-(void)postWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlockBack:(void (^)(id <AFMultipartFormData> formData))block call:(void (^)(NSError *error, id responseObject))callback
{
    NSString *key = NSStringFromClass([tag class]);
    id operation = nil;
    operation = [self POST:URLString parameters:parameters constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(nil, responseObject);
        [self removeConnection:operation group:key];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(error, nil);
        [self removeConnection:operation group:key];
    }];
    [self addConnection:operation group:key];
}

-(void)loadWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters call:(void (^)(APIShareSdkObject* info))callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary quDic];
    if ([parameters isKindOfClass:[NSDictionary class]])
        [paramDic addEntriesFromDictionary:parameters];
    [self urlGroupKey:NSStringFromClass([tag class]) path:URLString parameters:paramDic call:^(NSError *error, id responseObject) {
        APIShareSdkObject *info = nil;
        if (error == nil) {
            NSLog(@"\n\n ---APIObject----result:-----------%@", responseObject);
                    NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
                    NSLog(@"\n\n ---APIObject----result:-----------%@", result);
            info = [APIShareSdkObject mj_objectWithKeyValues:responseObject];
            if (info==nil)
                info = [APIShareSdkObject infoWithErrorMessage:@"网络错误"];
            //        else if (info.data == nil)
            //            info.state = BOOL_NO;
        } else {
            NSLog(@"\n\n ---APIObject----result error:-----------%@", error);
            info = [APIShareSdkObject infoWithError:error];
        }
        
        callback(info);
    }];
}

-(void)tableListWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(NSDictionary *)parameters pageIndex:(int)page subClass:(Class)aClass call:(TableShareSdkBlock)callback
{
    NSMutableDictionary *dic = [NSMutableDictionary quDicWithPage:page pageRow:TABLE_PAGE_ROW];
    if ([parameters isKindOfClass:[NSDictionary class]])
        [dic addEntriesFromDictionary:parameters];
    [self loadWithTag:tag path:URLString parameters:dic call:^(APIShareSdkObject *info) {
        int newPage = 0;
        int total = 0;
        NSArray *newArr = nil;
        if (info.retCode == RETCODE_SUCCESS && [info.result isKindOfClass:[NSDictionary class]]) {
            total = [[info.result objectForKey:@"total"] intValue];
            newPage = [[info.result objectForKey:@"curPage"] intValue];
            NSArray *list = [info.result objectForKey:@"list"];
            if (list.count > 0)
                newArr = [aClass mj_objectArrayWithKeyValuesArray:list];
        }
        callback(total, newArr, info);
    }];
}




#pragma mark - 菜谱

/**
 *  菜谱分类标签查询
 *
 *  @param tag      url链接对象
 *  @param callback 返回分类信息
 */
-(void)cookCategoryQueryWithTag:(NSObject *)tag call:(void (^)(CookCategoryObject* item, APIShareSdkObject* info))callback
{
    [self loadWithTag:tag path:@"http://apicloud.mob.com/v1/cook/category/query" parameters:nil call:^(APIShareSdkObject *info) {
        CookCategoryObject *it = [CookCategoryObject mj_objectWithKeyValues:info.result];
        callback(it, info);
    }];
}


/**
 *  按标签查询菜谱接口  备注说明：根据标签ID/菜谱名称查询菜谱详情。
 *
 *  @param tag      url链接对象
 *  @param cid      标签ID(末级分类标签)
 *  @param name     菜谱名称
 *  @param page     页码数
 *  @param callback 返回订单列表
 */
-(void)cookListWithTag:(NSObject *)tag cookId:(NSString *)cid name:(NSString *)name pageIndex:(int)page call:(TableShareSdkBlock)callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    if (name.length > 0)
        [paramDic setValidStr:name forKey:@"name"];
    else if (cid.length > 0)
        [paramDic setValidStr:cid forKey:@"cid"];
    [self tableListWithTag:tag path:@"http://apicloud.mob.com/v1/cook/menu/search" parameters:paramDic pageIndex:page subClass:[CookObject class] call:^(int totalpage, NSArray *tableArr, APIShareSdkObject *info) {
        callback(totalpage, tableArr, info);
    }];
}



/**
 *  菜谱查询接口
 *
 *  @param tag      url链接对象
 *  @param cid      菜谱ID
 *  @param callback 返回菜谱信息
 */
-(void)cookInfoWithTag:(NSObject *)tag cookId:(NSString *)cid call:(void (^)(CookObject* item, APIShareSdkObject* info))callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    [paramDic setValidStr:cid forKey:@"cid"];
    [self loadWithTag:tag path:@"http://apicloud.mob.com/v1/cook/menu/query" parameters:paramDic call:^(APIShareSdkObject *info) {
        CookObject *it = [CookObject mj_objectWithKeyValues:info.result];
        callback(it, info);
    }];
}











#pragma mark - API
-(void)loadAPIWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters call:(void (^)(APIObject* info))callback
{
//    NSMutableDictionary* paramDic = [NSMutableDictionary quDic];
//    if ([parameters isKindOfClass:[NSDictionary class]])
//        [paramDic addEntriesFromDictionary:parameters];
    NSLog(@"URLString:%@ 参数parameters:%@", URLString, parameters);
    NSString *url = [NSString urlWithExtra:URLString];
    [self urlGroupKey:NSStringFromClass([tag class]) path:url parameters:parameters call:^(NSError *error, id responseObject) {
        APIObject *info = nil;
        if (error == nil) {
            NSLog(@"\n\n ---APIObject----result:-----------%@", responseObject);
            info = [APIObject mj_objectWithKeyValues:responseObject];
            if (info==nil)
                info = [APIObject infoWithErrorMessage:@"网络错误"];
        } else {
            NSLog(@"\n\n ---APIObject----result error:-----------%@", error);
            info = [APIObject infoWithError:error];
        }
        
        callback(info);
    }];
}


-(void)loadAPITableListWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(NSDictionary *)parameters pageIndex:(int)page subClass:(Class)aClass call:(TableArrBlock)callback
{
    NSMutableDictionary *dic = [NSMutableDictionary quDicWithPage:page pageRow:TABLE_PAGE_ROW];
    if ([parameters isKindOfClass:[NSDictionary class]])
        [dic addEntriesFromDictionary:parameters];
    [self loadAPIWithTag:tag path:URLString parameters:dic call:^(APIObject *info) {
        NSArray *newArr = nil;
        if (info.code == RESP_STATUS_YES && [info.data isKindOfClass:[NSArray class]]) {
            newArr = [aClass mj_objectArrayWithKeyValuesArray:info.data];
        }
        callback(newArr, info);
    }];
}




#pragma mark----****----通用接口

/**
 *   省市区列表接口
 *
 *  @param tag      链接对象
 *  @param gion_level  省市县级别，0(省)、1(市)、2(县)
 *  @param gion_id    上级ID，当grade为0时不传
 *  @param callback 返回列表
 */
-(void)regionListWithTag:(NSObject *)tag gion_level:(int)gion_level gion_id:(int)gion_id call:(TableArrBlock)callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    [paramDic setInt:gion_level forKey:@"gion_level"];
    [paramDic setInt:gion_id forKey:@"gion_id"];
    [self loadAPIWithTag:self path:@"/common/region_list" parameters:paramDic call:^(APIObject *info) {
        NSArray *newArr = [RegionObject mj_objectArrayWithKeyValuesArray:info.data];
        callback(newArr, info);
    }];
}



#pragma mark----****----用户资料
/**
 *  用户资料编辑接口
 *
 *  @param tag      链接对象
 *  @param it       提交信息对象
 *  @param callback 返回信息
 */
-(void)userInfoEditWithTag:(NSObject *)tag postItem:(ZLUserInfo *)it call:(void (^)(APIObject* info))callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    [paramDic setInt:it.user_id forKey:@"user_id"];
    [paramDic setInt:it.user_sex forKey:@"user_sex"];
    [paramDic setNeedStr:it.user_nick forKey:@"user_nick_name"];
    [paramDic setNeedStr:it.user_header forKey:@"user_header_url"];
    [self loadAPIWithTag:tag path:@"/user/user_edit" parameters:paramDic call:^(APIObject *info) {
        callback(info);
    }];
}



/**
 *  用户资料编辑接口
 *
 *  @param tag      链接对象
 *  @param ison     是否开启推送 0不开启 1开启
 *  @param callback 返回信息
 */
-(void)userPushSettingWithTag:(NSObject *)tag isOn:(BOOL)ison call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setObject:StringWithBool(ison) forKey:@"user_is_notify"];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:tag path:@"/user/user_edit" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


#pragma mark----****----用户地址管理
/**
 *   用户收货地址信息列表接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)addressListWithTag:(NSObject *)tag call:(TableArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:self path:@"/user/address/address_list" parameters:paramDic call:^(APIObject *info) {
            NSArray *newArr = [AddressObject mj_objectArrayWithKeyValuesArray:[info.data objectWithKey:@"address"]];
            if (newArr.count > 0)
                [AddressObject arrInsertToDB:newArr];
            
            callback(newArr, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  用户地址信息编辑接口
 *
 *  @param tag      链接对象
 *  @param it       提交信息对象
 *  @param is_default 是否设置为默认地址
 *  @param callback 返回信息
 */
-(void)addressInfoEditWithTag:(NSObject *)tag postItem:(AddressObject *)it is_default:(BOOL)is_default call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [it mj_keyValues];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        
        if (is_default) {
            AddressObject *defultItem = [AddressObject defaultAddress];
            if (defultItem != nil) {
                if (defultItem.addr_id == it.addr_id)  //如果自身是默认地址，就不用再更新
                    [paramDic setInt:0 forKey:@"is_default"];
                else
                    [paramDic setInt:defultItem.addr_sort+1 forKey:@"is_default"]; //在默认地址的sort上加１
            } else
                [paramDic setInt:1 forKey:@"is_default"]; //没有默认地址设置为１
        } else
            [paramDic setInt:0 forKey:@"is_default"];
        
        [self loadAPIWithTag:tag path:@"/user/address/address_edit" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  用户地址信息删除接口
 *
 *  @param tag      链接对象
 *  @param addr_id  地址id
 *  @param callback 返回信息
 */
-(void)addressInfoDeleteWithTag:(NSObject *)tag addr_id:(int)addr_id call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:addr_id forKey:@"addr_id"];
        [self loadAPIWithTag:tag path:@"/user/address/address_delete" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


#pragma mark----****----用户房屋管理
/**
 *   用户房屋信息列表接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)houseListWithTag:(NSObject *)tag call:(TableArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:self path:@"/user/house/house_list" parameters:paramDic call:^(APIObject *info) {
            NSArray *newArr = [HouseObject mj_objectArrayWithKeyValuesArray:[info.data objectWithKey:@"house"]];
            if (newArr.count > 0)
                [HouseObject arrInsertToDB:newArr];
            callback(newArr, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  用户房屋信息编辑接口
 *
 *  @param tag      链接对象
 *  @param it       提交信息对象
 *  @param callback 返回信息
 */
-(void)houseInfoEditWithTag:(NSObject *)tag postItem:(HouseObject *)it is_default:(BOOL)is_default call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [it mj_keyValues];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        
        if (is_default) {
            HouseObject *defultItem = [HouseObject defaultAddress];
            if (defultItem != nil) {
                if (defultItem.real_id == it.real_id)  //如果自身是默认地址，就不用再更新
                    [paramDic setInt:0 forKey:@"is_default"];
                else
                    [paramDic setInt:defultItem.real_id+1 forKey:@"is_default"]; //在默认地址的sort上加１
            } else
                [paramDic setInt:1 forKey:@"is_default"]; //没有默认地址设置为１
        } else
            [paramDic setInt:0 forKey:@"is_default"];
        [self loadAPIWithTag:tag path:@"/user/house/house_edit" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  用户地址信息删除接口
 *
 *  @param tag      链接对象
 *  @param real_id  房屋id
 *  @param callback 返回信息
 */
-(void)houseInfoDeleteWithTag:(NSObject *)tag real_id:(int)real_id call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:6 forKey:@"user_id"];
        [paramDic setInt:real_id forKey:@"real_id"];
        [self loadAPIWithTag:tag path:@"/user/house/house_delete" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


#pragma mark----****----社区管理
/**
 *   社区列表接口
 *  1. 使用search搜索（请求参数：search）；2. 以省市县获取数据（请求参数cmut_province、 cmut_city、cmut_county）；3. 获取附近小区数据--默认请求方式（请求参数：lat、lng）
 *
 *  @param tag      链接对象
 *  @param location  经维度
 *  @param search    搜索小区文字,默认为空。非空返回搜索匹配文字小区
 *  @param province  所属省id,默认为空
 *  @param city      所属市id,默认为空
 *  @param county    所属区县id,默认为空
 *  @param callback 返回列表
 */
-(void)communityListWithTag:(NSObject *)tag location:(CLLocationCoordinate2D)location search:(NSString *)search province:(int)province city:(int)city county:(int)county call:(TableArrBlock)callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    [paramDic setInt:6 forKey:@"user_id"];
    
    if (search.length > 0)
        [paramDic setObject:search forKey:@"search"];
    
    if (location.latitude>0 || location.longitude>0) {
        [paramDic setObject:StringWithDouble(location.latitude) forKey:@"lat"];
        [paramDic setObject:StringWithDouble(location.longitude) forKey:@"lng"];
    }
    
    if (province > 0)
        [paramDic setObject:StringWithInt(province) forKey:@"cmut_province"];
    if (city > 0)
        [paramDic setObject:StringWithInt(city) forKey:@"cmut_city"];
    if (county > 0)
        [paramDic setObject:StringWithInt(county) forKey:@"cmut_county"];
    
    [self loadAPIWithTag:self path:@"/user/house/house_list" parameters:paramDic call:^(APIObject *info) {
        NSArray *newArr = [HouseObject mj_objectArrayWithKeyValuesArray:info.data];
        callback(newArr, info);
    }];
}


/**
 *   社区楼栋列表接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)communityBansetListWithTag:(NSObject *)tag cmut_id:(int)cmut_id call:(TableArrBlock)callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    [paramDic setInt:cmut_id forKey:@"cmut_id"];
    [self loadAPIWithTag:self path:@"/community/communityBanset" parameters:paramDic call:^(APIObject *info) {
        if (info.code == RESP_STATUS_YES && [info.data isKindOfClass:[NSArray class]]) {
            NSArray *newArr = [CommunityUmitsetObject mj_objectArrayWithKeyValuesArray:info.data];
            callback(newArr, info);
        } else
            callback(nil, info);
    }];
}





#pragma mark----****----用户登录注册管理
- (void)ZLLoginWithPhone:(NSString *)mPhone andPwd:(NSString *)mPwd block:(void(^)(APIObject *mBaseObj,ZLUserInfo *mUser))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"acc_phone"];
    [para setObject:mPwd forKey:@"acc_pass"];
    [para setObject:@"ios" forKey:@"sys_t"];
    [para setObject:[Util getAppVersion] forKey:@"app_v"];
    [para setObject:[Util getAPPBuildNum] forKey:@"sys_v"];
    
    [self loadAPIWithTag:self path:@"/user/user_login" parameters:para call:^(APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            ZLUserInfo *user = [ZLUserInfo mj_objectWithKeyValues:[info.data objectWithKey:@"user"]];
            CommunityObject *community = [CommunityObject mj_objectWithKeyValues:[info.data objectWithKey:@"community"]];
            WalletObject *wallet = [WalletObject mj_objectWithKeyValues:[info.data objectWithKey:@"wallet"]];
            if (user != nil) {
                if (community != nil)
                    user.community = community;
                
                if (wallet != nil)
                    user.wallet = wallet;
                
                [ZLUserInfo updateUserInfo:user];
            }
            block(info, user);
        } else
            block(info, nil);
    }];
}

   
#pragma mark----****----注册
- (void)ZLRegistPhone:(NSString *)mPhone andPwd:(NSString *)mPwd andCode:(NSString *)mCode block:(void(^)(APIObject *mBaseObj))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"acc_phone"];
    [para setObject:mPwd forKey:@"acc_pass"];
    [para setObject:mCode forKey:@"v_code"];
    
    [self loadAPIWithTag:self path:@"/user/user_register" parameters:para call:^(APIObject *info) {
        block(info);
    }];
}
#pragma mark----****----获取验证码
- (void)ZLGetVerigyCode:(NSString *)mCode andType:(int)mtype block:(void(^)(APIObject *mBaseObj))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mCode forKey:@"mobile"];
    [para setObject:NumberWithInt(mtype) forKey:@"type"];
    

    [self loadAPIWithTag:self path:@"/common/get_sms_code" parameters:para call:^(APIObject *info) {
        block(info);
    }];
}


#pragma mark----****----app初始化加载数据
- (void)ZLAppInit:(void(^)(APIObject *mBaseObj,ZLAPPInfo *mAppInfo))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
    [para setObject:@"ios" forKey:@"sys_t"];
    [para setObject:[Util getAppVersion] forKey:@"app_v"];
    [para setObject:[Util getAPPBuildNum] forKey:@"sys_v"];

    
    [self loadAPIWithTag:self path:@"/common/initload" parameters:para call:^(APIObject *info) {

        [ZLAPPInfo ZLDealSession:info block:block];
    }];
}
#pragma mark----****----获取首页banner
- (void)ZLgetHomeBanner:(void(^)(APIObject *mBaseObj,ZLHomeFunvtionAndBanner *mFunc))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    

    [self loadAPIWithTag:self path:@"/home/banner" parameters:para call:^(APIObject *info) {

       
        if (info.code == RESP_STATUS_YES) {
            
            ZLHomeFunvtionAndBanner *mFuncTion = [ZLHomeFunvtionAndBanner new];
            
            NSMutableArray *mBannerArr = [NSMutableArray new];
            NSMutableArray *mFuncArr = [NSMutableArray new];
            
            id mBanner = [info.data objectForKey:@"banners"];
            id mFunction = [info.data objectForKey:@"functions"];
            
            if ([mBanner isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in mBanner) {
                    [mBannerArr addObject:[ZLHomeBanner mj_objectWithKeyValues:dic]];
                }
                
            }
            if ([mFunction isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in mFunction) {
                    [mFuncArr addObject:[ZLHomeFunctions mj_objectWithKeyValues:dic]];
                }
                
            }
            
            mFuncTion.banners = mBannerArr;
            mFuncTion.functions = mFuncArr;
            
            block (info,mFuncTion);
            
            
        }else{
            block (info,nil);
            
        }
    
    }];
    

    
}

#pragma mark----****----获取首页数据
///获取首页数据
- (void)ZLGetHome:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(APIObject *mBaseObj,ZLHomeObj *mHome))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    if (mLat) {
        [para setNeedStr:mLat forKey:@"adv_lat"];
    }
    if (mLng) {
        [para setNeedStr:mLng forKey:@"adv_lng"];

    }
    [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
    

    [self loadAPIWithTag:self path:@"/home/homePage" parameters:para call:^(APIObject *info) {
        
        
        if (info.code == RESP_STATUS_YES) {
            
            ZLHomeObj *mHomeObj = [[ZLHomeObj alloc] init];
            
            id mAdv = [info.data objectForKey:@"sAdvertList"];
            
            id mCom = [info.data objectForKey:@"eCompanyNoticeList"];
            
            
            NSMutableArray *mAdvArr = [NSMutableArray new];
            NSMutableArray *mComArr = [NSMutableArray new];
            if ([mAdv isKindOfClass:[NSArray class]]) {
                
                for ( NSDictionary *dic in mAdv) {
                    [mAdvArr addObject:[ZLHomeAdvList mj_objectWithKeyValues:dic]];
                }
                
            }
            if ([mCom isKindOfClass:[NSArray class]]) {
                for ( NSDictionary *dic in mCom) {
                    [mComArr addObject:[ZLHomeAdvList mj_objectWithKeyValues:dic]];
                }                
            }
            
            mHomeObj.sAdvertList = mAdvArr;
            mHomeObj.eCompanyNoticeList = mComArr;
            
            block(info,mHomeObj);
            
        }else{
            block(info,nil);

        }
        
    }];
}

#pragma mark----****----获取首页社区地址数据
/**
 获取首页社区地址数据
 
 @param mLat       纬度
 @param mLng       经度
 @param mSearchTx  搜索内容
 @param mProvince  省份id
 @param mCityId    城市id
 @param mCountryId 区县id
 @param block      返回值
 */
- (void)ZLGetHomeCommunity:(NSString *)mLat andLng:(NSString *)mLng andSearchText:(NSString *)mSearchTx andProvinceId:(int)mProvince andCityId:(int)mCityId andCountryId:(int)mCountryId block:(void(^)(APIObject *mBaseObj,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    if (mLat) {
        [para setNeedStr:mLat forKey:@"lat"];
    }
    if (mLng) {
        [para setNeedStr:mLng forKey:@"lng"];
        
    }
    if (mSearchTx.length>0 || ![mSearchTx isEqualToString:@""]) {
        [para setNeedStr:mSearchTx forKey:@"search"];
    }
    if (mProvince) {
        [para setInt:mProvince forKey:@"cmut_province"];
    }
    if (mCityId) {
        [para setInt:mCityId forKey:@"cmut_city"];
    }
    if (mCountryId) {
        [para setInt:mCountryId forKey:@"cmut_county"];
    }
    
    
    [self loadAPIWithTag:self path:@"/community/community_search_list" parameters:para call:^(APIObject *info) {
        
        
        if (info.code == RESP_STATUS_YES) {
            
            NSMutableArray *mTempArr = [NSMutableArray new];
            
            id mArrTemp = info.data;
            
            if ([mArrTemp isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in mArrTemp) {
                    
                    [mTempArr addObject:[ZLHomeCommunity mj_objectWithKeyValues:dic]];
                    
                }
            }
        
            
            block(info,mTempArr);
         
        }else{
            block(info,nil);
            
        }
        
    }];
    
}
#pragma mark----****----获取社区超市首页
/**
 获取社区超市首页
 
 @param mLat  纬度
 @param mLng  经度
 @param mType 类型：1超市  2报修 3家政干洗
 @param block 返回值
 */
- (void)ZLGetShopHomePage:(NSString *)mLat andLng:(NSString *)mLng andType:(int)mType block:(void(^)(APIObject *mBaseObj,ZLShopHomePage *mShopHome))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    if (mLat) {
        [para setNeedStr:mLat forKey:@"lat"];
    }
    if (mLng) {
        [para setNeedStr:mLng forKey:@"lng"];
        
    }
    
    [para setInt:mType forKey:@"shop_type"];
    
    [self loadAPIWithTag:self path:@"/shop/shop_home" parameters:para call:^(APIObject *info) {
        
        
        if (info.code == RESP_STATUS_YES) {
            
            NSMutableArray *mBannerArr = [NSMutableArray new];
            NSMutableArray *mCampainArr = [NSMutableArray new];
            NSMutableArray *mClassifyArr = [NSMutableArray new];
            
            id mBanner = [info.data objectForKey:@"banners"];
            id mCanpain = [info.data objectForKey:@"campaign"];
            id mClassify = [info.data objectForKey:@"classify"];
            
            if ([mBanner isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in mBanner) {
                    
                    [mBannerArr addObject:[ZLHomeBanner mj_objectWithKeyValues:dic]];
                    
                }
            }
            if ([mCanpain isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in mCanpain) {
                    
                    [mCampainArr addObject:[ZLShopHomeCampaign mj_objectWithKeyValues:dic]];
                    
                }
            }
            if ([mClassify isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in mClassify) {
                    
                    [mClassifyArr addObject:[ZLShopHomeClassify mj_objectWithKeyValues:dic]];
                    
                }
            }
            
            ZLShopHomePage *mShopHomePage = [[ZLShopHomePage alloc] init];
            mShopHomePage.banner = mBannerArr;
            mShopHomePage.campaign = mCampainArr;
            mShopHomePage.classify = mClassifyArr;
            block(info,mShopHomePage);
            
        }else{
            block(info,nil);
            
        }
        
    }];
    
    
    
    
}

#pragma mark----****----获取社区超市店铺列表
/**
 获取社区超市店铺列表
 
 @param mLat  纬度
 @param mLng  经度
 @param mClassId 店铺分类id
 @param mPage 分页
 @param block 返回值
 */
- (void)ZLGetShopHomeShopList:(int)mShopType andLat:(NSString *)mLat andLng:(NSString *)mLng andClassId:(NSString *)mClassId andPage:(int)mPage  block:(void(^)(APIObject *mBaseObj,ZLShopHomeShopList *mShopList))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    [para setInt:mShopType forKey:@"shop_type"];
    [para setNeedStr:mLat forKey:@"lat"];
    [para setNeedStr:mLng forKey:@"lng"];
    
    if (mClassId != 0) {
        [para setNeedStr:mClassId forKey:@"cls_id"];

    }
    if (mPage) {
        [para setInt:mPage forKey:@"page"];

    }

    
    [self loadAPIWithTag:self path:@"/shop/shop_list" parameters:para call:^(APIObject *info) {
        
        
        if (info.code == RESP_STATUS_YES) {
            
            ZLShopHomeShopList *mShopList = [ZLShopHomeShopList new];
            
            mShopList.totalRow = [[info.data objectForKey:@"totalRow"] intValue];
            mShopList.totalPage = [[info.data objectForKey:@"totalPage"] intValue];
            mShopList.pageNumber = [[info.data objectForKey:@"pageNumber"] intValue];
            mShopList.pageSize = [[info.data objectForKey:@"pageSize"] intValue];
            
            NSMutableArray *mTempArr = [NSMutableArray new];
            id mList = [info.data objectForKey:@"list"];
            if ([mList isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in mList) {
                    [mTempArr addObject:[ZLShopHomeShopObj mj_objectWithKeyValues:dic]];
                }

            }
            mShopList.list = mTempArr;
            block(info,mShopList);
            
        }else{
            block(info,nil);
            
        }
        
    }];
}

#pragma mark----****----获取社区超市店铺信息
/**
 获取社区超市店铺信息
 
 @param mShopType 店铺类型
 @param mShopId   店铺id
 @param block     返回值
 */
- (void)ZLGetShopMsgWithShopType:(int)mShopType andShopId:(int)mShopId block:(void(^)(APIObject *mBaseObj,ZLShopObj *mShop,ZLShopLeftTableArr *mLeftTabArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setInt:mShopType forKey:@"shop_type"];
    [para setInt:mShopId forKey:@"shop_id"];
    
    [self loadAPIWithTag:self path:@"/shop/shop_info" parameters:para call:^(APIObject *info) {
        
        
        if (info.code == RESP_STATUS_YES) {
            
            ZLShopObj *mShopList = [ZLShopObj new];
            ZLShopLeftTableArr *mLeftArr = [ZLShopLeftTableArr new];
            mShopList.mShopMsg = [ZLShopMsg mj_objectWithKeyValues:[info.data objectForKey:@"shop"]];
            mShopList.mShopCoupon =[ZLShopCoupon mj_objectWithKeyValues:[info.data objectForKey:@"coupons"]];
            
            
            id mClass = [info.data objectForKey:@"classify"];
            id mCampain = [info.data objectForKey:@"campaigns"];
            
            NSMutableArray *mClassArr = [NSMutableArray new];
            NSMutableArray *mCampainArr = [NSMutableArray new];
            
            if ([mClass isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in mClass) {
                    [mClassArr addObject:[ZLShopClassify mj_objectWithKeyValues:dic]];
                }
                
            }
            if ([mCampain isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in mCampain) {
                    [mCampainArr addObject:[ZLShopCampain mj_objectWithKeyValues:dic]];
                }
                
            }
            mShopList.mShopClassify = mClassArr;
            mShopList.mShopCampains = mCampainArr;

            
            
            if (mCampainArr.count > 0 && mClassArr.count<=0) {
                mLeftArr.mLeftType = 1;
                mLeftArr.mCampainArr = mCampainArr;
            }else if (mCampainArr.count <= 0 && mClassArr.count>0){
                mLeftArr.mLeftType = 2;
                mLeftArr.mClassArr = mClassArr;
            }else{
            
                mLeftArr.mLeftType = 3;
                mLeftArr.mCampainArr = mCampainArr;
                mLeftArr.mClassArr = mClassArr;
            }
            
            block(info,mShopList,mLeftArr);
            
        }else{
            block(info,nil,nil);
            
        }
        
    }];
    
}

#pragma mark----****----获取店铺商品信息
/**
 获取店铺商品信息
 
 @param mShopId  店铺id
 @param mCamId   活动id
 @param mClassId 分类id
 @param mPage    分页
 @param block    返回值
 */
- (void)ZLGetShopGoodsList:(int)mShopId andCamId:(int)mCamId andClassId:(int)mClassId andPage:(int)mPage andType:(ZLRightGoodsType)mType block:(void(^)(APIObject *mBaseObj,ZLShopGoodsList *mShopGoodsObj))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setInt:mShopId forKey:@"shop_id"];
    [para setInt:mPage forKey:@"page"];

    if (mCamId) {
        [para setInt:mCamId forKey:@"cam_id"];
    }
    if(mClassId){
        [para setInt:mClassId forKey:@"cls_id"];
    }
    
    [self loadAPIWithTag:self path:@"/shop/product_list" parameters:para call:^(APIObject *info) {
        
        
        if (info.code == RESP_STATUS_YES) {
            
            ZLShopGoodsList *mShopGoodsList = [ZLShopGoodsList mj_objectWithKeyValues:info.data];
            
            NSMutableArray *mGoodsList = [NSMutableArray new];
            
            id mList = [info.data objectForKey:@"list"];
            
            
            if ([mList isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in mList) {
                    
                    switch (mType) {
                        case ZLRightGoodsTypeFromCamp:
                        {
                            [mGoodsList addObject:[ZLGoodsWithCamp mj_objectWithKeyValues:dic]];

                        }
                            break;
                        case ZLRightGoodsTypeFromClass:
                        {
                         
                            [mGoodsList addObject:[ZLGoodsWithClass mj_objectWithKeyValues:dic]];

                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                }
                
            }
            
            mShopGoodsList.list = mGoodsList;
            block(info,mShopGoodsList);
            
        }else{
            block(info,nil);
            
        }
        
    }];
    
    
}

#pragma mark----****----获取商品详情
/**
 获取商品详情
 
 @param mGoodsId 商品id
 @param mCamId   活动id
 @param block    返回值
 */
- (void)ZLGetGoodsDetail:(NSString *)mGoodsId andCamId:(NSString *)mCamId block:(void(^)(APIObject *mBaseObj,ZLGoodsDetail *mGoodsDetailObj,NSArray *mGoodsDetailImgArr))block{

    
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    if (mCamId) {
        [para setNeedStr:mCamId forKey:@"cam_gid"];
        
    }
    if(mGoodsId){
        [para setNeedStr:mGoodsId forKey:@"pro_id"];
    }
    
    [self loadAPIWithTag:self path:@"/shop/product_info" parameters:para call:^(APIObject *info) {
        
        
        if (info.code == RESP_STATUS_YES) {
            
            ZLGoodsDetail *mGoodsDetail = [ZLGoodsDetail mj_objectWithKeyValues:info.data];
            
            NSMutableArray *mImgArr = [NSMutableArray new];
            
            id mImg = [info.data objectForKey:@"images"];
            
            if ([mImg isKindOfClass:[NSArray class]]) {
            
                for (NSDictionary *dic in mImg) {
                    [mImgArr addObject:[ZLGoodsDetailImg mj_objectWithKeyValues:dic]];
                }
                
                
                
            }
            
            mGoodsDetail.images = mImgArr;
            block(info,mGoodsDetail,mImgArr);
            
        }else{
            block(info,nil,nil);
            
        }
        
    }];
    

    
    
}
@end
