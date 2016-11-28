//
//  ZLHttpRequest.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/28.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLHttpRequest.h"

#import "MJExtension.h"
#import "Util.h"
#import "NSObject_Objc.h"

@interface ZLHttpRequest()

@end
@implementation ZLHttpRequest

HDSingletonM(HDNetworking) // 单例实现

-(void)postUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)(  ZLBaseObj* info))callback
{
    [[ZLHttpRequest sharedHDNetworking] networkStatusUnknown:^{
        MLLog(@"未知网络连接");
    } reachable:^{
        MLLog(@"reachable");
    } reachableViaWWAN:^{
        MLLog(@"移动蜂窝网络");
    } reachableViaWiFi:^{
        MLLog(@"WiFi");
    }];
    
//    MLLog(@"请求地址：%@-------请求参数：%@",URLString,parameters);
    
//        if ([URLString isEqualToString:@"app/login/applogin"]) {
//            [self getRSAKey];
//        }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 10);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // 开启状态栏动画
    
    MLLog(@"请求地址：%@/%@-------请求参数：%@",[ZLHttpRequest returnNowURL],URLString,parameters);

    
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",[ZLHttpRequest returnNowURL],URLString] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *resbObj = [self deleteEmpty:responseObject];
        
        MLLog(@"去掉字典里的null值之后的数据---%@",resbObj);
        
        ZLBaseObj   *retob = [[ZLBaseObj alloc]initWithObj:resbObj];
        
        //        if( retob.mState == 400301 )
        //        {//需要登陆
        //            id oneid = [UIApplication sharedApplication].delegate;
        //            [oneid performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
        //        }
        callback(  retob );
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MLLog(@" error:%@",error.description);
        callback( [ZLBaseObj infoWithError:@"网络请求错误"] );
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    }];
    
    
    
}
+ (NSString *)returnNowURL{
    
//    NSArray *mUrl = [kAFAppDotNetAPIBaseURLString componentsSeparatedByString:@"/"];
//    NSString *mRsetUrl = [NSString stringWithFormat:@"%@//%@%@",[mUrl objectAtIndex:0],[mUrl objectAtIndex:1],[mUrl objectAtIndex:2]];
    
    return kAFAppDotNetAPIBaseURLString;
}
#pragma mark----返回资源url
/**
 *  返回资源url
 *
 *  @return 返回资源url
 */
+ (NSString *)currentResourceUrl{
    
    
    return nil;
}
#pragma mark----删除字典里的null值
- (NSDictionary *)deleteEmpty:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSMutableArray *set = [[NSMutableArray alloc] init];
    NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];
    for (id obj in mdic.allKeys)
    {
        id value = mdic[obj];
        if ([value isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *changeDic = [self deleteEmpty:value];
            [dicSet setObject:changeDic forKey:obj];
        }
        else if ([value isKindOfClass:[NSArray class]])
        {
            NSArray *changeArr = [self deleteEmptyArr:value];
            [arrSet setObject:changeArr forKey:obj];
        }
        else
        {
            if ([value isKindOfClass:[NSNull class]]) {
                [set addObject:obj];
            }
        }
    }
    for (id obj in set)
    {
        mdic[obj] = @"";
    }
    for (id obj in dicSet.allKeys)
    {
        mdic[obj] = dicSet[obj];
    }
    for (id obj in arrSet.allKeys)
    {
        mdic[obj] = arrSet[obj];
    }
    
    return mdic;
}

#pragma mark----删除数组中的null值
- (NSArray *)deleteEmptyArr:(NSArray *)arr
{
    NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
    NSMutableArray *set = [[NSMutableArray alloc] init];
    NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];
    
    for (id obj in marr)
    {
        if ([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *changeDic = [self deleteEmpty:obj];
            NSInteger index = [marr indexOfObject:obj];
            [dicSet setObject:changeDic forKey:@(index)];
        }
        else if ([obj isKindOfClass:[NSArray class]])
        {
            NSArray *changeArr = [self deleteEmptyArr:obj];
            NSInteger index = [marr indexOfObject:obj];
            [arrSet setObject:changeArr forKey:@(index)];
        }
        else
        {
            if ([obj isKindOfClass:[NSNull class]]) {
                NSInteger index = [marr indexOfObject:obj];
                [set addObject:@(index)];
            }
        }
    }
    for (id obj in set)
    {
        marr[(int)obj] = @"";
    }
    for (id obj in dicSet.allKeys)
    {
        int index = [obj intValue];
        marr[index] = dicSet[obj];
    }
    for (id obj in arrSet.allKeys)
    {
        int index = [obj intValue];
        marr[index] = arrSet[obj];
    }
    return marr;
}
#pragma mark----HDNetWork
/**
 *  网络监测(在什么网络状态)
 *
 *  @param unknown          未知网络
 *  @param reachable        无网络
 *  @param reachableViaWWAN 蜂窝数据网
 *  @param reachableViaWiFi WiFi网络
 */
- (void)networkStatusUnknown:(Unknown)unknown reachable:(Reachable)reachable reachableViaWWAN:(ReachableViaWWAN)reachableViaWWAN reachableViaWiFi:(ReachableViaWiFi)reachableViaWiFi;
{
    // 创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 监测到不同网络的情况
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                unknown();
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                reachable();
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                reachableViaWWAN();
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                reachableViaWiFi();
                break;
                
            default:
                break;
        }
    }] ;
    
    // 开始监听网络状况
    [manager startMonitoring];
}

@end
