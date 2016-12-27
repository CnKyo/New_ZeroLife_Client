//
//  JHJsonRequst.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "JHJsonRequst.h"
#import "CustomDefine.h"
#import "Util.h"
#import "AFNetworking.h"

#pragma mark -
#pragma mark APIClient

static NSString* const  kAFAppDotNetAPIBaseURLStringJuhe    = @"http://op.juhe.cn/ofpay/public/";

@implementation JHJsonRequst
HDSingletonM(HDNetworking) // 单例实现

#pragma mark -


-(void)postUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)(mJHBaseData  * info))callback
{
    
    MLLog(@"请求地址：%@-------请求参数：%@",URLString,parameters);

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = 10;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // 开启状态栏动画
    
    [manager POST:[NSString stringWithFormat:@"%@%@",[JHJsonRequst returnNowURL],URLString] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    
            MLLog(@"data:%@",responseObject);
            
            mJHBaseData   *retob = [[mJHBaseData alloc]initWithObj:[Util delNUll:responseObject]];
            
        
        callback(  retob );
        
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        

        MLLog(@"error:%@",error.description);
        callback( [mJHBaseData infoWithError:@"网络请求错误"] );
        
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    }];

    
}



+ (NSString *)returnNowURL{
    return kAFAppDotNetAPIBaseURLStringJuhe;
}

@end
