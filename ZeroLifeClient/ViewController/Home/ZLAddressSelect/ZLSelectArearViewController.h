//
//  ZLSelectArearViewController.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/2.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CustomVC.h"

@interface ZLSelectArearViewController : CustomVC


@property (strong,nonatomic) ZLHomeCommunity *mCommunityAdd;


/**
 block
 */
@property (nonatomic,strong) void(^block)(ZLHomeCommunity *mBlock);

@end
