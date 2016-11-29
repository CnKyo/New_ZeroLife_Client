//
//  APIClient.h
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "AFNetworking.h"
#import "APIObjectDefine.h"
#import <MapKit/MapKit.h>

typedef void (^TableArrBlock)(NSArray *tableArr, APIObject* info);

typedef void (^TableArrShareSdkBlock)(NSArray *tableArr, APIShareSdkObject* info);
typedef void (^TableShareSdkBlock)(int totalpage, NSArray *tableArr, APIShareSdkObject* info);



@interface NSMutableDictionary (APIClient_MyAdditions)
+(NSMutableDictionary *)quDic;
+(NSMutableDictionary *)quDicWithPage:(int)page pageRow:(int)row;
-(void)addCustomTableParamWithPage:(int)page row:(int)row;
@end


@interface APIClient : AFHTTPSessionManager
@property(nonatomic, strong) NSMutableDictionary *conDic;//存网络链接，便于取消

+ (instancetype)sharedClient;


/**
 *  清除所有的所属组链接
 *
 *  @param key 网络链接所属于的组
 */
- (void)removeConnections:(NSString *)key;
/**
 *  上传图片方法
 *
 *  @param tag        tag
 *  @param URLString  请求地址
 *  @param parameters 参数
 *  @param block      返回值
 *  @param callback   返回值
 */
-(void)postWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlockBack:(void (^)(id <AFMultipartFormData> formData))block call:(void (^)(NSError *error, id responseObject))callback;


-(void)cookCategoryQueryWithTag:(NSObject *)tag call:(void (^)(CookCategoryObject* item, APIShareSdkObject* info))callback;
-(void)cookListWithTag:(NSObject *)tag cookId:(NSString *)cid name:(NSString *)name pageIndex:(int)page call:(TableShareSdkBlock)callback;
-(void)cookInfoWithTag:(NSObject *)tag cookId:(NSString *)cid call:(void (^)(CookObject* item, APIShareSdkObject* info))callback;




//-(void)dryClearnShopInfoWithTag:(NSObject *)tag shopId:(int)sid call:(void (^)(DryClearnShopObject* item, int coupon, int focus, APIObject* info))callback;
//-(void)dryClearnShopCollectWithTag:(NSObject *)tag shopId:(int)sid actionType:(BOOL)collect call:(void (^)(APIObject* info))callback;
//-(void)dryClearnShopClassListWithTag:(NSObject *)tag shopId:(int)sid call:(TableArrBlock)callback;
//-(void)dryClearnShopServerListWithTag:(NSObject *)tag shopId:(int)sid classId:(int)cid call:(TableArrBlock)callback;
//-(void)dryClearnShopServerInfoWithTag:(NSObject *)tag serverId:(int)sid call:(void (^)(DryClearnShopServerObject *item, APIObject* info))callback;
//-(void)dryClearnShopOpeningTimeListWithTag:(NSObject *)tag shopId:(int)sid dateStr:(NSString *)dateStr call:(TableArrBlock)callback;
//-(void)dryClearnShopOrderInfoWithTag:(NSObject *)tag serverId:(int)sid cartJson:(NSString *)cartStr call:(void (^)(DryClearnShopOrderShowObject *item, APIObject* info))callback;
//
//-(void)dryClearnShopOrderSubmmitWithTag:(NSObject *)tag postItem:(DryClearnShopOrderPostObject *)it call:(void (^)(APIObject* info))callback;
//
//-(void)dryClearnShopOrderCommentSubmmitWithTag:(NSObject *)tag postItem:(DryClearnShopOrderCommentPostObject *)it call:(void (^)(APIObject* info))callback;
//
//-(void)shopCommentImgUpdateWithTag:(NSObject *)tag img:(UIImage *)img call:( void(^)(NSString *file, APIObject* info))callback;
//
//-(void)complainListWithTag:(NSObject *)tag call:(TableArrBlock)callback;



-(void)regionListWithTag:(NSObject *)tag gion_level:(int)gion_level gion_id:(int)gion_id call:(TableArrBlock)callback;

//地址相关接口
-(void)addressListWithTag:(NSObject *)tag call:(TableArrBlock)callback;
-(void)addressInfoEditWithTag:(NSObject *)tag postItem:(AddressObject *)it is_default:(BOOL)is_default call:(void (^)(APIObject* info))callback;
-(void)addressInfoDeleteWithTag:(NSObject *)tag addr_id:(int)addr_id call:(void (^)(APIObject* info))callback;

//房屋相关接口
-(void)houseListWithTag:(NSObject *)tag call:(TableArrBlock)callback;
-(void)houseInfoEditWithTag:(NSObject *)tag postItem:(HouseObject *)it is_default:(BOOL)is_default call:(void (^)(APIObject* info))callback;
-(void)houseInfoDeleteWithTag:(NSObject *)tag real_id:(int)real_id call:(void (^)(APIObject* info))callback;


//小区相关接口
-(void)communityListWithTag:(NSObject *)tag location:(CLLocationCoordinate2D)location search:(NSString *)search province:(int)province city:(int)city county:(int)county call:(TableArrBlock)callback;

#pragma mark----****----登录
///登录
- (void)ZLLoginWithPhone:(NSString *)mPhone andPwd:(NSString *)mPwd block:(void(^)(APIObject *mBaseObj,ZLUserInfo *mUser))block;
#pragma mark----****----注册
///注册
- (void)ZLRegistPhone:(NSString *)mPhone andPwd:(NSString *)mPwd andCode:(NSString *)mCode block:(void(^)(APIObject *mBaseObj))block;
#pragma mark----****----获取验证码
///获取验证码
- (void)ZLGetVerigyCode:(NSString *)mCode andType:(int)mtype block:(void(^)(APIObject *mBaseObj))block;
#pragma mark----****----获取首页banner
///获取首页banner
- (void)ZLgetHomeBanner:(void(^)(APIObject *mBaseObj,NSArray *mArr))block;
#pragma mark----****----获取首页数据
///获取首页数据
- (void)ZLGetHome:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(APIObject *mBaseObj,ZLHomeObj *mHome))block;
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
- (void)ZLGetHomeCommunity:(NSString *)mLat andLng:(NSString *)mLng andSearchText:(NSString *)mSearchTx andProvinceId:(int)mProvince andCityId:(int)mCityId andCountryId:(int)mCountryId block:(void(^)(APIObject *mBaseObj,NSArray *mArr))block;

@end
