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
#import "JHJsonRequst.h"
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

/**
 *  可接受的响应内容类型
 */
@property (nonatomic, copy) NSSet <NSString *> *acceptableContentTypes;

+ (instancetype)sharedClient;

#pragma mark----  获取跑跑腿订单操作状态
/**
 获取跑跑腿订单操作状态
 
 @param mStatus 状态
 @return 返回操作类型
 */
+ (NSString *)ZLCurrentOperatorPPTOrderStatus:(ZLOperatorPPTOrderStatus)mStatus;

- (void)getUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( APIObject* info))callback;

/**
 返回当前apiurl

 @return 返回url
 */
- (NSString *)currentUrl;

/**
 返回当前图片url

 @param mUrl 图片的url
 @return 返回图片的URL
 */
- (NSString *)currentImgUrl:(NSString *)mUrl;

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
- (void)userInfoWithTag:(NSObject *)tag call:(void(^)(ZLUserInfo *user, APIObject *info))callback;
-(void)userInfoEditWithTag:(NSObject *)tag postItem:(ZLUserInfo *)it call:(void (^)(APIObject* info))callback;
-(void)userPushSettingWithTag:(NSObject *)tag isOn:(BOOL)ison call:(void (^)(APIObject* info))callback;
-(void)userSecurityPasswordSettingWithTag:(NSObject *)tag acc_pass:(NSString *)acc_pass security_password:(NSString *)security_password call:(void (^)(APIObject* info))callback;
-(void)userSecurityPasswordCompalainWithTag:(NSObject *)tag mobile:(NSString *)mobile idCard:(NSString *)idCard acc_pass:(NSString *)acc_pass call:(void (^)(APIObject* info))callback;

#pragma mark----****---- 更新用户信息
/**
 更新用户信息

 @param block 返回值
 */
- (void)ZLUpdateUserInfo:(void (^)(APIObject* info))block;

//用户审核资料提交相关接口
-(void)userApplyPaopaoWithTag:(NSObject *)tag item:(PaopaoApplyObject *)item call:(void (^)(APIObject* info))callback;


//通用接口
-(void)regionListWithTag:(NSObject *)tag gion_level:(int)gion_level gion_id:(int)gion_id call:(TableArrBlock)callback;
-(void)fileUploadWithTag:(NSObject *)tag uploadDatas:(NSArray *)uploadDatas type:(kFileType)type path:(NSString *)path call:(TableArrBlock)callback;
-(void)fileOneUploadWithTag:(NSObject *)tag data:(NSData *)data type:(kFileType)type path:(NSString *)path call:(void (^)(NSString *fileUrlStr, APIObject* info))callback;


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


//用户收藏商品相关接口
-(void)productFocusAddWithTag:(NSObject *)tag pro_id:(int)pro_id is_focus:(BOOL)is_focus call:(void (^)(APIObject* info))callback;
-(void)productFocusDelWithTag:(NSObject *)tag foc_id:(int)foc_id call:(void (^)(APIObject* info))callback;
-(void)productFocusListWithTag:(NSObject *)tag page:(int)page call:(TablePageArrBlock)callback;



//优惠券相关接口
-(void)couponListWithTag:(NSObject *)tag call:(TableArrBlock)callback;


//用户钱包相关接口
-(void)walletRecordListWithTag:(NSObject *)tag type:(int)type page:(int)page call:(TablePageArrBlock)callback;


//用户积分相关接口
-(void)userScoreRecordListWithTag:(NSObject *)tag page:(int)page call:(TablePageArrBlock)callback;


//投诉相关接口
-(void)complaintListWithTag:(NSObject *)tag page:(int)page call:(TablePageArrBlock)callback;
-(void)complaintCompanyAddWithTag:(NSObject *)tag content:(NSString *)content call:(void (^)(APIObject* info))callback;
-(void)complaintCommunityUpWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id call:(void (^)(APIObject* info))callback;
-(void)complaintPeopleUpWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id call:(void (^)(APIObject* info))callback;
#pragma mark - deprecated
-(void)complaintCommunityAddWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id user_name:(NSString *)user_name call:(void (^)(APIObject* info))callback __deprecated_msg("Method deprecated. Use `complaintCommunityUpWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id call:(void (^)(APIObject* info))callback`");
-(void)complaintPeopleAddWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id address:(NSString *)address call:(void (^)(APIObject* info))callback __deprecated_msg("Method deprecated. Use `-(void)complaintPeopleUpWithTag:(NSObject *)tag content:(NSString *)content cmut_id:(int)cmut_id call:(void (^)(APIObject* info))callback`");
#pragma mark -


//用户签到相关接口
-(void)userSignWithTag:(NSObject *)tag call:(void (^)(int score, APIObject* info))callback;


//订单相关接口
-(void)orderListWithTag:(NSObject *)tag odr_type:(kOrderClassType)odr_type odr_status:(NSString *)odr_status page:(int)page call:(TablePageArrBlock)callback;
-(void)orderInfoWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code call:(void (^)(OrderObject *item, APIObject* info))callback;
-(void)orderOprateWithTag:(NSObject *)tag odr_id:(int)odr_id odr_type:(int)odr_type odr_code:(NSString *)odr_code odr_state_next:(NSString *)odr_state_next odr_memo:(NSString *)odr_memo call:(void (^)(NSString* odr_state_val, NSMutableArray* odr_state_next, APIObject* info))callback;
-(void)orderOprateRecycleWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code pay_amount:(int)pay_amount pass:(NSString *)pass call:(void (^)(NSString* odr_state_val, NSMutableArray* odr_state_next, APIObject* info))callback;
-(void)orderOprateDiffPriceWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code call:(void (^)(ZLCreateOrderObj* item, APIObject* info))callback;
-(void)orderOprateBidWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code bid_id:(int)bid_id call:(void (^)(ZLCreateOrderObj *payItem, APIObject* info))callback;
-(void)orderOprateEvaluateWithTag:(NSObject *)tag odr_id:(int)odr_id com_star:(double)com_star com_content:(NSString *)com_content com_imgs:(NSString *)com_imgs com_is_security:(BOOL)com_is_security call:(void (^)(NSString* odr_state_val, NSMutableArray* odr_state_next, APIObject* info))callback;
-(void)orderBidListWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code call:(TableArrBlock)callback;

-(void)preOrderRechargeWithTag:(NSObject *)tag call:(void (^)(PreApplyObject*item, APIObject* info))callback;
-(void)preOrderMobileWithTag:(NSObject *)tag call:(void (^)(PreApplyObject*item, APIObject* info))callback;
-(void)preOrderPresentWithTag:(NSObject *)tag call:(void (^)(PrePresentApplyObject*item, APIObject* info))callback;
-(void)preOrderPaopaoApplyWithTag:(NSObject *)tag call:(void (^)(PrePaopaoApplyObject*item, APIObject* info))callback;
-(void)preOrderTransferWithTag:(NSObject *)tag call:(void (^)(PreApplyObject*item, APIObject* info))callback;
-(void)preOrderPropertyWithTag:(NSObject *)tag pfee_id:(int)pfee_id call:(void (^)(PreApplyObject*item, APIObject* info))callback;

-(void)propertyFeeListWithTag:(NSObject *)tag call:(TableArrBlock)callback;

-(void)orderPaopaoManListWithTag:(NSObject *)tag odr_status:(NSString *)odr_status page:(int)page call:(TablePageArrBlock)callback;
-(void)orderPaopaoManInfoWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code call:(void (^)(OrderObject *item, APIObject* info))callback;
-(void)orderPaopaoManOprateWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code odr_state_next:(NSString *)odr_state_next call:(void (^)(NSString* odr_state_val, NSMutableArray* odr_state_next, APIObject* info))callback;
-(void)orderPaopaoManOprateDiffWithTag:(NSObject *)tag odr_id:(int)odr_id odr_code:(NSString *)odr_code diff_price:(float)diff_price call:(void (^)(float odr_amount, float odr_pay_price, NSString* odr_state_val, NSMutableArray* odr_state_next, APIObject* info))callback;

//小区相关接口
-(void)communityListWithTag:(NSObject *)tag location:(CLLocationCoordinate2D)location search:(NSString *)search province:(int)province city:(int)city county:(int)county call:(TableArrBlock)callback;
-(void)communityBansetListWithTag:(NSObject *)tag cmut_id:(int)cmut_id call:(TableArrBlock)callback;


#pragma mark----****----登录
///登录
- (void)ZLLoginWithPhone:(NSString *)mPhone andPwd:(NSString *)mPwd block:(void(^)(APIObject *mBaseObj,ZLUserInfo *mUser))block;
-(void)userLoginOutWithTag:(NSObject *)tag call:(void (^)(APIObject* info))callback;
-(void)userJpushUpdateWithTag:(NSObject *)tag jpush_id:(NSString *)jpush_id call:(void (^)(APIObject* info))callback;
#pragma mark----****----三方登录
/**
 三方登录

 @param mLoginObj 登录对象
 @param block 返回值
 */
- (void)ZLPlaframtLogin:(ZLPlafarmtLogin *)mLoginObj block:(void (^)(APIObject* info))block;
#pragma mark----****----绑定手机账号
/**
 绑定账号
 @param mOpenId openid
 @param mPhone 手机
 @param mPwd 密码
 @param block 返回值
 */
- (void)ZLPlaframtLogin:(NSString *)mOpenId andPhone:(NSString *)mPhone andPwd:(NSString *)mPwd block:(void (^)(APIObject* info))block;
#pragma mark----****----注册
///注册
- (void)ZLRegistPhone:(NSString *)mPhone andPwd:(NSString *)mPwd andCode:(NSString *)mCode andType:(ZLRegistOrForgetPwd)mType block:(void(^)(APIObject *mBaseObj))block;
#pragma mark----****----获取验证码
///获取验证码
- (void)ZLGetVerigyCode:(NSString *)mCode andType:(ZLRegistOrForgetPwd)mtype block:(void(^)(APIObject *mBaseObj))block;
#pragma mark----****----app初始化加载数据
- (void)ZLAppInit:(void(^)(APIObject *mBaseObj,ZLAPPInfo *mAppInfo))block;

#pragma mark----****----获取首页banner
///获取首页banner
- (void)ZLgetHomeBanner:(void(^)(APIObject *mBaseObj,ZLHomeFunvtionAndBanner *mFunc))block;
#pragma mark----****----获取首页数据
///获取首页数据
- (void)ZLGetHome:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(APIObject *mBaseObj,ZLHomeObj *mHome))block;
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
//- (void)ZLGetHomeCommunity:(NSString *)mLat andLng:(NSString *)mLng andSearchText:(NSString *)mSearchTx andProvinceId:(int)mProvince andCityId:(int)mCityId andCountryId:(int)mCountryId block:(void(^)(APIObject *mBaseObj,NSArray *mArr))block __deprecated_msg("Method deprecated. Use `-(void)communityListWithTag:(NSObject *)tag location:(CLLocationCoordinate2D)location search:(NSString *)search province:(int)province city:(int)city county:(int)county call:(TableArrBlock)callback`");



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
 @param mShopId   活动id
 @param mSkuId   规格id
 @param block    返回值
 */
- (void)ZLGetGoodsDetail:(NSString *)mGoodsId andShopId:(NSString *)mShopId andSkuId:(NSString *)mSkuId block:(void(^)(APIObject *mBaseObj,NSString *mUrl))block;


-(void)externalPlatformListWithTag:(NSObject *)tag call:(TableArrBlock)callback;



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
- (void)ZLGetHomeAnouncement:(int)mPage block:(TablePageArrBlock)block;
#pragma mark----*****----提交预订单
/**
 提交预订单
 @param mType 预订单类型
 @param mShopId 店铺id
 @param mGoods 商品json数组
 @param block 返回值
 */
- (void)ZLCommitPreOrderWithType:(kOrderClassType)mType andShopId:(int)mShopId andGoodsArr:(NSString *)mGoods block:(void (^)(APIObject *mBaseObj,ZLPreOrderObj *mPreOrder))block;



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
- (void)ZLCommitOrder:(kOrderClassType)mOrderType andShopId:(NSString *)mShopId andGoods:(NSString *)mGoodsList andSendAddress:(NSString *)mSendAddress andArriveAddress:(NSString *)mArriveAddress andServiceTime:(NSString *)mServiceTime andSendType:(ZLShopSendType)mSendType andSendPrice:(NSString *)mSendPrice andCoupId:(NSString *)mCoupId andRemark:(NSString *)mRemark andSign:(NSString *)mSign block:(void (^)(APIObject *mBaseObj,ZLCreateOrderObj *mOrder))block;


#pragma mark----****----发起支付
/**
 发起支付
 @param mGoPayType 去支付对象
 @param mPayObj 支付订单对象
 @param mPayType 支付类型
 @param block 返回值
 */
- (void)ZLSendToPayOrderObjGoPay:(ZLGoPayType)mGoPayType andPayObj:(ZLCreateOrderObj *)mPayObj andPayType:(ZLPayType)mPayType block:(void (^)(APIObject *mBaseObj,ZLCreateOrderObj* mPayOrderObj))block;

#pragma mark----****----获取跑腿首页分类
/**
 获取跑腿首页分类

 @param block 返回值
 */
- (void)ZLGetPPTHome:(void (^)(APIObject *mBaseObj,ZLPPTHomeClassList *mList))block;



#pragma mark----****----获取跑腿榜
/**
 获取跑腿榜

 @param mPage 行数页数
 @param mPageSize 每页条数
 @param mSort 排序类型(1:订单量排名[默认为0]，2：金额量排名,3:评价排名)
 */
- (void)ZLGetPPTTopList:(NSString *)mPage andPageSize:(NSString *)mPageSize andSort:(NSString *)mSort block:(void(^)(APIObject *mBaseObj,ZLPPTTopObj *mList))block;


#pragma mark----****----获取跑腿酬金列表
/**
 获取跑腿酬金列表

 @param mPage 行数页数
 @param block 返回值
 */
- (void)ZLGetPPTRewardList:(NSString *)mPage block:(void(^)(APIObject *mBaseObj,ZLPPTRewardList *mList))block;

#pragma mark----****----获取评价
/**
 获取评价

 @param mPage 行数页数
 @param mType 请求类型
 @param mId id
 @param mPageSize 每页条数
 @param block 返回值
 */
- (void)ZLGetRateList:(int)mPage andType:(ZLRateVCType)mType andId:(int)mId andPageSize:(int)mPageSize block:(void(^)(APIObject *mBaseObj,NSArray *mList,OrderCommentExtraObject *mExt))block;

//#pragma mark----****----获取手机充值预订单
///**
// 获取手机充值预订单
// @param block 返回值
// */
//- (void)ZLGetPreRechargePhone:(void(^)(APIObject *mBaseObj,ZLCreatePreOrder *mRecharge))block;


#pragma mark----****---- 报修预订单接口
/**
 报修预订单接口

 @param mClsId 分类id
 @param block 返回值
 */
- (void)ZLFixPreOrder:(int)mClsId block:(void(^)(APIObject *mBaseObj,ZLCreatePreOrder *mPreOrder))block;

//#pragma mark----****---- 申请跑跑腿预订单
///**
// 申请跑跑腿预订单
//
// @param block 返回值
// */
//- (void)ZLApplyPPTPreOrder:(void(^)(APIObject *mBaseObj,ZLCreatePreOrder *mPreOrder))block;


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
- (void)ZLGetRunningmanHomeList:(double)mLat andLng:(double)mLng andPage:(int)mPage andPageSize:(int)mPageSize andClsId:(int)mId block:(void(^)(APIObject *mBaseObj,ZLRunningmanHomeList *mList))block;
#pragma mark----****----  获取跑腿者经纬度
/**
 获取跑腿者经纬度

 @param mLocation 位置信息
 @param block 返回值
 */
- (void)ZLGetPPTLocation:(CommunityObject *)mLocation block:(void(^)(APIObject *mBaseObj))block;


#pragma mark----****----获取发布跑跑腿预订单
/**
 获取发布跑跑腿预订单

 @param block 返回值
 */
- (void)ZLGetRunningmanPreOrder:(void(^)(APIObject *mBaseObj,ZLPreOrderObj *mPreOrder))block;

#pragma mark----****---- 获取我的跑跑腿订单
/**
 获取我的跑跑腿订单

 @param mPage 分页
 @param mPageSize 每页数量
 @param mStatus 状态
 @param block 返回值
 */
- (void)ZLGetMyPPTOrder:(int)mPage andPageSize:(int)mPageSize andStatus:(NSString *)mStatus block:(void(^)(APIObject *mBaseObj,NSArray *mArr))block;


#pragma mark----****---- 水电煤缴费查询接口
/**
 水电煤缴费查询接口

 @param mType 选择类型
 @param mPara 参数
 @param block 返回值
 */
- (void)ZLFindPublic:(ZLHydroelectricType)mType andPara:(NSDictionary *)mPara block:(void(^)(mJHBaseData *resb,NSArray *mArr))block;

#pragma mark----****---- 水电煤缴费查询接口
/**
 水电煤缴费查询接口

 @param mPara 参数
 @param block 返回值
 */
- (void)ZLInquireOrder:(ZLHydroelectricPreOrder *)mPara block:(void(^)(mJHBaseData *resb,NSString *mBalance))block;
#pragma mark----****---- 水电煤缴费接口
/**
 水电煤缴费接口
 
 @param mPara 参数
 @param block 返回值
 */
- (void)ZLGoPayHyelectricOrder:(ZLHydroelectricPreOrder *)mPara block:(void(^)(mJHBaseData *resb))block;

#pragma mark----****----获取店铺优惠卷
/**
 获取店铺优惠卷

 @param mShopId 店铺id
 @param block 返回值
 */
- (void)ZLGetShopCoup:(int)mShopId block:(void(^)(APIObject *resb,NSString *mUrl))block;


#pragma mark----****---- 跑腿者操作接口
/**
 跑腿者操作接口

 @param mOrderId 订单id
 @param mOrderCode 订单编号
 @param mStatus 操作状态
 @param block 返回值
 */
- (void)ZLOperatorPPTOrder:(int)mOrderId andOrderCode:(NSString *)mOrderCode andOperatorStatus:(ZLOperatorPPTOrderStatus)mStatus block:(void(^)(APIObject *resb))block;
#pragma mark----****---- 发布者操作接口
/**
 发布者操作接口
 
 @param mOrderId 订单id
 @param mOrderCode 订单编号
 @param mStatus 操作状态
 @param block 返回值
 */
- (void)ZLReleaseOperatorPPTOrder:(int)mOrderId andOrderCode:(NSString *)mOrderCode andOperatorStatus:(ZLOperatorPPTOrderStatus)mStatus block:(void(^)(APIObject *resb))block;



@end
