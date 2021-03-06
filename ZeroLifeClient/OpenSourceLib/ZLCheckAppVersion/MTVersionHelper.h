//
//  MTVersionHelper.h
//  QinQingBao
//
//  Created by 王钶 on 2016/12/7.
//  Copyright © 2016年 重庆超尔科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTVersionModel.h"

typedef void(^CheckVersionBlock)(MTVersionModel *appInfo);

@interface MTVersionHelper : NSObject

/**
 *  检测新版本(使用默认提示框)
 */
+(void)checkNewVersion;

/**
 *  检测新版本(自定义提示框)
 *
 *  @param newVersion 新版本信息回调
 */
+(void)checkNewVersionAndCustomAlert:(CheckVersionBlock)newVersion;

@end
