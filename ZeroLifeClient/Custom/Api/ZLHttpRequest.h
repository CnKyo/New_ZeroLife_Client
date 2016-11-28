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

NS_ASSUME_NONNULL_BEGIN

static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://app.china-cr.com/";

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



@end

NS_ASSUME_NONNULL_END
