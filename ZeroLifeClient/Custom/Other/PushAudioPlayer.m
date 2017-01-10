//
//  PushAudioPlayer.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/9/3.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "PushAudioPlayer.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface PushAudioPlayer ()<AVAudioPlayerDelegate>
@property(nonatomic,strong) AVAudioPlayer *player;
@end



@implementation PushAudioPlayer

+ (instancetype)sharedClient {
    static PushAudioPlayer *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[PushAudioPlayer alloc] init];
    });
    return _sharedClient;
}

-(id)init
{
    self = [super init];
    if (self) {
        //self.player = [[AVAudioPlayer alloc] init];
    }
    return self;
}

- (void)play:(NSString *)fileName
{
    if (fileName.length > 0) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSURL *url = [NSURL fileURLWithPath:filePath];
            if (url != nil) {
                [self stop];
                
                self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                [self.player play];
            }
        }
    }
}

-(void)stop
{
    if (self.player != nil) {
        if (self.player.playing == YES)
            [self.player stop];
        
        self.player = nil;
    }
}


@end
