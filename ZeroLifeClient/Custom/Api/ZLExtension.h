//
//  ZLExtension.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/28.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomDefine.h"
#import <LKDBHelper/LKDBHelper.h>
#import <MJExtension/MJExtension.h>
#import "NSObject_Objc.h"
#import "APIClient.h"

@interface ZLExtension : NSObject

@end
#pragma mark - NSDictionary自定义
@interface NSDictionary (QUAdditions)
-(id)objectWithKey:(NSString *)key; //返回有效值
@end

@interface NSMutableDictionary (QUAdditions)
///设置必须有的值
- (void)setNeedStr:(NSString *)anObject forKey:(id)aKey;
//当值不为空时，设置该值
- (void)setValidStr:(NSString *)anObject forKey:(id)aKey;
- (void)setInt:(int)anObject forKey:(id)aKey;
@end
#pragma mark----****----基本数据结构
@interface ZLBaseObj : NSObject
@property (nonatomic,strong) NSString   *mTitle;

@property (nonatomic,assign) int        mState;

@property (nonatomic,assign) BOOL        mSucess;

@property (nonatomic,strong) id         mData;


@property (nonatomic,assign) int        mAlert;


@property (nonatomic,strong) NSString   *mMessage;


-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

+(ZLBaseObj *)infoWithError:(NSString*)error;

@end
#pragma mark----****----用户信息
@interface ZLUserInfo : NSObject
#pragma mark----****----登录

- (void)ZLLoginWithPhone:(NSString *)mPhone andPwd:(NSString *)mPwd block:(void(^)(ZLBaseObj *mBaseObj))block;

@end
