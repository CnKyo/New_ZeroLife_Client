//
//  ZLHttpRequest.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/28.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLResponseSerialization.h"
#import "ZLExtension.h"
#import "AFNetworking.h"
#import "HDSingleton.h"
NS_ASSUME_NONNULL_BEGIN

static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.114/api/app/client";

@class ZLBaseObj;

typedef void (^ _Nullable Success)(id responseObject);     // 成功Block
typedef void (^ _Nullable Failure)(NSError *error);        // 失败Blcok
typedef void (^ _Nullable Progress)(NSProgress * _Nullable progress); // 上传或者下载进度Block
typedef NSURL * _Nullable (^ _Nullable Destination)(NSURL *targetPath, NSURLResponse *response); //返回URL的Block
typedef void (^ _Nullable DownLoadSuccess)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath); // 下载成功的Blcok

typedef void (^ _Nullable Unknown)();          // 未知网络状态的Block
typedef void (^ _Nullable Reachable)();        // 无网络的Blcok
typedef void (^ _Nullable ReachableViaWWAN)(); // 蜂窝数据网的Block
typedef void (^ _Nullable ReachableViaWiFi)(); // WiFi网络的Block



@interface ZLHttpRequest : NSObject

HDSingletonH(HDNetworking) // 单例声明

-(void)postUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( ZLBaseObj* info))callback;

/**
 *  上传图片大小(kb)
 */
@property (nonatomic, assign) NSUInteger picSize;

/**
 *  超时时间(默认20秒)
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 *  可接受的响应内容类型
 */
@property (nonatomic, copy) NSSet <NSString *> *acceptableContentTypes;
#pragma mark----网络监测(在什么网络状态)
/**
 *  网络监测(在什么网络状态)
 *
 *  @param unknown          未知网络
 *  @param reachable        无网络
 *  @param reachableViaWWAN 蜂窝数据网
 *  @param reachableViaWiFi WiFi网络
 */
- (void)networkStatusUnknown:(Unknown)unknown reachable:(Reachable)reachable reachableViaWWAN:(ReachableViaWWAN)reachableViaWWAN reachableViaWiFi:(ReachableViaWiFi)reachableViaWiFi;

#pragma mark----返回当前url
/**
 *  返回当前url
 *
 *  @return 返回当前url
 */
+ (NSString *)returnNowURL;
#pragma mark----返回资源url
/**
 *  返回资源url
 *
 *  @return 返回资源url
 */
+ (NSString *)currentResourceUrl;

@end

NS_ASSUME_NONNULL_END
