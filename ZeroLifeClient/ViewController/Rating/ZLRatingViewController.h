//
//  ZLRatingViewController.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/22.
//  Copyright © 2016年 ChaoerTEC. All rights reserved.
//

#import "CustomVC.h"

@interface ZLRatingViewController : CustomVC

@property(nonatomic,strong) OrderObject *orderItem;

///评论成功返回方法
@property (nonatomic, copy) void (^evaluateSuccessCallBack)(NSString *odr_state_val, NSMutableArray *odr_state_next);




@end
