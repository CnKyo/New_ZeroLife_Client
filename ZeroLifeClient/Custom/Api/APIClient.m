//
//  APIClient.m
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "APIClient.h"
#import "CustomDefine.h"
#import <WXApiObject.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>

#import <JPush/JPUSHService.h>

#pragma mark -
#pragma mark NSMutableDictionary
@implementation NSMutableDictionary (APIClient_MyAdditions)

+(NSMutableDictionary *)quDic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"104ef5c579850" forKey:@"key"]; //apicloud key
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
    [self setValue:StringWithInt(page) forKey:@"pageNumber"]; //起始页
    [self setValue:StringWithInt(row) forKey:@"pageSize"]; //默认每一次取20条数据
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
+ (instancetype)sharedUpLoad{
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //[APIClient loadDefault];
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDotNetImgBaseURLString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        ;
        //_sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.requestSerializer.HTTPShouldHandleCookies = YES;
        //_sharedClient.requestSerializer.Content = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return _sharedClient;
}
#pragma mark----  聚合流量充值方法
+ (instancetype)sharedJHFlow{
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //[APIClient loadDefault];
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppJHFlowURLString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        ;
        _sharedClient.requestSerializer.HTTPShouldHandleCookies = YES;
    });
    return _sharedClient;
}
- (NSString *)currentUrl{

    return [NSString stringWithFormat:@"%@%@",kAFAppDotNetApiBaseURLString,kAFAppDotNetApiExtraURLString];
}

#pragma mark----  获取跑跑腿订单操作状态
/**
 获取跑跑腿订单操作状态
 
 @param mStatus 状态
 @return 返回操作类型
 */
+ (NSString *)ZLCurrentOperatorPPTOrderStatus:(ZLOperatorPPTOrderStatus)mStatus{
    
    
    if (mStatus == ZLOperatorPPTOrderStatusWithAccept) {
        return @"SSELECT";
    }else if (mStatus == ZLOperatorPPTOrderStatusWithServicing){
        return @"SSERVICE";
        
    }else if (mStatus == ZLOperatorPPTOrderStatusWithCancel){
        return @"SCANCEL";
        
    }else{
        return @"SDONE";
        
    }
    
}

- (void)getUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( APIObject* info))callback{

    MLLog(@"请求地址：%@-------请求参数：%@",URLString,parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = 10;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager GET:[NSString stringWithFormat:@"%@/%@",[self currentUrl],URLString] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MLLog(@"data:%@",responseObject);
        
        NSDictionary *resbObj = [Util deleteEmpty:responseObject];
        
        MLLog(@"去掉字典里的null值之后的数据：%@",resbObj);
        
        APIObject   *retob = [APIObject mj_objectWithKeyValues:resbObj];
        
        callback(  retob );
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MLLog(@"error:%@",error.description);
        callback( [APIObject infoWithError:error] );
        
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];

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
//                    NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
//                    NSLog(@"\n\n ---APIObject----result:-----------%@", result);
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
        if (info.retCode == RESP_STATUS_YES && [info.result isKindOfClass:[NSDictionary class]]) {
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
    
    NSString *url = nil;
    
    if ([Util ZLRangOfString:URLString]) {
        url = [NSString urlWithServiceUrl:URLString];

    }else{
    
        url = [NSString urlWithExtra:URLString];
    }
    
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
-(void)JHloadAPIWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters call:(void (^)(mJHBaseData* info))callback
{

    NSLog(@"URLString:%@ 参数parameters:%@", URLString, parameters);

    [self urlGroupKey:NSStringFromClass([tag class]) path:URLString parameters:parameters call:^(NSError *error, id responseObject) {
        mJHBaseData *info = nil;
        if (error == nil) {
            NSLog(@"\n\n ---APIObject----result:-----------%@", responseObject);
            info = [mJHBaseData mj_objectWithKeyValues:responseObject];
            
            if ([info.reason isEqualToString:@"success"]) {
                info.mSucess = YES;
            }else{
                info.mSucess = NO;
            }
            info.mData = info.result;
            
            if (info==nil)
                info = [mJHBaseData infoWithError:@"网络错误"];
        } else {
            NSLog(@"\n\n ---APIObject----result error:-----------%@", error);
            info = [mJHBaseData infoWithError:error.description];
        }
        
        callback(info);
    }];
}

-(void)loadAPITableListWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(NSDictionary *)parameters pageIndex:(int)page subClass:(Class)aClass call:(TablePageArrBlock)callback
{
    NSMutableDictionary *dic = [NSMutableDictionary quDicWithPage:page pageRow:TABLE_PAGE_ROW];
    if ([parameters isKindOfClass:[NSDictionary class]])
        [dic addEntriesFromDictionary:parameters];
    [self loadAPIWithTag:tag path:URLString parameters:dic call:^(APIObject *info) {
        int total = 0;
        NSArray *newArr = nil;
        if (info.code == RESP_STATUS_YES && [info.data isKindOfClass:[NSDictionary class]]) {
            total = [[info.data objectForKey:@"totalPage"] intValue];
            NSArray *list = [info.data objectForKey:@"list"];
            if (list.count > 0)
                newArr = [aClass mj_objectArrayWithKeyValuesArray:list];
        }
        callback(total, newArr, info);
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




/**
 *   文件上传接口
 *
 *  @param tag      链接对象
 *  @param uploadDatas     上传数据的NSData集合
 *  @param type     文件类型（1-图片，2-音频）
 *  @param path     功能参数（用户头像-U_PHOTO，用户认证文件-U_AUT，用户跑跑腿申请资料-U_APPLY，用户订单处理-U_ORDERS）
 *  @param callback 返回列表
 */
-(void)fileUploadWithTag:(NSObject *)tag uploadDatas:(NSArray *)uploadDatas type:(kFileType)type path:(NSString *)path call:(TableArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:type forKey:@"type"];
        [paramDic setObject:path forKey:@"path"];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self postWithTag:tag path:@"/resource/api/app/client/file/upload" parameters:paramDic constructingBodyWithBlockBack:^(id<AFMultipartFormData> formData) {
            NSString *mimeType = nil;
            NSString *fileExt = nil;
            
            switch (type) {
                case kFileType_photo:
                    fileExt = @".png";
                    mimeType = @"image/jpg/png";
                    break;
                case kFileType_video:
                    fileExt = @".mp4";
                    mimeType = @"video/mpeg4";
                    break;
                default:
                    break;
            }
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *timeStr = [formatter stringFromDate:[NSDate date]];
            
            for (int i=0; i<uploadDatas.count; i++) {
                NSString *fileName = [NSString stringWithFormat:@"%@_%i%@",timeStr, i, fileExt];
                NSString *name = [NSString stringWithFormat:@"uploadFile%i", i];
                [formData appendPartWithFileData:uploadDatas[i] name:name fileName:fileName mimeType:mimeType];
            }
            
        } call:^(NSError *error, id responseObject) {
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
            
            if (info.code == RESP_STATUS_YES) {
                NSArray *newArr = [FileUploadResponseObject mj_objectArrayWithKeyValuesArray:info.data];
                callback(newArr, info);
            } else
                callback(nil, info);

        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}



/**
 *   单个文件上传接口
 *
 *  @param tag      链接对象
 *  @param data     上传数据
 *  @param type     文件类型（1-图片，2-音频）
 *  @param path     功能参数（用户头像-U_PHOTO，用户认证文件-U_AUT，用户跑跑腿申请资料-U_APPLY，用户订单处理-U_ORDERS）
 *  @param callback 返回列表
 */
-(void)fileOneUploadWithTag:(NSObject *)tag data:(NSData *)data type:(kFileType)type path:(NSString *)path call:(void (^)(NSString *fileUrlStr, APIObject* info))callback
{
    NSArray *arr = [NSArray arrayWithObject:data];
    
    [self fileUploadWithTag:tag uploadDatas:arr type:type path:path call:^(NSArray *tableArr, APIObject *info) {
        if (tableArr.count > 0) {
            FileUploadResponseObject *item = [tableArr objectAtIndex:0];
            callback(item.name, info);
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
    
    [para setNeedStr:[JPUSHService registrationID] forKey:@"jpush"]; //极光注册ID
    
    [self loadAPIWithTag:self path:@"/user/user_login" parameters:para call:^(APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            ZLUserInfo *user = [ZLUserInfo mj_objectWithKeyValues:[info.data objectWithKey:@"user"]];
            CommunityObject *community = [CommunityObject mj_objectWithKeyValues:[info.data objectWithKey:@"community"]];
            WalletObject *wallet = [WalletObject mj_objectWithKeyValues:[info.data objectWithKey:@"wallet"]];
            OpeningFunctionObject *open = [OpeningFunctionObject mj_objectWithKeyValues:[info.data objectWithKey:@"openInfo"]];
            if (user != nil) {
                if (community != nil)
                    user.community = community;
                
                if (wallet != nil)
                    user.wallet = wallet;
                if (open != nil)
                    user.openInfo = open;
                
                [ZLUserInfo updateUserInfo:user];
            }
            block(info, user);
        } else
            block(info, nil);
    }];
}


/**
 *  用户提交极光注册ID接口
 *
 *  @param tag      链接对象
 *  @param jpush_id  极光注册ID
 *  @param callback 返回信息
 */
-(void)userJpushUpdateWithTag:(NSObject *)tag jpush_id:(NSString *)jpush_id call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setNeedStr:user.sign forKey:@"sign"];
        [paramDic setNeedStr:jpush_id forKey:@"jpush"];
        [paramDic setObject:@"ios" forKey:@"sys_t"];
        [self loadAPIWithTag:tag path:@"/user/jpush" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    }
}
#pragma mark----****----三方登录
/**
 三方登录
 
 @param mLoginObj 登录对象
 @param block 返回值
 */
- (void)ZLPlaframtLogin:(ZLPlafarmtLogin *)mLoginObj block:(void (^)(APIObject* info,ZLUserInfo *mUser))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
   
    [para setObject:mLoginObj.open_id forKey:@"open_id"];
    [para setObject:mLoginObj.nick_name forKey:@"nick_name"];
    [para setObject:mLoginObj.photo forKey:@"photo"];
    [para setObject:mLoginObj.jpush forKey:@"jpush"];
    [para setObject:mLoginObj.app_v forKey:@"app_v"];
    [para setObject:mLoginObj.sys_v forKey:@"sys_v"];
    [para setObject:mLoginObj.sys_t forKey:@"sys_t"];
    MLLog(@"三方登录传的参数：%@",para);
    [self loadAPIWithTag:self path:@"/user/plat/plat_login" parameters:para call:^(APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            ZLUserInfo *user = [ZLUserInfo mj_objectWithKeyValues:[info.data objectWithKey:@"user"]];
            CommunityObject *community = [CommunityObject mj_objectWithKeyValues:[info.data objectWithKey:@"community"]];
            WalletObject *wallet = [WalletObject mj_objectWithKeyValues:[info.data objectWithKey:@"wallet"]];
            OpeningFunctionObject *open = [OpeningFunctionObject mj_objectWithKeyValues:[info.data objectWithKey:@"openInfo"]];
            if (user != nil) {
                if (community != nil)
                    user.community = community;
                
                if (wallet != nil)
                    user.wallet = wallet;
                if (open != nil)
                    user.openInfo = open;
                
            }
       
            block(info,user);
        }else{
            block(info,nil);
        }

    }];

}
#pragma mark----****----绑定手机账号
/**
 绑定账号
 @param mOpenId openid
 @param mPhone 手机
 @param mPwd 密码
 @param block 返回值
 */
- (void)ZLPlaframtLogin:(NSString *)mOpenId andPhone:(NSString *)mPhone andPwd:(NSString *)mPwd block:(void (^)(APIObject* info))block{
    block(nil);
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mOpenId forKey:@"open_id"];
    [para setObject:mPhone forKey:@"acc_phone"];
    [para setObject:mPwd forKey:@"v_code"];
    [self loadAPIWithTag:self path:@"/user/plat/plat_bind" parameters:para call:^(APIObject *info) {
        block(info);
    }];
}


/**
 *  用户退出登录接口
 *
 *  @param tag      链接对象
 *  @param callback 返回信息
 */
-(void)userLoginOutWithTag:(NSObject *)tag call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setNeedStr:user.sign forKey:@"sign"];
        [self loadAPIWithTag:tag path:@"/user/user_logout" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"您尚未登陆"]);
}


#pragma mark----****----注册
- (void)ZLRegistPhone:(NSString *)mPhone andPwd:(NSString *)mPwd andCode:(NSString *)mCode andType:(ZLRegistOrForgetPwd)mType block:(void (^)(APIObject *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"acc_phone"];
    [para setObject:mPwd forKey:@"acc_pass"];
    [para setObject:mCode forKey:@"v_code"];
    
    NSString *mUrl = nil;
    if (mType == ZLRegistPwd) {
        mUrl = @"/user/user_register";
    }else{
        mUrl = @"/user/user_repass";
    }
    
    [self loadAPIWithTag:self path:mUrl parameters:para call:^(APIObject *info) {
        block(info);
    }];
}
#pragma mark----****----获取验证码
- (void)ZLGetVerigyCode:(NSString *)mCode andType:(ZLRegistOrForgetPwd)mtype block:(void(^)(APIObject *mBaseObj))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mCode forKey:@"mobile"];
    [para setObject:NumberWithInt(mtype) forKey:@"type"];
    
    
    [self loadAPIWithTag:self path:@"/common/get_sms_code" parameters:para call:^(APIObject *info) {
        block(info);
    }];
}


#pragma mark----****----用户资料
/**
 *  获取用户资料接口
 *
 *  @param tag      链接对象
 *  @param callback 返回信息
 */
- (void)userInfoWithTag:(NSObject *)tag call:(void(^)(ZLUserInfo *user, APIObject *info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        
        [paramDic setNeedStr:[JPUSHService registrationID] forKey:@"jpush"]; //极光注册ID
        
        [self loadAPIWithTag:self path:@"/user/userInfo_index" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                ZLUserInfo *user = [ZLUserInfo mj_objectWithKeyValues:[info.data objectWithKey:@"user"]];
                CommunityObject *community = [CommunityObject mj_objectWithKeyValues:[info.data objectWithKey:@"community"]];
                WalletObject *wallet = [WalletObject mj_objectWithKeyValues:[info.data objectWithKey:@"wallet"]];
                OpeningFunctionObject *open = [OpeningFunctionObject mj_objectWithKeyValues:[info.data objectWithKey:@"openInfo"]];
                if (user != nil) {
                    if (community != nil)
                        user.community = community;
                    
                    if (wallet != nil)
                        user.wallet = wallet;
                    if (open != nil)
                        user.openInfo = open;
                    
                    [ZLUserInfo updateUserInfo:user];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:MyUserInfoChangedNotification object:nil];
                callback(user, info);
            } else
                callback(nil, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}

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
    [paramDic setNeedStr:it.user_nick forKey:@"user_nick"];
    [paramDic setNeedStr:it.user_header forKey:@"user_header"];
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

/**
 *  用户交易密码设置接口
 *
 *  @param tag      链接对象
 *  @param acc_pass  登录密码
 *  @param security_password  6位纯数字交易密码
 *  @param callback 返回信息
 */
-(void)userSecurityPasswordSettingWithTag:(NSObject *)tag acc_pass:(NSString *)acc_pass security_password:(NSString *)security_password call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setNeedStr:acc_pass forKey:@"acc_pass"];
        [paramDic setNeedStr:security_password forKey:@"security_password"];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:tag path:@"/user/user_security_password" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  用户提交支付密码的工单接口
 *
 *  @param tag      链接对象
 *  @param mobile   手机号
 *  @param idCard   身份证号
 *  @param callback 返回信息
 */
-(void)userSecurityPasswordCompalainWithTag:(NSObject *)tag mobile:(NSString *)mobile idCard:(NSString *)idCard call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setNeedStr:mobile forKey:@"mobile"];
        [paramDic setNeedStr:idCard forKey:@"idcard"];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:tag path:@"/user/complaint/complaint_pass" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}

#pragma mark----****---- 更新用户信息
/**
 更新用户信息
 
 @param block 返回值
 */
- (void)ZLUpdateUserInfo:(void (^)(APIObject* info))block{

    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* para = [NSMutableDictionary dictionary];
        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        
        [self loadAPIWithTag:self path:@"/user/userInfo_index" parameters:para call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                ZLUserInfo *user = [ZLUserInfo mj_objectWithKeyValues:[info.data objectWithKey:@"user"]];
                CommunityObject *community = [CommunityObject mj_objectWithKeyValues:[info.data objectWithKey:@"community"]];
                WalletObject *wallet = [WalletObject mj_objectWithKeyValues:[info.data objectWithKey:@"wallet"]];
                OpeningFunctionObject *open = [OpeningFunctionObject mj_objectWithKeyValues:[info.data objectWithKey:@"openInfo"]];
                if (user != nil) {
                    if (community != nil)
                        user.community = community;
                    
                    if (wallet != nil)
                        user.wallet = wallet;
                    if (open != nil)
                        user.openInfo = open;
                    
                    [ZLUserInfo updateUserInfo:user];
                }
                block(info);
            } else
                block(info);
            
        }];

    }else{
        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
    }
}


#pragma mark----****----资料提交接口
/**
 *  申请跑跑腿资料提交接口
 *
 *  @param tag              链接对象
 *  @param item             提交资料
 *  @param callback         返回信息
 */
-(void)userApplyPaopaoWithTag:(NSObject *)tag item:(PaopaoApplyObject *)item call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [item mj_keyValues];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        
        if (item.mat_document_name==nil || item.mat_document_name.length==0)
            [paramDic setObject:@"IDCard" forKey:@"mat_document_name"];
        
        [paramDic removeObjectForKey:@"mat_hand_url"];
        [paramDic setObject:item.mat_hand_url forKey:@"uopen_head"];
        
        
        [self loadAPIWithTag:tag path:@"/ppao/ppao_apply" parameters:paramDic call:^(APIObject *info) {
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
            if (info.code == RESP_STATUS_YES) {
                NSArray *newArr = [AddressObject mj_objectArrayWithKeyValuesArray:[info.data objectWithKey:@"address"]];
                if (newArr.count > 0)
                    [AddressObject arrInsertToDB:newArr];
                
                callback(newArr, info);
            } else
                callback(nil, info);

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
            if (info.code == RESP_STATUS_YES) {
                NSArray *newArr = [HouseObject mj_objectArrayWithKeyValuesArray:[info.data objectWithKey:@"house"]];
                if (newArr.count > 0)
                    [HouseObject arrInsertToDB:newArr];
                callback(newArr, info);
            } else
                callback(nil, info);
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
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:real_id forKey:@"real_id"];
        [self loadAPIWithTag:tag path:@"/user/house/house_delete" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}

#pragma mark----****----用户银行卡接口
/**
 *   用户银行卡列表接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)bankCardListWithTag:(NSObject *)tag call:(TableArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:self path:@"/user/bankcard/bankcard_list" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                NSArray *newArr = [BankCardObject mj_objectArrayWithKeyValuesArray:info.data];
                callback(newArr, info);
            } else
                callback(nil, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}

/**
 *  用户银行卡添加接口
 *
 *  @param tag              链接对象
 *  @param bank_real_name   真实姓名
 *  @param bank_mobile      电话号码
 *  @param bank_card        银行卡号
 *  @param id_card          身份证号码
 *  @param callback         返回信息
 */
-(void)bankCardAddWithTag:(NSObject *)tag bank_real_name:(NSString *)bank_real_name bank_mobile:(NSString *)bank_mobile bank_card:(NSString *)bank_card id_card:(NSString *)id_card call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setNeedStr:bank_real_name forKey:@"bank_real_name"];
        [paramDic setNeedStr:bank_mobile forKey:@"bank_mobile"];
        [paramDic setNeedStr:bank_card forKey:@"bank_card"];
        [paramDic setNeedStr:id_card forKey:@"id_card"];
        [self loadAPIWithTag:tag path:@"/user/bankcard/bankcard_add" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  用户银行卡删除接口
 *
 *  @param tag      链接对象
 *  @param bank_id  银行卡id
 *  @param security_password  6位纯数字交易密码
 *  @param callback 返回信息
 */
-(void)bankCardDeleteWithTag:(NSObject *)tag bank_id:(int)bank_id security_password:(NSString *)security_password call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:bank_id forKey:@"bank_id"];
        [paramDic setNeedStr:security_password forKey:@"security_password"];
        [self loadAPIWithTag:tag path:@"/user/bankcard/bankcard_delete" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


#pragma mark----****----用户商品关注收藏接口

/**
 *  商品关注接口接口
 *
 *  @param tag              链接对象
 *  @param pro_id           商品id
 *  @param callback         返回信息
 */
-(void)productFocusAddWithTag:(NSObject *)tag pro_id:(int)pro_id is_focus:(BOOL)is_focus call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:pro_id forKey:@"pro_id"];
        [paramDic setObject:StringWithBool(is_focus) forKey:@"focus_type"];
        [self loadAPIWithTag:tag path:@"/shop/product_focus" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  商品取消关注接口接口
 *
 *  @param tag              链接对象
 *  @param foc_id           收藏ID（注：有多个请用","号隔开;如:1,2,3）
 *  @param callback         返回信息
 */
-(void)productFocusDelWithTag:(NSObject *)tag foc_id:(int)foc_id call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:foc_id forKey:@"foc_id"];
        [self loadAPIWithTag:tag path:@"/shop/delproduct_focus" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *   用户商品收藏列表接口
 *
 *  @param tag      链接对象
 *  @param page     页码数
 *  @param callback 返回列表
 */
-(void)productFocusListWithTag:(NSObject *)tag page:(int)page call:(TablePageArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPITableListWithTag:self path:@"/user/userEnshrine/findEnshrineList" parameters:paramDic pageIndex:page subClass:[ZLGoodsWithClass class] call:^(int totalPage, NSArray *tableArr, APIObject *info) {
            callback(totalPage, tableArr, info);
        }];
    } else
        callback(0, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}




#pragma mark----****----用户优惠券接口列表接口
/**
 *   用户优惠券接口列表接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)couponListWithTag:(NSObject *)tag call:(TableArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:self path:@"/user/coupon/coupon_list" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                NSArray *newArr = [CouponObject mj_objectArrayWithKeyValuesArray:info.data];
                callback(newArr, info);
            } else
                callback(nil, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}



#pragma mark----****----用户钱包记录接口
/**
 *   用户钱包记录列表接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)walletRecordListWithTag:(NSObject *)tag type:(int)type page:(int)page call:(TablePageArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        if (type > 0)
            [paramDic setInt:type forKey:@"type"];
        
        [self loadAPITableListWithTag:self path:@"/user/wallet/walletRecord" parameters:paramDic pageIndex:page subClass:[WalletRecordObject class] call:^(int totalPage, NSArray *tableArr, APIObject *info) {
            callback(totalPage, tableArr, info);
        }];
    } else
        callback(0, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *   用户积分兑换记录列表接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)userScoreRecordListWithTag:(NSObject *)tag page:(int)page call:(TablePageArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPITableListWithTag:self path:@"/user/score/userScoreRecordList" parameters:paramDic pageIndex:page subClass:[UserScoreRecordObject class] call:^(int totalPage, NSArray *tableArr, APIObject *info) {
            callback(totalPage, tableArr, info);
        }];
    } else
        callback(0, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}




#pragma mark----****----用户订单相关接口
/**
 *   用户订单列表接口
 *
 *  @param tag      链接对象
 *  @param odr_type 订单类型
 *  @param odr_status 订单状态
 *  @param callback 返回列表
 */
-(void)orderListWithTag:(NSObject *)tag odr_type:(kOrderClassType)odr_type odr_status:(NSString *)odr_status page:(int)page call:(TablePageArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:odr_type forKey:@"odr_type"];
        [paramDic setValidStr:odr_status forKey:@"odr_status"];
        
        [self loadAPITableListWithTag:self path:@"/order/order_list" parameters:paramDic pageIndex:page subClass:[OrderObject class] call:^(int totalPage, NSArray *tableArr, APIObject *info) {
            callback(totalPage, tableArr, info);
        }];
    } else
        callback(0, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}





/**
 *  订单详情接口
 *
 *  @param tag              链接对象
 *  @param odr_id           订单id
 *  @param odr_code         订单订单编号
 *  @param callback         返回信息
 */
-(void)orderInfoWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code call:(void (^)(OrderObject *item, APIObject* info))callback
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setInt:odr_id forKey:@"odr_id"];
    [paramDic setNeedStr:odr_code forKey:@"odr_code"];
    [self loadAPIWithTag:tag path:@"/order/order_info" parameters:paramDic call:^(APIObject *info) {
        OrderObject *it = [OrderObject mj_objectWithKeyValues:info.data];
        callback(it, info);
    }];
}



/**
 *  订单通用操作接口
 *
 *  @param tag              链接对象
 *  @param odr_id           订单id
 *  @param odr_type         订单类型（列表数据或者详情数据获取）
 *  @param odr_code         订单订单编号
 *  @param odr_state_next   操作状态
 *  @param maintain_reason  维权原因(可选)
 *  @param maintain_type    维权处理方式（全额退款、退款不退货等文字描述）(可选)
 *  @param callback         返回信息
 */
-(void)orderOprateWithTag:(NSObject *)tag odr_id:(int)odr_id odr_type:(int)odr_type odr_code:(NSString *)odr_code odr_state_next:(NSString *)odr_state_next maintain_reason:(NSString *)maintain_reason maintain_type:(NSString *)maintain_type call:(void (^)(NSString* odr_state_val, NSMutableArray* odr_state_next, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:odr_id forKey:@"odr_id"];
        [paramDic setInt:odr_type forKey:@"odr_type"];
        [paramDic setNeedStr:odr_code forKey:@"odr_code"];
        [paramDic setNeedStr:odr_state_next forKey:@"odr_state_next"];
        [paramDic setValidStr:maintain_reason forKey:@"maintain_reason"];
        [paramDic setValidStr:maintain_type forKey:@"maintain_type"];
        [self loadAPIWithTag:tag path:@"/order/order_oprate" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                NSString *str = [info.data objectWithKey:@"odr_state_val"]; //操作成功后的状态描述
                NSMutableArray *arr = [info.data objectWithKey:@"odr_state_next"];  //操作成功后的操作数组
                callback(str, arr, info);
            } else
                callback(nil, nil, info);
        }];
    } else
        callback(nil, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  用户订单多余价格确认 -- 用于确认报修、跑腿多余价格确认操作
 *
 *  @param tag              链接对象
 *  @param odr_id           订单id
 *  @param odr_code         订单订单编号
 *  @param pay_amount       支付金额，0.10元（两位小数，已元为单位）
 *  @param pass             支付密码
 *  @param callback         返回信息
 */
-(void)orderOprateRecycleWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code pay_amount:(int)pay_amount pass:(NSString *)pass call:(void (^)(NSString* odr_state_val, NSMutableArray* odr_state_next, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:odr_id forKey:@"odr_id"];
        [paramDic setNeedStr:odr_code forKey:@"odr_code"];
        [paramDic setObject:StringWithDouble(pay_amount) forKey:@"pay_amount"];
        [paramDic setNeedStr:pass forKey:@"pass"];
        [self loadAPIWithTag:tag path:@"/order/order_recycle" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                NSString *str = [info.data objectWithKey:@"odr_state_val"]; //操作成功后的状态描述
                NSMutableArray *arr = [info.data objectWithKey:@"odr_state_next"];  //操作成功后的操作数组
                callback(str, arr, info);
            } else
                callback(nil, nil, info);
        }];
    } else
        callback(nil, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  用户确认竞价接口
 *
 *  @param tag              链接对象
 *  @param odr_id           报修单ID
 *  @param bid_id           竞价ID
 *  @param odr_code         订单订单编号
 *  @param callback         返回信息
 */
-(void)orderOprateBidWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code bid_id:(int)bid_id call:(void (^)(ZLCreateOrderObj *payItem, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:odr_id forKey:@"odr_id"];
        [paramDic setInt:bid_id forKey:@"bid_id"];
        [paramDic setNeedStr:odr_code forKey:@"odr_code"];
        [self loadAPIWithTag:tag path:@"/order/order_opt_bid" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                ZLCreateOrderObj *pay = [ZLCreateOrderObj mj_objectWithKeyValues:info.data];
//                NSString *odr_idStr = [info.data objectWithKey:@"odr_id"]; //订单Id
//                NSString *odr_codeStr = [info.data objectWithKey:@"odr_code"]; //订单编号
//                NSString *odr_shop_nameStr = [info.data objectWithKey:@"odr_shop_name"]; //消费商户描述
//                NSString *odr_amountStr = [info.data objectWithKey:@"odr_amount"]; //订单商品原价格
//                NSString *odr_pay_priceStr = [info.data objectWithKey:@"odr_pay_price"]; //需支付金额
//                NSString *notifyStr = [info.data objectWithKey:@"notify"]; //支付创建接口参数
                callback(pay, info);
            } else
                callback(nil, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  订单获取差价支付信息
 *
 *  @param tag              链接对象
 *  @param odr_id           订单id
 *  @param odr_code         订单订单编号
 *  @param callback         返回信息
 */
-(void)orderOprateDiffPriceWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code call:(void (^)(ZLCreateOrderObj* item, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:odr_id forKey:@"odr_id"];
        [paramDic setNeedStr:odr_code forKey:@"odr_code"];
        [self loadAPIWithTag:tag path:@"/order/order_diffprice" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                ZLCreateOrderObj *it = [ZLCreateOrderObj mj_objectWithKeyValues:info.data];
                callback(it, info);
            } else
                callback(nil, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  订单获取差价支付信息
 *
 *  @param tag              链接对象
 *  @param odr_id           订单id
 *  @param com_star         评分
 *  @param com_content      评价类容
 *  @param com_imgs         评价图片(注：如有多个请用","分开)
 *  @param com_is_security  是否匿名(默认：0)1：匿名；0：不匿名
 *  @param callback         返回信息
 */
-(void)orderOprateEvaluateWithTag:(NSObject *)tag odr_id:(int)odr_id com_star:(double)com_star com_content:(NSString *)com_content com_imgs:(NSString *)com_imgs com_is_security:(BOOL)com_is_security call:(void (^)(NSString* odr_state_val, NSMutableArray* odr_state_next, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:odr_id forKey:@"odr_id"];
        [paramDic setObject:StringWithDouble(com_star) forKey:@"com_star"];
        [paramDic setValidStr:com_content forKey:@"com_content"];
        [paramDic setValidStr:com_imgs forKey:@"com_imgs"];
        [paramDic setObject:StringWithBool(com_is_security) forKey:@"com_is_security"];
        [self loadAPIWithTag:tag path:@"/order/order_evaluate" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                NSString *str = [info.data objectWithKey:@"odr_state_val"]; //操作成功后的状态描述
                NSMutableArray *arr = [info.data objectWithKey:@"odr_state_next"];  //操作成功后的操作数组
                callback(str, arr, info);
            } else
                callback(nil, nil, info);
        }];
    } else
        callback(nil, nil,[APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *   商户竞价列表接口接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)orderBidListWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code call:(TableArrBlock)callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    [paramDic setInt:odr_id forKey:@"odr_id"];
    [paramDic setNeedStr:odr_code forKey:@"odr_code"];
    [self loadAPIWithTag:self path:@"/order/order_bid_list" parameters:paramDic call:^(APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            NSArray *newArr = [OrderRepairBidObject mj_objectArrayWithKeyValuesArray:info.data];
            callback(newArr, info);
        } else
            callback(nil, info);
    }];
}


/**
 *   充值预订单接口
 *
 *  @param tag              链接对象
 *  @param callback         返回信息
 */
-(void)preOrderRechargeWithTag:(NSObject *)tag call:(void (^)(PreApplyObject*item, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:tag path:@"/preorder/pre_recharge" parameters:paramDic call:^(APIObject *info) {
            PreApplyObject *it = [PreApplyObject mj_objectWithKeyValues:info.data];
            callback(it, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *   手机充值预订单接口
 *
 *  @param tag              链接对象
 *  @param callback         返回信息
 */
-(void)preOrderMobileWithTag:(NSObject *)tag call:(void (^)(PreApplyObject*item, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:tag path:@"/preorder/pre_mobile" parameters:paramDic call:^(APIObject *info) {
            PreApplyObject *it = [PreApplyObject mj_objectWithKeyValues:info.data];
            callback(it, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}

/**
 *   手机充值预订单接口(新)
 *
 *  @param tag              链接对象
 *  @param callback         返回信息
 */
-(void)preOrderMobileV2WithTag:(NSObject *)tag call:(void (^)(PreApplyObject*item, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:tag path:@"/preorder/pre_mobile_v" parameters:paramDic call:^(APIObject *info) {
            PreApplyObject *it = [PreApplyObject mj_objectWithKeyValues:info.data];
            
            NSMutableArray *aaa = [MobileFluxObject mj_objectArrayWithKeyValuesArray:it.goods];
            it.goods = aaa;
            
            callback(it, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}



/**
 *   提现预订单接口
 *
 *  @param tag              链接对象
 *  @param callback         返回信息
 */
-(void)preOrderPresentWithTag:(NSObject *)tag call:(void (^)(PrePresentApplyObject*item, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:tag path:@"/preorder/pre_present" parameters:paramDic call:^(APIObject *info) {
            PrePresentApplyObject *it = [PrePresentApplyObject mj_objectWithKeyValues:info.data];
            callback(it, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *   转账预订单接口
 *
 *  @param tag              链接对象
 *  @param callback         返回信息
 */
-(void)preOrderTransferWithTag:(NSObject *)tag call:(void (^)(PreApplyObject*item, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:tag path:@"/preorder/pre_transfer" parameters:paramDic call:^(APIObject *info) {
            PreApplyObject *it = [PreApplyObject mj_objectWithKeyValues:info.data];
            callback(it, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}

/**
 *  跑跑腿申请押金预订单接口
 *
 *  @param tag              链接对象
 *  @param callback         返回信息
 */
-(void)preOrderPaopaoApplyWithTag:(NSObject *)tag call:(void (^)(PrePaopaoApplyObject*item, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:tag path:@"/preorder/pre_ppao_apply" parameters:paramDic call:^(APIObject *info) {
            PrePaopaoApplyObject *it = [PrePaopaoApplyObject mj_objectWithKeyValues:info.data];
            callback(it, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *   物业费预订单接口
 *
 *  @param tag              链接对象
 *  @param pfee_id          物业费id
 *  @param callback         返回信息
 */
-(void)preOrderPropertyWithTag:(NSObject *)tag pfee_id:(int)pfee_id call:(void (^)(PreApplyObject*item, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:pfee_id forKey:@"pfee_id"];
        [self loadAPIWithTag:tag path:@"/preorder/pre_property" parameters:paramDic call:^(APIObject *info) {
            PreApplyObject *it = [PreApplyObject mj_objectWithKeyValues:info.data];
            callback(it, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}

/**
 *   用户物业缴费列表接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)propertyFeeListWithTag:(NSObject *)tag call:(TableArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:self path:@"/property/search_fee" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                NSArray *newArr = [PropertyFeeObject mj_objectArrayWithKeyValuesArray:info.data];
                callback(newArr, info);
            } else
                callback(nil, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}




/**
 *   跑跑者订单列表接口
 *
 *  @param tag      链接对象
 *  @param odr_status 订单状态
 *  @param callback 返回列表
 */
-(void)orderPaopaoManListWithTag:(NSObject *)tag odr_status:(NSString *)odr_status page:(int)page call:(TablePageArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setNeedStr:odr_status forKey:@"odr_status"];
        [self loadAPITableListWithTag:self path:@"/ppao/ppao_order_list" parameters:paramDic pageIndex:page subClass:[OrderObject class] call:^(int totalPage, NSArray *tableArr, APIObject *info) {
            callback(totalPage, tableArr, info);
        }];
    } else
        callback(0, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  跑跑者订单详情接口
 *
 *  @param tag              链接对象
 *  @param odr_id           订单id
 *  @param odr_code         订单订单编号
 *  @param callback         返回信息
 */
-(void)orderPaopaoManInfoWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code call:(void (^)(OrderObject *item, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:odr_id forKey:@"odr_id"];
        [paramDic setNeedStr:odr_code forKey:@"odr_code"];
        [self loadAPIWithTag:tag path:@"/ppao/ppao_order_info" parameters:paramDic call:^(APIObject *info) {
            OrderObject *it = [OrderObject mj_objectWithKeyValues:info.data];
            callback(it, info);
        }];
    } else
        callback(nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  跑腿者订单通用操作接口
 *
 *  @param tag              链接对象
 *  @param odr_id           订单id
 *  @param odr_code         订单订单编号
 *  @param odr_state_next   操作状态   SSELECT--接单、SSERVICE--服务中（跑跑到达指定地点开始服务）、SCANCEL--商户取消订单、SDONE--完成订单
 *  @param callback         返回信息
 */
-(void)orderPaopaoManOprateWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code odr_state_next:(NSString *)odr_state_next call:(void (^)(NSString* odr_state_val, NSMutableArray* odr_state_next, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:odr_id forKey:@"odr_id"];
        [paramDic setNeedStr:odr_code forKey:@"odr_code"];
        [paramDic setNeedStr:odr_state_next forKey:@"odr_state_next"];
        [self loadAPIWithTag:tag path:@"/ppao/order_oprate" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                NSString *str = [info.data objectWithKey:@"odr_state_val"]; //操作成功后的状态描述
                NSMutableArray *arr = [info.data objectWithKey:@"odr_state_next"];  //操作成功后的操作数组
                callback(str, arr, info);
            } else
                callback(nil, nil, info);
        }];
    } else
        callback(nil, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}



/**
 *  跑腿者订单差价提交接口
 *
 *  @param tag              链接对象
 *  @param odr_id           订单id
 *  @param odr_code         订单订单编号
 *  @param diff_price       最终价格，格式化两位小数
 *  @param callback         返回信息
 */
-(void)orderPaopaoManOprateDiffWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code diff_price:(float)diff_price call:(void (^)(float odr_amount, float odr_pay_price, NSString* odr_state_val, NSMutableArray* odr_state_next, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:odr_id forKey:@"odr_id"];
        [paramDic setNeedStr:odr_code forKey:@"odr_code"];
        [paramDic setObject:StringWithDouble(diff_price) forKey:@"diff_price"];
        [self loadAPIWithTag:tag path:@"/ppao/order_diff" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                NSString *odr_amountStr = [info.data objectWithKey:@"odr_amount"]; //操作成功后订单商品价格
                NSString *odr_pay_priceStr = [info.data objectWithKey:@"odr_pay_price"]; //操作成功后订单支付价格
                NSString *odr_state_valStr = [info.data objectWithKey:@"odr_state_val"]; //操作成功后的状态描述
                NSMutableArray *arr = [info.data objectWithKey:@"odr_state_next"];  //操作成功后的操作数组
                callback([odr_amountStr floatValue], [odr_pay_priceStr floatValue], odr_state_valStr, arr, info);
            } else
                callback(0.0, 0.0, nil, nil, info);
        }];
    } else
        callback(0.0, 0.0, nil, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
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
    
    if (search.length > 0)
        [paramDic setObject:search forKey:@"search"];
    
    if (location.latitude>0 || location.longitude>0) {
        [paramDic setObject:StringWithDouble(location.latitude) forKey:@"lat"];
        [paramDic setObject:StringWithDouble(location.longitude) forKey:@"lng"];
    }else{
        [paramDic setObject:StringWithDouble(29.542968) forKey:@"lat"];
        [paramDic setObject:StringWithDouble(106.511898) forKey:@"lng"];
    }
    
    if (province > 0)
        [paramDic setObject:StringWithInt(province) forKey:@"cmut_province"];
    if (city > 0)
        [paramDic setObject:StringWithInt(city) forKey:@"cmut_city"];
    if (county > 0)
        [paramDic setObject:StringWithInt(county) forKey:@"cmut_county"];
    MLLog(@"para_is:%@",paramDic);
    [self loadAPIWithTag:self path:@"/community/community_search_list" parameters:paramDic call:^(APIObject *info) {
        NSArray *newArr = [CommunityObject mj_objectArrayWithKeyValuesArray:info.data];
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

    [self loadAPIWithTag:self path:@"/home/banner" parameters:nil call:^(APIObject *info) {

       
        if (info.code == RESP_STATUS_YES) {
            
            ZLHomeFunvtionAndBanner *mFuncTion = [ZLHomeFunvtionAndBanner new];
            
            mFuncTion.banners = [ZLHomeBanner mj_objectArrayWithKeyValuesArray:[info.data objectWithKey:@"banners"]];
            mFuncTion.functions = [ZLHomeFunctions mj_objectArrayWithKeyValuesArray:[info.data objectWithKey:@"functions"]];
            
            block (info,mFuncTion);
            
        } else
            block (info,nil);
    }];
    

    
}

#pragma mark----****----获取首页数据
///获取首页数据
- (void)ZLGetHome:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(APIObject *mBaseObj,ZLHomeObj *mHome))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    [para setValidStr:mLat forKey:@"adv_lat"];
    [para setValidStr:mLng forKey:@"adv_lng"];
    
    if ([ZLUserInfo ZLCurrentUser]) {
        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
    }
    
    [self loadAPIWithTag:self path:@"/home/homePage" parameters:para call:^(APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            
            ZLHomeObj *mHomeObj = [[ZLHomeObj alloc] init];
            
            id mAdv = [info.data objectWithKey:@"sAdvertList"];
            id mCom = [info.data objectWithKey:@"eCompanyNoticeList"];
            
            NSMutableArray *mAdvArr = [ZLHomeAdvList mj_objectArrayWithKeyValuesArray:mAdv];
            NSMutableArray *mComArr = [ZLHomeCompainNoticeList mj_objectArrayWithKeyValuesArray:mCom];
            
            mHomeObj.sAdvertList = mAdvArr;
            mHomeObj.eCompanyNoticeList = mComArr;
            
            block(info,mHomeObj);
            
        }else{
            block(info,nil);

        }
        
    }];
}
#pragma mark----****----获取首页系统发放优惠卷数据
- (void)ZLGetSystemCoupList:(void(^)(APIObject *mBaseObj,NSArray *List))block{

    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    NSMutableDictionary *para = [NSMutableDictionary new];

    if (user.user_id > 0) {
        [para setInt:user.user_id forKey:@"user_id"];
        [para setObject:@"3ac4bb811f3d9dde89eb6079133426e8" forKey:@"sign"];
        [self loadAPIWithTag:self path:@"/user/coupon/load_coupon" parameters:para call:^(APIObject *info) {

            if (info.code == RESP_STATUS_YES) {
                
                NSMutableArray *mTempArr = [NSMutableArray new];
                for (NSDictionary *dic in info.data) {
                    [mTempArr addObject:[ZLSystempCoup mj_objectWithKeyValues:dic]];
                }
                block(info,mTempArr);

            }else{
                block(info,nil);
            }
            
            
        }];
    }else{
        block(nil, nil);
    }
}
//#pragma mark----****----获取首页社区地址数据
///**
// 获取首页社区地址数据
// 
// @param mLat       纬度
// @param mLng       经度
// @param mSearchTx  搜索内容
// @param mProvince  省份id
// @param mCityId    城市id
// @param mCountryId 区县id
// @param block      返回值
// */
//- (void)ZLGetHomeCommunity:(NSString *)mLat andLng:(NSString *)mLng andSearchText:(NSString *)mSearchTx andProvinceId:(int)mProvince andCityId:(int)mCityId andCountryId:(int)mCountryId block:(void(^)(APIObject *mBaseObj,NSArray *mArr))block{
//
//    NSMutableDictionary *para = [NSMutableDictionary new];
//    
//    
//    if (mLat) {
//        [para setNeedStr:mLat forKey:@"lat"];
//    }
//    if (mLng) {
//        [para setNeedStr:mLng forKey:@"lng"];
//        
//    }
//    if (mSearchTx.length>0 || ![mSearchTx isEqualToString:@""]) {
//        [para setNeedStr:mSearchTx forKey:@"search"];
//    }
//    if (mProvince) {
//        [para setInt:mProvince forKey:@"cmut_province"];
//    }
//    if (mCityId) {
//        [para setInt:mCityId forKey:@"cmut_city"];
//    }
//    if (mCountryId) {
//        [para setInt:mCountryId forKey:@"cmut_county"];
//    }
//    
//    
//    [self loadAPIWithTag:self path:@"/community/community_search_list" parameters:para call:^(APIObject *info) {
//        
//        
//        if (info.code == RESP_STATUS_YES) {
//            
//            NSMutableArray *mTempArr = [NSMutableArray new];
//            
//            id mArrTemp = info.data;
//            
//            if ([mArrTemp isKindOfClass:[NSArray class]]) {
//                for (NSDictionary *dic in mArrTemp) {
//                    
//                    [mTempArr addObject:[ZLHomeCommunity mj_objectWithKeyValues:dic]];
//                    
//                }
//            }
//        
//            
//            block(info,mTempArr);
//         
//        }else{
//            block(info,nil);
//            
//        }
//        
//    }];
//    
//}
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
    
    [para setValidStr:mLat forKey:@"lat"];
    [para setValidStr:mLng forKey:@"lng"];
    [para setInt:mType forKey:@"shop_type"];
    
    [self loadAPIWithTag:self path:@"/shop/shop_home" parameters:para call:^(APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            
            NSMutableArray *mBannerArr = [NSMutableArray new];
            NSMutableArray *mCampainArr = [NSMutableArray new];
            NSMutableArray *mClassifyArr = [NSMutableArray new];
            
            id mBanner = [info.data objectForKey:@"banners"];
            id mCanpain = [info.data objectForKey:@"campaign"];
            id mClassify = [info.data objectForKey:@"classify"];
            
            mBannerArr = [ZLHomeBanner mj_objectArrayWithKeyValuesArray:mBanner];
            mCampainArr = [ZLShopHomeCampaign mj_objectArrayWithKeyValuesArray:mCanpain];
            
            if ([mClassify isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in mClassify) {
                    ZLShopHomeClassify *aa = [ZLShopHomeClassify mj_objectWithKeyValues:dic];
                    aa.class_type = mType;
                    [mClassifyArr addObject:aa];
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
 @param mShopId   活动id
 @param mSkuId   规格id
 @param block    返回值
 */
- (void)ZLGetGoodsDetail:(NSString *)mGoodsId andShopId:(NSString *)mShopId andSkuId:(NSString *)mSkuId block:(void(^)(APIObject *mBaseObj,NSString *mUrl))block{

    
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    if(mGoodsId){
        [para setNeedStr:mGoodsId forKey:@"pro_id"];
    }
    if (mSkuId) {
        [para setNeedStr:mSkuId forKey:@"sku_id"];

    }
    if (mShopId) {
        [para setNeedStr:mShopId forKey:@"shop_id"];
        
    }

    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    if (user.user_id > 0) {
        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        
        [self getUrl:@"/wap/good/goodsdetails" parameters:para call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                block(info, nil);
            } else
                block(info, nil);
        }];
        
    

    }else{
    
        block([APIObject infoWithReLoginErrorMessage:@"您还未登录呐～"],nil);
    }
    
    

    
    
}

#pragma mark----****----获取便民服务接口
/**
 *   便民服务接口列表接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)externalPlatformListWithTag:(NSObject *)tag call:(TableArrBlock)callback
{
    [self loadAPIWithTag:self path:@"/other/external_platform_list" parameters:nil call:^(APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            NSArray *newArr = [ZLHomeServicePerson mj_objectArrayWithKeyValuesArray:info.data];
            callback(newArr, info);
        } else
            callback(nil, info);
    }];
}




#pragma mark----*****----获取首页消息列表
/**
 获取首页消息列表
 
 @param block 返回值
 */
- (void)ZLGetHomeMsgList:(void (^)(APIObject *mBaseObj, ZLHomeMsgObj* mHomeMsg))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
    
    [self loadAPIWithTag:self path:@"/user/message/message_list" parameters:para call:^(APIObject *info) {
        if (info.code == RESP_STATUS_YES) {
            ZLHomeMsgObj *mHomeMsg = [ZLHomeMsgObj mj_objectWithKeyValues:info.data];
            block(info,mHomeMsg);
        } else
            block(info,nil);
    }];
}

#pragma mark----*****----获取首页公告列表
/**
 获取首页公告列表
 @param mPage 页码默认值: 1
 @param block 返回值
 */
- (void)ZLGetHomeAnouncement:(int)mPage block:(TablePageArrBlock)block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        [para setInt:mPage forKey:@"page"];
        [para setInt:TABLE_PAGE_ROW forKey:@"rows"];
        
        [self loadAPITableListWithTag:self path:@"/other/notice/notice_list" parameters:para pageIndex:mPage subClass:[ZLHomeAnouncementListObj class] call:^(int totalPage, NSArray *tableArr, APIObject *info) {
            
            ZLHomeAnouncementListObj *mList = [ZLHomeAnouncementListObj mj_objectWithKeyValues:info.data];

            block(totalPage, mList.list, info);
            
        }];
    }else{
        block(0, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);

    }
    


}

#pragma mark----****----用户签到相关接口
/**
 *  用户签到接口
 *
 *  @param tag      链接对象
 *  @param callback 返回信息
 */
-(void)userSignWithTag:(NSObject *)tag call:(void (^)(int score, APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPIWithTag:tag path:@"/user/wallet/userSign" parameters:paramDic call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES && info.data!=nil) {
                NSString *scoreStr = [info.data objectWithKey:@"score"];
                callback([scoreStr intValue], info);
            } else
                callback(0, info);
        }];
    } else
        callback(0, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


#pragma mark----****----投诉建议接口
/**
 *   投诉建议接口列表接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)complaintListWithTag:(NSObject *)tag page:(int)page call:(TablePageArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPITableListWithTag:self path:@"/user/complaint/complaint_list" parameters:paramDic pageIndex:page subClass:[ComplaintObject class] call:^(int totalPage, NSArray *tableArr, APIObject *info) {
            callback(totalPage, tableArr, info);
        }];
    } else
        callback(0, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  投诉建议-公司接口
 *
 *  @param tag      链接对象
 *  @param content  投诉正文
 *  @param callback 返回信息
 */
-(void)complaintCompanyAddWithTag:(NSObject *)tag content:(NSString *)content call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setNeedStr:content forKey:@"content"];
        [self loadAPIWithTag:tag path:@"/user/complaint/complaint_company" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  投诉建议-小区物管接口
 *
 *  @param tag      链接对象
 *  @param content  投诉正文
 *  @param cmut_id  小区id
 *  @param callback 返回信息
 */
-(void)complaintCommunityUpWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:cmut_id forKey:@"cmut_id"];
        [paramDic setNeedStr:content forKey:@"content"];
        [self loadAPIWithTag:tag path:@"/user/complaint/complaint_community" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}

/**
 *  投诉建议-小区居民接口
 *
 *  @param tag      链接对象
 *  @param content  投诉正文
 *  @param cmut_id  小区id
 *  @param callback 返回信息
 */
-(void)complaintPeopleUpWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:cmut_id forKey:@"cmut_id"];
        [paramDic setNeedStr:content forKey:@"content"];
        [self loadAPIWithTag:tag path:@"/user/complaint/complaint_people" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


/**
 *  投诉建议-小区物管接口  【该方法已遗弃】
 *
 *  @param tag      链接对象
 *  @param content  投诉正文
 *  @param cmut_id  小区id
 *  @param user_name 投诉者姓名，默认为空
 *  @param callback 返回信息
 */
-(void)complaintCommunityAddWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id user_name:(NSString *)user_name call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:cmut_id forKey:@"cmut_id"];
        [paramDic setValidStr:user_name forKey:@"complaint_user_name"];
        [paramDic setNeedStr:content forKey:@"content"];
        [self loadAPIWithTag:tag path:@"/user/complaint/complaint_community" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}



/**
 *  投诉建议-小区居民接口 【该方法已遗弃】
 *
 *  @param tag      链接对象
 *  @param content  投诉正文
 *  @param cmut_id  小区id
 *  @param address  小区里面楼栋房间号
 *  @param callback 返回信息
 */
-(void)complaintPeopleAddWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id address:(NSString *)address call:(void (^)(APIObject* info))callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [paramDic setInt:cmut_id forKey:@"cmut_id"];
        [paramDic setValidStr:address forKey:@"address"];
        [paramDic setNeedStr:content forKey:@"content"];
        [self loadAPIWithTag:tag path:@"/user/complaint/complaint_people" parameters:paramDic call:^(APIObject *info) {
            callback(info);
        }];
    } else
        callback([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}


#pragma mark----*****----提交预订单
/**
 提交预订单
 @param mType 预订单类型
 @param mShopId 店铺id
 @param mGoods 商品json数组
 @param block 返回值
 */
- (void)ZLCommitPreOrderWithType:(kOrderClassType)mType andShopId:(int)mShopId andGoodsArr:(NSString *)mGoods block:(void (^)(APIObject *mBaseObj,ZLPreOrderObj *mPreOrder))block{

    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* para = [NSMutableDictionary dictionary];
        
        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        
        if (mShopId) {
            [para setInt:mShopId forKey:@"shop_id"];
        }
        
        [para setObject:mGoods forKey:@"goods"];
        
        NSString *mUrl = nil;
        if (mType == kOrderClassType_product) {
            mUrl = @"/preorder/pre_products";
        }else{
            mUrl = @"/preorder/pre_dryclean";
        }
        MLLog(@"上传的商品：------%@",mGoods);
        [self loadAPIWithTag:self path:mUrl parameters:para call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                block(info,[ZLPreOrderObj mj_objectWithKeyValues:info.data]);
            }else{
                block(info,nil);
            }
            
        }];
        
    }else{
        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"],nil);

    }
    

    


    
}

#pragma mark----****----用户生成订单接口
/**
 用户生成订单接口
 
 @param mOrderType 订单类型
 @param mShopId 店铺id
 @param mGoodsList 商品json列表
 @param mSendAddress 配送地址
 @param mArriveAddress 送达地址
 @param mServiceTime 服务时间
 @param mSendType 配送方式
 @param mSendPrice 配送费
 @param mCoupId 优惠卷id
 @param mRemark 备注
 @param mSign 下单签名
 @param block 返回值
 */
- (void)ZLCommitOrder:(kOrderClassType)mOrderType andShopId:(NSString *)mShopId andGoods:(NSString *)mGoodsList andSendAddress:(NSString *)mSendAddress andArriveAddress:(NSString *)mArriveAddress andServiceTime:(NSString *)mServiceTime andSendType:(ZLShopSendType)mSendType andSendPrice:(NSString *)mSendPrice andCoupId:(NSString *)mCoupId andRemark:(NSString *)mRemark andSign:(NSString *)mSign block:(void (^)(APIObject *mBaseObj,ZLCreateOrderObj *mOrder))block{
    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    if (user.user_id > 0) {
        NSMutableDictionary* para = [NSMutableDictionary dictionary];
        
        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        
        [para setInt:mOrderType forKey:@"odr_type"];
        
        if (mShopId) {
            [para setObject:mShopId forKey:@"shop_id"];
        }
        if (mGoodsList) {
            [para setObject:mGoodsList forKey:@"goods"];
        }
        if (mSendAddress) {
            [para setObject:mSendAddress forKey:@"addr_id"];
        }
        if (mArriveAddress) {
            [para setObject:mArriveAddress forKey:@"addr_id_pick"];
        }
        if (mServiceTime) {
            [para setObject:mServiceTime forKey:@"odr_timing"];
        }
        
        if (mSendType > 0) {
            [para setInt:mSendType forKey:@"odr_deliver_type"];
        }
        
        if (mSendPrice) {
            [para setObject:mSendPrice forKey:@"odr_deliver_fee"];
        }
        if (mCoupId) {
            [para setObject:mCoupId forKey:@"cuc_id"];
        }
        if (mRemark) {
            [para setObject:mRemark forKey:@"odr_remark"];
        }
        if (mSign) {
            [para setObject:mSign forKey:@"sign"];
        }
        
        [self loadAPIWithTag:self path:@"/order/order_create" parameters:para call:^(APIObject *info) {
            if (info.code == RESP_STATUS_YES) {
                block(info,[ZLCreateOrderObj mj_objectWithKeyValues:info.data]);
            }else{
                block(info,nil);
            }
            
        }];
        
    } else {
        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"],nil);
    }
}

#pragma mark----****----发起支付
/**
 发起支付
 @param mGoPayType 去支付对象
 @param mPayObj 支付订单对象
 @param mPayType 支付类型
 @param block 返回值
 */
- (void)ZLSendToPayOrderObjGoPay:(ZLGoPayType)mGoPayType andPayObj:(ZLCreateOrderObj *)mPayObj andPayType:(ZLPayType)mPayType block:(void (^)(APIObject *mBaseObj,ZLCreateOrderObj* mPayOrderObj))block{

    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    if (user.user_id > 0) {
        
        NSMutableDictionary* para = [NSMutableDictionary dictionary];
        
        NSString *mUri = nil;
        
        if (mGoPayType == ZLGoPayTypeWithConfirmPay) {///去支付
            mUri = @"/pay/confirm_pay";
      
            [para setObject:mPayObj.pass forKey:@"pass"];
            [para setObject:mPayObj.sign forKey:@"sign"];

        }else{
            mUri = @"/pay/create_pay";
           
            [para setObject:mPayObj.notify forKey:@"notify"];
            [para setInt:mPayType forKey:@"pay_channel"];

        }
    
        [para setInt:user.user_id forKey:@"user_id"];
        
        [para setObject:[NSString stringWithFormat:@"%.2f",mPayObj.odr_pay_price] forKey:@"pay_amount"];
        
        
        [para setInt:mPayObj.odr_id forKey:@"odr_id"];
        
        [para setObject:mPayObj.odr_code forKey:@"odr_code"];

     
        
        [self loadAPIWithTag:self path:mUri parameters:para call:^(APIObject *info) {
            
            if (info.code == RESP_STATUS_YES) {
                
                if (mPayType == ZLPayTypeWithWechat) {
                    SWxPayInfo* wxpayinfo = [SWxPayInfo mj_objectWithKeyValues:info.data];
//                    [ZLUserInfo ZLCurrentUser].mPayBlock = ^(APIObject *resb){
//                        if (resb.code == RESP_STATUS_YES) {
//                            block(resb,nil);//再回调获取
//
//                        }else{
//                            block(resb,nil);//再回调获取
//
//                        }
//                        [ZLUserInfo ZLCurrentUser].mPayBlock = nil;
//                    };
                    [self gotoWXPayWithSRV:wxpayinfo];
                }else if (mPayType == ZLPayTypeWithAlipay){
                    SWxPayInfo* aliPay = [SWxPayInfo mj_objectWithKeyValues:info.data];
//                    [ZLUserInfo ZLCurrentUser].mPayBlock = ^(APIObject *resb){
//                        if (resb.code == RESP_STATUS_YES) {
//                            block(resb,nil);//再回调获取
//                            
//                        }else{
//                            block(resb,nil);//再回调获取
//                            
//                        }
//                        [ZLUserInfo ZLCurrentUser].mPayBlock = nil;
//
//                    };

                    [self gotoAliPay:aliPay];
                }else{
                    block(info,[ZLCreateOrderObj mj_objectWithKeyValues:info.data]);

                }

            }else{
                
                block(info,nil);
                
            }
            
        }];
        
    }else{
        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"],nil);
        
    }

    
    
    
}
#pragma mark----****----微信支付
- (void)gotoWXPayWithSRV:(SWxPayInfo*)payinfo{
    PayReq *payobj = [[PayReq alloc] init];
    payobj.partnerId = @"1336953201";
    payobj.prepayId = payinfo.prepay_id;
    payobj.nonceStr = payinfo.nonce_str;
    payobj.timeStamp = payinfo.timeStamp;
    payobj.package = @"Sign=WXPay";
    payobj.sign = payinfo.sign;
    [WXApi sendReq:payobj];
}
#pragma mark----****----支付宝支付
- (void)gotoAliPay:(SWxPayInfo *)payinfo{
    [[AlipaySDK defaultService] payOrder:payinfo.packages fromScheme:@"zerolife" callback:^(NSDictionary *resultDic) {
        MLLog(@"xxx:%@",resultDic);
        APIObject *retobj = [[APIObject alloc]init];
        if (resultDic) {
            if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
            {
                
                retobj.msg = @"支付成功";
                retobj.code = 200;
                [[NSNotificationCenter defaultCenter] postNotificationName:MyOrderPaySuccessNotification object:nil];
                [SVProgressHUD showSuccessWithStatus:retobj.msg];

            }
            else
            {
                [SVProgressHUD showErrorWithStatus:[resultDic objectForKey:@"memo" ]];

                retobj.msg = [resultDic objectForKey:@"memo" ];
                retobj.code = 500;
                [SVProgressHUD showErrorWithStatus:retobj.msg];

            }
        }else{

            retobj.msg = @"支付出现异常";
            retobj.code = 500;
            [SVProgressHUD showErrorWithStatus:retobj.msg];


        }


    }];
}


#pragma mark----****----获取跑腿首页分类
/**
 获取跑腿首页分类
 
 @param block 返回值
 */
- (void)ZLGetPPTHome:(void (^)(APIObject *mBaseObj,ZLPPTHomeClassList *mList))block{

    
    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    if (user.user_id > 0) {
        
        NSMutableDictionary* para = [NSMutableDictionary dictionary];
        
        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        
        
        [self loadAPIWithTag:self path:@"/ppao/ppao_load" parameters:para call:^(APIObject *info) {
            
            if (info.code == RESP_STATUS_YES) {
                
                block(info,[ZLPPTHomeClassList mj_objectWithKeyValues:info.data]);
                
            }else{
                
                block(info,nil);
                
            }
            
        }];
        
    }else{
        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"],nil);
        
    }
    
}

#pragma mark----****----获取跑腿榜
/**
 *  获取跑腿榜
 *
 *  @param tag      链接对象
 *  @param mSort 排序类型(1:订单量排名[默认为0]，2：金额量排名,3:评价排名)
 *  @param page     页码数
 *  @param callback 返回列表
 */
-(void)ZLGetPPTTopListWithTag:(NSObject *)tag sort:(kPaopaoSortType)mSort page:(int)page call:(TablePageArrBlock)callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    [paramDic setInt:mSort forKey:@"sort"];
    [self loadAPITableListWithTag:self path:@"/ppao/ppao_sort" parameters:paramDic pageIndex:page subClass:[ZLPPTTopObj class] call:^(int totalPage, NSArray *tableArr, APIObject *info) {
        callback(totalPage, tableArr, info);
    }];
}


#pragma mark----****----获取跑腿酬金列表
/**
 *  获取跑腿酬金列表
 *
 *  @param tag      链接对象
 *  @param page     页码数
 *  @param callback 返回列表
 */
-(void)ZLGetPPTRewardList:(NSObject *)tag page:(int)page call:(TablePageArrBlock)callback
{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    if (user.user_id > 0) {
        NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
        [paramDic setInt:user.user_id forKey:@"user_id"];
        [self loadAPITableListWithTag:self path:@"/ppao/ppao_revenue" parameters:paramDic pageIndex:page subClass:[ZLPPTRewardObj class] call:^(int totalPage, NSArray *tableArr, APIObject *info) {
            callback(totalPage, tableArr, info);
        }];
    } else
        callback(0, nil, [APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
}

#pragma mark----****----获取评价
/**
 获取评价
 
 @param mPage 行数页数
 @param mType 请求类型
 @param mId id
 @param mPageSize 每页条数
 @param block 返回值
 */
- (void)ZLGetRateList:(int)mPage andType:(ZLRateVCType)mType andId:(int)mId andPageSize:(int)mPageSize block:(void(^)(APIObject *mBaseObj,NSArray *mList,OrderCommentExtraObject *mExt))block{

    
    NSString *mUrl = nil;
    NSMutableDictionary* para = [NSMutableDictionary dictionary];

    if (mType == ZLRateVCTypeWithShop) {///店铺评价
        
        mUrl = @"/shop/shop_evaluate";
        [para setInt:mId forKey:@"shop_id"];

    }else{///跑跑腿评价
        mUrl = @"/ppao/ppao_evaluate";
        [para setInt:mId forKey:@"user_id"];

    }
    if (mPage) {
        [para setObject:NumberWithInt(mPage) forKey:@"pageNumber"];
        
    }
    [para setInt:20 forKey:@"pageSize"];
    
    
    [self loadAPIWithTag:self path:mUrl parameters:para call:^(APIObject *info) {
        
        if (info.code == RESP_STATUS_YES) {
            
            NSMutableArray *mTempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in [[info.data objectForKey:@"pages"] objectForKey:@"list"]) {
                [mTempArr addObject:[OrderCommentObject mj_objectWithKeyValues:dic]];
            }
            
            block(info,mTempArr,[OrderCommentExtraObject mj_objectWithKeyValues:[info.data objectForKey:@"count"]]);
            
        }else{
            
            block(info,nil,nil);
            
        }
        
    }];
    

    
}

//#pragma mark----****----获取手机充值预订单
///**
// 获取手机充值预订单
// @param block 返回值
// */
//- (void)ZLGetPreRechargePhone:(void(^)(APIObject *mBaseObj,ZLCreatePreOrder *mRecharge))block{
//
//    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
//    
//    if (user.user_id > 0) {
//        
//        NSMutableDictionary* para = [NSMutableDictionary dictionary];
//        
//        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
//        
//        [self loadAPIWithTag:self path:@"/preorder/pre_mobile" parameters:para call:^(APIObject *info) {
//            
//            if (info.code == RESP_STATUS_YES) {
//                
//                block(info,[ZLCreatePreOrder mj_objectWithKeyValues:info.data]);
//                
//            }else{
//                
//                block(info,nil);
//                
//            }
//            
//        }];
//        
//    }else{
//        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"],nil);
//        
//    }
//    
//    
//}

#pragma mark----****----手机充值订单
/**
 手机充值
 
 @param mRecharge 充值对象
 @param mPhone 充值电话
 
 @param mOrderType 充值订单类型
 @param mMoney 充值金额
 
 @param block 返回值
 */
//#warning 这里缺省提交的订单类型枚举值（ZLCommitOrderType）
//- (void)ZLPhoneRecharge:(int)mRecharge andOrderType:(ZLCommitOrderType)mOrderType andPhone:(NSString *)mPhone andMoney:(NSString *)mMoney block:(void(^)(APIObject *mBaseObj))block{
//
//    
//    
//}

#pragma mark----****---- 报修预订单接口
/**
 报修预订单接口
 
 @param mClsId 分类id
 @param block 返回值
 */
- (void)ZLFixPreOrder:(int)mClsId block:(void(^)(APIObject *mBaseObj,ZLCreatePreOrder *mPreOrder))block{

    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    if (user.user_id > 0) {
        
        NSMutableDictionary* para = [NSMutableDictionary dictionary];
        MLLog(@"%@",[ZLUserInfo ZLCurrentUser]);

        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        [para setInt:mClsId forKey:@"cls_id"];

        [self loadAPIWithTag:self path:@"/preorder/pre_fix" parameters:para call:^(APIObject *info) {
            
            if (info.code == RESP_STATUS_YES) {
                
                block(info,[ZLCreatePreOrder mj_objectWithKeyValues:info.data]);
                
            }else{
                
                block(info,nil);
                
            }
            
        }];
        
    }else{
        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"],nil);
        
    }
    

}
//#pragma mark----****---- 申请跑跑腿预订单
///**
// 申请跑跑腿预订单
// 
// @param block 返回值
// */
//- (void)ZLApplyPPTPreOrder:(void(^)(APIObject *mBaseObj,ZLCreatePreOrder *mPreOrder))block{
//    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
//    
//    if (user.user_id > 0) {
//        
//        NSMutableDictionary* para = [NSMutableDictionary dictionary];
//        
//        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
//        
//        MLLog(@"%@",[ZLUserInfo ZLCurrentUser]);
//        [self loadAPIWithTag:self path:@"/preorder/pre_ppao_apply" parameters:para call:^(APIObject *info) {
//            
//            if (info.code == RESP_STATUS_YES) {
//                
//                block(info,[ZLCreatePreOrder mj_objectWithKeyValues:info.data]);
//                
//            }else{
//                
//                block(info,nil);
//                
//            }
//            
//        }];
//        
//    }else{
//        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"],nil);
//        
//    }
//    
//}


#pragma mark----****----  获取跑跑腿首页订单列表
/**
 获取跑跑腿首页订单列表
 
 @param mLat 纬度
 @param mLng 经度
 @param mPage 分页
 @param mPageSize 每页条数
 @param mId 分类id
 @param block 返回值
 */
- (void)ZLGetRunningmanHomeList:(double)mLat andLng:(double)mLng andPage:(int)mPage andPageSize:(int)mPageSize andClsId:(int)mId block:(void(^)(APIObject *mBaseObj,ZLRunningmanHomeList *mList))block{
    
    NSMutableDictionary* para = [NSMutableDictionary dictionary];
    
    if (mPage) {
        [para setInt:mPage forKey:@"pageNumber"];
    }
    
    if (mPageSize) {
        [para setInt:mPageSize forKey:@"pageSize"];
    }
    [para setInt:mId forKey:@"cls_id"];

    [para setObject:[NSString stringWithFormat:@"%f",mLat] forKey:@"lat"];
    [para setObject:[NSString stringWithFormat:@"%f",mLng] forKey:@"lng"];
    
    
    [self loadAPIWithTag:self path:@"/ppao/order_task" parameters:para call:^(APIObject *info) {
        
        if (info.code == RESP_STATUS_YES) {
            
            block(info,[ZLRunningmanHomeList mj_objectWithKeyValues:info.data]);
            
        }else{
            
            block(info,nil);
            
        }
        
    }];
    
}
#pragma mark----****----  获取跑腿者经纬度
/**
 获取跑腿者经纬度
 
 @param mLocation 位置信息
 @param block 返回值
 */
- (void)ZLGetPPTLocation:(CommunityObject *)mLocation block:(void(^)(APIObject *mBaseObj))block{

    NSMutableDictionary* para = [NSMutableDictionary dictionary];
    

 
    [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
    
    [para setObject:NumberWithFloat(mLocation.cmut_lat) forKey:@"lat"];
    [para setObject:NumberWithFloat(mLocation.cmut_lng) forKey:@"lng"];
    
    
    [self loadAPIWithTag:self path:@"/ppao/ppao_location" parameters:para call:^(APIObject *info) {
        
        block(info);
        
    }];

    
}

#pragma mark----****----获取发布跑跑腿预订单
/**
 获取发布跑跑腿预订单
 
 @param block 返回值
 */
- (void)ZLGetRunningmanPreOrder:(void(^)(APIObject *mBaseObj,ZLPreOrderObj *mPreOrder))block{

    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    if (user.user_id > 0) {
        
        NSMutableDictionary* para = [NSMutableDictionary dictionary];
        
        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        
        MLLog(@"%@",[ZLUserInfo ZLCurrentUser]);
        [self loadAPIWithTag:self path:@"/preorder/pre_ppao" parameters:para call:^(APIObject *info) {
            
            if (info.code == RESP_STATUS_YES) {
                
                block(info,[ZLPreOrderObj mj_objectWithKeyValues:info.data]);
                
            }else{
                
                block(info,nil);
                
            }
            
        }];
        
    }else{
        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"],nil);
        
    }
    
}

#pragma mark----****---- 获取我的跑跑腿订单
/**
 获取我的跑跑腿订单
 
 @param mPage 分页
 @param mPageSize 每页数量
 @param mStatus 状态
 @param block 返回值
 */
- (void)ZLGetMyPPTOrder:(int)mPage andPageSize:(int)mPageSize andStatus:(NSString *)mStatus block:(void(^)(APIObject *mBaseObj,NSArray *mArr))block{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    if (user.user_id > 0) {
        
        NSMutableDictionary* para = [NSMutableDictionary dictionary];
        
//        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        [para setObject:NumberWithInt([ZLUserInfo ZLCurrentUser].user_id) forKey:@"user_id"];
        
        if (mPage) {
            [para setInt:mPage forKey:@"pageNumber"];
        }
        if (mPageSize) {
            [para setInt:mPageSize forKey:@"pageSize"];
        }
        
        [para setObject:mStatus forKey:@"odr_status"];
        MLLog(@"%@",[ZLUserInfo ZLCurrentUser]);
        
        
        [self loadAPIWithTag:self path:@"/ppao/ppao_order_list" parameters:para call:^(APIObject *info) {
            
            if (info.code == RESP_STATUS_YES) {
                
                NSMutableArray *mTempArr = [NSMutableArray new];
                
                for (NSDictionary *dic in [info.data objectForKey:@"list"]) {
                    
                    [mTempArr addObject:[OrderObject mj_objectWithKeyValues:dic]];

                }
                
                block(info,mTempArr);
                
            }else{
                
                block(info,nil);
                
            }
            
        }];

        
    }else{
        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"],nil);

    }
    
}

#pragma mark----****---- 水电煤缴费查询接口
/**
 水电煤缴费查询接口
 
 @param mType 选择类型
 @param mPara 参数
 @param block 返回值
 */
- (void)ZLFindPublic:(ZLHydroelectricType)mType andPara:(NSDictionary *)mPara block:(void(^)(mJHBaseData *resb,NSArray *mArr))block{

    
    NSString *posturl = nil;
    if (mType == ZLHydroelectricTypeWithProvince) {
        posturl = @"province";

    }else if (mType == ZLHydroelectricTypeWithCity){
        posturl = @"city";

    }else if (mType == ZLHydroelectricTypeWithPayType){
        posturl = @"project";

    }else if(mType == ZLHydroelectricTypeWithPayUnint){
        posturl = @"unit";

    }else{
        posturl = @"query";

    }
    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    if (user.user_id > 0) {
        [[JHJsonRequst sharedHDNetworking] postUrl:posturl parameters:mPara call:^(mJHBaseData *info) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            if (info.mSucess) {
                
                if (mType == ZLHydroelectricTypeWithProvince) {
                    tempArr = [ZLJHProvince mj_objectArrayWithKeyValuesArray:info.mData];
                    
                }else if (mType == ZLHydroelectricTypeWithCity){
                    tempArr = [ZLJHCity mj_objectArrayWithKeyValuesArray:info.mData];
                    
                }else if (mType == ZLHydroelectricTypeWithPayType){
                    tempArr = [ZLJHPayType mj_objectArrayWithKeyValuesArray:info.mData];

                }else if(mType == ZLHydroelectricTypeWithPayUnint){
                    tempArr = [ZLJHPayUnint mj_objectArrayWithKeyValuesArray:info.mData];

                }else{
                    
                }
                
                block ( info ,tempArr);
                
            }else{
                block ( info ,nil);
            }
            
        }];

    }else{
        block([mJHBaseData infoWithError:@"请重新登陆"],nil);
        
    }
  
    
}
#pragma mark----****---- 水电煤缴费查询接口
/**
 水电煤缴费查询接口
 
 @param mPara 参数
 @param block 返回值
 */
- (void)ZLInquireOrder:(ZLHydroelectricPreOrder *)mPara block:(void(^)(mJHBaseData *resb,NSString *mBalance))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPara.mProvince.provinceName forKey:@"provname"];
    [para setObject:mPara.mCity.cityName forKey:@"cityname"];
    [para setObject:mPara.mType forKey:@"type"];
    [para setObject:mPara.mPayUnint.payUnitId forKey:@"code"];
    [para setObject:mPara.mPayUnint.payUnitName forKey:@"name"];
    [para setObject:mPara.mPaytype.payProjectId forKey:@"cardid"];
    
    [para setObject:mPara.mPayAmount forKey:@"account"];
    [para setObject:JHSDK_AppKey forKey:@"key"];

    
    [[JHJsonRequst sharedHDNetworking] postUrl:@"mbalance" parameters:para call:^(mJHBaseData *info) {
        
        NSMutableArray *tempArr = [NSMutableArray new];
        [tempArr removeAllObjects];
        if (info.mSucess) {
            
            block ( info,[[[[info.mData objectForKey:@"result"] objectForKey:@"balances"] objectAtIndex:0] objectForKey:@"balance"]);

            
        }else{
            block ( info ,nil);
        }
        
    }];
}
#pragma mark----****---- 水电煤缴费接口
/**
 水电煤缴费接口
 
 @param mPara 参数
 @param block 返回值
 */
- (void)ZLGoPayHyelectricOrder:(ZLHydroelectricPreOrder *)mPara block:(void(^)(mJHBaseData *resb))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPara.mProvince.provinceName forKey:@"provname"];
    [para setObject:mPara.mCity.cityName forKey:@"cityname"];
    [para setObject:mPara.mType forKey:@"type"];
    [para setObject:mPara.mPayUnint.payUnitId forKey:@"code"];
    [para setObject:mPara.mPayUnint.payUnitName forKey:@"name"];
    [para setObject:mPara.mPaytype.payProjectId forKey:@"cardid"];
    
    [para setObject:mPara.mPayAmount forKey:@"account"];
    [para setObject:JHSDK_AppKey forKey:@"key"];
    
    [[JHJsonRequst sharedHDNetworking] postUrl:@"order" parameters:para call:^(mJHBaseData *info) {
        
        
        NSMutableArray *tempArr = [NSMutableArray new];
        [tempArr removeAllObjects];
        if (info.mSucess) {
            
//            for (NSDictionary *dic in info.mData) {
//                [tempArr addObject:[[JHPayData alloc]initWithObj:dic]];
//            }
            
            block ( info );
            
        }else{
            block ( info );
        }
        
    }];

}

#pragma mark----****----获取店铺优惠卷
/**
 获取店铺优惠卷
 
 @param mShopId 店铺id
 @param block 返回值
 */
- (void)ZLGetShopCoup:(int)mShopId block:(void(^)(APIObject *resb,NSString *mUrl))block{

    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    if (user.user_id > 0) {
        
        NSMutableDictionary* para = [NSMutableDictionary dictionary];
        
        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        [para setInt:mShopId forKey:@"shop_id"];

        MLLog(@"%@",[ZLUserInfo ZLCurrentUser]);
        [self loadAPIWithTag:self path:@"/shop/coupon_wap" parameters:para call:^(APIObject *info) {
            
            if (info.code == RESP_STATUS_YES) {
                
                block(info,nil);
                
            }else{
                
                block(info,nil);
                
            }
            
        }];
        
    }else{
        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"],nil);
        
    }
}

#pragma mark----****---- 跑腿操作接口
/**
 跑腿操作接口
 
 @param mOrderId 订单id
 @param mOrderCode 订单编号
 @param mStatus 操作状态
 @param block 返回值
 */
- (void)ZLOperatorPPTOrder:(int)mOrderId andOrderCode:(NSString *)mOrderCode andOperatorStatus:(ZLOperatorPPTOrderStatus)mStatus block:(void(^)(APIObject *resb))block{

    
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    if (user.user_id > 0) {
        
        NSMutableDictionary* para = [NSMutableDictionary dictionary];
        
        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        [para setInt:mOrderId forKey:@"odr_id"];
        [para setObject:mOrderCode forKey:@"odr_code"];
        [para setObject:[APIClient ZLCurrentOperatorPPTOrderStatus:mStatus] forKey:@"odr_state_next"];
        
        
        MLLog(@"%@",[ZLUserInfo ZLCurrentUser]);
        [self loadAPIWithTag:self path:@"/ppao/order_oprate" parameters:para call:^(APIObject *info) {
            
            if (info.code == RESP_STATUS_YES) {
                
                block(info);
                
            }else{
                
                block(info);
                
            }
            
        }];
        
    }else{
        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
        
    }
    
}

#pragma mark----****---- 发布者操作接口
/**
 发布者操作接口
 
 @param mOrderId 订单id
 @param mOrderCode 订单编号
 @param mStatus 操作状态
 @param block 返回值
 */
- (void)ZLReleaseOperatorPPTOrder:(int)mOrderId andOrderCode:(NSString *)mOrderCode andOperatorStatus:(ZLOperatorPPTOrderStatus)mStatus block:(void(^)(APIObject *resb))block{
    ZLUserInfo *user = [ZLUserInfo ZLCurrentUser];
    
    if (user.user_id > 0) {
        
        NSMutableDictionary* para = [NSMutableDictionary dictionary];
        
        [para setInt:[ZLUserInfo ZLCurrentUser].user_id forKey:@"user_id"];
        [para setInt:mOrderId forKey:@"odr_id"];
        [para setObject:mOrderCode forKey:@"odr_code"];
        [para setObject:[APIClient ZLCurrentOperatorPPTOrderStatus:mStatus] forKey:@"odr_state_next"];
        
        
        MLLog(@"%@",[ZLUserInfo ZLCurrentUser]);
        [self loadAPIWithTag:self path:@"/order/order_oprate" parameters:para call:^(APIObject *info) {
            
            if (info.code == RESP_STATUS_YES) {
                
                block(info);
                
            }else{
                
                block(info);
                
            }
            
        }];
        
    }else{
        block([APIObject infoWithReLoginErrorMessage:@"请重新登陆"]);
        
    }
    
}
#pragma mark----****---- 聚合电话号码流量查询
/**
 聚合电话号码流量查询
 
 @param mPhone 电话
 @param block 返回值
 */
- (void)ZLJHCheckePhone:(NSString *)mPhone block:(void(^)(mJHBaseData *resb,ZLJHFlowTelcheck *JHFlow))block{
    
    
    NSMutableDictionary* para = [NSMutableDictionary dictionary];
    
    [para setObject:mPhone forKey:@"phone"];
    [para setObject:JHFlow_AppKey forKey:@"key"];
    
    
    MLLog(@"%@",[ZLUserInfo ZLCurrentUser]);
    
    [self JHloadAPIWithTag:self path:@"telcheck" parameters:para call:^(mJHBaseData *info) {
        if (info.mSucess) {
            if ([info.result isKindOfClass:[NSArray class]]) {
                ZLJHFlowTelcheck *mFlow = [ZLJHFlowTelcheck mj_objectWithKeyValues:info.result[0]];
                block(info,mFlow);
            }else{
                block(info,nil);
            }
   
        }else{
            block(info,nil);
        }
        
    }];
    
    
}

@end


