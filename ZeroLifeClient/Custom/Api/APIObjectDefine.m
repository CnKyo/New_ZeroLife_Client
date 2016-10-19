//
//  APIObjectDefine.m
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "APIObjectDefine.h"

@implementation APIObjectDefine

@end






#pragma mark -
#pragma mark APIObject
@implementation APIObject
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"msg": @"result"};
}


+(APIObject *)infoWithError:(NSError *)error
{
    APIObject *info = [[APIObject alloc] init];
    NSString *des = [error.userInfo objectForKey:@"NSLocalizedDescription"];
    if (des.length > 0)
        info.msg = des;
    else
        info.msg       = @"网络请示失败，请检查网络";
    info.code = RESP_STATUS_NO;
    return info;
}

+(APIObject *)infoWithErrorMessage:(NSString *)errMsg
{
    APIObject *info = [[APIObject alloc] init];
    info.msg       = errMsg;
    info.code = RESP_STATUS_NO;
    return info;
}

+(APIObject *)infoWithReLoginErrorMessage:(NSString *)errMsg
{
    APIObject *info = [[APIObject alloc] init];
    info.msg       = errMsg.length>0 ? errMsg : @"请登录";
    info.code = RESP_STATUS_YES;
    return info;
}

-(void)setCode:(int)code
{
    _code = code;
    
    if (code == 20004)
        [self performSelector:@selector(startLogin) withObject:nil afterDelay:0.8];
}

-(void)startLogin
{
//    UIViewController *se = [UIViewController topViewController];
//    if (![se isKindOfClass:[LoginTVC class]]) {
//        [LoginTVC startPresent:se];
//    }
}

@end


