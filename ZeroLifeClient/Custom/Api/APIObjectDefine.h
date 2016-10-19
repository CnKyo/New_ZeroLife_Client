//
//  APIObjectDefine.h
//  ZeroLifeClient
//
//  Created by 瞿伦平 on 2016/10/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomDefine.h"


@interface APIObjectDefine : NSObject

@end





@interface APIObject : NSObject
@property (nonatomic,strong) id                 data;         //正文
@property (nonatomic,strong) NSString *         msg;   //错误消息
@property (nonatomic,assign) int                code;         //非0表示 错误,调试使用
+(APIObject *)infoWithError:(NSError *)error;
+(APIObject *)infoWithErrorMessage:(NSString *)errMsg;
+(APIObject *)infoWithReLoginErrorMessage:(NSString *)errMsg;
@end
