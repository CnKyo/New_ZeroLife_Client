//
//  APIObjectDefine.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomDefine.h"
#import <LKDBHelper/LKDBHelper.h>
#import <MJExtension/MJExtension.h>
#import <JKCategories/NSString+JKHash.h>


#pragma mark - NSDictionary自定义
@interface NSDictionary (QUAdditions)
-(id)objectWithKey:(NSString *)key; //返回有效值
@end

@interface NSMutableDictionary (QUAdditions)
- (void)setNeedStr:(NSString *)anObject forKey:(id)aKey;  //设置必须有的值
- (void)setValidStr:(NSString *)anObject forKey:(id)aKey;  //当值不为空时，设置该值
- (void)setInt:(int)anObject forKey:(id)aKey;
@end



@interface NSString(QUAdd)
-(NSString *)compSelfIsNone;
+(NSString *)compIsNone:(NSString *)str;
+(NSString *)houseIsOwner:(BOOL)is_owner; //得到房主租客文字
+(NSString *)strUserSexType:(kUserSexType)type;  //得到性别文字
+(NSString *)urlWithExtra:(NSString *)str;  //组合url地址

@end


#pragma mark - NSObject
@interface NSObject (QUAdd)
/**
 *  把该对象object的数组集插入到db中
 *
 *  @param arr object的arr
 */
+(void)arrInsertToDB:(NSArray *)arr;
@end




#pragma mark - shareSDK 菜谱

@interface APIShareSdkObject : NSObject
@property (nonatomic,strong) id                     result;         //正文
@property (nonatomic,strong) NSString *             msg;   //错误消息
@property (nonatomic,assign) int                    retCode;         //非0表示 错误,调试使用
+(APIShareSdkObject *)infoWithError:(NSError *)error;
+(APIShareSdkObject *)infoWithErrorMessage:(NSString *)errMsg;
@end



@interface CookCategoryInfoObject : NSObject
@property (nonatomic, strong) NSString *            ctgId;              //分类ID
@property (nonatomic, strong) NSString *            name;              //分类描述
@property (nonatomic, strong) NSString *            parentId;              //上层分类ID
@end

@interface CookCategoryObject : NSObject
@property (nonatomic, strong) CookCategoryInfoObject *  categoryInfo;              //分类ID
@property (nonatomic, strong) NSMutableArray *      childs;              //子集合
@end


@interface CookRecipeStepObject : NSObject
@property (nonatomic, strong) NSString *            img;              //图片显示
@property (nonatomic, strong) NSString *            step;               //制作步骤
@end


@interface CookRecipeObject : NSObject
@property (nonatomic, strong) NSString *            img;              //预览图地址
@property (nonatomic, strong) NSString *            ingredients;              //原材料
@property (nonatomic, strong) NSMutableArray *      method;              //具体方法
@property (nonatomic, strong) NSString *            sumary;              //简介
@property (nonatomic, strong) NSString *            title;              //标题
@property (nonatomic, strong) NSMutableArray *      childs;              //子集合
@end


@interface CookObject : NSObject
@property (nonatomic, strong) NSMutableArray *      ctgIds;              //分类ID
@property (nonatomic, strong) NSString *            ctgTitles;              //分类标签
@property (nonatomic, strong) NSString *            menuId;              //菜谱id
@property (nonatomic, strong) NSString *            name;              //菜谱名称
@property (nonatomic, strong) NSString *            thumbnail;              //预览图地址
@property (nonatomic, strong) CookRecipeObject *    recipe;              //制作步骤
@end



@interface APIObjectDefine : NSObject

@end




#pragma mark - APIObject 接口外层对象
@interface APIObject : NSObject
@property (nonatomic,strong) id                     data;         //正文
@property (nonatomic,strong) NSString *             msg;   //错误消息
@property (nonatomic,assign) int                    code;         //非0表示 错误,调试使用
+(APIObject *)infoWithError:(NSError *)error;
+(APIObject *)infoWithErrorMessage:(NSString *)errMsg;
+(APIObject *)infoWithReLoginErrorMessage:(NSString *)errMsg;
@end



#pragma mark -  省市区对象
@interface RegionObject : NSObject
@property(nonatomic,assign) int                     gion_id;         //
@property(nonatomic,strong) NSString *              gion_code;            //地区编码
@property(nonatomic,strong) NSString *              gion_name;          // 地区名字
@property(nonatomic,assign) int                     parent_id;             // 上级ID
@property(nonatomic,assign) int                     gion_level;              // 级别
@property(nonatomic,strong) NSString *              gion_name_en;           //地区拼音名称
@property(nonatomic,strong) NSString *              gion_name_en_s;            // 地区短名称
@end


//用户选择省市区对象
@interface ZLSeletedAddress : NSObject
@property (nonatomic,assign) int                    mProvince;
@property (nonatomic,assign) int                    mCity;
@property (nonatomic,assign) int                    mArear;
@property (nonatomic,strong) NSString *             mProvinceStr;
@property (nonatomic,strong) NSString *             mCityStr;
@property (nonatomic,strong) NSString *             mArearStr;

+ (ZLSeletedAddress *)ShareClient;
+(void)destory;
-(NSString *)getAddress;

@end




#pragma mark -  用户地址对象
@interface AddressObject : NSObject
@property(nonatomic,assign) int                     addr_id;         //
@property(nonatomic,assign) kUserSexType            addr_sex;         //
@property(nonatomic,strong) NSString *              user_id;            //用户id
@property(nonatomic,strong) NSString *              addr_name;          // 收货人姓名
@property(nonatomic,strong) NSString *              addr_phone;             // 手机号
@property(nonatomic,strong) NSString *              addr_address;            // 详细地址
@property(nonatomic,assign) int                     addr_province;         //
@property(nonatomic,assign) int                     addr_city;         //
@property(nonatomic,assign) int                     addr_county;         //
@property(nonatomic,strong) NSString *              addr_province_val;            // 省
@property(nonatomic,strong) NSString *              addr_city_val;            // 市
@property(nonatomic,strong) NSString *              addr_county_val;            // 区
@property(nonatomic,assign) int                     addr_sort;         //排序（从大到小，第一个为默认地址）
@property(nonatomic,assign) BOOL                    addr_state;         // 可用状态
+(AddressObject *)defaultAddress; //默认选择地区
-(NSMutableString *)getProvinceCityCountyStr; //获取省市区文字
-(NSMutableString *)getProvinceCityCountyAddressStr; //获取完整地址
@end


#pragma mark -  用户房屋对象
@interface HouseObject : NSObject
@property(nonatomic,assign) int                     real_id;         //房屋认证ID
@property(nonatomic,assign) int                     user_id;            //用户id
@property(nonatomic,assign) kUserSexType            real_sex;         //
@property(nonatomic,strong) NSString *              real_owner;          // 联系人姓名
@property(nonatomic,strong) NSString *              real_phone;             // 手机号
@property(nonatomic,assign) int                     real_province;         //所属省
@property(nonatomic,assign) int                     real_city;         //所属市
@property(nonatomic,assign) int                     real_county;         //所属县区
@property(nonatomic,strong) NSString *              real_province_val;            // 省
@property(nonatomic,strong) NSString *              real_city_val;            // 市
@property(nonatomic,strong) NSString *              real_county_val;            // 区
@property(nonatomic,assign) int                     cmut_id;              // 小区id
@property(nonatomic,strong) NSString *              real_cmut_name;           //小区名称
@property(nonatomic,assign) int                     real_ban;           //楼栋
@property(nonatomic,assign) int                     real_unit;           //单元
@property(nonatomic,assign) int                     real_floor;           //楼层
@property(nonatomic,assign) int                     real_number;           //房号
@property(nonatomic,assign) BOOL                    real_is_owner;         // 是否为业主（Y(1), N(0)）
@property(nonatomic,assign) int                     real_sort;         //排序（从大到小）
@property(nonatomic,strong) NSString *              real_add_time;           //认证时间
+(HouseObject *)defaultAddress;
-(NSMutableString *)getProvinceCityCountyStr; //获取省市区文字
-(NSMutableString *)getFullStr; //获取完整地址文字
-(NSString *)getBanUnitFloorNumberStr; //获取楼单元文字
@end





#pragma mark -  小区对象
@interface CommunityObject : NSObject
@property(nonatomic,assign) int                     cmut_id;         //小区id
@property(nonatomic,strong) NSString *              cmut_name;          // 小区名称
@property(nonatomic,assign) int                     cmut_province;         //小区所属省id
@property(nonatomic,assign) int                     cmut_city;         //小区所属市id
@property(nonatomic,assign) int                     cmut_county;         //小区所属区县id
@property(nonatomic,strong) NSString *              cmut_address;            // 小区地址
@property(nonatomic,assign) double                  cmut_lng;         //小区经度
@property(nonatomic,assign) double                  cmut_lat;         //小区纬度
@property(nonatomic,strong) NSString *              gion_name;            // 小区所属县区名称
@property(nonatomic,strong) NSString *              cmut_add_time;            // 小区添加时间
@end


#pragma mark -  小区楼栋对象
@interface CommunityBansetObject : NSObject //楼栋对象
@property(nonatomic,assign) int                     bset_unit;         //单元
@property(nonatomic,assign) int                     bset_number;         //户数最大值
@property(nonatomic,assign) int                     bset_floor;         //楼层最大值
@end

@interface CommunityUmitsetObject : NSObject //单元对象
@property(nonatomic,assign) int                     bset_ban;         //楼栋号
@property(nonatomic,strong) NSArray *               umitList;          //单元列表
@end



#pragma mark -  投诉建议对象
@interface ComplaintObject : NSObject
@property(nonatomic,assign) int                     cpm_id;         //对应id
@property(nonatomic,assign) kComplaintType          cpm_type;         //投诉类型
@property(nonatomic,assign) int                     user_id;         //用户id
@property(nonatomic,strong) NSString *              cpm_staff;          // 被投诉者
@property(nonatomic,assign) int                     cmut_id;         //小区id
@property(nonatomic,strong) NSString *              cmut_name;         //社区名称
@property(nonatomic,strong) NSString *              cpm_content;          // 投诉类容
@property(nonatomic,strong) NSString *              cpm_handle_content;            //处理结果
@property(nonatomic,strong) NSString *              cpm_add_time;            // 生成时间
@end


///钱包对象
@interface WalletObject : NSObject
@property (assign,nonatomic) int                    uwal_id;      ///钱包ID
@property (assign,nonatomic) int                    user_id;           ///用户id
@property (assign,nonatomic) float                  uwal_balance;       ///余额
@property (assign,nonatomic) int                    uwal_score;     ///积分
@property (strong,nonatomic) NSString *             uwal_state;///钱包状态（normal 正常 locked 锁定）
@property (strong,nonatomic) NSString *             pass;///是否有支付密码(NOPASS-无/PASS-有)
@end







#pragma mark -  用户优惠券对象
@interface CouponObject : NSObject
@property (nonatomic,assign) int                    cuc_uid;         //用户优惠券ID
@property (nonatomic,assign) kCouponType            cuc_state;
@property (nonatomic,strong) NSString *             cup_name;         //优惠券名称
@property (nonatomic,strong) NSString *             cup_content;         //描述
@property (nonatomic,strong) NSString *             cup_author;         //优惠券发放者名称
@property (nonatomic,strong) NSString *             cup_logo;         //描述优惠券发放者LOGO（无显示默认LOGO）
@property (nonatomic,assign) float                  cup_price;         //折扣价格
@property (nonatomic,assign) float                  cup_min_price;         //最低使用价格
@property (nonatomic,strong) NSString *             cup_is_shop;         //是否为店铺发放
@property (nonatomic,strong) NSString *             cuc_overdue;         //是否已过期
@property (nonatomic,strong) NSString *             cuc_add_time;         //
//@property (nonatomic,strong) NSDate *             cuc_overdue;         //过期时间
//@property (nonatomic,strong) NSDate *             cuc_add_time;         //
@end



#pragma mark -  用户银行卡对象
@interface BankCardObject : NSObject
@property(nonatomic,assign) int                     bank_id;         //对应id
@property(nonatomic,assign) int                     user_id;         //用户id
@property(nonatomic,strong) NSString *              bank_name;          // 银行名称
@property(nonatomic,strong) NSString *              bank_code;         //银行代码
@property(nonatomic,strong) NSString *              bank_type;            //银行类型
@property(nonatomic,strong) NSString *              bank_card;            // 银行卡号
@property(nonatomic,strong) NSString *              bank_card_val;            // 银行卡-模糊
@property(nonatomic,strong) NSString *              bank_mobile;            //银行卡预留手机号
@property(nonatomic,strong) NSString *              bank_real_name;            //银行卡对应真实姓名
@property(nonatomic,strong) NSString *              id_card;            // 身份证号
@property(nonatomic,strong) NSString *              id_card_val;            // 身份证号-模糊
@property(nonatomic,strong) NSString *              id_card_url;            // 银行卡正面图片url
@property(nonatomic,strong) NSString *              id_card_back_url;            // 银行卡背面图片url
@end

#pragma mark----****----收银台测试model
@interface ZLGoPayObject : NSObject
@property(nonatomic, assign) BOOL                   isSelected;
@end









#pragma mark -  用户订单对象

//订单评价记录对象
@interface OrderCommentObject : NSObject
@property(nonatomic,assign) int                     com_id;         //id
@property(nonatomic,assign) kOrderClassType         odr_type;         //订单类型
@property(nonatomic,assign) int                     odr_id;         //订单id
@property(nonatomic,assign) int                     user_id;         //评价用户id
@property(nonatomic,strong) NSString *              user_nike;         //评价用户名称
@property(nonatomic,strong) NSString *              user_header;         //评价用户id
@property(nonatomic,assign) int                     com_tag_id;         //评价的对象id
@property(nonatomic,assign) float                   com_star;         //评价星级(1-5): 好评数(Star>3),差评数(Star<3),中评数(Star=3)
@property(nonatomic,strong) NSString *              com_content;         //评论文字
@property(nonatomic,strong) NSString *              com_imgs;         //评论图片集合，用逗号分割
@property(nonatomic,strong) NSString *              com_state;         //评论状态
@property(nonatomic,strong) NSString *              com_add_time;         //评论时间
@property(nonatomic,assign) BOOL                    com_is_security;         //是否匿名评价(０不匿名)
@end

//订单商品清单对象
@interface OrderGoodsObject : NSObject
@property(nonatomic,assign) int                     odrg_id;         //id
@property(nonatomic,assign) int                     odr_id;         //订单id
@property(nonatomic,assign) int                     pro_id;         //商品ID
@property(nonatomic,assign) int                     cam_gid;         //活动商品ID
@property(nonatomic,assign) int                     sku_id;         //规格SKU
@property(nonatomic,assign) float                   sku_cost;         //商品成本
@property(nonatomic,strong) NSString *              odrg_pro_name;         //商品名
@property(nonatomic,strong) NSString *              odrg_spec;         //规格描述
@property(nonatomic,assign) int                     odrg_number;         //数量
@property(nonatomic,strong) NSString *              odrg_img;         //商品小图片url
@property(nonatomic,strong) NSString *              odrg_img_repair;         //商品图(报修)
@property(nonatomic,strong) NSString *              odrg_video_repair;         //商品视频(报修)
@property(nonatomic,assign) float                   odrg_price;         //价格
@end


//订单参与活动信息对象
@interface OrderCampaignObject : NSObject
@property(nonatomic,assign) int                     odr_cid;         //id
@property(nonatomic,assign) int                     odr_id;         //订单id
@property(nonatomic,assign) int                     cam_id;         //活动ID
@property(nonatomic,assign) int                     cam_type;         //活动类型
@property(nonatomic,strong) NSString *              cam_name;         //活动标题
@property(nonatomic,assign) float                   cam_satisfy;         //活动条件
@property(nonatomic,assign) float                   cam_act_satisfy;         //订单活动优惠价格
@end


//支付订单信息对象
@interface OrderPayObject : NSObject
@property(nonatomic,assign) int                     pay_id;         //id
@property(nonatomic,assign) kOrderClassType         odr_type;         //订单类型
@property(nonatomic,assign) int                     odr_id;         //订单id
@property(nonatomic,assign) int                     user_id;         //用户id
@property(nonatomic,strong) NSString *              pay_user_name;         //用户名
@property(nonatomic,strong) NSString *              odr_code;         //订单编号
@property(nonatomic,strong) NSString *              pay_code;         //支付订单编号
@property(nonatomic,assign) float                   pay_amount;         //支付金额
@property(nonatomic,assign) int                     pay_channel;         //支付方式
@property(nonatomic,strong) NSString *              pay_time;         //支付时间
@property(nonatomic,strong) NSString *              pay_ext_code;         //外部编码
@property(nonatomic,strong) NSString *              pay_currency;         //货币代码
@property(nonatomic,strong) NSString *              pay_desc;         //描述
@property(nonatomic,strong) NSString *              pay_memo;         //回调结果
@property(nonatomic,strong) NSString *              pay_state;         //支付状态
@property(nonatomic,strong) NSString *              pay_add_time;         //生成时间
@end


//订单扩展信息对象
@interface OrderExtObject : NSObject
@property(nonatomic,assign) int                     odr_id;         //订单id
@property(nonatomic,strong) NSString *              odr_deliver_name;         //收货人
@property(nonatomic,strong) NSString *              odr_deliver_phone;         //联系电话
@property(nonatomic,strong) NSString *              odr_deliver_address;         //收货地址
@property(nonatomic,strong) NSString *              odr_timing;         //定时服务时间
@property(nonatomic,assign) int                     odr_deliver_type;         //配送方式
@property(nonatomic,assign) float                   odr_deliver_fee;         //配送费
@property(nonatomic,assign) int                     cuc_id;         //用户优惠券ID
@property(nonatomic,assign) float                   ord_coupon_price;         //优惠券优惠金额
@property(nonatomic,assign) int                     acc_uid;         //服务人员ID
@property(nonatomic,strong) NSString *              odr_service_person;         //服务人员
@property(nonatomic,strong) NSString *              odr_service_phone;         //服务电话
@property(nonatomic,strong) NSString *              odr_pick_name;         //取件联系人
@property(nonatomic,strong) NSString *              odr_pick_phone;         //取件联系电话
@property(nonatomic,strong) NSString *              odr_pick_address;         //取件联系地址
@end


//订单基础信息对象
@interface OrderObject : NSObject
@property(nonatomic,assign) int                     odr_id;         //订单id
@property(nonatomic,strong) NSString *              odr_code;         //订单编号
@property(nonatomic,assign) kOrderClassType         odr_type;         //订单类型
@property(nonatomic,assign) int                     odr_state;         //订单状态
@property(nonatomic,assign) int                     cmut_id;         //社区ID
@property(nonatomic,assign) int                     shop_id;         //店铺ID
@property(nonatomic,strong) NSString *              odr_shop_name;         //店铺名
@property(nonatomic,strong) NSString *              odr_shop_img;         //店铺logo url
@property(nonatomic,assign) int                     user_id;         //购买者ID
@property(nonatomic,assign) int                     odr_pay_type;         //支付方式
@property(nonatomic,strong) NSString *              odr_pay_name;         //支付名
@property(nonatomic,strong) NSString *              pay_code;         //支付订单编号
@property(nonatomic,strong) NSString *              odr_pay_time;         //支付时间
@property(nonatomic,strong) NSString *              odr_add_time;         //生成时间
@property(nonatomic,strong) NSString *              odr_finished_time;         //完成时间
@property(nonatomic,assign) float                   odr_cost_price;         //成本价
@property(nonatomic,assign) float                   odr_amount;         //订单总价
@property(nonatomic,assign) float                   odr_benefit_price;         //优惠价
@property(nonatomic,assign) float                   odr_pay_price;         //应支付价格
@property(nonatomic,strong) OrderExtObject *        odr_ext;         //订单额外信息对象
@property(nonatomic,strong) NSMutableArray *        goods_list;         //商品清单集合
@property(nonatomic,strong) NSMutableArray *        cam_list;         //订单拥有优惠集合
@end



//订单竞价信息对象
@interface OrderRepairBidObject : NSObject
@property(nonatomic,assign) int                     bid_id;         //竞价信息id
@property(nonatomic,assign) int                     rpr_id;         //报修单ID
@property(nonatomic,assign) int                     shop_id;         //店铺ID
@property(nonatomic,strong) NSString *              shop_name;         //店铺名
@property(nonatomic,strong) NSString *              shop_logo;         //店铺小图
@property(nonatomic,assign) float                   bid_price;         //竞价价格
@property(nonatomic,strong) NSString *              bid_state;         //状态
@property(nonatomic,strong) NSString *              rpr_code;         //报修单号
@property(nonatomic,strong) NSString *              bid_add_time;         //竞价时间
@end


//订单报修单信息对象
@interface OrderRepairObject : NSObject
@property(nonatomic,assign) int                     rpr_id;         //报修单id
@property(nonatomic,strong) NSString *              rpr_code;         //报修单编号
@property(nonatomic,assign) int                     cmut_id;         //社区ID
@property(nonatomic,assign) int                     user_id;         //发布者ID
@property(nonatomic,strong) NSString *              rpr_user_name;         //发布者名
@property(nonatomic,assign) int                     odr_state;         //订单状态
@property(nonatomic,strong) NSString *              odr_add_time;         //生成时间
@property(nonatomic,strong) NSString *              odr_finished_time;         //完成时间
@property(nonatomic,assign) float                   odr_visiting_fee;         //上门费
@property(nonatomic,assign) float                   odr_cost_price;         //成本价
@property(nonatomic,assign) float                   odr_benefit_price;         //优惠价
@property(nonatomic,assign) float                   odr_pay_price;         //应支付价格
@property(nonatomic,assign) float                   odr_amount;         //订单总价
@property(nonatomic,strong) NSString *              odr_deliver_name;         //收货人
@property(nonatomic,strong) NSString *              odr_deliver_phone;         //联系电话
@property(nonatomic,strong) NSString *              odr_deliver_address;         //收货地址
@property(nonatomic,strong) NSString *              odr_timing;         //定时服务时间
@property(nonatomic,strong) NSString *              odr_remark;         //备注
@property(nonatomic,assign) int                     pro_cls_id;         //分类ID
@property(nonatomic,strong) NSString *              odrg_pro_name;         //商品名
@property(nonatomic,assign) float                   odrg_price;         //价格
@property(nonatomic,strong) NSString *              odrg_img_url;         //商品小图片url
@property(nonatomic,strong) NSString *              odrg_repair_img_url;         //报修图
@property(nonatomic,strong) NSString *              odrg_repair_video_url;         //报修视频
@property(nonatomic,strong) NSMutableArray *        bid_list;         //竞价信息集合
@end



#pragma mark----****----用户信息

@class WalletObject;
@class CommunityObject;
///
@interface ZLUserInfo : NSObject
@property (assign,nonatomic) int                    user_id; ///对应用户id
@property (strong,nonatomic) NSString*              user_nick; ///用户昵称
@property (assign,nonatomic) kUserSexType           user_sex; ///性别（UNKNOW(0), MALE(1), FEMALE(2)）
@property (strong,nonatomic) NSString*              user_phone; //手机号
@property (strong,nonatomic) NSString*              user_header; //用户头像图片url
@property (strong,nonatomic) NSString*              user_birth; //生日
@property (assign,nonatomic) int                    user_province; //所属省
@property (assign,nonatomic) int                    user_city; //所属市
@property (assign,nonatomic) int                    user_county; //所属县区
@property (strong,nonatomic) NSString*              user_qrcode; //用户二维码图片url
@property (strong,nonatomic) NSString*              user_emaill; //用户邮箱
@property (assign,nonatomic) BOOL                   user_is_notify; //是否开启推送消息功能（Y(1), N(0)）
@property (strong,nonatomic) NSString*              user_add_time; ///

@property (nonatomic,strong) WalletObject*           wallet; //用户钱包信息
@property (nonatomic,strong) CommunityObject*       community; //用户绑定小区信息

#pragma mark----****----登录
///需要登录
- (BOOL)isNeedLogin;
///用户信息实效
- (BOOL)ZLUserIsValid;

//更新用户数据
+(void)updateUserInfo:(ZLUserInfo *)user;
/**
 *  退出登录
 */
+ (void)logOut;
///返回当前用户信息
+ (ZLUserInfo *)ZLCurrentUser;
//+ (void)ZLDealSession:(APIObject *)info andPwd:(NSString *)mPwd andOpenId:(NSString *)mOpenId block:(void(^)(APIObject* resb, ZLUserInfo *user))block;

@end
/////用户默认绑定小区对象
//@interface ZLUserCommunityObj : NSObject
/////小区id
//@property (assign,nonatomic) int ZLUmut_id;
/////小区名称
//@property (strong,nonatomic) NSString* ZLUmut_name;
/////小区所属省id
//@property (assign,nonatomic) int ZLUmut_province;
/////小区所属市id
//@property (assign,nonatomic) int ZLUmut_city;
/////小区所属区县id
//@property (assign,nonatomic) int ZLUmut_county;
/////小区地址
//@property (strong,nonatomic) NSString* ZLUmut_address;
/////小区纬度
//@property (strong,nonatomic) NSString* ZLUmut_lng;
/////小区经度
//@property (strong,nonatomic) NSString* ZLUmut_lat;
/////小区所属县区名称
//@property (strong,nonatomic) NSString* ZLGion_name;
//
//
//@end
/////钱包对象
//@interface ZLWalletObj : NSObject
/////用户id
//@property (assign,nonatomic) int user_id;
/////余额
//@property (assign,nonatomic) float uwal_balance;
/////钱包ID
//@property (assign,nonatomic) int uwal_id;
/////积分
//@property (assign,nonatomic) int uwal_score;
/////钱包状态（normal 正常 locked 锁定）
//@property (assign,nonatomic) ZLWalletStatu uwal_state;
//
//
//@end
///

@interface ZLHomeFunvtionAndBanner : NSObject

@property (strong,nonatomic) NSArray*              banners;///banner
@property (strong,nonatomic) NSArray*              functions;///功能


@end

#pragma mark----****----首页banner
@interface ZLHomeBanner : NSObject
@property (assign,nonatomic) int                    bnr_id; ///banner	ID
@property (assign,nonatomic) int                    bnr_type;///类型(1:平台/2:超市)
@property (assign,nonatomic) int                    bnr_sort;///排序
@property (strong,nonatomic) NSString*              bnr_explain;///banner说明
@property (strong,nonatomic) NSString*              bnr_page;///page(跳转界面)
@property (strong,nonatomic) NSString*              bnr_image;///url（图片URL）
@property (assign,nonatomic) ZLHomeBannerType       bnr_state;///状态1平台 2超市
@end
#pragma mark----****----首页功能分类
@interface ZLHomeFunctions : NSObject

@property (assign,nonatomic) int                    fct_id;///功能ID

@property (strong,nonatomic) NSString*              fct_name;///名称
@property (strong,nonatomic) NSString*              fct_logo;///图片（没有图片用默认图片）

@property (assign,nonatomic) ZLHomeFunctionType     fct_type;///类型（1.缴费；2.超市；3.报修；4.家政；5.便民；6.跑跑腿；7.公告；8.邻里圈）

@property (assign,nonatomic) int                    fct_sort;///排序（从大到小）

@property (strong,nonatomic) NSString*             fct_state;///状态
@end


@interface ZLHomeObj : NSObject

//平台活动广告
@property (strong,nonatomic) NSArray* sAdvertList;

//平台公告(List)
@property (strong,nonatomic) NSArray* eCompanyNoticeList;


@end



///平台活动广告  //活动广告
@interface ZLHomeAdvList : NSObject
@property (assign,nonatomic) int                    shop_id;//店铺ID
@property (assign,nonatomic) int                    adv_id;//广告活动ID
@property (assign,nonatomic) int                    cpn_id;//公司ID
@property (strong,nonatomic) NSString*              distance;//活动距离(单位：米)
@property (strong,nonatomic) NSString*              adv_image;//活动图片
@property (strong,nonatomic) NSString*              adv_click_url;////点击的URL
@property (assign,nonatomic) int                    adv_type;//类型（0:WAP;1:原生）
@property (assign,nonatomic) int                    cam_type;//活动类型
@end



///平台公告(List)
@interface ZLHomeCompainNoticeList : NSObject
@property (assign,nonatomic) int                    not_id;//公告ID
@property (strong,nonatomic) NSString*              not_title;//公告标题;
@property (assign,nonatomic) int                    cmut_id;//社区ID
@property (assign,nonatomic) int                    not_is_cmut;//是否是社区发布(0：平台；1：社区)
@property (assign,nonatomic) int                    not_state;//新闻状态
@property (strong,nonatomic) NSString*              not_sub;//内容简介
@property (strong,nonatomic) NSString*              not_add_time;//公告发布时间
@property (strong,nonatomic) NSString*              not_image;////公告图片
@property (strong,nonatomic) NSString*              not_deadline;//失效时间
@property (strong,nonatomic) NSString*              not_add_person;//发布者
@property (strong,nonatomic) NSString*              not_type;
@end



@interface ZLHomeCommunity : NSObject
@property (assign,nonatomic) int                    cmut_id;///小区id
@property (strong,nonatomic) NSString*              cmut_name;///小区名称
@property (assign,nonatomic) int                    cmut_province;///小区所属省id
@property (assign,nonatomic) int                    cmut_city;///小区所属市id
@property (assign,nonatomic) int                    cmut_county;///小区所属区县id
@property (strong,nonatomic) NSString*              cmut_address;///小区地址
@property (strong,nonatomic) NSString*              cmut_lng;///小区纬度
@property (strong,nonatomic) NSString*              cmut_lat;///小区经度
@property (strong,nonatomic) NSString*              gion_name;///小区所属县区名称
@end


#pragma mark----****----app初始化加载数据
@class ZLAppSet;
@class ZLAPPMethod;
@interface ZLAPPInfo : NSObject


@property (strong,nonatomic)ZLAppSet *set;

@property (strong,nonatomic)ZLAPPMethod *app;
///app信息失效
- (BOOL)ZLAppinfoIsValid;
+ (ZLAPPInfo *)ZLCurrentAppInfo;
+ (void)ZLDealSession:(APIObject *)info  block:(void(^)(APIObject* resb, ZLAPPInfo *appInfo))block;

@end
@interface ZLAppSet : NSObject
///
@property (strong,nonatomic) NSString* fig_android;
///
@property (strong,nonatomic) NSString* fig_ios;
///
@property (assign,nonatomic) int fig_is_upgrade;
///
@property (strong,nonatomic) NSString* fig_phone;
///
@property (strong,nonatomic) NSString* fig_qq;
///
@property (strong,nonatomic) NSString* fig_version;


@end
@interface ZLAPPMethod : NSObject

@property (strong,nonatomic) NSString* color;



@end
#pragma mark----****----社区超市首页
///社区超市首页
@interface ZLShopHomePage : NSObject
///banner
@property (strong,nonatomic) NSArray* banner;
///功能分类
@property (strong,nonatomic) NSArray* functions;

///活动
@property (strong,nonatomic) NSArray* campaign;
///分类
@property (strong,nonatomic) NSArray* classify;


@end
#pragma mark----****----社区超市首页banner

///社区超市首页活动
@interface ZLShopHomeCampaign : NSObject
///距离
@property (assign,nonatomic) int distance;
///类型？
@property (assign,nonatomic) int adv_type;
///活动类型？
@property (assign,nonatomic) int cam_type;
///添加时间？
@property (strong,nonatomic) NSString* adv_add_time;
///状态？
@property (strong,nonatomic) NSString* adv_state;
///？
@property (strong,nonatomic) NSString* adv_add_person;
///经度
@property (strong,nonatomic) NSString* adv_lng;
///纬度
@property (strong,nonatomic) NSString* adv_lat;

///活动ID
@property (assign,nonatomic) int adv_id;
///店铺ID
@property (assign,nonatomic) int shop_id;
///公司ID
@property (assign,nonatomic) int cpn_id;
///活动标题
@property (strong,nonatomic) NSString* adv_title;
///活动图片
@property (strong,nonatomic) NSString* adv_image;
///点击跳转类型（0:WAP;1:原生）
@property (assign,nonatomic) ZLShopHomeCampainType adv_click_type;
///Wap页面URL
@property (strong,nonatomic) NSString* adv_click_url;



@end

#pragma mark----****----社区超市首页分类
///社区超市首页分类
@interface ZLShopHomeClassify : NSObject
///分类ID
@property (assign,nonatomic) int cls_id;
///店铺ID（通用分类为0）
@property (assign,nonatomic) int shop_id;
///父级ID
@property (assign,nonatomic) int cls_parent;
///级别
@property (assign,nonatomic) int cls_level;
///名称
@property (strong,nonatomic) NSString* cls_name;
///图片
@property (strong,nonatomic) NSString* cls_image;
///排序
@property (assign,nonatomic) int cls_sort;

@property (strong,nonatomic) NSString* cls_state;

@property (strong,nonatomic) NSString* parent_name;


@end

#pragma mark----****----社区超市首页店铺列表
@interface ZLShopHomeShopList : NSObject
///数据总条数
@property (assign,nonatomic) int totalRow;
///数据总分页数
@property (assign,nonatomic) int totalPage;
///当前分页页码
@property (assign,nonatomic) int pageNumber;
///当前分页标准（每页多少条数据）
@property (assign,nonatomic) int pageSize;
///店铺列表数据
@property (strong,nonatomic) NSArray *list;


@end
#pragma mark----****----社区超市首页店铺对象
@interface ZLShopHomeShopObj : NSObject
///店铺id
@property (assign,nonatomic) int shop_id;
///名称
@property (strong,nonatomic) NSString* shop_name;
///图片
@property (strong,nonatomic) NSString* shop_logo;
///地址
@property (strong,nonatomic) NSString* shop_address;
///距离
@property (strong,nonatomic) NSString* distance;
///销量
@property (assign,nonatomic) int ext_sales_month;

///送达时间
@property (strong,nonatomic) NSString* ext_max_time;

///配送费
@property (assign,nonatomic) float ext_min_price;

@end
#pragma mark----****----社区超市店铺对象
@class ZLShopMsg;
@class ZLShopCoupon;

@interface ZLShopObj : NSObject
///店铺信息
@property (strong,nonatomic) ZLShopMsg *mShopMsg;
///店铺优惠
@property (strong,nonatomic) ZLShopCoupon *mShopCoupon;
///店铺分类
@property (strong,nonatomic) NSArray *mShopClassify;
///店铺活动 
@property (strong,nonatomic) NSArray *mShopCampains;


@end
#pragma mark----****----社区超市店铺对象

@interface ZLShopMsg : NSObject
///店铺id
@property (assign,nonatomic) int shop_id;
///名称
@property (strong,nonatomic) NSString* shop_name;
///店铺描述
@property (strong,nonatomic) NSString* shop_desc;
///店铺Logo图片URL
@property (strong,nonatomic) NSString* shop_logo;
///店铺地址
@property (strong,nonatomic) NSString* shop_address;
///店铺联系电话
@property (strong,nonatomic) NSString* shop_phone;
///店铺定位纬度
@property (strong,nonatomic) NSString* shop_lat;
///店铺定位经度
@property (strong,nonatomic) NSString* shop_lng;
///营业时间
@property (strong,nonatomic) NSString* ext_open_time;
///休业时间
@property (strong,nonatomic) NSString* ext_close_time;
///最低起送金额（0表示无限制）
@property (assign,nonatomic) float ext_min_price;
///配送时间描述
@property (strong,nonatomic) NSString* ext_max_time;
///整体评分
@property (assign,nonatomic) float ext_score;
///月销量
@property (assign,nonatomic) int ext_sales_month;
///店铺关闭时间（与休业时间不同），店铺关闭为年月日（2016.12.01）
@property (strong,nonatomic) NSString* ext_closed_time;

@end
#pragma mark----****----社区超市店铺分类对象

@interface ZLShopClassify : NSObject
///分类ID
@property (assign,nonatomic) int cls_id;
///分类名称
@property (strong,nonatomic) NSString* cls_name;
///分类图标（视前端情况显示分类图片，如超市店铺列表页面的分类有图标，在店铺详情页面中的商品分类无图片）
@property (strong,nonatomic) NSString* cls_image;
///分类排序（从大到小）
@property (assign,nonatomic) int cls_sort;

@end
#pragma mark----****----社区超市店铺优惠券对象

@interface ZLShopCoupon : NSObject
///是否有优惠券，0代表没有，1代表有
@property (assign,nonatomic) int is_coupon;
///优惠券领取WAP页面URL
@property (strong,nonatomic) NSString* cup_url;
@end
#pragma mark----****----社区超市店铺活动对象

@interface ZLShopCampain : NSObject
///活动ID
@property (assign,nonatomic) int cam_id;
///活动名称
@property (strong,nonatomic) NSString* cam_name;
///是否为商品活动（0-否，1-是）
@property (assign,nonatomic) int cam_is_goods;
///类型（1.2.3...具体类型待定）
@property (assign,nonatomic) int cam_type;
///开始时间
@property (strong,nonatomic) NSString* cam_begin;
///结束时间
@property (strong,nonatomic) NSString* cam_end;
///状态
@property (strong,nonatomic) NSString* cam_state;
@end
///店铺左边数据源
@interface ZLShopLeftTableArr : NSObject
///左边的类型
@property (assign,nonatomic) int mLeftType;
///活动
@property (strong,nonatomic) NSArray* mCampainArr;
///分类
@property (strong,nonatomic) NSArray* mClassArr;


@end

#pragma mark----****----店铺商品对象
///店铺商品列表
@interface ZLShopGoodsList : NSObject
///行数
@property (assign,nonatomic) int totalRow;
///页数
@property (assign,nonatomic) int pageNumber;
///最后一页
@property (assign,nonatomic) BOOL lastPage;
///第一页
@property (assign,nonatomic) BOOL firstPage;
///总页数
@property (assign,nonatomic) int totalPage;
///一页数量
@property (assign,nonatomic) int pageSize;
///列表数据
@property (strong,nonatomic) NSArray* list;


@end
#pragma mark----****----商品类型返回对象
///商品类型返回对象
@interface ZLGoodsWithClass : NSObject
///商品数量
@property (assign,nonatomic) int mNum;

///商品单位
@property (strong,nonatomic) NSString* pro_unit;
///活动商品限购量（0表示无限制），活动商品列表特有
@property (assign,nonatomic) int pro_purchase_num;
///商品SKU列表数据；注：活动商品时，数据和商品数据同一级
@property (strong,nonatomic) NSArray* skus;
///商品id
@property (assign,nonatomic) int pro_id;
///商品重量
@property (strong,nonatomic) NSString* pro_weight;
///商品小图URL
@property (strong,nonatomic) NSString* img_url;
///SKU id
@property (assign,nonatomic) int sku_id;
///保质期
@property (strong,nonatomic) NSString* pro_date_life;
///销售量
@property (assign,nonatomic) int pro_sales_total;
///生产日期
@property (strong,nonatomic) NSString* pro_date_create;
///商品名称
@property (strong,nonatomic) NSString* pro_name;

@end
//便民服务对象
@interface ExternalPlatformObject : NSObject
@property (assign,nonatomic) int                    pla_id;///对应id
@property (strong,nonatomic) NSString*              pla_name;///第三方名称
@property (strong,nonatomic) NSString*              pla_logo;///Logo图片URL
@property (strong,nonatomic) NSString*              pla_uri;///点击链接url
@end



#pragma mark----****----商品库存对象
///商品库存对象
@interface ZLGoodsSKU : NSObject
///规格值名称
@property (strong,nonatomic) NSString* sta_val_name;
///规格类型名称
@property (strong,nonatomic) NSString* sta_name;
@property (strong,nonatomic) NSString* sta_val_state;

///规格类型是否必选标识，1-是，0-否
@property (assign,nonatomic) int sta_required;
///商品对应SKU价格
@property (assign,nonatomic) float sku_price;
///规格类型ID
@property (assign,nonatomic) int sta_id;
///对应SKU库存
@property (assign,nonatomic) int sku_stock;
///SKU id
@property (assign,nonatomic) int sku_id;
///商品对应SKU成本
@property (assign,nonatomic) int sku_cost;
///规格值id
@property (assign,nonatomic) int sta_val_id;

@end
#pragma mark----****----活动商品类型返回对象
///活动商品类型返回对象
@interface ZLGoodsWithCamp : NSObject

@property (assign,nonatomic) int mNum;
///规格值名称
@property (strong,nonatomic) NSString* sta_val_name;
@property (strong,nonatomic) NSString* sta_val_state;

///规格类型名称
@property (strong,nonatomic) NSString* sta_name;
///规格类型是否必选标识，1-是，0-否
@property (assign,nonatomic) int sta_required;
///对应SKU库存
@property (assign,nonatomic) int sku_stock;
///活动id，活动商品列表特有
@property (assign,nonatomic) int cam_gid;
///SKU id
@property (assign,nonatomic) int sku_id;
///活动商品限购量（0表示无限制），活动商品列表特有
@property (assign,nonatomic) int cam_purchase_num;
///生产日期
@property (strong,nonatomic) NSString* pro_date_create;
///
@property (assign,nonatomic) int sku_id_def;
///活动商品池商品数量，活动商品列表特有
@property (assign,nonatomic) int cam_stock;
///活动id，活动商品列表特有
@property (assign,nonatomic) int cam_id;
///商品单位
@property (strong,nonatomic) NSString* pro_unit;
///商品限购量（0表示无限制）
@property (assign,nonatomic) int pro_purchase_num;
///商品id
@property (assign,nonatomic) int pro_id;
///商品重量
@property (strong,nonatomic) NSString* pro_weight;
///活动价格，活动商品列表特有
@property (assign,nonatomic) int cam_price;
///商品小图URL
@property (strong,nonatomic) NSString* img_url;
///规格类型ID
@property (assign,nonatomic) int sta_id;
///商品对应SKU价格
@property (assign,nonatomic) float sku_price;
///保质期
@property (strong,nonatomic) NSString* pro_date_life;
///销售量
@property (assign,nonatomic) int pro_sales_total;
///商品对应SKU成本
@property (assign,nonatomic) int sku_cost;
///商品名称
@property (strong,nonatomic) NSString* pro_name;
///规格值id
@property (assign,nonatomic) int sta_val_id;


@end
#pragma mark----****----活动商品详情返回对象
///活动商品详情返回对象
@interface ZLGoodsDetail : NSObject
///商品编号
@property (strong,nonatomic) NSString* pro_code;
///图片数组
@property (strong,nonatomic) NSArray* images;
///商品材质、成分
@property (strong,nonatomic) NSString* pro_component;
///商品条码
@property (strong,nonatomic) NSString* pro_code_bar;
///活动商品ID
@property (assign,nonatomic) int cam_gid;
///商品描述
@property (strong,nonatomic) NSString* pro_spec;
///商品配件、备注
@property (strong,nonatomic) NSString* pro_remark;
///默认SKU ID
@property (assign,nonatomic) int sku_id;
///活动商品限购，0无限制
@property (assign,nonatomic) int cam_purchase_num;
///生产日期
@property (strong,nonatomic) NSString* pro_date_create;
///商品品牌英文名称
@property (strong,nonatomic) NSString* bra_name_en;
///商品品牌中文名称
@property (strong,nonatomic) NSString* bra_name_cn;
///活动商品池数量
@property (assign,nonatomic) int cam_stock;
///活动ID
@property (assign,nonatomic) int cam_id;
///商品单位
@property (strong,nonatomic) NSString* pro_unit;
///商品限购，0无限制；当为活动商品时，参照cam_purchase_num
@property (assign,nonatomic) int pro_purchase_num;
///商品ID
@property (assign,nonatomic) int pro_id;
///商品重量
@property (strong,nonatomic) NSString* pro_weight;
///商品品牌LOGO
@property (strong,nonatomic) NSString* bra_logo;
///活动价格，注：以上数据为活动商品特有数据
@property (assign,nonatomic) int cam_price;
///保质期描述，如《2年》
@property (strong,nonatomic) NSString* pro_date_life;
///销量
@property (assign,nonatomic) int pro_sales_total;
///商品自定义属性
@property (strong,nonatomic) NSString* pro_property;
///商品名称
@property (strong,nonatomic) NSString* pro_name;

@end
#pragma mark----****----活动商品详情图片返回对象
///
@interface ZLGoodsDetailImg : NSObject
///商品图片URL
@property (strong,nonatomic) NSString* img_url;
///商品图片ID
@property (assign,nonatomic) int img_id;
///商品图片排序，从大到小
@property (assign,nonatomic) int img_sort;

@end
///规格列表
@interface ZLGoodsSpeList : NSObject
///规格名
@property (strong,nonatomic) NSString* mSpeName;
///规格数据源
@property (strong,nonatomic) NSMutableArray* mSpeArr;
///staid
@property (assign,nonatomic) int mStaId;
///规格id
@property (assign,nonatomic) int mSkuId;


@end
#pragma mark-----****----///规格值对象
@class ZLGoodsSKU;
///规格值对象
@interface ZLSpeObj : NSObject
///规格商品名称
@property (strong,nonatomic) NSString* mSpeGoodsName;

@property (assign,nonatomic) int mSta_val_id;

///价格
@property (assign,nonatomic) float mPrice;
///库存
@property (assign,nonatomic) int mStock;
///是否有效
@property (assign,nonatomic) int mIsValid;
///sku对象
@property (strong,nonatomic) ZLGoodsSKU *mSku;


@end
#pragma mark-----****----///店铺加入购物车扩展对象
@interface ZLAddShopCarExObj : NSObject
///商品数量
@property (assign,nonatomic) int mGoodsNum;
///总价格
@property (assign,nonatomic) float mTotlePrice;

@end
#pragma mark-----****----///物业报修父类扩展对象
///物业报修父类扩展对象
@interface ZLFixClassExtObj : NSObject
///父级id
@property (assign,nonatomic) int mParentId;
///父级名称
@property (strong,nonatomic) NSString* mParentName;
///子类数组
@property (strong,nonatomic) NSMutableArray* mClassArr;


@end
#pragma mark-----****----物业报修子类扩展对象
///物业报修子类扩展对象
@interface ZLFixSubExtObj : NSObject
///子类id
@property (assign,nonatomic) int mClassId;
///子类名称
@property (strong,nonatomic) NSString* mClassName;
///子类图片
@property (strong,nonatomic) NSString* mClassImg;

@end
#pragma mark-----****----首页便民服务对象
@interface ZLHomeServicePerson : NSObject
///添加的状态
@property (strong,nonatomic) NSString* pla_state;
///添加的时间
@property (strong,nonatomic) NSString* pla_add_time;
///添加人？
@property (strong,nonatomic) NSString* pla_add_person;
///对应id
@property (assign,nonatomic) int pla_id;
///点击链接url
@property (strong,nonatomic) NSString* pla_uri;
///第三方名称
@property (strong,nonatomic) NSString* pla_name;
///Logo图片URL
@property (strong,nonatomic) NSString* pla_logo;




@end


#pragma mark-----****----首页消息对象
///首页消息对象
@interface ZLHomeMsgObj : NSObject
///总排数
@property (assign,nonatomic) int totalRow;
///第几页
@property (assign,nonatomic) int pageNumber;
///总页数
@property (assign,nonatomic) int totalPage;
///页数条数
@property (assign,nonatomic) int pageSize;
///消息列表
@property (strong,nonatomic) NSArray* msgList;


@end
#pragma mark-----****----消息对象
///消息对象
@interface ZLMessageObj : NSObject

///消息已读？还是未读
@property (assign,nonatomic) BOOL mIsRead;
///消息状态
@property (strong,nonatomic) NSString* msg_state;
///消息标题
@property (strong,nonatomic) NSString* msg_title;
///消息内容
@property (strong,nonatomic) NSString* msg_content;
///消息附带数据
@property (strong,nonatomic) NSString* msg_extras;
///消息类型
@property (assign,nonatomic) int msg_type;
///消息ID
@property (assign,nonatomic) int msg_id;
///消息简介
@property (strong,nonatomic) NSString* msg_sub;
///消息来源
@property (strong,nonatomic) NSString* msg_auth;

@end
#pragma mark-----****----公告列表对象
///公告列表对象
@interface ZLHomeAnouncementListObj : NSObject

///总排数
@property (assign,nonatomic) int totalRow;
///第几页
@property (assign,nonatomic) int pageNumber;
///总页数
@property (assign,nonatomic) BOOL firstPage;
///页数条数
@property (assign,nonatomic) BOOL lastPage;
///总页数
@property (assign,nonatomic) int totalPage;
///
@property (assign,nonatomic) int pageSize;
///列表数据
@property (strong,nonatomic) NSArray* list;

@end
#pragma mark-----****----公告对象
///公告对象
@interface ZLHomeAnouncement : NSObject
///公告id
@property (assign,nonatomic) int not_id;
///标题
@property (strong,nonatomic) NSString* not_title;
///小区id
@property (assign,nonatomic) int cmut_id;
///是否为小区公告
@property (assign,nonatomic) int not_is_cmut;
///
@property (strong,nonatomic) NSString* not_state;
///主题简要描述
@property (strong,nonatomic) NSString* not_sub;
///添加时间
@property (strong,nonatomic) NSString* not_add_time;
///图片url
@property (strong,nonatomic) NSString* not_image;
///
@property (strong,nonatomic) NSString* not_deadline;
///
@property (strong,nonatomic) NSString* not_add_person;
///类型
@property (assign,nonatomic) int not_type;



@end


@class ZLAddShopCarExObj;
@class ZLSpeObj;
///商品加入数据库
@interface LKDBHelperGoodsObj : NSObject
///商品名称
@property (strong,nonatomic) NSString* mGoodsName;
///商品图片
@property (strong,nonatomic) NSString* mGoodsImg;
///商品id
@property (assign,nonatomic) int mGoodsId;
///活动id
@property (assign,nonatomic) int mCampId;
///规格id
@property (assign,nonatomic) int mSKUID;
///数量
@property (assign,nonatomic) int mNum;
///是否选中
@property (assign,nonatomic) BOOL mSelected;
///店铺id
@property (assign,nonatomic) int mShopId;
///商品数据
@property (strong,nonatomic) ZLSpeObj* mSpe;

@property (strong,nonatomic) ZLAddShopCarExObj* mExtObj;

@property (strong,nonatomic) NSArray* mGoodsSKU;



@end

@class AddressObject;
@class ZLPreOrderCoupons;
@interface ZLPreOrderObj : NSObject

@property (assign,nonatomic) float deliver_price_free;

@property (assign,nonatomic) int shop_id;

@property (strong,nonatomic) NSArray* campaigns;

@property (strong,nonatomic) NSString* shop_logo;

@property (strong,nonatomic) NSString* shop_name;

@property (assign,nonatomic) float totalMoney;

@property (assign,nonatomic) float payMoney;

@property (assign,nonatomic) int odr_type;

@property (strong,nonatomic) NSArray* coupons;

@property (assign,nonatomic) float deliver_price;

@property (assign,nonatomic) float campaignMoney;

@property (strong,nonatomic) NSArray* goods;

@property (assign,nonatomic) int deliver_id;

@property (strong,nonatomic) NSString* sign;
#pragma mark----****----确认订单扩展字段
///配送方式
@property (assign,nonatomic) ZLShopSendType mSendType;
///收货地址
@property (strong,nonatomic) AddressObject *mAddress;
///优惠卷信息
@property (strong,nonatomic) ZLPreOrderCoupons *mCoupon;
///备注
@property (strong,nonatomic) NSString* mNote;
///选择优惠卷优惠金额
@property (assign,nonatomic) float mCoupMoney;


@end


@interface ZLPreOrderGoods : NSObject

@property (assign,nonatomic) int cam_gid;

@property (strong,nonatomic) NSString* odrg_img;

@property (assign,nonatomic) int odrg_number;

@property (assign,nonatomic) float odrg_price;

@property (strong,nonatomic) NSString* odrg_pro_name;

@property (strong,nonatomic) NSString* odrg_spec;

@property (assign,nonatomic) int pro_id;

@property (assign,nonatomic) int sku_cost;

@property (assign,nonatomic) int sku_id;

@end

@interface ZLPreOrderCoupons : NSObject

@property (strong,nonatomic) NSString* cuc_add_time;

@property (assign,nonatomic) int cuc_id;

@property (strong,nonatomic) NSString* cuc_overdue;

@property (strong,nonatomic) NSString* cuc_state;

@property (strong,nonatomic) NSString* cup_author;

@property (strong,nonatomic) NSString* cup_content;

@property (assign,nonatomic) int cup_id;

@property (assign,nonatomic) int cup_is_shop;

@property (strong,nonatomic) NSString* cup_logo;

@property (assign,nonatomic) float cup_min_price;

@property (strong,nonatomic) NSString* cup_name;

@property (assign,nonatomic) int cup_mould_id;

@property (assign,nonatomic) float cup_price;

@property (assign,nonatomic) int user_id;

@end

@interface ZLPreOrderCampains : NSObject

@property (assign,nonatomic) int cam_act_satisfy;

@property (assign,nonatomic) int cam_id;

@property (strong,nonatomic) NSString* cam_name;

@property (assign,nonatomic) int cam_satisfy;

@property (assign,nonatomic) int cam_type;

@end



