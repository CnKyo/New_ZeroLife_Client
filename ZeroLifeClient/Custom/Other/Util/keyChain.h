//
//  keyChain.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/8.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface keyChain : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;
@end
