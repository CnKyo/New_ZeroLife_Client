//
//  NSObject_Objc.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/28.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "NSObject_Objc.h"

@implementation NSObject (myobj)
- (id)objectForKeyMy:(id)aKey
{
    
    if( [self isKindOfClass:[NSDictionary class]] ||
       [self isKindOfClass:[NSMutableDictionary class]] )
    {
        id s = self;
        id v = [s objectForKey:aKey];
        if( v && [v isKindOfClass: [NSNull class]] ) return nil;
        return v;
    }
    return nil;
}
@end

