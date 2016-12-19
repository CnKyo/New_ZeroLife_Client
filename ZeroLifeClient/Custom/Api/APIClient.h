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
typedef void (^TablePageArrBlock)(int totalPage, NSArray *tableArr, APIObject* info);


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


//菜谱相关接口
-(void)cookCategoryQueryWithTag:(NSObject *)tag call:(void (^)(CookCategoryObject* item, APIShareSdkObject* info))callback;
-(void)cookListWithTag:(NSObject *)tag cookId:(NSString *)cid name:(NSString *)name pageIndex:(int)page call:(TableShareSdkBlock)callback;
-(void)cookInfoWithTag:(NSObject *)tag cookId:(NSString *)cid call:(void (^)(CookObject* item, APIShareSdkObject* info))callback;



//用户信息相关接口
-(void)userInfoEditWithTag:(NSObject *)tag postItem:(ZLUserInfo *)it call:(void (^)(APIObject* info))callback;
-(void)userPushSettingWithTag:(NSObject *)tag isOn:(BOOL)ison call:(void (^)(APIObject* info))callback;
-(void)userSecurityPasswordSettingWithTag:(NSObject *)tag acc_pass:(NSString *)acc_pass security_password:(NSString *)security_password call:(void (^)(APIObject* info))callback;

//通用接口
-(void)regionListWithTag:(NSObject *)tag gion_level:(int)gion_level gion_id:(int)gion_id call:(TableArrBlock)callback;


//地址相关接口
-(void)addressListWithTag:(NSObject *)tag call:(TableArrBlock)callback;
-(void)addressInfoEditWithTag:(NSObject *)tag postItem:(AddressObject *)it is_default:(BOOL)is_default call:(void (^)(APIObject* info))callback;
-(void)addressInfoDeleteWithTag:(NSObject *)tag addr_id:(int)addr_id call:(void (^)(APIObject* info))callback;

//房屋相关接口
-(void)houseListWithTag:(NSObject *)tag call:(TableArrBlock)callback;
-(void)houseInfoEditWithTag:(NSObject *)tag postItem:(HouseObject *)it is_default:(BOOL)is_default call:(void (^)(APIObject* info))callback;
-(void)houseInfoDeleteWithTag:(NSObject *)tag real_id:(int)real_id call:(void (^)(APIObject* info))callback;

//银行卡相关接口
-(void)bankCardListWithTag:(NSObject *)tag call:(TableArrBlock)callback;
-(void)bankCardDeleteWithTag:(NSObject *)tag bank_id:(int)bank_id security_password:(NSString *)security_password call:(void (^)(APIObject* info))callback;
-(void)bankCardAddWithTag:(NSObject *)tag bank_real_name:(NSString *)bank_real_name bank_mobile:(NSString *)bank_mobile bank_card:(NSString *)bank_card id_card:(NSString *)id_card call:(void (^)(APIObject* info))callback;


//投诉相关接口
-(void)complaintListWithTag:(NSObject *)tag page:(int)page call:(TablePageArrBlock)callback;
-(void)complaintCompanyAddWithTag:(NSObject *)tag content:(NSString *)content call:(void (^)(APIObject* info))callback;
-(void)complaintCommunityUpWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id call:(void (^)(APIObject* info))callback;
-(void)complaintPeopleUpWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id call:(void (^)(APIObject* info))callback;
#pragma mark - deprecated
-(void)complaintCommunityAddWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id user_name:(NSString *)user_name call:(void (^)(APIObject* info))callback __deprecated_msg("Method deprecated. Use `complaintCommunityUpWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id call:(void (^)(APIObject* info))callback`");
-(void)complaintPeopleAddWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id address:(NSString *)address call:(void (^)(APIObject* info))callback __deprecated_msg("Method deprecated. Use `-(void)complaintPeopleUpWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id call:(void (^)(APIObject* info))callback`");
#pragma mark -

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
#pragma mark----****----app初始化加载数据
- (void)ZLAppInit:(void(^)(APIObject *mBaseObj,ZLAPPInfo *mAppInfo))block;

#pragma mark----****----获取首页banner
///获取首页banner
- (void)ZLgetHomeBanner:(void(^)(APIObject *mBaseObj,ZLHomeFunvtionAndBanner *mFunc))block;
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
-(void)communityBansetListWithTag:(NSObject *)tag cmut_id:(int)cmut_id call:(TableArrBlock)callback;


#pragma mark----****----获取社区超市首页
/**
 获取社区超市首页

 @param mLat  纬度
 @param mLng  经度
 @param mType 类型：1超市  2报修 3家政干洗
 @param block 返回值
 */
- (void)ZLGetShopHomePage:(NSString *)mLat andLng:(NSString *)mLng andType:(int)mType block:(void(^)(APIObject *mBaseObj,ZLShopHomePage *mShopHome))block;

#pragma mark----****----获取社区超市店铺列表
/**
 获取社区超市店铺列表
 
 @param mLat  纬度
 @param mLng  经度
 @param mClassId 店铺分类id
 @param mPage 分页
 @param block 返回值
 */
- (void)ZLGetShopHomeShopList:(int)mShopType andLat:(NSString *)mLat andLng:(NSString *)mLng andClassId:(NSString *)mClassId andPage:(int)mPage  block:(void(^)(APIObject *mBaseObj,ZLShopHomeShopList *mShopList))block;

#pragma mark----****----获取社区超市店铺信息
/**
 获取社区超市店铺信息

 @param mShopType 店铺类型
 @param mShopId   店铺id
 @param block     返回值
 */
- (void)ZLGetShopMsgWithShopType:(int)mShopType andShopId:(int)mShopId block:(void(^)(APIObject *mBaseObj,ZLShopObj *mShop,ZLShopLeftTableArr *mLeftTabArr))block;

#pragma mark----****----获取店铺商品信息
/**
 获取店铺商品信息

 @param mShopId  店铺id
 @param mCamId   活动id
 @param mClassId 分类id
 @param mPage    分页
 @param mType    类型
 @param block    返回值
 */
- (void)ZLGetShopGoodsList:(int)mShopId andCamId:(int)mCamId andClassId:(int)mClassId andPage:(int)mPage andType:(ZLRightGoodsType)mType block:(void(^)(APIObject *mBaseObj,ZLShopGoodsList *mShopGoodsObj))block;

#pragma mark----****----获取商品详情
/**
 获取商品详情

 @param mGoodsId 商品id
 @param mCamId   活动id
 @param block    返回值
 */
- (void)ZLGetGoodsDetail:(NSString *)mGoodsId andCamId:(NSString *)mCamId block:(void(^)(APIObject *mBaseObj,ZLGoodsDetail *mGoodsDetailObj,NSArray *mGoodsDetailImgArr))block;


-(void)externalPlatformListWithTag:(NSObject *)tag call:(TableArrBlock)callback;

-(void)fileUploadWithTag:(NSObject *)tag data:(NSData *)data type:(kFileType)type path:(NSString *)path call:(void (^)(NSString *fileUrlStr, APIObject* info))callback;

#pragma mark----*****----获取便民服务
/**
 获取便民服务

 @param block 返回值
 */
- (void)ZLGetHomeSercicePeron:(void (^)(APIObject *mBaseObj, NSArray* mArr))block;
#pragma mark----*****----获取首页消息列表
/**
 获取首页消息列表
 
 @param block 返回值
 */
- (void)ZLGetHomeMsgList:(void (^)(APIObject *mBaseObj, ZLHomeMsgObj* mHomeMsg))block;

#pragma mark----*****----获取首页公告列表
/**
 获取首页公告列表
 @param mPage 页码默认值: 1
 @param block 返回值
 */
- (void)ZLGetHomeAnouncement:(int)mPage block:(void (^)(APIObject *mBaseObj, ZLHomeAnouncementListObj* mNouncementList))block;
#pragma mark----*****----提交预订单
/**
 提交预订单

 @param mShopId 店铺id
 @param mGoods 商品json数组
 @param block 返回值
 */
- (void)ZLCommitOrder:(int)mShopId andGoodsArr:(NSString *)mGoods block:(void (^)(APIObject *mBaseObj,ZLPreOrderObj *mPreOrder))block;



@end
