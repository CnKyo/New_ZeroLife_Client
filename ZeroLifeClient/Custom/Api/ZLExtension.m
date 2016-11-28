//
//  ZLExtension.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/28.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "ZLExtension.h"
@implementation NSDictionary (QUAdditions)
-(id)objectWithKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if ([obj isEqual:[NSNull null]]) {
        obj = nil;
    }
    return obj;
}
@end

@implementation NSMutableDictionary (QUAdditions)
- (void)setNeedStr:(NSString *)anObject forKey:(id)aKey
{
    if (anObject.length > 0)
        [self setObject:anObject forKey:aKey];
    else
        [self setObject:@"" forKey:aKey];
}

- (void)setValidStr:(NSString *)anObject forKey:(id)aKey
{
    if (anObject.length > 0)
        [self setObject:anObject forKey:aKey];
}

- (void)setInt:(int)anObject forKey:(id)aKey
{
    [self setObject:StringWithInt(anObject) forKey:aKey];
}
@end
@interface ZLBaseObj()

@property (nonatomic,strong)    id mcoredat;


@end

@implementation ZLBaseObj

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        self.mData = [obj objectForKeyMy:@"data"];
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    _mTitle = [obj objectForKeyMy:@"title"];
    _mState = [[obj objectForKeyMy:@"state"] intValue];
    self.mMessage = [obj objectForKeyMy:@"message"];
    self.mAlert = [[obj objectForKeyMy:@"alert"] intValue];
    self.mData = [obj objectForKeyMy:@"data"];
    
    
    if (self.mState == 200000) {
        self.mSucess = YES;
    }else{
        self.mSucess = NO;
    }
    
}
+ (ZLBaseObj *)infoWithError:(NSString *)error{
    ZLBaseObj *retobj = ZLBaseObj.new;
    retobj.mTitle = @"";
    retobj.mState = 400301;
    retobj.mData = nil;
    retobj.mMessage = @"服务器君开小差啦!";
    return retobj;
}
@end

@implementation ZLExtension

@end

@implementation ZLUserInfo

- (void)ZLLoginWithPhone:(NSString *)mPhone andPwd:(NSString *)mPwd block:(void (^)(ZLBaseObj *))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"acc_phone"];
    [para setObject:mPwd forKey:@"acc_pass"];
    [para setObject:@"ios" forKey:@"sys_t"];

}

@end
