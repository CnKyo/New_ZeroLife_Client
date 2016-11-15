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


#pragma mark - NSDictionary自定义
@interface NSDictionary (QUAdditions)
-(id)objectWithKey:(NSString *)key; //返回有效值
@end

@interface NSMutableDictionary (QUAdditions)
- (void)setNeedStr:(NSString *)anObject forKey:(id)aKey;  //设置必须有的值
- (void)setValidStr:(NSString *)anObject forKey:(id)aKey;  //当值不为空时，设置该值
- (void)setInt:(int)anObject forKey:(id)aKey;
@end



#pragma mark - shareSDK 菜谱

@interface APIShareSdkObject : NSObject
@property (nonatomic,strong) id                 result;         //正文
@property (nonatomic,strong) NSString *         msg;   //错误消息
@property (nonatomic,assign) int                retCode;         //非0表示 错误,调试使用
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
@property (nonatomic,strong) id                 data;         //正文
@property (nonatomic,strong) NSString *         msg;   //错误消息
@property (nonatomic,assign) int                code;         //非0表示 错误,调试使用
+(APIObject *)infoWithError:(NSError *)error;
+(APIObject *)infoWithErrorMessage:(NSString *)errMsg;
+(APIObject *)infoWithReLoginErrorMessage:(NSString *)errMsg;
@end



#pragma mark -  用户订单对象
@interface OrderObject : NSObject
@property (nonatomic,strong) NSString *         iD;         //
@property (nonatomic,assign) kOrderClassType    type;         //
@property (nonatomic,assign) int                status;         //
@end



#pragma mark -  用户地址对象
@interface AddressObject : NSObject
@property(nonatomic,strong) NSString *              iD;         //
@property(nonatomic,assign) kUserSexType            sex;         //
@property(nonatomic,strong) NSString *              user_id;            //用户id
@property(nonatomic,strong) NSString *              consignee;          // 收货人姓名
@property(nonatomic,strong) NSString *              mobile;             // 手机号
@property(nonatomic,strong) NSString *              area_code;           //地区编码
@property(nonatomic,strong) NSString *              address;            // 详细地址
@property(nonatomic,assign) BOOL                    is_default;         // 是否为默认地址
@property(nonatomic,strong) NSString *              zipcode;            // 邮编
+(AddressObject *)defaultAddress; //默认选择地区
@end


#pragma mark -  用户房屋对象
@interface HouseObject : NSObject
@property(nonatomic,strong) NSString *              iD;         //
@property(nonatomic,assign) kUserSexType            sex;         //
@property(nonatomic,strong) NSString *              user_id;            //用户id
@property(nonatomic,strong) NSString *              real_name;          // 联系人姓名
@property(nonatomic,strong) NSString *              mobile;             // 手机号
@property(nonatomic,strong) NSString *              xiaoqu;              // 小区id
@property(nonatomic,strong) NSString *              area_code;           //地区编码
@property(nonatomic,strong) NSString *              address;            // 详细地址
@end



#pragma mark -  用户优惠券对象
@interface CouponObject : NSObject
@property (nonatomic,strong) NSString *         iD;         //
@property (nonatomic,assign) kCouponType        type;
@end



#pragma mark -  用户银行卡对象
@interface BankCardObject : NSObject
@property (nonatomic,strong) NSString *         iD;         //
@property (nonatomic,strong) NSString *         name;         //
@end
