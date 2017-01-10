//
//  PushAudioPlayer.h
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/9/3.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushAudioPlayer : NSObject
+ (instancetype)sharedClient;
-(void)play:(NSString *)fileName;
-(void)stop;

@end
