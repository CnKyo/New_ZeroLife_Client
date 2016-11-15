//
//  DryCleanOrderTimeVC.h
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//干洗订单选择时间界面

#import "CustomScrollVC.h"
#import "APIClient.h"


@interface TimeObject : NSObject
@property (nonatomic, assign) BOOL                  canEdit;              //
@property (nonatomic, strong) NSString *            time;              //
@end



@interface DryCleanOrderChooseTimeVC : CustomScrollVC
@property(nonatomic,assign) int shopId; //店铺id

@property (nonatomic, copy) void (^chooseCallBack)(NSString* dateStr, NSString* timeStr);

@end
