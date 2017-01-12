//
//  ZLWebViewViewController.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/19.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

//#import "CustomVC.h"
#import <UIKit/UIKit.h>
#import "CustomDefine.h"
#import "APIObjectDefine.h"

//@interface ZLWebViewViewController : CustomVC
@interface ZLWebViewViewController : UIViewController

@property (nonatomic, copy) NSString *mUrl;

@property (nonatomic, strong) ZLGoodsWithCamp *mCamGoodsObj;

@property (nonatomic, strong) ZLGoodsWithClass *mClsGoodsObj;

@property (nonatomic, assign) int mShopId;

@property (nonatomic, assign) kOrderClassType mType;
@property (nonatomic, assign) ZLShopObj *mShopObj;

@property (nonatomic, copy) NSString *mTitle;

@end
