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
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDotNetApiBaseURLString_test]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        
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
    [self urlGroupKey:NSStringFromClass([tag class]) path:URLString parameters:parameters call:^(NSError *error, id responseObject) {
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


///**
// *  获取干洗店铺信息
// *
// *  @param tag      链接对象
// *  @param sid      商铺id
// *  @param callback 返回数据
// */
//-(void)dryClearnShopInfoWithTag:(NSObject *)tag shopId:(int)sid call:(void (^)(DryClearnShopObject* item, int coupon, int focus, APIObject* info))callback
//{
//    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
//    [paramDic setInt:sid forKey:@"shopId"];
//    [paramDic setInt:[mUserInfo backNowUser].mUserId forKey:@"userId"];
//    [self loadAPIWithTag:tag path:@"/clean/shop/index" parameters:paramDic call:^(APIObject *info) {
//        if (info.data != nil  && [info.data isKindOfClass:[NSDictionary class]]) {
//            int couponCount = [[info.data objectWithKey:@"coupon"] intValue]; //优惠券数量
//            int focusId = [[info.data objectWithKey:@"focus"] intValue]; //用户收藏表记录id
//            NSDictionary *shopDic = [info.data objectForKey:@"shop"];
//            DryClearnShopObject *it = [DryClearnShopObject mj_objectWithKeyValues:shopDic];
//            callback(it, couponCount, focusId, info);
//        } else
//            callback(nil, 0, 0, info);
//    }];
//}
//
//
///**
// *  干洗店铺收藏接口
// *
// *  @param tag      链接对象
// *  @param sid      商铺id
// *  @param collect  type=1收藏操作，type=0取消操作
// *  @param callback 返回成功失败
// */
//-(void)dryClearnShopCollectWithTag:(NSObject *)tag shopId:(int)sid actionType:(BOOL)collect call:(void (^)(APIObject* info))callback
//{
//    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
//    [paramDic setInt:sid forKey:@"shopId"];
//    [paramDic setObject:[NSString stringWithFormat:@"%i",collect] forKey:@"type"];
//    [paramDic setInt:[mUserInfo backNowUser].mUserId forKey:@"userId"];
//    [self loadAPIWithTag:tag path:@"/clean/shop/collectShop" parameters:paramDic call:^(APIObject *info) {
//        callback(info);
//    }];
//}
//
//
///**
// *  干洗店铺商品分类列表接口
// *
// *  @param tag      链接对象
// *  @param sid      商铺id
// *  @param callback 返回列表
// */
//-(void)dryClearnShopClassListWithTag:(NSObject *)tag shopId:(int)sid call:(TableArrBlock)callback
//{
//    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
//    [paramDic setInt:sid forKey:@"shopId"];
//    [paramDic setObject:@"0" forKey:@"classify"];
//    [self loadAPITableListWithTag:tag path:@"/clean/shop/classify" parameters:paramDic pageIndex:0 subClass:[DryClearnShopClassObject class] call:^(NSArray *tableArr, APIObject *info) {
//        callback(tableArr, info);
//    }];
//}
//
//
///**
// *  干洗店铺商品服务列表接口
// *
// *  @param tag      链接对象
// *  @param sid      商铺id
// *  @param cid      分类id
// *  @param callback 返回列表
// */
//-(void)dryClearnShopServerListWithTag:(NSObject *)tag shopId:(int)sid classId:(int)cid call:(TableArrBlock)callback
//{
//    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
//    [paramDic setInt:sid forKey:@"shopId"];
//    [paramDic setInt:cid forKey:@"classify"];
//    [self loadAPITableListWithTag:tag path:@"/clean/shop/classify" parameters:paramDic pageIndex:0 subClass:[DryClearnShopServerObject class] call:^(NSArray *tableArr, APIObject *info) {
//        callback(tableArr, info);
//    }];
//}
//
//
///**
// *  干洗店铺商品服务详情信息接口
// *
// *  @param tag      链接对象
// *  @param sid      服务id
// *  @param callback 返回信息
// */
//-(void)dryClearnShopServerInfoWithTag:(NSObject *)tag serverId:(int)sid call:(void (^)(DryClearnShopServerObject *item, APIObject* info))callback
//{
//    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
//    [paramDic setInt:sid forKey:@"classify"];
//    [paramDic setInt:[mUserInfo backNowUser].mUserId forKey:@"userId"];
//    [self loadAPIWithTag:tag path:@"/clean/shop/classifyInfo" parameters:paramDic call:^(APIObject *info) {
//        if (info.data != nil) {
//            DryClearnShopServerObject *it = [DryClearnShopServerObject mj_objectWithKeyValues:info.data];
//            callback(it, info);
//        } else
//            callback(nil, info);
//    }];
//}
//
//
//
///**
// *  干洗店铺营业时间
// *
// *  @param tag      链接对象
// *  @param sid      店铺id
// *  @param dateStr  营业时间 如20160822
// *  @param callback 返回当天营业时间段
// */
//-(void)dryClearnShopOpeningTimeListWithTag:(NSObject *)tag shopId:(int)sid dateStr:(NSString *)dateStr call:(TableArrBlock)callback
//{
//    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
//    [paramDic setInt:sid forKey:@"shopId"];
//    [paramDic setObject:dateStr forKey:@"time"];
//    [self loadAPIWithTag:tag path:@"/clean/order/pretimes" parameters:paramDic call:^(APIObject *info) {
//        if (info.data != nil) {
//            callback(info.data, info);
//        } else
//            callback(nil, info);
//    }];
//}
//
//
///**
// *  干洗店铺商品结算订单信息获取接口
// *
// *  @param tag      链接对象
// *  @param sid      服务id
// *  @param cartStr  购物车json数据
// *  @param callback 返回信息
// */
//-(void)dryClearnShopOrderInfoWithTag:(NSObject *)tag serverId:(int)sid cartJson:(NSString *)cartStr call:(void (^)(DryClearnShopOrderShowObject *item, APIObject* info))callback
//{
//    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
//    [paramDic setObject:[Util RSAEncryptor:[NSString stringWithFormat:@"%d",sid]] forKey:@"shopId"];
//    [paramDic setObject:[Util RSAEncryptor:[NSString stringWithFormat:@"%d",[mUserInfo backNowUser].mUserId]] forKey:@"userId"];
//    [paramDic setValidStr:cartStr forKey:@"cartJson"];
//    [paramDic setObject:@"ios" forKey:@"device"];
//    [self loadAPIWithTag:tag path:@"/clean/order/preorder" parameters:paramDic call:^(APIObject *info) {
//        if (info.data != nil) {
//            DryClearnShopOrderShowObject *it = [DryClearnShopOrderShowObject mj_objectWithKeyValues:info.data];
//            callback(it, info);
//        } else
//            callback(nil, info);
//    }];
//}
//
//
///**
// *  干洗店铺商品结算订单提交生成接口
// *
// *  @param tag      链接对象
// *  @param it       提交信息对象
// *  @param callback 返回信息
// */
//-(void)dryClearnShopOrderSubmmitWithTag:(NSObject *)tag postItem:(DryClearnShopOrderPostObject *)it call:(void (^)(APIObject* info))callback
//{
//    NSDictionary *paramDic = [it mj_keyValues];
//    [self loadAPIWithTag:tag path:@"/clean/order/placeorder" parameters:paramDic call:^(APIObject *info) {
//        callback(info);
//    }];
//}
//
//
///**
// *  超市用户评价接口
// *
// *  @param tag      链接对象
// *  @param it       提交信息对象
// *  @param callback 返回信息
// */
//-(void)dryClearnShopOrderCommentSubmmitWithTag:(NSObject *)tag postItem:(DryClearnShopOrderCommentPostObject *)it call:(void (^)(APIObject* info))callback
//{
//    NSDictionary *paramDic = [it mj_keyValues];
//    [self loadAPIWithTag:tag path:@"/clean/order/evaluate" parameters:paramDic call:^(APIObject *info) {
//        callback(info);
//    }];
//}
//
//
//
///**
// *  上传超市评论图片
// *
// *  @param tag      链接对象
// *  @param img      图片对象
// *  @param callback 返回信息
// */
//-(void)shopCommentImgUpdateWithTag:(NSObject *)tag img:(UIImage *)img call:( void(^)(NSString *file, APIObject* info))callback
//{
//    
//    NSString *mUrl = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],@"shop/comment"];
//    
//    [self postWithTag:tag path:mUrl parameters:nil constructingBodyWithBlockBack:^(id<AFMultipartFormData> formData) {
//        NSData *imgData = UIImageJPEGRepresentation(img, 1.0);
//        [formData appendPartWithFileData:imgData name:@"file" fileName:@"img.png" mimeType:@"image/png"];
//    } call:^(NSError *error, id responseObject) {
//        APIObject *info = nil;
//        NSString *fileStr = nil;
//        if (error == nil) {
//            NSLog(@"\n\n ---APIObject----result:-----------%@", responseObject);
//            info = [APIObject mj_objectWithKeyValues:responseObject];
//            if (info==nil)
//                info = [APIObject infoWithErrorMessage:@"网络错误"];
//            else if (info.data != nil  && [info.data isKindOfClass:[NSDictionary class]])
//                fileStr = [info.data objectWithKey:@"file"];
//            
//        } else {
//            NSLog(@"\n\n ---APIObject----result error:-----------%@", error);
//            info = [APIObject infoWithError:error];
//        }
//        
//        callback(fileStr, info);
//    }];
//    
//}
//
//
//
///**
// *  投诉建议列表
// *
// *  @param tag      链接对象
// *  @param callback 返回列表
// */
//-(void)complainListWithTag:(NSObject *)tag call:(TableArrBlock)callback
//{
//    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
//    [paramDic setInt:[mUserInfo backNowUser].mUserId forKey:@"userId"];
//    [self loadAPITableListWithTag:tag path:@"/app/complain/complaints" parameters:paramDic pageIndex:0 subClass:[ComplainObject class] call:^(NSArray *tableArr, APIObject *info) {
//        callback(tableArr, info);
//    }];
//}



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
    [self loadAPIWithTag:self path:@"/api/app/client/common/region_list" parameters:paramDic call:^(APIObject *info) {
        NSArray *newArr = [RegionObject mj_objectArrayWithKeyValuesArray:info.data];
        callback(newArr, info);
    }];
}



/**
 *   用户收货地址信息列表接口
 *
 *  @param tag      链接对象
 *  @param callback 返回列表
 */
-(void)addressListWithTag:(NSObject *)tag call:(TableArrBlock)callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    [paramDic setInt:6 forKey:@"user_id"];
    [self loadAPIWithTag:self path:@"/api/app/client/user/address/address_list" parameters:paramDic call:^(APIObject *info) {
        NSArray *newArr = [AddressObject mj_objectArrayWithKeyValuesArray:info.data];
        callback(newArr, info);
    }];
}



- (void)ZLLoginWithPhone:(NSString *)mPhone andPwd:(NSString *)mPwd block:(void(^)(APIObject *mBaseObj,ZLUserInfo *mUser))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"acc_phone"];
    [para setObject:mPwd forKey:@"acc_pass"];
    [para setObject:@"ios" forKey:@"sys_t"];
    [para setObject:[Util getAppVersion] forKey:@"app_v"];
    [para setObject:[Util getAPPBuildNum] forKey:@"sys_v"];
    
    [self loadAPIWithTag:self path:@"/api/app/client/user/user_login" parameters:para call:^(APIObject *info) {
        [ZLUserInfo ZLDealSession:info andPwd:mPwd andOpenId:nil block:block];
    }];

    
}
- (void)ZLRegistPhone:(NSString *)mPhone andPwd:(NSString *)mPwd andCode:(NSString *)mCode block:(void(^)(APIObject *mBaseObj))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"acc_phone"];
    [para setObject:mPwd forKey:@"acc_pass"];
    [para setObject:mCode forKey:@"v_code"];
    
    [self loadAPIWithTag:self path:@"/api/app/client/user/user_register" parameters:para call:^(APIObject *info) {
        block(info);
    }];
    
 
}

- (void)ZLGetVerigyCode:(NSString *)mCode andType:(int)mtype block:(void(^)(APIObject *mBaseObj))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mCode forKey:@"mobile"];
    [para setObject:NumberWithInt(mtype) forKey:@"type"];
    
    [self loadAPIWithTag:self path:@"/api/app/client/common/get_sms_code" parameters:para call:^(APIObject *info) {
        block(info);
    }];

}
#pragma mark----****----获取首页banner
- (void)ZLgetHomeBanner:(void(^)(APIObject *mBaseObj,NSArray *mArr))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    [self loadAPIWithTag:self path:@"/api/app/client/home/banner" parameters:para call:^(APIObject *info) {

        NSMutableArray *mtempArr = [NSMutableArray new];

        if (info.code == RESP_STATUS_YES) {
            
            id mArr = info.data;
            
            if ([mArr isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in info.data) {
                    
                    
                    [mtempArr addObject:[ZLHomeBanner mj_objectWithKeyValues:dic]];
                }
                
            }
            
            
            block (info,mtempArr);
            
            
        }else{
            block (info,mtempArr);
            
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
    
    [self loadAPIWithTag:self path:@"/api/app/client/home/homePage" parameters:para call:^(APIObject *info) {
        
        
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


@end
